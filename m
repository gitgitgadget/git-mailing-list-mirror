Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C22C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 00:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C691561220
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 00:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbhDMAsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 20:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhDMAsr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 20:48:47 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7AC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 17:48:26 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id c16so15388530oib.3
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Dd3i8N7QmhS2m0ZHs0Db7CM1tSLpH3L5OCum1OoDm3Y=;
        b=SOFSMW1NGSHZTap0YIMI8ZZUHVUcRr1SItMy1Rs+uJFMtcMtTijVKyhyvWrjkzuR4C
         oKmR8Mc2qnGhhHjhK+wb01MPPZLPWDFah2BbalZUkoeXNGLDWcgF+prXHZBSudNOhO1A
         DSbTqkq0W9RgqLyLCNM01kJWgEjwJqRimbrxRQZlxG2J/8y1eDMxjdUK8w/qGTB1DcAE
         eGimmiSoCYZ7Olsnsz5LLj49lyx294E3VVPTmSaiG+hAPU7nK+lL6cqI88nF2jOQeYUy
         wz9U19RslvAoEOnhMpIWCQ9gLsTuN0ob/L2mulKAYP8fKm7PN+Ol64mQYzIdaHnn4mGh
         FqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dd3i8N7QmhS2m0ZHs0Db7CM1tSLpH3L5OCum1OoDm3Y=;
        b=NTiduD8wLj1H2/tl+9nmb/SSCkwxhw8467CLQwRlgy5OQ9yjx9eZM5GcsUbrjvR+bB
         I5FIpVZ89NRaQNwdlCHKPyFtgevKH62TJno7G7tYF9ZOKeGdVnqviq+zZiN2MB4b2L//
         yhHXxSCA8U95WNEQZzhBt254tEBcQC0wkBuyll+kqwGmRimT9AF/ktkg1wi0HKuoklvO
         ln2lqyDP411gNGNv7OWpqlItuiBJjJLZw2n5sv1bUcorFHfJdeCRTconnNtOKmBoMzNo
         R9oAr+cM1jMQIOC3JptM03/pHH3dFP27bI/J6c/XfTVXY1qTnfml4SqRtR7X1IlWNdX6
         q/hw==
X-Gm-Message-State: AOAM533PJVf94L4ZuEXLgMZRMRoTSsgYejI6/C/ypfXmHfMtPbQsI2NL
        3FWW3OtMAFQ7y87+NdsnuyhvyjdoXjlzkg==
X-Google-Smtp-Source: ABdhPJydf/h7Z9ABQmXegfVaVUDcmbWjpTTKpR3S9pwic+MT4qct60D5dZiC8nAXYL8q6IBWA6JHQQ==
X-Received: by 2002:aca:3555:: with SMTP id c82mr1415794oia.8.1618274905797;
        Mon, 12 Apr 2021 17:48:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:80ed:1004:39f6:3449? ([2600:1700:e72:80a0:80ed:1004:39f6:3449])
        by smtp.gmail.com with ESMTPSA id o2sm486072oti.30.2021.04.12.17.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 17:48:25 -0700 (PDT)
Subject: Re: [PATCH] pack-objects: update "nr_seen" progress based on
 pack-reused count
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <YHPBXu9R/7i1jZhy@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <06e42cf3-188c-d314-b3b9-bdb2f43a37e6@gmail.com>
Date:   Mon, 12 Apr 2021 20:48:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHPBXu9R/7i1jZhy@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/2021 11:41 PM, Jeff King wrote:> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 525c2d8552..faee5a5c76 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3527,7 +3527,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
>  			&reuse_packfile_bitmap)) {
>  		assert(reuse_packfile_objects);
>  		nr_result += reuse_packfile_objects;
> -		display_progress(progress_state, nr_result);
> +		nr_seen += reuse_packfile_objects;
> +		display_progress(progress_state, nr_seen);

nr_seen and nr_result are defined in the same line with nr_written,
as static globals. I can understand how this mistake happened.

There are no other places where nr_result is used for
display_progress() while nr_seen _is_ used a couple more times.

> +test_expect_success 'enumerating progress counts pack-reused objects' '
> +	count=$(git rev-list --objects --all --count) &&
> +	git repack -adb &&
> +
> +	# check first with only reused objects; confirm that our progress
> +	# showed the right number, and also that we did pack-reuse as expected.
> +	# Check only the final "done" line of the meter (there may be an
> +	# arbitrary number of intermediate lines ending with CR).
> +	GIT_PROGRESS_DELAY=0 \
> +		git pack-objects --all --stdout --progress \
> +		</dev/null >/dev/null 2>stderr &&
> +	grep "Enumerating objects: $count, done" stderr &&
> +	grep "pack-reused $count" stderr &&
> +
> +	# now the same but with one non-reused object
> +	git commit --allow-empty -m "an extra commit object" &&
> +	GIT_PROGRESS_DELAY=0 \
> +		git pack-objects --all --stdout --progress \
> +		</dev/null >/dev/null 2>stderr &&
> +	grep "Enumerating objects: $((count+1)), done" stderr &&
> +	grep "pack-reused $count" stderr
> +'

Good test. LGTM.

Thanks,
-Stolee
