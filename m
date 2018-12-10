Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C22D20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 07:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeLJHAf (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 02:00:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44494 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLJHAe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 02:00:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so9212827wrt.11
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 23:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ABIRDJL7xhqEPovtQyBN9ThBC6Xstky/V82VQoJV6V4=;
        b=RqDrIc766Jkhx34nFgFq+AEIORzl/QxwKLAp/LL3e4uoZsM1kish1k/X269/nyFzQY
         CoId0DEalojXRZAKzRncNf3XRH9HRboDKLKNrftd/TR9y/jBca8FqfA3EahGIUZVSVTQ
         iNS0/Jr/k4FIMWd+ysY4LK7JxBPpGOgmo7uoYNKwlDvRCi5RVOwMLqhw1wXBa0VL9yW6
         OYAPQ4c6pPBL5IGEUx+YLk8T639t6YICZ2GWJ2pvhYF2MEbSkCEvDgW62pb7N7fvZVLD
         dVrM5LFRaqSzlCCp2aBCAgc3jLfh8vAxtp2WfrDc7/wpesD5ZTVKFpKJNtRUTEaHLT7U
         dHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ABIRDJL7xhqEPovtQyBN9ThBC6Xstky/V82VQoJV6V4=;
        b=uJiZTBpNkIQGIw8h6vw7KB9W/dwh48TGVAq5L6jPnszznsZeRFArBedT3VRjCiJnVq
         +/1w4hYTtdSDw5Zk/YZHMydaB3AK4pzzjHis8+wjQHmmR2jQKaFD+Fy41fLB73Lu++I6
         glWPcZtlyjaEsdikyLkyyVvpJBzOj3XVWwsqiBcms2lwD26M5CIU48s0LgGw3vE4ji4I
         VisNwXi2yUn3v0OntvN2ne77GmVr7RUHQ7GZnOXunDfaLvidDExf0ZMhnOY19UI4Qx9C
         o+yRrOwj2aD7QQsn1kQN6AY/Ugl9VpiHwTTuW9IzDErJS2v0D9ujUY2ewIvHeCwHklD8
         Jdkw==
X-Gm-Message-State: AA+aEWbSXvMCVI34R/yPifoY3HMGphpJuCjQwVayOf/61aNlyLGfAfTO
        qMwvQbJ5Rfj4GHj0VZIXDD4=
X-Google-Smtp-Source: AFSGD/WiXDCrwbm4lo7IktUcmdSA50RxzAymo40vGTiz3sTa+pDOZbpzYw9LE9A6BTFlUUp8zQk2zg==
X-Received: by 2002:a5d:4fcb:: with SMTP id h11mr9137897wrw.139.1544425231594;
        Sun, 09 Dec 2018 23:00:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q12sm8452272wmf.2.2018.12.09.23.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 23:00:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [RFC PATCH 2/2] grep: fallback to interpreter if JIT fails with pcre2
References: <20181209230024.43444-1-carenas@gmail.com>
        <20181209230024.43444-3-carenas@gmail.com>
Date:   Mon, 10 Dec 2018 16:00:29 +0900
In-Reply-To: <20181209230024.43444-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 9 Dec 2018 15:00:24 -0800")
Message-ID: <xmqqh8flkgs2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> starting with 10.23, and as a side effect of the work for bug1749[1] (grep
> -P crash with seLinux), pcre2grep was modified to ignore any errors from
> pcre2_jit_compile so the interpreter could be used as a fallback

That may (or may not---I do not know and I do not particularly feel
the need to know or care about pcre2grep that is somebody else's
project) describe what happened in the pcre2grep project, but it
solicits a "so what?" response without the rest of the sentence you
omitted.

I am guessing that the missing end of the sentence is "we should
follow suit because ...", i.e. something like

    Starting from 10.23 [of what??? pcre2grep's version, libpcre's
    version, or something else???], pcre2grep falls back to
    interpreted pcre when JIT compilation fails.  We should follow
    suit in "git grep", because ...




> [1] https://bugs.exim.org/show_bug.cgi?id=1749
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  grep.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 5ccc0421a1..c751c8cc74 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -530,8 +530,11 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>  	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
>  	if (p->pcre2_jit_on == 1) {
>  		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
> -		if (jitret)
> -			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
> +		if (jitret) {
> +			/* JIT failed so fallback to the interpreter */
> +			p->pcre2_jit_on = 0;
> +			return;
> +		}
>  
>  		/*
>  		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
