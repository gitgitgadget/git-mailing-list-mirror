Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B60C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 19:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDGTKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDGTJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 15:09:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF561B0
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 12:09:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i9so43036196wrp.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680894588; x=1683486588;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W44KOqWM46mxjfczqnH4UHG03aHqtgIxxmUMAH+DVtw=;
        b=Iy/Rab2FC31mQruFohW/VBSJOxryAGrAZ369X/P6SVGpHWXB9+HUHPmC+4A4CjdJbV
         BElwKDkOns+i5Fr3o+CNOhdLdgMSqnNmxdiacRxEdyRAj9OmSu0KFtvHwek+R8icclI9
         eS879FXuREBw/PBmXB+FcwioTh1tftqJ+T6dM0Ta1OFCJSvf3HUS47dnTz+XQZaGXsTI
         p878n0LVDpziMEZ/Mju9rxbKQmJfi1EWlVK36QOaCRn2ilr+yrF6EaoWi5MeavH+mwx0
         Zw5XQgxBnLzHlBBVjPWYGCEvUQer1WRAILHrPSdTYaMZjkiV6DZuxgDSnrZNq111LLIK
         qdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680894588; x=1683486588;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W44KOqWM46mxjfczqnH4UHG03aHqtgIxxmUMAH+DVtw=;
        b=GG7KCt/vTkAqzNgB1ruK0V7K7LxefBbHf0QEV1+5f/xymvj8A3vJyuGjGr9YqRvnso
         JiSrJyZR9frHpT1P5vwsfyEwIJp2ARwvwSgOjvFekzCgEzbvy/F3kMGTGkZgx0Zqe0xF
         8yzecmUt1DwO/n/ICRpK0Mn+XKAPks0mW2dVnL57a3AUUhXFst7X1nYFmf8x9y57YMkK
         1XA8ODlltk3me0WbdhHTE6J2L5ASKOH9kx7AkkYRXnOnmzxQFSTHVna9h5syRFMt4Mvm
         7l3xY0QL3MYRyivoMG0t7ofRAHzF+zlr8KWGqmxL24To+s7gIKsoF2GOIv2fmjG5h+kF
         uepg==
X-Gm-Message-State: AAQBX9cNrb1hZQAt3PnZEoJQfoyL3spGXqP/xayySEPy4RawQdZwZRuh
        vUO1oZ/VapYu/iSWN3spZ2VB4mPttBI=
X-Google-Smtp-Source: AKy350YzkczoqCeddoXrDCelQ5cx683k6DAW5hgrSRvHB9qnVgEsyT/ceBR6wfj9HjflnUIujsP8wQ==
X-Received: by 2002:a5d:5046:0:b0:2cf:f467:54d9 with SMTP id h6-20020a5d5046000000b002cff46754d9mr2166285wrt.53.1680894588309;
        Fri, 07 Apr 2023 12:09:48 -0700 (PDT)
Received: from [192.168.2.52] (123.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.123])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d5183000000b002c59f18674asm5232775wrv.22.2023.04.07.12.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 12:09:47 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: add and apply branch_get() rules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
 <xmqqjzynlm9i.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <376aca6d-1b09-9bf9-c258-81e8ed2443c2@gmail.com>
Date:   Fri, 7 Apr 2023 21:09:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqjzynlm9i.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07-abr-2023 08:55:53, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > There are three supported ways to obtain a "struct branch *" for the
> > currently checked out branch, in the current worktree, using the API
> > branch_get(): branch_get(NULL), branch_get("") and branch_get("HEAD").
> >
> > The first one is the recommended [1][2] and optimal usage.  Let's add
> > two coccinelle rules to convert the latter two into the first one.
> >
> >   1. f019d08ea6 (API documentation for remote.h, 2008-02-19)
> >
> >   2. d27eb356bf (remote: move doc to remote.h and refspec.h, 2019-11-17)
> 
> Citing commits in the past is not an optimal way to justify a
> recommendation, though.

Well, my intention is to state that the recommendation is not recent.
Perhaps it is confusing to not state clearly that it is also current.

> > diff --git a/contrib/coccinelle/branch_get.cocci b/contrib/coccinelle/branch_get.cocci
> > new file mode 100644
> > index 0000000000..3ec5b59723
> > --- /dev/null
> > +++ b/contrib/coccinelle/branch_get.cocci
> > @@ -0,0 +1,10 @@
> > +@@
> > +@@
> > +- branch_get("HEAD")
> > ++ branch_get(NULL)
> > +@@
> > +@@
> > +- branch_get("")
> > ++ branch_get(NULL)
> > +
> 
> I am not sure about these rules.  Noybody is passing "" to ask for
> HEAD in the current code.  Neither
> 
>     $ git log -S'branch_get("")'

I'm not sure if there is any path that might use "", but the
consideration is there since introduced in cf818348f1 (Report
information on branches from remote.h, 2007-09-10).

> 
> shows anything.  The first one does modify existing calls, but there
> are many calls to branch_get() that pass a computed value in a
> strbuf or a variable.  Do we know they are not passing "HEAD" or ""?
> 
> Stepping back a bit.  What is the ultimate goal for this change?

Of course, as you pointed out, there are usages where a computed value
is used, perhaps coming from the user, which might end up specifying
"HEAD".  Those usages of branch_get() are not considered here.  Not even
indirect ones.

Having said that, the goal in this change is to aid following, now and
in the future, when using a literal with branch_get(), the
recommendation we already have.  Which, IMHO, is also the optimal usage.

As a collateral, we save some cycles; either at runtime, avoiding the if
(!strcmp("HEAD", "HEAD")) to the user; or better, at compile time,
saving the compiler from optimizing out that strcmp.

I have to admit I have this change in mind, not in the current form, but
in the same direction, since my patches for builtin/branch.c, a few
months ago.  When, reviewing the use of branch_get() I was a bit
confused.

Thanks.
