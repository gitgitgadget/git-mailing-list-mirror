Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0689C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 15:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC23206BE
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 15:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy2TmFOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgIMPFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 11:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgIMPFo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 11:05:44 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCCEC06174A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 08:05:43 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j185so8135875vsc.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0F3hA0NXlLGwRiP6OQRAxRjXOiIZ78kaSEy3QZ/JUw=;
        b=Oy2TmFOOeOTQyFFsGARuerRH+wF5DVe1VSj+eX3MMBhUrxUV/w1vtxj5C7Bmyzh4OA
         PhHL/FuXIBc5ZN1fhY72i39bimNweUuJ252a9hvuBb8RCb2kAprdWa8spScg4Rb4+QPI
         HpTFkBzV/PjrcQxfWTakDBHgepLd3+ARygiC3IXv4BlATHKoXZjFRcbI54nQfzd/N9tJ
         0XfoRf3d+I8cRev/rkXzJfW7HQgMxnfpJ57xNCJvktANlzM0f8N1pTOzGTiuMsuAoy/e
         BZZm6AhUBi1rj/BfWXdoPROJbCaHItvE3LW/zGXM3HpVGiW12grSq5ry2/u1qo/IORM8
         hayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0F3hA0NXlLGwRiP6OQRAxRjXOiIZ78kaSEy3QZ/JUw=;
        b=HM2D0Mr2Ca2eoCpIPWTTsGNGKhtQY+rOLhRl9CkucoJHvfVoCQD4jL2NhtAnsAybDz
         Q4I1sr3MRHDIAeP2OVjlgaBchr5eMmaI406uWLNoeplcivtYPolSbiql4K1etYkuC7mW
         Zaavn9GkDz0Q4N5//K81GqrZiMAN+KZwylH54X6D3acaqYE6F0DoCCLbXP3laJ/jHdji
         xdU8ZokasSnxJxVSsLcCTVABWzYYODNV5e7GH0mPKO4N2tgwmhOP5vzVkMOjDNvIqKQR
         XVa9CGekPQiJ48HW2pla9643/LZbqRNwRANiA8WT3ctte7j99qt/ABo60VtQszLFAZef
         81Pg==
X-Gm-Message-State: AOAM530Bqdzu+jXCUA9x/ewDNc3FsWqkG9fmxza+YXJU3dOOlgJmdcNS
        oOMaMaGeBeWOjgbo1uRL22T/r2wPAsMc9nq7mi/9q6j2
X-Google-Smtp-Source: ABdhPJxteXGJvz0uRTL8jM9UQ7KUqahWljeeVi/tT5rf9BpVG9r1giGQYILUkzxwYqBX2Q7yK2iMha1MnFblTeshf8A=
X-Received: by 2002:a67:7d52:: with SMTP id y79mr5356572vsc.34.1600009542857;
 Sun, 13 Sep 2020 08:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net> <20200912204824.2824106-2-sandals@crustytoothpaste.net>
In-Reply-To: <20200912204824.2824106-2-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 13 Sep 2020 17:05:31 +0200
Message-ID: <CAN0heSo8XsToRm1st4PqPp8PNwc98Csx-+o78J-mh3bbYoneWQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs: explain why squash merges are broken with
 long-running branches
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 12 Sep 2020 at 22:52, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> In many projects, squash merges are commonly used, primarily to keep a
> tidy history in the face of developers who do not use logically
> independent, bisectable commits.  As common as this is, this tends to
> cause significant problems when squash merges are used to merge
> long-running branches due to the lack of any new merge bases.  Even very
> experienced developers may make this mistakes, so let's add a FAQ entry

s/mistakes/mistake/

> explaining why this is problematic and explaining that regular merge
> commits should be used to merge two long-running branches.

> +What kinds of problems can occur when merging long-running branches with squash merges?::
> +       In general, there are a variety of problems that can occur when using squash
> +       merges with long-running branches.  These can include seeing extra commits in
> +       `git log` output, with a GUI, or when using the `...` notation to express a
> +       range, as well as the possibility of needing to re-resolve conflicts again and
> +       again.

Very well-written, as always.

I grepped around a little and couldn't find that we're using this "long-
running branch" notion anywhere. I think it might make sense to
define/explain that somewhere early, e.g., with something like "...
merged repeatedly ... more development...".

So in particular, a "long-running" branch is not something like

  I branched off a long time ago, I've been hacking on this feature for
  a long time and the branch has run quite long with lots of commits.
  Now it's time to merge it and be done with it!

Once that piece of background is in place, what you have here reads very
well to me. It was only somewhere halfway through the second paragraph
that I got what you meant by "long-running branch".


Martin
