Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB0C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 06:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E43F6198F
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 06:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhC3GFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 02:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC3GFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 02:05:18 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A6C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 23:05:18 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id p2-20020a4aa8420000b02901bc7a7148c4so3518953oom.11
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oQxcnqv4WqAWIhmY4K6Fn/vqla88rqPbtWM9LkNh7fM=;
        b=kJJ3wnoJgcdm1LY8R/z++GC7nPIbZyC6BEBA+OU1ZTT6hj1ZKwTRrBPhh+QPx1YyUz
         +85UUFOm0M5BFX3ejbRnLm7D/vIomQr1Nz6JcPapnp4FfeEHQk2QnQchjjB+tNUv+W0u
         VS5WyQRTqoXACmUzkqX/bPitEGXiWaCCLYtyzXBtxjEZbUDE3bIz4RNZeOAOlhmED8mb
         1mI18X9WlsAuP3C4Qssk4ucJ7fn3jzLir26bSI0trwE0K2N2gl1yUyBSQOAhJ8pB2dje
         P4gznxrxd69NDjW+cfrCcmUT5+JFypSxxX3rUQYwz9y1Vv3B0OZu6Z2r66YR8fz86GTp
         2grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oQxcnqv4WqAWIhmY4K6Fn/vqla88rqPbtWM9LkNh7fM=;
        b=EwITLEj1NRYwa3DuEx/GFBR2TCBFGzCNNg6HKfewpv3OiAaW74Wdq0QnYNSP5HE5++
         zg9PbH0QGwuhXe7NHJqeSlNc3AipzTFBDVWuW2iFrxDJFtTdBT7khS+GsZL2C2WcOK+a
         P9+oEkCF0t9+LpPki/XhNiO5VI4X94DbVdpOhLsKer/tIqsmU1KeoFuvBV0BfaOaH1J7
         4JIGiSSno4isLn3Y35dCRZC1FaBGU1WrYwAZ+G6xaZr8+4UftTSTYMVlvMdMWBmIGIK0
         pfQBYpoTU0Xg9pDrOmakh6ukmVp7LewvqTRrqW7MJz97HvfmaNUmLEG02juH5fILYCBq
         PqAA==
X-Gm-Message-State: AOAM530LRsatOj17YwSqNz40YpyGlSRnc/LjqHW1brVLVSKv8Wc0lMro
        4HqKMipIHk80pRTvh33OcntUQTNdvE7jKj5GG1bqsjk33y+iIA==
X-Google-Smtp-Source: ABdhPJyXhp6EfGwDxIw1Yvb265MJiG0bKeKaF8KgtwB1/Q5vG5rcgft3/E/ByomFOZ9L26JFPgc4Z18q+r1YM0Ns32g=
X-Received: by 2002:a4a:df08:: with SMTP id i8mr14126481oou.32.1617084316495;
 Mon, 29 Mar 2021 23:05:16 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Mar 2021 23:05:05 -0700
Message-ID: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
Subject: Bug report: git branch behaves as if --no-replace-objects is passed
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Forwarding a report from
https://github.com/newren/git-filter-repo/issues/229, with a few more
details...

log, diff, etc. seem to all support replace objects nicely:

    git init -b main whatever
    cd whatever/
    >empty
    git add empty
    git commit -m initial
    git replace -f deadbeefdeadbeefdeadbeefdeadbeefdeadbeef $(git
rev-parse main)

    echo stuff >>empty

Now, If I try to use this replace object:

    $ git diff --stat deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
     empty | 1 +
     1 file changed, 1 insertion(+)
    $ git log --oneline deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
    deadbee (replaced) initial

it all works well.  BUT, if I try to use it with branch it doesn't work:

    $ git branch --contains deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
    $

and possibly worse, if I create a new branch based on it and use it:

    $ git branch foobar deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
    $ git checkout foobar
    $ echo stuff >empty
    $ git add empty
    $ git commit -m more

then it's clear that branch created foobar pointing to the replaced
object rather than the replacement object -- despite the fact that the
replaced object doesn't even exist within this repo:

    $ git cat-file -p HEAD
    tree 18108bae26dc91af2055bc66cc9fea278012dbd3
    parent deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
    author Elijah Newren <newren@gmail.com> 1617083739 -0700
    committer Elijah Newren <newren@gmail.com> 1617083739 -0700

    more

I poked around in the code a little but it is not at all clear to me
why some parts of the code (log, diff) translate replace refs
correctly, while others (branch) don't.  It is clear from the output
that log is aware that the refs are replaced, which makes me wonder if
every caller needs to be aware of replace refs for them to work
correctly everywhere, because I couldn't find a missing environment
setup for "branch".
