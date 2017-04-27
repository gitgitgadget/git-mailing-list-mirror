Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2802E207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 00:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754767AbdD0A5M (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 20:57:12 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35191 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754764AbdD0A5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 20:57:10 -0400
Received: by mail-it0-f67.google.com with SMTP id 70so610038ita.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 17:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FkBpba7NCYje21fAR6fkdInh5vnY6tNrShlZ7acPmsM=;
        b=thouMS2nSl4V11sDodbnmlAN7U5ou4RYi5uQx7g9EBVoYkPM7idaC5nDc1YJ5d3s9i
         Yx9mrJfut0O19idDaJjn+cH9zTbtHq8W7sPLu8fS+M2jV+BhIb6WxefbA6pVOTA8nlpG
         YXPpfIuixO5mc+VSf+MC3CoVk9lR2yRSHS8kGQU0j3JHG8vEA9bjn+EejB4T35N/lJb4
         6XFdqcR/4dqdcDzPflP587j/FT2/3lGuogj3wCzrym8AS+PjFkePHNj+ta8T0/fEPnWw
         7aWqvEs7iS+AhpSM4BoxKI7m6s2dCjw6bJHQz6BME13kC4dREIxd6eb6HrRcdPauUXXn
         K0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FkBpba7NCYje21fAR6fkdInh5vnY6tNrShlZ7acPmsM=;
        b=CMQnRbWnQs3GfQ24cbv7LJOVk2enuao97YA+Oc9Sxx1vmSxzHXYIHXkOIeRYnsPc/4
         dnMIbRT0MVLVvjVsyX649N3FVOowcJe36/9E+oqNeDxZJP7eOcSorYDULcdNUCdq+yiZ
         FEC8QVAqOBS+rQEysD9Me20KJZESR5LS9rYzPOKT54Y/YGSwBO7vSUHXEZKEXRBdOAz2
         IuvVFQESuLSLCUUWfYJ4lNCPHtjmTODlHxVVu4HfQ0mdIP6H+h1mkDDmC5nZ/DoowhQa
         LFa0B0wnUY/rrSH42v/uk41iNgWonp/8G8wc0F08vCDCvfhRxhA7xi5qcNm3SFREQ40X
         dV7w==
X-Gm-Message-State: AN3rC/6jiNar4IUaTOjfuSPJk/+6IbEt02s4arB3SnKlxhTizeTMQZ/2
        qJgGf2LB1z4Qxw==
X-Received: by 10.36.253.73 with SMTP id m70mr942145ith.19.1493254629731;
        Wed, 26 Apr 2017 17:57:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id w134sm441631iod.14.2017.04.26.17.57.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 17:57:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/15] remote.c: report error on failure to fopen()
References: <20170420112609.26089-1-pclouds@gmail.com>
        <20170420112609.26089-8-pclouds@gmail.com>
        <3a2686c2-6766-1235-001f-1b5283b5f408@kdbg.org>
Date:   Wed, 26 Apr 2017 17:57:08 -0700
In-Reply-To: <3a2686c2-6766-1235-001f-1b5283b5f408@kdbg.org> (Johannes Sixt's
        message of "Wed, 26 Apr 2017 18:59:20 +0200")
Message-ID: <xmqqwpa6pt0b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> +++ git ls-remote 'refs*master'
> +warning: unable to access '.git/branches/refs*master': Invalid argument
>  fatal: 'refs*master' does not appear to be a git repository
>  fatal: Could not read from remote repository.
>
>  Please make sure you have the correct access rights
>  and the repository exists.
> +++ exit_code=128
>
> On Windows, it is not allowed to pass a file name with an asterisk to
> the OS. The test case contains this comment:
>
> # We could just as easily have used "master"; the "*" emphasizes its
> # role as a pattern.
>
> So, can we replace the name with a simple "master", our would this
> miss the goal of the test case? Should we make it conditional on the
> MINGW prerequisite?

I would actually be more worried about the real-life impact of this
change.  Those who did "git ls-remote 'refs*master'" merely got "it
does not appear to be a git repository" and that was entirely sensible
response from the command.  Can Windows folks live with an extra
warning before it, or do they object to see that new warning?

