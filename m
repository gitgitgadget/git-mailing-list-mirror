Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8572CC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 08:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C3464F53
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 08:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhBBIuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 03:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbhBBIus (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 03:50:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7F7C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 00:50:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id s24so1831561pjp.5
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gClhpJXWafgYkOT2AzdqyznC7KzFyLFLqGYiSWxM4Ak=;
        b=YHApyKO+89grbEHrk9ZMPVn+GHJzFGNLc2TB3J2CiEr8oGxtQNUCPGAWshhiYwXy2z
         gMZR8ew4Xfk2kP91W5aAlRb13baOVbfYhmyTwXg1J2NfODOJHlldni9Cj8tZm842W6zA
         OBkxKxZBsR/GVWBnYRrVvcwP6dwjuNyjSHrTz34sjdswe0jMFSzCOY5+UkN6+S3keJJr
         wVenAk1epYHdvM+GwDEYYezYI0K6S0PFr6VcqGnsSWqEemLzOzmAGy1SCjG8mvB/BGTg
         IgX1rBKHWpggIPiS8nJbGaw4g7Z2iajM1InmlhkdUWck3P9UP62BrT1UyAQM6HBGcHmn
         xJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gClhpJXWafgYkOT2AzdqyznC7KzFyLFLqGYiSWxM4Ak=;
        b=BGcopsEsI2DsSEALElIFBlxOuDWh34swKRvKZCRW5efzeyg0Af3Gp+8QY0lLIubtdT
         czydaRrADJ8gW2AN6nXMbUL0RCyouQz21cZxLCkg3WHr0Om6ozUoh3gODLXKKlNWMkEn
         qTw+ccV+yHUiqKJMC+LM/o8b22UPSGqAemCp4s6cygauvLacypCKeMT5HdbOuSZ8eun7
         36ovmtTEfbjuDM4cvD2aD0y7P0v4klNcZj+C/5wS3dQfPAXfNyeL9qZAwuhXqYLVSP27
         moXrIVJuJts07704Et83C6brJKHO9ESL2fTfRibPpHWHcCZwqRQtX8H/QLACZ07I4Nke
         QPAg==
X-Gm-Message-State: AOAM531Zd8+wj/5Sau0ENqxtU0XeKPbujoRIONnoQPRMLod1IPxtLIm1
        0xcznqrVSb4P5SKffktdFiU=
X-Google-Smtp-Source: ABdhPJwbE++ZgFTBY/K5OrKnjyz9yY31eFj8BSqw23n85ck6BmKfoMea1jSdkE5jqMdJt1Z4bJuQGw==
X-Received: by 2002:a17:90a:670c:: with SMTP id n12mr1403308pjj.46.1612255808074;
        Tue, 02 Feb 2021 00:50:08 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id 123sm21198555pfd.91.2021.02.02.00.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:50:07 -0800 (PST)
Date:   Tue, 2 Feb 2021 00:50:04 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/5] pager: test for exit code with and without SIGPIPE
Message-ID: <YBkSPO9tFb3JXmql@generichostname>
References: <20210201144921.8664-1-avarab@gmail.com>
 <20210202020001.31601-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210202020001.31601-3-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 02:59:58AM +0100, Ævar Arnfjörð Bjarmason wrote:
> This test construct is stolen from 7559a1be8a0 (unblock and unignore
> SIGPIPE, 2014-09-18). The reason not to make the test itself depend on
> the MINGW prerequisite is to make a subsequent commit easier to read.

[...]

> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index fdb450e446a..0aa030962b1 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -656,4 +656,86 @@ test_expect_success TTY 'git tag with auto-columns ' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
> +	test_when_finished "rm pager-used" &&
> +	test_config core.pager ">pager-used; head -n 1; exit 0" &&

I may be missing something but this code seems racy, especially since
the history is relatively short at this point. It seems like it's
plausible for git log to be able to dump its output entirely before the
pager part even runs. In that case, it'd fail due to success being its
exit code since it wouldn't be killed by SIGPIPE. 

This is what my `test-tool pager` approach was hoping to prevent since
that would guarantee a SIGPIPE.

Sidenote, going back to 7559a1be8a0 (unblock and unignore SIGPIPE,
2014-09-18), it seems like those tests are also racy since it's
theoretically possible for all of the output to be produced before the
piped command gets to it. However, in that case, they're producing a
huge amount of output so this raciness seems mostly academic.

Thanks,
Denton

> +
> +	if test_have_prereq !MINGW
> +	then
> +		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
> +		test_match_signal 13 "$OUT"
> +	else
> +		test_terminal git log
> +	fi &&
> +	test_path_is_file pager-used
> +'
