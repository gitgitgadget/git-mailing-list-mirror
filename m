Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1290FC2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 17:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F5D613B4
	for <git@archiver.kernel.org>; Fri, 28 May 2021 17:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhE1RY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 13:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhE1RY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 13:24:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31A4C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 10:22:50 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w127so4929587oig.12
        for <git@vger.kernel.org>; Fri, 28 May 2021 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yhScdywk4PnIZORepdj5E663b7EUA5RyXNvBYj3kzzc=;
        b=WhZk3DF/EIaAkTsD/G0Gs4q1xZoaLx7ZDVywMJv9OuS1MkIcrBblktopGkAcpr0Pst
         m8oWEVVzqtjQxAMLmEnaYiKzgxQluqEwZVsQfBGvcwMnnxlWAW4isASFBWgF68kU7z9m
         yvjD0NbTRJZUn1aB2PZf6j4lMtrh8B1ZRYytuQsPyy4L68qAVVZE6YAlTaUY8rGsjY+h
         t2lQRXYuKvqVwbZrTA02IK1S5KTIUhRpL8rXhFcvJptEJU2HD4sJDhfVjhi6QU3kN2IQ
         RF4shOjvEPW7e2LtdnYkpCrTpJ23xyrbzsaPdG+UG7r72nH7+9c/fME6vdTXvGosM612
         rXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yhScdywk4PnIZORepdj5E663b7EUA5RyXNvBYj3kzzc=;
        b=hx81fF6BbUYZAW43JPO18uBSvCbSA+lOEI/5nBymV35nOdNBLnxWN+kyUxvdOX+KC4
         P67i6OFEMFA7zAbPkjwnSyrgVKV48dRWgUrYBb67wms7nK9vUxNGxqL7UMzl36Yisv8J
         DJBkrTEMy4dFQ/7aHrNPSy7b3CZ5Oq/WEAfOaH9KaPQrCI89bu/T6Bb7Afu7b0tXGBMm
         uHCJV1gGe/dv2z0xeHEVB4ATjrPeiYynjSPgsH7JI+uP06yrQavoByABxkpAkxhpjfQj
         lBm77opMnOtkrNp1JrausbR1baG9ubJSs5FVNA/37bUtrs784OPOTdydtY1ddg0onuZf
         3p7A==
X-Gm-Message-State: AOAM533/qljCraBKyqwz9ek2GQPxRsGC+9fmcP2YkJ/pWEUnaCF7hbpP
        gGFAM36Ioljqkn5PREZvQQbza+9+vIE4hw==
X-Google-Smtp-Source: ABdhPJyIAX6UzKiy/DDvvAT99Ork+bdiCbq8TnZflPT5r3cYcvHxndXpC6wS20twHW4Sr6ZIOFmesw==
X-Received: by 2002:aca:120c:: with SMTP id 12mr6543836ois.42.1622222570360;
        Fri, 28 May 2021 10:22:50 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i2sm1254544oto.66.2021.05.28.10.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 10:22:50 -0700 (PDT)
Date:   Fri, 28 May 2021 12:22:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <60b126e8cf42e_51908208d4@natae.notmuch>
In-Reply-To: <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
 <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
 <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
Subject: Re: git push doesn't use local branch name as default
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> > If there is no upstream, then there also is no "remote I normally pull
> > from", and thus, according to the doc, `simple` should actually work
> > like `current` in this case. Am I wrong here?
> 
> The relevant code is
> 
>     return (fetch_remote && fetch_remote != remote);
> 
> so you only get the "current" behavior when fetch_remote is non-NULL.

fetch_remote is practically never non-NULL.

fetch_remote is remote_get(NULL), which is basically the equivalent of:

remote_get(remote_for_branch(current_branch, ...));

Typically when an upstream branch is not configured, this is the same
as:

remote_get("origin");

The only time fetch_remote is NULL is when the configured remote is
invalid.

So you don't get the "current" behavior when pushing to "origin".

Perhaps:

--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -29,8 +29,8 @@ push.default::
   different from the local one.
 +
 When pushing to a remote that is different from the remote you normally
-pull from, work as `current`.  This is the safest option and is suited
-for beginners.
+pull from (typically "origin"), work as `current`.  This is the safest option
+and is suited for beginners.
 +
 This mode has become the default in Git 2.0.

-- 
Felipe Contreras
