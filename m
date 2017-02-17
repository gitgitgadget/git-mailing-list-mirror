Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7386A201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964777AbdBQW3g (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:29:36 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38781 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935000AbdBQW3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:29:34 -0500
Received: by mail-wm0-f54.google.com with SMTP id r141so19488928wmg.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=FDBj+eBaO2uGRrSVfy5SYpd2LYh3m6kXEGvSWmpwuf4=;
        b=EBGF6/3+OXBZTIZA4jhvb3+28S/mAWHQ5nvUBtKKsBo8PsKzF3nbqVEt7lBj89cJyg
         NVzFGq9umOESH2JrEV1WPFdKy/LaAwR4v6kAC8G1V1jjCyYOLAtYrzGYr1x8M6mij+of
         ISt0U+70oZscn6CF7+FY3/qUbeiRYKpYBOgJsKQ8/2b4qPy7CJctbEpqHkqMsxOhr+Zo
         Ouo9Yr1wO1Y6f0OP48Juv2Dxwx3HZN7/lnAdMpvvSplE98cA0N//s2XsqX2nWvcSetak
         UN3ueoxyxMFJQSp+K/oJSsRlSG7QkreTgqzZJ+i3Gz3Zg05jkFrmtHsb3H1R+7p81A9J
         PRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=FDBj+eBaO2uGRrSVfy5SYpd2LYh3m6kXEGvSWmpwuf4=;
        b=EwgnMhMh4QKIVK3zwQ7dBd2d2CRbtq2JLRHa0OVJKD634CJ+hG5gQDpxTUX4VnFoh6
         TJzGcFkEyn2r5Ya0CvLa38orYFsid4kQHM0WO/CBN7VX6lC5oYwk3xs908Y1Aq0qeOIP
         ItyFkbBlqM3N+V7ELmUkVtMaCKwx7DqQlmrqBl8N11Z4JtsfjICHSDDm2g+dxiKDIrLE
         sPdcGQaL+9v35AiDzOwJ0c4sPdoeWYi5uGRq+tIrhrmTJyZuh5FmKQRwr6lC1Cp3pC6s
         WXLS4iEqKRIvDDT5BXPmf1gbvJelCCrO4zLsSZ4bVs1X9I9fw0euQ/XQLjLKyfJOYu6J
         OvQA==
X-Gm-Message-State: AMke39kEwWB7Gj5KxLYM97byTCbQsMD0MqdEAi3snlloDs5WTTpR2K/3VHVUehNXEF7w957B5qOw3EwqcCmVSQ==
X-Received: by 10.28.207.7 with SMTP id f7mr6049308wmg.112.1487370562257; Fri,
 17 Feb 2017 14:29:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.226.6 with HTTP; Fri, 17 Feb 2017 14:29:21 -0800 (PST)
X-Originating-IP: [77.176.41.146]
From:   Alex Hoffman <spec@gal.ro>
Date:   Fri, 17 Feb 2017 23:29:21 +0100
X-Google-Sender-Auth: 08uLo2S0FTe-pwmFoYnvyMoZJZk
Message-ID: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
Subject: Git bisect does not find commit introducing the bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

According to the documentation "git bisect" is designed "to find the
commit that introduced a bug" .
I have found a situation in which it does not returns the commit I expected.
In order to reproduce the problem:

1. mkdir test; cd test;
git clone https://github.com/entbugger/git-bisect-issue.git
cd git-bisect-issue

The tag "v.bad" is one bad version and tag "v.good" is the first good
version. A good version is one having the line "FEATURE2" in
file1.txt, which was introduced in "v.good".

2. Copy test scripts to another folder to make sure they are not
overridden by 'git bisect'
cp *.sh ../
cd ..
./search-bug-git.sh

3. Run ./search-bug-git.sh to search for the commit introducing the
bug. It finds that the commit 04c6f4b9ed with the message "Feature 1"
is the first one introducing the bug.

First of all this is confusing, as this commit cannot be reached
starting from "v.good". Then I expected the commit with the message
"Introduce bug" to be returned by 'git bisect', as it is the first
commit  between "v.good" and "v.bad" that does not contain the line
"FEATURE2" in file1.txt, which is what I understand by the commit
"that introduced a bug" (cited from the manpage of git bisect).

Thanks for looking to this,

Best regards,
VG
