Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EFAC433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 08:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6135C65014
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 08:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhCEISb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCEIS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 03:18:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58038C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 00:18:27 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id mj10so1755834ejb.5
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 00:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=PuOXGSU5i8fnor6KZUHvm8N6NKO5P22M6mIJdPbZ3S4=;
        b=E1zqI+8pGPKB7qWDcLDw75bENKXHMZ2LeYM1pmpaObDh4Av8T16gU2ToKjwKu9l59A
         EgkzZ7N7cTuj/g6cyfkgGXJUZH4+qcrYQWp5fW2BYuamMIo6HXP9kMmI0Z3Nlw1uQ4vA
         xSdq9W0CO32Lj6hEliYRsyNjwCcBhSxP4w0BqqZnL93PF0lYj6bQfJ0vIfjvNnJgYqtk
         onHdMDzU8cMHqakjoDx+lZNTOADVtPWVsk8zhxh01PjoXFE97ljWnsqWD49lsldi3Fhs
         fAF8ep7tRTealTFZdOyuAGCaiaoxXi6Nrehcb4eJP4QOugOjwOBlqTN2bhyJ0B0yD14B
         nxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PuOXGSU5i8fnor6KZUHvm8N6NKO5P22M6mIJdPbZ3S4=;
        b=BjHAwz9c3HZrkAkWRvc6xAFQNXnj5xw50G8RTupGGXrMZR6XaP/wpToPonX+g5cXu0
         QEYJaLiNJSv6kd+//14RvD+fMw8uuG4Km7BIydk8i1gzE9oPF8he/SKn74IfGIpwNa7M
         KSrCXdrcFYhlklDzmnOYi6Kf5JA/zc+ukDKv4sFBU8pMO199kHkeLOF5qvUQHpXX5c+P
         RSFp2ilEn8iQ46wuA/VUd9fqh87fxE8QwUGkoEsoAAgnChTClShqFeHSNOS4JFRKSmjm
         Ql9aw4WCtTQlQxzA39Y6DQPw5dBpR6sf8kCfSsqmg1msWQRqJdtOWcZWXgnwiEzCGjeu
         H9zw==
X-Gm-Message-State: AOAM530gK+wNbuOnAMCkcNLHVribeDu7eer/NpMB5YeVYt4P/gkF32Ut
        pE/TxdBhRrXHnG5GAjELYwaIyq/13ieKgiHiMmdA4nj3Cc9OnQ==
X-Google-Smtp-Source: ABdhPJz9ItIr2ts+0eJBfoI6INRQOoSm8czwjR4uZirqsRNytFEDsoA07CQd5cAbqAnCCQrKb3jab4QpzxPkvRFcG+A=
X-Received: by 2002:a17:906:f6ce:: with SMTP id jo14mr1315327ejb.476.1614932305824;
 Fri, 05 Mar 2021 00:18:25 -0800 (PST)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 5 Mar 2021 00:18:15 -0800
Message-ID: <CAGyf7-EXQJ2rWFqvt++Gi2=ZSCBonNtS1JSBkW4k+ORrQiyizQ@mail.gmail.com>
Subject: rev-list --use-bitmap-index
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for --use-bitmap-index notes that if used with
--objects trees and blobs they won't have their paths printed, but it
appears to change a whole lot more than that. In my testing, it
appears to mean --date-order, --format. --parents, and maybe more are
effectively ignored.

It appears this changed in 2.26.0. The release notes for that version
include this blurb, which seems like it might be relevant, but I'm not
sure:
* The object reachability bitmap machinery and the partial cloning
  machinery were not prepared to work well together, because some
  object-filtering criteria that partial clones use inherently rely
  on object traversal, but the bitmap machinery is an optimization
  to bypass that object traversal. There however are some cases
  where they can work together, and they were taught about them.

