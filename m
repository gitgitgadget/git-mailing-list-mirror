Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FD2C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 02:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiHQCMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 22:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbiHQCMa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 22:12:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6E99251
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:12:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r16so5389399wrm.6
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=5kENPB0yhBFwaZdb7A0g1EHYDWRrimrzqL/S9WqdpHU=;
        b=CW/VzEeyCVjvPxjLcwvf3pOcFVRRiV6n31+RNE+vcFnUAWByJLQIG8vVynhCKdXs0b
         9XzRJ9gLggJDpQNpr97wo+Bk+OPL9UBJZNscI17tP4d4lzdCUoEZ+RLLAbuOlNEDXhZ+
         Pw3uuH+HsYZdbYWJc+FK/Uw/3jp3DCmGtoh4GWoGtCgBpnO+GXIyr/Hhav1EVHT9SpOS
         zT2iOI4unn4QjJD6K/vwMluBt3Cq/2WzLMKZL9CfF+u/UylSl5N+sSduycD9oQPuWEGM
         5snD2Ije6PmjY+0t6aTzRK0Tx3UQDOQSab373O/KbMjh1t7RgJ/igku/FvNLINq77rkl
         rZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5kENPB0yhBFwaZdb7A0g1EHYDWRrimrzqL/S9WqdpHU=;
        b=DebYFtYQZf3fSKbYTG7bPsdt9So8J//hSYi8q5n0DusfzHRCzWm43LAx0sqM3ajFo1
         1ZalGbvIh4GpyYOtUM4er/TiTvYws5MhxsKnx2cQEOaHtP+RY/X8y73uusDSea4ywIiY
         +50+3NrDxGThkL6eevViB+JM/sYtGDITfox+f/61MkteMPXU21OCmEaDIgQDOZ2X/GZi
         UAGabSo9GXgURWMXV7iPOB0LDl8VANBi4BxZKgwa7Y/vkJN5AxwxZl0ZtV04Xy7B7HZi
         pGUqKmDF2vFmBosTPQd6eud1tDFU8dexwITqa6zRGohNIzzdZ0fLP4X6FvhzYWlvnFAe
         F5fw==
X-Gm-Message-State: ACgBeo3+R3xxyaFjS+ZYBmB3lP4ChJCmPrRqhjZfFxz6cUOr137TeVSg
        0ow2Mcsc3RyBRFgABDNAyN43EfLiWeD0Ow==
X-Google-Smtp-Source: AA6agR6p+3ErPL6bQ5RORjjiINoGwSI0AEmfIx0sLgeWXCKTo3HYCr8P491n+bs6chlq8SlbNQo1Mw==
X-Received: by 2002:a5d:59a8:0:b0:220:7076:dce0 with SMTP id p8-20020a5d59a8000000b002207076dce0mr13550411wrr.570.1660702347711;
        Tue, 16 Aug 2022 19:12:27 -0700 (PDT)
Received: from gmgdl ([213.220.121.135])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d52cf000000b0021f73c66198sm11558646wrv.1.2022.08.16.19.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 19:12:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oO8Xh-0007nf-2A;
        Wed, 17 Aug 2022 04:12:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 03/14] merge-index: libify merge_one_path() and
 merge_all()
Date:   Wed, 17 Aug 2022 04:10:47 +0200
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
 <20220809185429.20098-4-alban.gruin@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220809185429.20098-4-alban.gruin@gmail.com>
Message-ID: <220817.86lernaa9i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 09 2022, Alban Gruin wrote:

[Re-arranged]

Rather than changing this behavior:

> diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
> index 89a62ac53b..96befa5b80 100755
> --- a/t/t7607-merge-state.sh
> +++ b/t/t7607-merge-state.sh
> @@ -20,7 +20,7 @@ test_expect_success 'Ensure we restore original state if no merge strategy handl
>  	# just hit conflicts, it completely fails and says that it cannot
>  	# handle this type of merge.
>  	test_expect_code 2 git merge branch2 branch3 >output 2>&1 &&
> -	grep "fatal: merge program failed" output &&
> +	grep "error: merge program failed" output &&
>  	grep "Should not be doing an octopus" output &&

In this (or some of it?):

> [...]
>  	# Make sure we did not leave stray changes around when no appropriate
> [...]
> -	if (run_command_v_opt(arguments, 0)) {
> -		if (one_shot)
> -			err++;
> -		else {
> -			if (!quiet)
> -				die("merge program failed");
> -			exit(1);
> [...]
> +			if (!quiet && !oneshot)
> +				error(_("merge program failed"));
> +			return 1;
> [...]
> +		if (err && !oneshot) {
> +			if (!quiet)
> +				error(_("merge program failed"));
> +			return 1;
> +		}
> +	}
> +
> +	if (err && !quiet)
> +		error(_("merge program failed"));

Should we not be using die_message() here instead?
