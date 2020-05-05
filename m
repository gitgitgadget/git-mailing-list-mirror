Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A2C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2F9206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo2GkDNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEEAel (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgEEAel (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:34:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D332C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 17:34:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so107399plr.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 17:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6HtY8hixPrDEkZOAgoXUcS1BZscWTMvwWQdkTH5coEU=;
        b=jo2GkDNnaQJmxbyX6q9vsXSBKWYM7Ei63rPU0J6NYvOlXtXmxjhaE8NwJap6acn9PY
         vfJLG1QgdsX7DHnZNFTkMC5R8HsYD/HAeChA0qPAeQdyyoY47qxWmLAlehY875j/HJrr
         46dQ6Xq1cY/N903SE/CxLwznU3eJRF7ML5cc0lRZYCPhqzsQcapNODuFfVYjw4dmYQA1
         HNhJTCtbJAeYRyZnfOVTiplP6wLVDbjfQ7odcCXpcQ0eGmJYklWxT4UZUImuLFCPPz8w
         XnhXT7f/ss69rIDQ9Kr2+WtSD5SxSmnUinqKgmnZklblB2X4HnwHRmH01k8fqII7UMbD
         4c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6HtY8hixPrDEkZOAgoXUcS1BZscWTMvwWQdkTH5coEU=;
        b=XiIx9jdCrReuGnmHN3YAp9BciBaam+1d2x3E6NsQDV8zqp+p3BWHGfKITChHyWM7t4
         ulH8aKhH5nRyWP0Ou5KUHL4kNyT6TdMBGu1DLhe8qux6mmUA7GN4mQlu79Np0Xp+181h
         FofMAglppc1f30Q3fVDjtprolaZ9x2Rk5w96hNDkt+yQzuGjvWlajl6rRD4rPCQYk7+Q
         CXXfntJqNhcB6PQi4dcp6hrkln5xHUc5U1+8Zc5CLKXulCduphuiggGvdtd6b4mjTCn2
         QYh9I2heiLIY8gtl1UxIItFxDk9/cmkDzqfABziWCMGS+lVK3h+iicbbeZSdM/mjC3U7
         Ki+A==
X-Gm-Message-State: AGi0PuYdKTqg4mVhS4DNj5hVIWMxdBbEuFJUXaFKfaabEtZKEN+wjcx/
        TIe+onQZs4fQ0QrGwNVKRyq//Uvm
X-Google-Smtp-Source: APiQypLXyFUcUZ0wCC2HWzQYQOWyXMwvBSu/YjGdeDphW+4Uts3AGMJMNEhmkCVIcBQYnxNdEqBDlQ==
X-Received: by 2002:a17:90a:2365:: with SMTP id f92mr46705pje.117.1588638880552;
        Mon, 04 May 2020 17:34:40 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id y7sm263551pfq.21.2020.05.04.17.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 17:34:39 -0700 (PDT)
Date:   Tue, 5 May 2020 07:34:38 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200505003438.GA927@danh.dev>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504162311.GE12842@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-04 12:23:11-0400, Jeff King <peff@peff.net> wrote:
> On Mon, May 04, 2020 at 10:49:31PM +0700, Đoàn Trần Công Danh wrote:
> Doing "**" here makes sense to catch everything (it would be even better
> if we could just say "everything with a pull request" by omitting the
> branch filter entirely, but maybe that's not possible).

When I was doing this, I couldn't create a fork of my fork to check
the syntax for GitHub PR. So, I pick a safe step.

Turn out, I can create PR against my own fork.
And, it's possible to omit the branch filter entirely.

> > +    tags:
> > +      - '*'
> 
> Would we want that here, too? I guess nobody is likely to push
> "foo/v1.2.3".
> 
> Or on the flip side, would we want to tighten this? If I push a tag
> "wip", I probably don't want it built. Probably the right rule is
> "annotated tags only", but I suspect that's not possible.

From my reading, GitHub Actions only accepts filter by refname.

From GitHub manual, we can limit tags selection by: 
-------------8<------
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index adf8824af1..9bba0ce068 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -11,7 +11,8 @@ on:
       - pu
       - 'for-ci**'
     tags:
-      - '*'
+      - '**'
+      - '!**wip**'
 
 env:
   DEVELOPER: 1
---------------->8-------------

But, I'm running into GitHub internal error with this snippet.
I'll look into it later.

> 
> > +  push:
> > +    branches:
> > +      - maint
> > +      - master
> > +      - next
> > +      - jch
> > +      - pu
> 
> What happened to "for-ci" (presumably "for-ci/**")?

Hm, it was lost when I created a lot of branch for testing and I send the incorrect one out.
It'll be correct next time.

-- 
Danh
