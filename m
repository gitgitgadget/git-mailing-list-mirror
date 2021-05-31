Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE36C47094
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCCA6108D
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhEaHUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 03:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhEaHUG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 03:20:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA327C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:18:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id i5so7738793pgm.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WtW6nh0m9btJwM1o8W+dJckl9bficltbYqFHWmFYvB0=;
        b=jgnzmljlsabw1IOMlrnfcqZ8WW1V2W7xKspv1o578KcQgQWLTZI/36FZCKOUQBigz3
         JsTenTnCeAwIugCnY2WgbEsYZpNtWy1N0yfKfmdCL+GxxN76jILfmDkLx8vixM3EDtqT
         nb9z+as4a8wDcBUgN5xJgE7hUT7PQpfhLOWAE4uYXxtRR40LcCio/363IPVgyLCmZiPC
         EejUWElNa+3o372dcoSTt6aQjZbDdRIIPiVjzdAa0Ce6MStxSfKc+xpZWcsx9wBKv7z+
         Dn8K44ddYUzTRwtsUEwRyRev80QCMhLvjZH/r8JsPlSQJsyUBDlRdlqtRPeV+e7Ajs08
         gEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WtW6nh0m9btJwM1o8W+dJckl9bficltbYqFHWmFYvB0=;
        b=nW8NMT7VvTXHC9/5thz6WqIezf03Lv07v1fLzY6qORZMD9RS/Umne+0oZK95J/QcEJ
         zW66BWGLP2h7dG3JSbLsqqFFlzeDu3kbpI4BpVHOGBYvJgnbWLNqZgggc9XFXHvmhiff
         jB1XwBVSpBsPRblT8U/YomiH0mwldbsNTXmkHKOxfGIJYTtUCKOQXldElGDz92eFdfX1
         byarMxZSqA4YFn1cXCGrp3X1/eJFthqiXTz1OfQ+3Tx3hPeJCcZh/Q2D1yx4Z7ZvMFxI
         4V/3aHIPAtA1bROVQwHhf3POk4zvONVbD1d+yl1kwlqTlbv1eJ2bRS4fUGDsYHEO4Vte
         iC0A==
X-Gm-Message-State: AOAM532GAlj1dGwIV6FRo9iuoF5w/EHiGUf+gY94Fzq6ol3lMJni+Q/m
        ulwgJM3jL1xqPl+VUSwvnzBD5bd9FWs=
X-Google-Smtp-Source: ABdhPJxiYHseuZAgZVrNvFnHxb7EoVxxuWjnebA7UquKdvmITPcx0Y4MswQUPCHIZl84JqCA0QKgng==
X-Received: by 2002:a63:b10:: with SMTP id 16mr21589678pgl.90.1622445506322;
        Mon, 31 May 2021 00:18:26 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id v11sm7550434pju.27.2021.05.31.00.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 00:18:25 -0700 (PDT)
Date:   Mon, 31 May 2021 14:18:23 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andy AO via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Derrick Stolee <stolee@gmail.com>, Andy AO <zen96285@gmail.com>
Subject: Re: [PATCH] describe-doc:fix a obscure error description in the git
 log documentation
Message-ID: <YLSNv8Xw3SVzYm8r@danh.dev>
References: <pull.1030.git.git.1622440856607.gitgitgadget@gmail.com>
 <YLSGasYc4wVoOfYt@danh.dev>
 <xmqqmtsbv19u.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmtsbv19u.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-31 15:57:17+0900, Junio C Hamano <gitster@pobox.com> wrote:
> > I think you meant:
> >
> > 	git log -1 >/tmp/no-decorate
> 
> Yes, and this (with redirection to file), I think you do not get any
> decoration---that is what you get from --decorate=auto, i.e.
> 
> 	git log --decorate=auto -1 >/tmp/auto-decorate
> 
> I think the default discussed in the paragraph the patch touches is
> "what happens if you do not say what kind, i.e. "--decorate" not
> "--decorate=<what kind>", so "the default is 'short'" is correct,
> but at the same time, "even if you do not say --decorate, you'll see
> short decoration when on a terminal" is worth mentioning somewhere.

I forgot that I have log.decorate configured to 'short'. *facepalm*

I think something like this should be nice.

----8<----
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1bbf865a1b..0498e7bacb 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -39,7 +39,9 @@ OPTIONS
 	full ref name (including prefix) will be printed. If 'auto' is
 	specified, then if the output is going to a terminal, the ref names
 	are shown as if 'short' were given, otherwise no ref names are
-	shown. The default option is 'short'.
+	shown. The option `--decorate` is short-hand for `--decorate=short`.
+	Default to configuration value of `log.decorate` if configured,
+	otherwise, `auto`.
 
 --decorate-refs=<pattern>::
 --decorate-refs-exclude=<pattern>::
---->8---------

Andy, feel free to pick this up and re-wording however you like.

-- 
Danh
