Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B34EC636D3
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 18:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjA3Sy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjA3Sy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 13:54:26 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209BA6582
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 10:54:25 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so649404pjb.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHqvoHBQPzvU4lvUlOtxswxs9r0S8uRZiIGWIwgIfF8=;
        b=kJDuxQ9BEsbn0A0kMqSeOuqF3Tp5DVzK/GXNWrGhXs9OZ50TO45btbvnPxJIH7qWyU
         q8PME/PL2c4FsbwC3++3U3CpfzfzkNqLATV4CWWzIx/u5sQSj9f4l1wZnlQrOT8s+PEr
         LTBLkgGqi+kueDj5dUSPbPmykuD1iXNRHpG/n2bb4W7bua5rqwjr8tEFOJYfSZN1tqqO
         9xav4rZVnobsoQ4G/t4CNvgLDAZxd5sbd3Rg2qY3k4LGAbTFYDsm9B1owxqWa94kKEmv
         PpN7bPWx2LknOqNvysSj3V3tsZEvRYcl4gfMJflb9iUzTK5rFGlLTdmaIflaNQAJBlMs
         wzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PHqvoHBQPzvU4lvUlOtxswxs9r0S8uRZiIGWIwgIfF8=;
        b=Tsn6ooQHxsHo/wSBxfNBAEupvDCv5WPdM85gwac0r+KeAYBOSy8b1aWA6ApkiBLKmX
         kyZxG/AcB67xgO0Gytp7zb3hFspRx3VqnZQ71Tc1ipA+aybfT05V8YmYmgtM/LktwWPm
         18pyAyPcjH4OOyzg0IFWgazzQBXGw98W1TKtA9fi8fTuPylRDhp6QcPgS48RLvhjGi7B
         GKzkwArTJ6gF4UJP1qL3mdVAQlIrc60nDTQJ58gFJ02qIo/2iz/EZa01xLR53YjXwbxy
         hpSwtdjH1EtLahe+SPLd6399lgDs2uAf3f7vR8IeN+HSlC183ve+dYnxG1TiRhhjLMIQ
         BWdQ==
X-Gm-Message-State: AFqh2krk+xtMgSMJN1KbkEAgwU0HajmSGVbTlksJbgeoyd7M7mKTW/RF
        G6XF/dHxndVT+TNEXeer16M=
X-Google-Smtp-Source: AMrXdXtsthp6FwRapIvHwXNphaJitVUQue54Osyq7JY+mkAvfsPJiJ0c5X33E3oyjGE1XzCkxAlR1g==
X-Received: by 2002:a05:6a20:d80e:b0:ac:b2a3:e39c with SMTP id iv14-20020a056a20d80e00b000acb2a3e39cmr48550486pzb.62.1675104864489;
        Mon, 30 Jan 2023 10:54:24 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id e17-20020a656891000000b004768b74f208sm7282464pgt.4.2023.01.30.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:54:24 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
        <xmqqbkmk9bsn.fsf@gitster.g> <xmqq1qnfancf.fsf@gitster.g>
        <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
        <xmqqk0156z55.fsf@gitster.g>
        <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net>
Date:   Mon, 30 Jan 2023 10:54:23 -0800
In-Reply-To: <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net> (Mathias
        Krause's message of "Mon, 30 Jan 2023 12:08:45 +0100")
Message-ID: <xmqq357r4zvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Krause <minipli@grsecurity.net> writes:

> My patch doesn't make it worse than what 'git grep' would currently be
> doing. On the contrary, actually. It allows me to use PaX's MPROTECT and
> have a functional 'git grep' as well.

I know.  But then without the "why did it fail?" logic (i.e. the v1
patch), it does not make it worse than the current code, either, and
of course allows you to use JIT-enabled pcre2 even where JIT is
impossible due to MPROTECT and whatever reasson.

> Maybe the missing piece here is simply something like below to make
> users more aware of the possibility to disable the JIT for the more
> complex cases?:

If we were to keep that "die", it is absolutely required, I would
think.  Users who got their Git with JIT-enabled pcre2 may be
viewing JIT merely as "a clever optimization the implementation is
allowed to use when able", without knowing and more importantly
without wanting to know how to disable it from within their
patterns.

But can't we drop that die() if we took the v1 route?

> diff --git a/grep.c b/grep.c
> index 59afc3f07fc9..1422f168b087 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -357,7 +357,8 @@ static void compile_pcre2_pattern(struct grep_pat
> *p, const struct grep_opt *opt
>                         p->pcre2_jit_on = 0;
>                         return;
>                 } else if (jitret) {
> -                       die("Couldn't JIT the PCRE2 pattern '%s', got
> '%d'\n", p->pattern, jitret);
> +                       die("Couldn't JIT the PCRE2 pattern '%s', got
> '%d'%s\n", p->pattern, jitret,
> +                           pcre2_jit_functional() ? "\nYou might retry
> by prefixing the pattern with '(*NO_JIT)'" : "");
>                 }
>
>                 /*
>
> (Sorry about the wrapped lines, my mailer is just broken. I'll make it a
> proper patch, if such functionality is indeed wanted.)
>
> Thanks,
> Mathias