I have a repository with a bitmap:
$ git repack -abdfln --keep-unreachable
Marked 2 islands, done.
Enumerating objects: 3603142, done.
Propagating island marks: 100% (2576295/2576295), done.
Counting objects: 100% (3603142/3603142), done.
Delta compression using up to 20 threads
Compressing objects: 100% (2898179/2898179), done.
Writing objects: 100% (3603142/3603142), done.
Reusing bitmaps: 291, done.
Selecting bitmap commits: 293052, done.
Building bitmaps: 100% (363/363), done.

Here's some output from Git 2.25.1:
$ /opt/git/2.25.1/bin/git rev-list --boundary --ignore-missing
--date-order --parents --use-bitmap-index
c6abb83d2798415fa9fe0ebd683623620076b412
1c55e675a66cb98955232e1bd230119fd97a5467
634396036782682e7cd8c955070dfb30546ed58c -- | head
c6abb83d2798415fa9fe0ebd683623620076b412
2c7281b151d0079acc3f9b2c67d4667e1c9bf6d9
634396036782682e7cd8c955070dfb30546ed58c
1c55e675a66cb98955232e1bd230119fd97a5467
2c7281b151d0079acc3f9b2c67d4667e1c9bf6d9
d672894d3b2413b62034cb3cdb3470e5dee0001c
76250ec85aadff2ff451ec13efdadb8ccfd6b239
d672894d3b2413b62034cb3cdb3470e5dee0001c
013343e1900330429bcd1e31bb2ae7261fc1e3af
3e1e27621aa5f1d49286e23d77199004a835699e
3e1e27621aa5f1d49286e23d77199004a835699e
b944291d204cb7f3d5eb7678360b16435c53b2f3
b745a7b9bd9434eefb411d5f2a80a7187e3e8b93
1c55e675a66cb98955232e1bd230119fd97a5467
7f2c871e0d239e87bef7a1505ae928ae3a09a402
76250ec85aadff2ff451ec13efdadb8ccfd6b239
04f561866a9c015c14c69a0294b753ced5e084f2
013343e1900330429bcd1e31bb2ae7261fc1e3af
d907528818d010a360113790e227ebbcd8a61395
b745a7b9bd9434eefb411d5f2a80a7187e3e8b93
b944291d204cb7f3d5eb7678360b16435c53b2f3
7f2c871e0d239e87bef7a1505ae928ae3a09a402
c2ec4d3d76d865a9b701eb8be822d31252278a76

Changing to Git 2.26.0, I see this:
$ /opt/git/2.26.0/bin/git rev-list --boundary --ignore-missing
--date-order --parents --use-bitmap-index
c6abb83d2798415fa9fe0ebd683623620076b412
1c55e675a66cb98955232e1bd230119fd97a5467
634396036782682e7cd8c955070dfb30546ed58c -- | head
634396036782682e7cd8c955070dfb30546ed58c
1c55e675a66cb98955232e1bd230119fd97a5467
7f2c871e0d239e87bef7a1505ae928ae3a09a402
c2ec4d3d76d865a9b701eb8be822d31252278a76
899053a9043045fcfeb7f9254f2700d286c60a63
f1adcf64a8c06cb12f4e3e876040ee596fb3c0ca
16792db59ffdbbefe4a27a11a9831eac39be69a0
b844c3d11d09c2aec3428ce61bef02fdd097b9f9
802918fb139ef96cae5259822d22a36478c5e7b1
3a6105686ab302093648733dbf5fada3b44db72b

No parents now, and the commits aren't in the same order. I've tested
with 2.30.1 and it produces the same output as 2.26.0. If I remove the
bitmap, all versions produce the same output as 2.25.1 does, with
parents and in the expected order. (I should note, the bitmap is
perfectly up-to-date; I did the repack right before running these
rev-list commands. I've also tried the rev-list without several of the
options in place, like --boundary, and it behaves the same. This
command line is assembled automatically, so I'm just including it here
how the system produced it.)

Is this expected? If so, perhaps the --use-bitmap-index documentation
should be updated to indicate that it has unexpected interactions with
a whole lot more than just --objects? Or perhaps I'm doing something
wrong/unexpected here? What sorts of traversals are --use-bitmap-index
expected to be used for?

Best regards,
Bryan Turner
