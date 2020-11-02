Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C725C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E197B2225B
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OouFN0/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKBWo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgKBWo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:44:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F3C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:44:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 33so5618022wrl.7
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ej7sPf1bY69jzLMwtqOQ9BbSqjv8PiMleOBvgxYS5u0=;
        b=OouFN0/ASNcoihA2ysL1g5aV6QdXOHTmgelF3UAdQmsE1j0XC8SRKbC5nLr8Kx3bUk
         9W+ZfnWxTns6TZiTUJTHIifcsPafjMjLVcEJtD9HfwPIh4VNsYfcJaHdZQMpdN5VsW1T
         fd2gQaSUlBqRCdEr2Eet/Kc81PUMfsivkb2KlPbEb9qq+q6wc09p+bC2EnJ9jQJMElGx
         cIeklxBvH8Ni4BtCR8NoCRqkmd8wkxajV/jB2IuVz0LhuGG7ylswTVmkk3/EDhK7MbJk
         WERfzbM2FMvizXAchsc9dt3yv5kQrB751sWwge84qyLcUvXPbDNNI5xWkS4SlDnaUDTe
         taNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ej7sPf1bY69jzLMwtqOQ9BbSqjv8PiMleOBvgxYS5u0=;
        b=RHWYBGG+ALMHeH7YaehvLokhQkW6W9PXIvdNxbVLQUuwT4BUe2sD9jvqiKZvHXbNsN
         q7Kz6ZQaCWvog59FkfaeiXcystc0ldkvEt7+LIDU/reMPTs7+W8lLYyx6oRMScgnKBmz
         PDleTredVuCoCW3DK/F5IY7B3qUh3h/sVNscWOzQfG/FaTsynClzYp4pzSBmpCetEvV9
         FDiRMm01a8wO8KIGoXm/aM7c+Q9Coappc39cT3ItykPszAok3XJ1YXaCH+fKFVJjHinu
         03nAfIjM/8Vm/sj7Fm2onJDGqlzWbgbbe9Pc57AL1H3vpnO8uuMx6oISnMwN6q7MvnUR
         ophg==
X-Gm-Message-State: AOAM532Zxx/kxnsCt2eLuKualA83hHWJXDHn6oOIxSK8GIJLYTqtnBfW
        BtdAqgqPkufFWuHSN5Yjulk8Gi5W0XKjtcOdWw17QPib7UnrGA==
X-Google-Smtp-Source: ABdhPJy0dXRzPrTfjPCfVqI5jkYDozGixUXSkXtDztJ7hSsNATo3Pwnb8m0vdCG2sAH1FBirSgSK7nRmIHE+phPHlEY=
X-Received: by 2002:a5d:424a:: with SMTP id s10mr22726444wrr.130.1604357094700;
 Mon, 02 Nov 2020 14:44:54 -0800 (PST)
MIME-Version: 1.0
From:   David Besen <dbesen@gmail.com>
Date:   Mon, 2 Nov 2020 15:44:43 -0700
Message-ID: <CAHqVHwt1QJjXCAbDD5ViZ1E_rD8u+H_XeJ=FOv4VFPTS8y3xjg@mail.gmail.com>
Subject: git clean -Xdf doesn't clean ignored files in subfolders
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I'm seeing some unexpected behavior with git clean:

git init test
cd test
echo "ignored.txt" > .gitignore
mkdir folder
touch folder/ignored.txt
git clean -Xdf

I'd expect this to delete folder/ignored.txt, and instead it doesn't.
I'm in git 2.29.2 on osx.

I saw that git clean -xdn does delete the file, so if this is a bug
it's limited to -X.

Thanks!
Dave
