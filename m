Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8177AC54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 19:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjA0TcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 14:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjA0TcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 14:32:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3C080151
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:32:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m11so5561432pji.0
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FmRXnYOjZ9OF+hGCcsLhx4EKRG8n2xRyZqypvcPasM=;
        b=OnzBYghr8QkKq6vduEwNxUD0J2spVyPN4EOVqI9wjvZQlWGcImXcJIHQ285LoUG4TW
         0ieSnbcUHeduka48UzLKAvUkiAJHRVTu6QvES8rdO2+7BXvNBwfigpiWfNXzfepTOI4s
         +UMuZ/ZtnDzR5qaWbNOytEAZ9Lua0DlQIOJA1rH6A+cvoMT5RR6F7FvqyaHZDjUtcyp0
         bRIYD7P3RMxrKUfhsTyw6T5M9wdTdL1XzDGsNGQC7x9/g8OryDbGCWvtgHrOE0BM4eyk
         +mE0SJox+1SSNaJhffw/mEOStq+jSm9THeR8GSczqbchGlXUet9eC323wur6s1QvtQbs
         BW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5FmRXnYOjZ9OF+hGCcsLhx4EKRG8n2xRyZqypvcPasM=;
        b=Yde39XhLtij06JhxanO/XXG985NXEAOR/iXLz1+iw/QQYyClZibsSV+G2Ri/Sd0ql2
         AUrVcqnQCaWMqrv3E9AIrvcOLZF3TTJNRgbFMwryjlAXiHQqISNJkVOeC0RuOItCKyHS
         t1vkp3wzlx2QVEyf+l1PspPpkpeQUeFkLV2/JUth0nFGAtejF/guuU7tAthOkXzgvfC8
         GYD/9lR9Plr64HhKhQ4KkQKDSmWI8pgkhElLf1NVfwWEdElf0Wd2/OI+Rn0Lxv9GAWVK
         7lfgsrEo/+BDLeBQ8CRtamRmN33S3YQq1qhRSt+L9x23Sk2giJ3sOyAJmtOwdRgCQG+s
         xYpg==
X-Gm-Message-State: AFqh2koEWC1ayoOuDcKXQhEFx7er3OKwATm0iIqM5voA7EwVaQSRXnfB
        a1gbRsiDNet5J4SfwUXOFFj7y7UUCuI=
X-Google-Smtp-Source: AMrXdXthKjM0MKq0T3S545sa1BybNDEnmJ7fVT+2UTKDEalcRmpnCjU0vr00P+iUZjUEsEyLrpP2TQ==
X-Received: by 2002:a17:90b:1e4b:b0:229:ff05:691a with SMTP id pi11-20020a17090b1e4b00b00229ff05691amr30368366pjb.16.1674847932967;
        Fri, 27 Jan 2023 11:32:12 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id y14-20020a637d0e000000b004ae6e97ed10sm2661716pgc.17.2023.01.27.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:32:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 05/10] bundle-uri: download in creationToken order
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <7cfaa3c518cbedb65c585cc02015bb21ae24e9fa.1674487310.git.gitgitgadget@gmail.com>
        <a2896d5b-f395-68df-1f23-356d0128cb9c@github.com>
Date:   Fri, 27 Jan 2023 11:32:12 -0800
In-Reply-To: <a2896d5b-f395-68df-1f23-356d0128cb9c@github.com> (Victoria Dye's
        message of "Fri, 27 Jan 2023 11:17:00 -0800")
Message-ID: <xmqqpmaz93k3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> +			/*
>> +			 * Not downloaded yet. Try downloading.
>> +			 *
>> +			 * Note that bundle->file is non-NULL if a download
>> +			 * was attempted, even if it failed to download.
>> +			 */
>> +			if (fetch_bundle_uri_internal(ctx.r, bundle, ctx.depth + 1, ctx.list)) {
>> +				/* Mark as unbundled so we do not retry. */
>> +				bundle->unbundled = 1;
>
> This implicitly shows that, unlike a failed unbundling, a failed download is
> always erroneous behavior, with the added benefit of avoiding (potentially
> expensive) download re-attempts.

Hmph, I somehow was hoping that we'd allow an option to use range
requests to resume an interrupted download in the future, so
outright "always avoid attempts to download again" may not be what
we want in the longer run.  But being able to tell if download
failed (and there will probably be more than "success/failure" bit,
but something like "we got an explicit 401 not found" vs "we were
disconnected after downloading a few megabytes"), and unbundling
failed (where there is no point attempting) is a good idea.

>>  	cat >expect <<-EOF &&
>> -	$HTTPD_URL/bundle-1.bundle
>> -	$HTTPD_URL/bundle-2.bundle
>> -	$HTTPD_URL/bundle-3.bundle
>> +	$HTTPD_URL/bundle-list
>>  	$HTTPD_URL/bundle-4.bundle
>> +	$HTTPD_URL/bundle-3.bundle
>> +	$HTTPD_URL/bundle-2.bundle
>> +	$HTTPD_URL/bundle-1.bundle
>> +	EOF
>
> Ooh, interesting - using the new "test_remote_https_urls", these tests now
> also verify that the bundles were downloaded in decreasing order when using
> the 'creationToken' heuristic. That's a nice extra confirmation that the
> heuristic is working as intended.

Yes, that indeed is very nice.
