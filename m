Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89E0C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 04:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9932076E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 04:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=msbit-com-au.20150623.gappssmtp.com header.i=@msbit-com-au.20150623.gappssmtp.com header.b="nLmNCZYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgHUE1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 00:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgHUE1g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 00:27:36 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB6C061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 21:27:35 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id x2so148800vkd.8
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 21:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=msbit-com-au.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=JFHkkMtkWTz85mXR99EKZHUY1qAPHQTp2BB2ulrSiIE=;
        b=nLmNCZYT7abpxizHuxLzkIHIWxxzCuuMuxVKliqr74ULc3F4LSPh1Dal1KYizpR2n+
         p2r0W6OB8KlG9O5QIy3Wam5Ez5FuB9lNXQ588iLwnzGgLePuLTy3OC1z1tqu61yYH9bD
         QlY7R14p5JlyyaokzHJUxWEkk2CK+bOq4C0lSbJpZn7iRbYGIkq7dfvNgU9D7z3eF6Md
         XsLN+VX45j0mGElkjfgJGaQ4pFuqh41mP9Km4ZRRPs92ALcT6XeVwucC08xVFhpUHTcH
         s/1iTPpxFa+rzDqps0I5TLHP79lzGnWBvQruCtI4ftBmZzRW2ZjSDg53SPCDh9Mo1VUV
         F8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JFHkkMtkWTz85mXR99EKZHUY1qAPHQTp2BB2ulrSiIE=;
        b=ljl9rJ6KccHZ7mP26lTjBfaBlS98vroNUMSmHZ2dge0MiYAABLeJMppLq7tyzyl9Jp
         ZHhrvVA5BV56EAzx0/W0RBXhNXSdvjPJ1HreyK8iJ6zxjleDmYZICMr3ic6bCUlP1v2R
         3i0BA7TeSCqGEZmGGKvblQVLrAX82dxkSpY7XLNPMVgo0H/ihq/ASsGlcoJUYooYhwa8
         sEa56BU/mPkvRuXebXRaxR67KKoPgN9f+vZEtmKYgh/WXep++EFxJ2Sz9+utkZSA2zWR
         FWAIwSkhbGIJC5HCPTxKMP76AGuy8qwqvzWz+h8Tvld3o4EhfUsHB8ag6JLAciSD5J9I
         J4xg==
X-Gm-Message-State: AOAM532jXatl6xCmWIARm+XgK8toacDAcl23l2DB896Z36yfyuyOhkAF
        wFlKidk//TyhzH+dwz/RHN99oGxFlaQxVFF68VxoAyAC86daXPks
X-Google-Smtp-Source: ABdhPJykXUrLDvCv1EqTHWdGN/J/3QhKJCUeUmI1Mr4C95T7DEtjnPXw96KFfvbsDHryuJaHVbR5XGrDpFBjaWNIGTo=
X-Received: by 2002:a05:6122:7c8:: with SMTP id l8mr698854vkr.50.1597984053980;
 Thu, 20 Aug 2020 21:27:33 -0700 (PDT)
MIME-Version: 1.0
From:   Thomas Sullivan <tom@msbit.com.au>
Date:   Fri, 21 Aug 2020 14:27:23 +1000
Message-ID: <CAB+jsAW_+NTJjDLG9uMrf4cc5rcwHLD5kTLk7QgvFCgryb22Gw@mail.gmail.com>
Subject: git add intent-to-add then git add patch no longer allows edit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

    rm -rf .git
    cat << EOF > file
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
eiusmod tempor incididunt ut labore et dolore magna aliqua.
    EOF
    git init .
    git add --intent-to-add file
    git add --patch file

What did you expect to happen? (Expected behavior)

To be able to edit the single hunk (`e` option)

What happened instead? (Actual behavior)

The `e` option isn't available (and providing it anyway errors with
`Sorry, cannot edit this hunk`)

Anything else you want to add:

Output of version 2.28.0:

    diff --git a/file b/file
    index 0000000..85e73d4
    --- /dev/null
    +++ b/file
    new file mode 100644
    @@ -0,0 +1 @@
    +Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
eiusmod tempor incididunt ut labore et dolore magna aliqua.
    (1/1) Stage addition [y,n,q,a,d,?]?

Output of version 2.27.0:

    diff --git a/file b/file
    index e69de29..85e73d4 100644
    --- a/file
    +++ b/file
    @@ -0,0 +1 @@
    +Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
eiusmod tempor incididunt ut labore et dolore magna aliqua.
    (1/1) Stage this hunk [y,n,q,a,d,e,?]?

Bisecting between the two tags reports this commit as the one
introducing the change:

    [feea6946a5b746ff4ebf8ccdf959e303203a6011] diff-files: treat
"i-t-a" files as "not-in-index"

[System Info]
git version:
git version 2.28.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 17.7.0 Darwin Kernel Version 17.7.0: Thu Jun 18 21:21:34
PDT 2020; root:xnu-4570.71.82.5~1/RELEASE_X86_64 x86_64
compiler info: clang: 10.0.0 (clang-1000.10.44.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

Regards,

Tom Sullivan

Head Developer
Most Significant Bit Software

e:  tom@msbit.com.au
p:  +61 407 890 821
