Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA3FC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 17:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhLHRMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbhLHRMi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 12:12:38 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A40EC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 09:09:06 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id v23-20020a170902bf9700b001421d86afc4so1187885pls.9
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 09:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oEPb2yJd13jkjMamWYM8JI6TX87s4O0i5dn/MypJJl4=;
        b=DvwKEoROjctTNCSVbPIve0ZL0+Ux4BoKkRmVN0d0mCe0BM1c3jeqfqiQ1zGTqqLomr
         xFgbf+XY1rIACVMG/JmTkaEZcPNF5NAYFyhdsLn+AMwU4PehQ0Q5KMsxjaiBD8sGIQts
         L3aRiS29uHHZM157lLSe7hINiSperwiVfKCHHiCBnXJPanMZBSJrjCSyUObl116UtQje
         1/GlAKxtmVaQOzo3old7fYoLEHXUVjy2fDNHNRKdpyxJ0qYe3xFifS3+wx1KeOeVY+gw
         Q72vt5tZYcrvKXVdLBBJ7Odw0VvnhBb5z729+g4xy1P6qCh/6AckNdLrjrtf6kueM06y
         DZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oEPb2yJd13jkjMamWYM8JI6TX87s4O0i5dn/MypJJl4=;
        b=J9mliNGc+Fl1EdO3GiJFayJqGcvMrJahYuI3t3d3MU/NA+hqvlw2PAgs83+VKtzkW/
         0qh0X5J+2hWGPKW/yMg2FNFWYunkCDwtewKV4FjoZgHYmmndF9tvW/tkJO79ed+LIyBt
         nNUn89OZ/tzsnUb3/FdACTc8QBvMnkhOizZo3bgaMJrxVMBU+8VNc65aWe0ws8DP4AaR
         W6PL0Vb8b3Y6TfRAILuB+AwfnkPt8fZNnkURpOeiLXyEv2QF4KG6Jm6ttgmhT/jSl4mF
         1VoYwcVA2n4Z1eAfddl/Qgy0VQoCOm7NiitNDRsoUjLdaiRJHFXD7KdnGKLs7/C1n9X9
         /0yQ==
X-Gm-Message-State: AOAM531Os7KBfm9UpiWont8Ou7Mz9/Ak+Hsm4W3R8IXMLhCUtIsBzAjm
        FuSaGc/zMuGllEq1PMzCdmmRceUUORcosw==
X-Google-Smtp-Source: ABdhPJyauZd5M6Inot/sZDGD5R4xuwJlaycdCkJ9AYoic7kY9jx5S3IbK3mL2Z82DDUqSFxY6Yeam9Pv4BtcRQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7c02:b0:143:9d6a:8e42 with SMTP
 id x2-20020a1709027c0200b001439d6a8e42mr60366613pll.80.1638983345608; Wed, 08
 Dec 2021 09:09:05 -0800 (PST)
Date:   Wed, 08 Dec 2021 09:09:05 -0800
In-Reply-To: <xmqq1r2pcnyw.fsf@gitster.g>
Message-Id: <kl6l8rwvaury.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com> <20211206215528.97050-1-chooglen@google.com>
 <20211206215528.97050-2-chooglen@google.com> <xmqq1r2pcnyw.fsf@gitster.g>
Subject: Re: [PATCH v2 1/3] branch: move --set-upstream-to behavior to setup_tracking()
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +void setup_tracking(const char *new_ref, const char *orig_ref,
>> +			   enum branch_track track, int quiet, int expand_orig)
>> +{
>> +	struct tracking tracking;
>> +	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
>> +	char *full_orig_ref;
>> +	struct object_id unused_oid;
>> +
>> +	memset(&tracking, 0, sizeof(tracking));
>> +	if (expand_orig)
>> +		validate_branch_start(the_repository, orig_ref, track, &unused_oid, &full_orig_ref);
>> +	else
>> +		full_orig_ref = xstrdup(orig_ref);
>> +
>> +	tracking.spec.dst = full_orig_ref;
>> +	if (for_each_remote(find_tracked_branch, &tracking))
>> +		goto cleanup;
>> +
>> +	if (!tracking.matches)
>> +		switch (track) {
>> +		case BRANCH_TRACK_ALWAYS:
>> +		case BRANCH_TRACK_EXPLICIT:
>> +		case BRANCH_TRACK_OVERRIDE:
>> +			break;
>
> This heavily conflicts with what another topic "inherit tracking
> info from the other branch" wants to do to this function.  What's 
> the status of that topic, by the way?  Should we block this one
> waiting for the other, or the other way around?
>
> Thanks.

As mentioned in [1], I plan to rebase this series on top of the "inherit
tracking info from the other branch" series.

I'll send a re-roll soon, thanks!

[1] https://lore.kernel.org/git/kl6lbl1rauw3.fsf@chooglen-macbookpro.roam.corp.google.com/
