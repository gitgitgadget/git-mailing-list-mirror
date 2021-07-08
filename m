Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF864C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 16:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F5161874
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 16:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhGHQIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 12:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhGHQIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 12:08:43 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15EAC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 09:06:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 37so6524715pgq.0
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MJSu5euroakqlHWXT2HpbsDbIDx/XNHRffCCH54HFL8=;
        b=pROJWO0yW9r8bgBpexJPVdoL4NdHSgLDcLO7E4YGvw3efvxflVIHLU5AehJMgMCCGO
         EotI7Q62ARgZfN7wIDyoOPmmfwkgCcFr2QBET8iTVtvTSmw1fMvWlVWEGI2o7bDhzw72
         q9UNjHwi8eZNgKuhAHlHNhRxyOnkyzmNiAdDg0LlwYoXWnGODPghVxlkIwUa2VT+97wW
         VNFKN6Eoz4Zr811f9tHJpGPpQTiYgZmSmhTmgUMMPiikZ6ZxmFEgg2hFENvBC1nQbnWs
         +qQSdqdlNINwodVz9/L7bM2uNk+il37jJW09cFRRDm2DGH7fBWq3WiDouLaZbPUQG5Kz
         x8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MJSu5euroakqlHWXT2HpbsDbIDx/XNHRffCCH54HFL8=;
        b=kDLTHzVrxC3jRD7qHmXjGcB+o2qW5hh3XuzPveTJFIC90oXpbp9yXRQKC9rBL7o4Hu
         ijR6+yTT+/vWl03Q/ucfCzsd5FXDw3hxtCNI4hM/gyU6HR1uevLP4cfDhxu4x+j/Zqal
         0sZ8mFRDrlZNFuKHm1AgxgjWmvnHke30oJKEjkjzN1J3nIHDmHsWLo8E13las6fv1gR2
         dogzNUnXwQETt1GN6h/fByPsOuZdrT/CFNGHIHtjkF+VbGHAq0BR6vwbCXKtqCUlUeMb
         g6IbTcGNSXR3yJQfNINRg7qiCEEAjkFwf4YULAhwrpmpCPI2PYgMyVtJfw4vq9iTHadU
         og5Q==
X-Gm-Message-State: AOAM531/L0aYTkA5+7CODa67qSincJVwb8LQbOSP9IlLbvCaulYDbv4Y
        lu1P3CwFqCHCXhM/fvGk5Ds=
X-Google-Smtp-Source: ABdhPJw2haMeDbFBVDy5xoEmP/q1F18TQLLnoqZduCU+KeD/pXSv3t9KuHy9wTRgKAIo0opTX8ryug==
X-Received: by 2002:a62:e40c:0:b029:317:3367:c5db with SMTP id r12-20020a62e40c0000b02903173367c5dbmr32306002pfh.62.1625760360445;
        Thu, 08 Jul 2021 09:06:00 -0700 (PDT)
Received: from localhost ([2402:800:63b8:9039:443b:57cf:40b5:f8d1])
        by smtp.gmail.com with ESMTPSA id f69sm3354445pfa.24.2021.07.08.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 09:05:59 -0700 (PDT)
Date:   Thu, 8 Jul 2021 23:05:57 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Hu Jialun <hujialun@comp.nus.edu.sg>
Cc:     git@vger.kernel.org, gitster@pobox.com, felipe.contreras@gmail.com
Subject: Re: [PATCH] commit: remove irrelavent prompt on
 `--allow-empty-message`
Message-ID: <YOciZUlWnF5ur5ec@danh.dev>
References: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
 <20210708151911.2524122-1-hujialun@comp.nus.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210708151911.2524122-1-hujialun@comp.nus.edu.sg>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-07-08 23:19:11+0800, Hu Jialun <hujialun@comp.nus.edu.sg> wrote:
> Junio C Hamano wrote:
> > char *hint_cleanup_all =
> > _("Please enter the ... , and an empty message aborts the commit.\n");
> > char *hint_cleanup_space =
> > _("Please enter the ... if you want to.\n"
> >       "An empty message aborts the commit.\n");
> >
> > if (allow_empty_message) {
> >         hint_cleanup_all = _("...");
> >         hint_cleanup_space = _("...");
> > }
> >
> > ... the if/elseif cascade in which calls to status_printf() are made
> > ... using these variables
> 
> Would it be better this way or just using the ternary operator in-line
> instead? If the latter, should it still be separated into another
> variable or just embedded in the status_printf call? Using the ternary
> operator does require to separate checks of allow_empty_message, but
> might as well save us an `if` construct to reassign the variable.
> 
> In other words, which of the following 3 is the most acceptable?
> 
> 1. As Junio suggested, quoted above.

I think this approach is the most expensive one, _() needs to query
the gettext infrastructure, which is usually costly.
However, I think that cost doesn't matter much since we're about to
open an editor soon.

> 2.
> status_printf(s, GIT_COLOR_NORMAL, allow_empty_message ?
>                                    _("...") :
> 				   _("...."), comment_line_char);

install_branch_config() uses this style.

> 
> 3.
> const char *hint_foo = allow_empty_message ?
>                        _("...") :
> 		       _("....");

builtin/remote.c:show_local_info_item() writes:

	const char *msg;
	if (condition)
		msg = _("some message");
	else
		msg = _("other message");

So, I guess it's fine either way. And people will need to see the
patch to see which one is better.

> ......
> status_printf(s, GIT_COLOR_NORMAL, hint_foo, comment_line_char);
> 
> --------------------------------------------------------------------
> 
> Felipe Contreras wrote:
> > In git the style is to avoid braces if the content of the condition is a
> > single line.
> 
> Đoàn Trần Công Danh wrote:
> > In Git project, it's enforced to have -Wdeclaration-after-statement,
> > IOW, move all declaration before statement.
> 
> Noted with thanks!
> 
> > After changing those texts, the tests should be updated, too.
> > It's a customary service for the next developer, who needs to bisect
> > this project to have all test-cases pass on each changes.
> > 
> > With this change, t7500.50 and t7502.37 runs into failures.
> > Please fix them here, instead of next change.
> 
> I did change test cases accordingly in the second patch (excerpt below), and
> both tests did pass afterwards. Was there something wrong with it?

Yes, when apply both 2 patches, the test passed, however, the test
doesn't pass with only 1/2 applied. Let's imagine in a near future,
some developers need to bisect some problems with Git with automation
scripts, and git-bisect stops at 1/2, since the tests report failure,
"git bisect run" will mark this change as "bad commit", thus render
git-bisect hard to use. We should make sure all tests pass on all
commit.

> And some perhaps rather noob questions below, as an (overly) curious
> newcomer,
> 
> - Why is the "lego" style breakdown of translation strings unrecommended?
>   I suppose it might be in consideration of possibly different linguistic
>   sequences across languages but I'm not so sure.

Let's imagine an artificial language which have 2 words "linos" and
"linas" which is both translated to English as "lines", translators
need full context to decide which word should be chosen. Things maybe
complicated with language with gender, word-cases, etc...

There're some problems reported on and off this list [1]

> - What is the rationale behind prohibiting braces around single line
>   constructs? It seems somewhat error-prone since somebody else could
>   later be adding statements into the body without putting the curly
>   braces.

Documentation/CodingGuidelines said so ;)
I don't think somebody adding random statements is a valid concern for
brace, I think it's expected to analyse the code context before doing
real-work on project. Furthermore, -Wmisleading-indentation is your
friends.


1: https://lore.kernel.org/git/20210509215250.33215-1-alexhenrie24@gmail.com/

-- 
Danh
