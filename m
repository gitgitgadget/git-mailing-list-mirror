Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BDCC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 10:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCDB2072D
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 10:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsqis8oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfLPKvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:51:16 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:45246 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPKvP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 05:51:15 -0500
Received: by mail-pf1-f178.google.com with SMTP id 2so5357146pfg.12
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 02:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fSCoylaPKB1mRNfHdSVfMHH/3Wxf8hPHzRF+kSdVjgw=;
        b=fsqis8oMTx1VnvqAoBeS5YwVdJigGBl7cME1Jzc61Vl1f1kGxNIRArioJuHY9UEBQ5
         Ovmbp/NgtWz7qM8WTXYhYHgYKcpkltEVEnxJ0tt7wvyY/2r52hpBTD+QpMLrFfNGnLJe
         7+ehf/10b/+NBCnWFla5ObDV74PMIWF/gc0FViTdg4NPs0YlnnrGfpJ7ami1VG3jsG+V
         f1JfahZdEeUnbOFmWd2DSipomI7GNTLteX5eXjS6djelBUHzY47EXLpOKhmhXv4rJxyX
         mtmIe6JppjUHsmmxh9ZGFuyOq9XlcqNuMo/3FgIQtNoK9J79dkarp7jeHHn/0mQeW+c0
         QcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fSCoylaPKB1mRNfHdSVfMHH/3Wxf8hPHzRF+kSdVjgw=;
        b=ZNUYCGIae3Nz0jTiuoRYOrsRLOHwAWhi9y0Jp9tCcrD9Yg7s76Hzy6usTB2rLpihIe
         +1ZG9yXlzl5gN2zbGaQNnj3JqdchyKSfRp0TERVaAakUvA6nmKVTuYhw7J3sUn4n03u7
         bPZPEa9KcNlUpRqdYQTiC7NKV13JDN/Ppehc7ERJuojgguLTX5Jkp1cNFqgfYvaTM/cn
         +pyxkMi+zdmGuKqn8XFQRP9Bz973pS5hUwwUCII3a6YJSP92BjSUNqgKCnj8F7+08Nkm
         E0abV/+hShJW0jLC+zEnhxYHNKiTDwOO+wwWEQiZrSYEKvLATWNfkZsKQKVrNaAOZuno
         OORw==
X-Gm-Message-State: APjAAAVJ5VZpf51Y/XIiUPC9CSG5Pore6NMqPJlg87EicgIgGUeBh9tY
        CMyVe1xzH0qBQDUWiC/+Xt006g9u4IPXo/rdqdpIxI3oYoc=
X-Google-Smtp-Source: APXvYqw1r5aGO6oTr/0FSwPdLUYqezpX4tr/dkGPaSYNPLExavwfbVGVsuMHMPtq46Yh4nc8pzKC233iuUoSSNqOgv4=
X-Received: by 2002:aa7:98cd:: with SMTP id e13mr14671370pfm.56.1576493474554;
 Mon, 16 Dec 2019 02:51:14 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?SGVucsOpIEJvdGhh?= <henrebotha@gmail.com>
Date:   Mon, 16 Dec 2019 11:51:03 +0100
Message-ID: <CAHbriemxQLVFQw9pTb37JmoD2QVqLcfgY43qFg4Ab8prrBSkuw@mail.gmail.com>
Subject: git restore --staged --worktree does not restore the index (Git 2.24.1)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git help restore says:

    The command can also be used to restore the content in the index
with --staged, or restore both the working tree and the index with
--staged --worktree.

However, this doesn't seem to work as advertised:

    $ mkdir foo; cd foo; git init
    $ touch a b; git add a b && git commit -m "Initial commit"
    $ echo "Foo" > a; echo "Bar" > b
    $ git add a
    $ git status --short
    M  a
     M b
    $ git restore --staged --worktree .
    $ git status --short
    M  a

I'm not sure whether I expect 'a' to be empty at the end of this
sequence, but I definitely expect it not to contain staged changes.
