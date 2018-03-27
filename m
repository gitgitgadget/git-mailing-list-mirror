Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D151F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeC0Jxz (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 05:53:55 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:40974 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeC0Jxy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 05:53:54 -0400
Received: by mail-ua0-f177.google.com with SMTP id i2so4859793uak.8
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 02:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=t0YeRcEGyKp3doIWtsLyZ1YSNGcHQcE+Q1tzZUJy0y0=;
        b=Kyc4E4TSewRraXR9eM5g+yF4p83Rx3C8H2BSdFf6Z6FTmuX7T/pCZSbtpsC1LdrZPV
         UtIuVVBFO1uFF/yBcecyw1scoAfN1QXROdUakNucV0PRTBCJ8qMUxWaDvSlVPkEHzkfC
         +IJ3xxqPqyq1NW/lOJbRGbhuLrIxCgqh4eRHTEW5ua8rXWxsnN6BCZmw/38sBqnOL6Bz
         kFGruGPHVMRSUg9P9DfSXCBulDPPDvUijHEyWjxd2XX2Mua2WQ6ulCPQiymRXIx82tBh
         t9BGn8KJP6YUFsubc18CVelIFKgGWKXvXOiMv1NIhUvoX7K14WIpERcU8wtUv55ld5bT
         BnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t0YeRcEGyKp3doIWtsLyZ1YSNGcHQcE+Q1tzZUJy0y0=;
        b=m1LdWg1Fod3tv1pbwEnkIqCvPaW2YjCxDUq50qgcgm9/X8hgz4eF4KWeFjnzNNFXkH
         sGqWvstabpWgTadbs3rjoIPqF7tch+7JefQMR4RbNFhH38E5T0N9JO+OtDn2ZGHgpvCt
         /ODH6rQ7zX46MhuwTSMCWqVBWx51T1UQhaeyB72CetcyaOwBckSydRT0gnW3F5UdrEJC
         uDvfImSAzAFObblKrKLvdXR8M4MRApheMPUVlrcoVZnQZcgaRDHmFohjix34GIqTwQg6
         GGkJ1Fgfc3lygE6IYR+iyD/TrsMj6xLvUJz2tPk8fVvWY1gIm0UU3leiKf9W3OE+SVfD
         LASA==
X-Gm-Message-State: AElRT7GTh29ryQyWy+A1f9WwfvelXZtpLYQ1tsMHSaRpnHb/OcfwElFD
        CJR1lLYU9feAk39s8SMDo8sUbVTtba3MRSBu9PuBwg==
X-Google-Smtp-Source: AIpwx4/qCYv+sd5eCH06rBL/FVKi3Wj8zrAgJuXbP3KuQ7rU1hf3Y//bRpeA2/Hhyajqx36cahZDc+w7RYikJfHl4cg=
X-Received: by 10.176.36.214 with SMTP id k22mr6470930uan.192.1522144433345;
 Tue, 27 Mar 2018 02:53:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.94.78 with HTTP; Tue, 27 Mar 2018 02:53:52 -0700 (PDT)
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Tue, 27 Mar 2018 12:53:52 +0300
Message-ID: <CAGHpTBJ-4a5+5=303_N-n3TtUg_sXt6J1cad0WCQ4Kc-=HDdSA@mail.gmail.com>
Subject: A bug in git merge
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

If I cherry-pick a commit that added a line, then merge another commit
which removes this line, the line remains in the file instead of being
removed.

The following script demonstrates the bug.

file should be equivalent on both branches

git init
seq 1 20 > file
git add file
git commit -m 'Initial'
sed -i "s/^5/5\n55/" file
git commit -a -m 'Added 55'
git checkout -b other HEAD^
git cherry-pick master
git commit --amend --author 'Author <a@b.c>' --no-edit # generate a new hash
sed -i '/55/d' file
git commit -a -m 'Removed 55'
git checkout master
git merge --no-edit other
git diff other # Should be equal

- Orgad
