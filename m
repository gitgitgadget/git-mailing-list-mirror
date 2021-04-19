Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AA8C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EAA61107
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbhDSVTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 17:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhDSVTN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 17:19:13 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59310C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 14:18:43 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p3so19835511ybk.0
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=l2YM96Qy+4Fpcou+g3QPoCXyJ4z2RKibLYxZvHESjR8=;
        b=ovPZorTLW6f0EfpDhGBcjqVJtWddWxAgupfWS3kQltg8W27d9bq/2Bda5B24KJTkuM
         V+9YsoZkoeo4SHzY4csYset/YfIzMVkkekmqmQeiZoLPdgg2ssYLk1ytUlAxLfUJmHpq
         fPnR1kGVytbIchAsTddtp75L8/xvUOvv15ocvYabNC256VmGUqFnppzNFakmZi16Gl/3
         1cXJN0eLg2INGcxYgeIm1WE1oJ2m9GNccgEN5LS+I6T6N1+VEnXYrrEJIUJ8Nw9Hrhrt
         1xrky1ZaVqOuDXKQDsgPP9Xt4i83XQuEwcuoUhyJ2Mhvs1G03tLTWI9pD584nvIQuHAj
         pNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=l2YM96Qy+4Fpcou+g3QPoCXyJ4z2RKibLYxZvHESjR8=;
        b=UYFekB4wCnE2BfMYGJyrXSZYzSYbZILVnoCGWTGXf7rM7DyqxplqLZ9GuDi2EKrFYD
         Px2wS6jJXjCxB9mykCyrlNB4mzSdYfp8iyeDf3jh4uaCrmlEhJG1fR1sazXGh2D1esen
         EypH29ov/JrifjYvol5xpzs9WTCuF2KF1/cO68/ZBPBv889cnLilwb+e4m8mbSTL1XwS
         IZniBghKXnZ18uQ1CvYsqOa9q+rmYzFiqFc56m/hFSA0WBFSHbOOZu75np+QO1zWpQKY
         UQ+Gzzt3TIGM34A6SKyK+hRMCp9wxDaPUqpnXE8dkqaEvBteMH/KR4dXmwlyLTK8m+KH
         DDDA==
X-Gm-Message-State: AOAM530XyKulrS4gm6CldVq4AsqNXpZuLtqnpxXu4FWk3BhgHV45Lazb
        612eVH1VM+9/IwiTuA1vziCuiULflVWNQyxsBut16w==
X-Google-Smtp-Source: ABdhPJzVVpqU+F0docVVt/hsszWafG0o6iGARCjFVLx+noS3gK2DOpyzWe+GAxOYTBDFG2Ycer+wTrV7rc56bRvsVUs=
X-Received: by 2002:a25:50c:: with SMTP id 12mr21010641ybf.220.1618867122361;
 Mon, 19 Apr 2021 14:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210415212017.1407303-1-bga@google.com> <YHoJUrqeT26Nihua@camp.crustytoothpaste.net>
In-Reply-To: <YHoJUrqeT26Nihua@camp.crustytoothpaste.net>
From:   Bruno Albuquerque <bga@google.com>
Date:   Mon, 19 Apr 2021 14:18:30 -0700
Message-ID: <CAPeR6H71Hn3ei4CzZLnQH1JGTvTpy6Ru-Mpin5cVJ0_7GSkoag@mail.gmail.com>
Subject: Re: [PATCH] object-info: support for retrieving object info
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bruno Albuquerque <bga@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 3:02 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:

> I want to point out a few notes as someone who's worked on projects
> appurtenant to VFS for Git.  If your goal is to create a VFS, then
> learning what Git thinks the object size is is not helpful.
>
> Git performs all sorts of operations on files when checking them out,
> such as smudge and clean filters (e.g., Git LFS), line ending
> conversion, and working tree encodings (e.g., to and from UTF-16 on
> Windows).  Thus, your VFS must necessarily exclude all of this
> functionality to use Git's concept of an object size as a VFS parameter.

This is, of course, completely valid from a Git-specific point of view
but, because we are dealing with a hypothetical remote FS, it would
not be unheard of (and, actually, this is most likely the norm more
often than not) that when exposing git objects in an actual FS, we
would not be doing any conversions whatsoever and would, instead, show
everything as it is actually stored on the remote server.

> For the average project, the worst functionality to lose is actually
> line ending conversion, since that means people will practically check
> in a mix of line endings unless you are very strict in CI.  VFS for Git
> was originally designed to address the needs of a project that was not
> cross-platform and thus this was not a problem, but these limitations
> are substantial and I wouldn't recommend repeating them.

Although I understand the issue here, this would be fine in the
context of a remote filesystem as I see it. In fact this is something
that actually has  precedent in git anyway ("git cat-file -s" without
--filters will emit the size without any conversions).

As long as the size we report match with the actual contents of the
file we expose (i.e. without conversions), this looks ok to me.

> So I'm not opposed to seeing this functionality come in if you have
> other plans for it (which is fine and I'm certainly interested in
> hearing about them if you do), but I don't think this is helpful for VFS
> scenarios and shouldn't be used for that purpose.

Thanks for your comments. This actually works for our purposes and,
more generally, it would be useful even if you do care about all the
conversions (in this case, as a reasonable approximation of the actual
disk size I guess).
