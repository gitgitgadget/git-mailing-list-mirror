Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A6C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 08:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243981AbiFVIVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 04:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbiFVIVU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 04:21:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD7F381A4
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 01:21:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id pk21so9428597ejb.2
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jiKGrIvkJUFx0Y32hKI/vcXpElIoqAiKlW0ZeVJX1ik=;
        b=Tph6Rzdfz/xXnZaZuhei8NEVD+YVqk3nyf0tsOPCLH2erXauPq6dtcEXe0A8JRxtLY
         mldIqVuptb/YB6kdgl92+XhMTk72Qep1W+fEurlzZjWYyw9fiEmdudNe8pcxEowHWeDW
         RotpU89rmJ4ulmENqFPUhcdez9DXro2z2MRKYwEYo9+zqTgblXDR2xxwVLORtPxW+Pw8
         SkqMLousugP1eGxLu4tRgooy2lq+yXWQUSkOH+YUWnxrYLhNZmbL39/9MAW9wnZmMH9s
         sBg+/Xdj1MbQC0mMzRBSNGwqjxzCuehRRCPaKJHZWYzOrMqMekRibQFqG7roylZsFW1E
         FykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jiKGrIvkJUFx0Y32hKI/vcXpElIoqAiKlW0ZeVJX1ik=;
        b=tcyiS0nq2UjO2MpU0dpk7wpD0ZqjHB79bg4g2yjXaT1gy0IQXv2CkrMBrfrnc2G/9h
         sdKfvEmNVmM3512qWAdK0vMo14vFV8BWcZFYA99aVukWVIbC9JLBJ5Ax1mIV5PAZAB9v
         qj9xlCDRtaI67on4QXLaADyDyvjuk2EJXKHV93bcExFZyUNah/SGy8xnAj1OEpOaaaKT
         MBr609H3y7nzuigP7/+sDS8ObYnCPtHsrKd6gEnmpmHebEH+NBqdCwNi3en9SxyRzEtR
         BsyyxBPVcM/x0UNVjOrfgl6Y8yYy7Ui+M5Sdn5d3XTzfKQCncnCKx61WaMmx95xQj8M1
         zm4w==
X-Gm-Message-State: AJIora9CitNcg7ftnGQeknaaQyriDOBSHdKESEh0YDJQp1ItnwuZijCx
        WwzWbWR+FMMwZJaoKnfE1LqZjk6YK9KYuw==
X-Google-Smtp-Source: AGRyM1tSAVzCpwwVjckkROSlKJN++hQx8rUFEyfmlxW5PMbOOax6bMeg7BizpJ4Qj/OIzWf/EoaXmQ==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr1917844ejc.243.1655886077540;
        Wed, 22 Jun 2022 01:21:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906309500b00706287ba061sm683535ejv.180.2022.06.22.01.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:21:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o3vbv-000axW-NM;
        Wed, 22 Jun 2022 10:21:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dimitriy Ryazantcev via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: Re: [PATCH v2] i18n: mark message helpers prefix for translation
Date:   Wed, 22 Jun 2022 10:12:51 +0200
References: <pull.1279.git.git.1655819439775.gitgitgadget@gmail.com>
 <pull.1279.v2.git.git.1655819877758.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1279.v2.git.git.1655819877758.gitgitgadget@gmail.com>
Message-ID: <220622.86v8stkt1g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 21 2022, Dimitriy Ryazantcev via GitGitGadget wrote:

> From: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
>
> Some messages prefixes like 'usage:'/'fatal:'/'warning:'/'error:'
> were not translated.
>
> Signed-off-by: Dimiytriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
> ---
>     i18n: mark message helpers prefix for translation
>     
>     Some messages prefixes like 'usage:'/'fatal:'/'warning:'/'error:' were
>     not translated.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1279%2FDJm00n%2Fl10n-fixes-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1279/DJm00n/l10n-fixes-v2
> Pull-Request: https://github.com/git/git/pull/1279
>
> Range-diff vs v1:
>
>  1:  efcf217b361 ! 1:  6f389468631 l10n: mark message helpers prefix for translation.
>      @@ Metadata
>       Author: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
>       
>        ## Commit message ##
>      -    l10n: mark message helpers prefix for translation.
>      +    i18n: mark message helpers prefix for translation
>       
>      -    Some messages prefixed like 'usage:'/'fatal:'/'warning:'/'error:'
>      +    Some messages prefixes like 'usage:'/'fatal:'/'warning:'/'error:'
>           were not translated.
>       
>           Signed-off-by: Dimiytriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
>
>
>  usage.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/usage.c b/usage.c
> index 56e29d6cd6a..5a7c6c346c1 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -33,7 +33,7 @@ static void vreportf(const char *prefix, const char *err, va_list params)
>  
>  static NORETURN void usage_builtin(const char *err, va_list params)
>  {
> -	vreportf("usage: ", err, params);
> +	vreportf(_("usage: "), err, params);
>  
>  	/*
>  	 * When we detect a usage error *before* the command dispatch in
> @@ -58,7 +58,7 @@ static NORETURN void usage_builtin(const char *err, va_list params)
>  static void die_message_builtin(const char *err, va_list params)
>  {
>  	trace2_cmd_error_va(err, params);
> -	vreportf("fatal: ", err, params);
> +	vreportf(_("fatal: "), err, params);
>  }
>  
>  /*
> @@ -78,14 +78,14 @@ static void error_builtin(const char *err, va_list params)
>  {
>  	trace2_cmd_error_va(err, params);
>  
> -	vreportf("error: ", err, params);
> +	vreportf(_("error: "), err, params);
>  }
>  
>  static void warn_builtin(const char *warn, va_list params)
>  {
>  	trace2_cmd_error_va(warn, params);
>  
> -	vreportf("warning: ", warn, params);
> +	vreportf(_("warning: "), warn, params);
>  }
>  
>  static int die_is_recursing_builtin(void)

I posted this patch[1] to do the same a while ago, except it also
translates the "BUG: " message:
https://lore.kernel.org/git/RFC-patch-20.21-69426ddb992-20211115T220831Z-avarab@gmail.com/;
I was meaning to submit it sometime soon, one thing it depended on was
the recently merged ab/bug-if-bug series (4da14b574f2 (Merge branch
'ab/bug-if-bug', 2022-06-10)).

It's more complex because it's handling the "BUG: " case, and was part
of a more general change to allow us to emit file & line numbers (as
with "BUG: ") for these usage/fatal/error/warning messages.

That being said I don't mind this smaller change going in first, but
it's perhaps worth noting that you're explicitly omitting one "message
helper" variant (BUG), and that unlike for most i18n messages this one
uses "lego", i.e. forces the message order to be LTR, so we'll still
need to further adjust this for RTL languages (the same is the case with
my patch).
