Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E972C1975A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 23:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4218A2072E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 23:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfuFQt+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCVXj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:39:59 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:41863 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgCVXj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 19:39:59 -0400
Received: by mail-vs1-f44.google.com with SMTP id a63so7631996vsa.8
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uUuu/uxY02wwmhnl9DOAjIEAXOJ98VCr+ic35WhzF4I=;
        b=WfuFQt+4/4PXMZUW1c7fi2gFJmPFnamJNdoNUPTBiOR2HxNsSDzz5Lv8Y/g+vuB++E
         LxVIBw/TnOMySvMZnseP7bfNamtqvVQEurBRrsSKQOWckO6rnkZddpILobfC+QsRYz91
         B3uxCfUKkRAYM2o+ePZqawTpqAZ3J+g1ODTj5YOyNxOyIjo+s3wQX+x1onNeJKEfqVK+
         KTkd1NIxx00LhEfkoj0L+4kZFoE49Byg3e992atj3zcQp3jc2nOljGAXcoWLelKV3hdx
         DNXXKHOJtwvNxRalATduhjpDjEL+fpnSmnzp5qkSbKmZw+eYqNhRwbf8BY5m52aYYJGp
         Divw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uUuu/uxY02wwmhnl9DOAjIEAXOJ98VCr+ic35WhzF4I=;
        b=U81rC/oU9k5glC1tguuccZeJnyqlBTcfcubWMvMXi/sty2ZMLoibh7cQxIQErhMxHI
         4avSqy72JaUqbYJ728LxD0/LZLVF1zHgdosM2+MrZQBY0K86AX+D3+jyoHdRma0XP5pJ
         F8E/qkhdGFFZ7aHuFqug3goUXDib3dFWjNZoUHDP34rYTwjEm38kSWG76/xOWPp05QlZ
         TYLrAOBifboPZg4sORF78DMh8/5aGFNQzTKrJvFIcYz50GOCqWIRBZv039yJcNVQq9NR
         Ur79R4KJxod4k1l3suv5qjxUxAkxd+r9jS8qecuc46vqBJHso9NTINIl0FLBhoFRZeZ9
         TNlQ==
X-Gm-Message-State: ANhLgQ0mTI1k/mCmyzT44xScYxC4SPpzK9AZU4Z04sy2+BzpLARbgfNb
        AHGJCX8RcHPb45wpY3cqdUx9aLZm6WAOJNfVacz9o2wL9h8=
X-Google-Smtp-Source: ADFU+vvcCPiX8Igd8yjS7oomYSHwx0uOLtWUjJqbTL/dF+HZYidI8Cc9rDhnC0zBaXMuSM6P80AuBtlbaUqHxnV1oWk=
X-Received: by 2002:a67:4384:: with SMTP id q126mr13567563vsa.154.1584920398311;
 Sun, 22 Mar 2020 16:39:58 -0700 (PDT)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 22 Mar 2020 17:39:47 -0600
Message-ID: <CAMP44s2XuXrgBztke50YgnZ1SQh6gvR6cdLz064xDDK3+s2CSA@mail.gmail.com>
Subject: Regression in git ls-files, or bug in completion?
To:     Git <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed a possible regression caused by commit b9670c1f5e (dir: fix
checks on common prefix directory).

What is supposed to be the output of this?

  git init
  mkdir simple-dir
  touch simple-dir/empty
  git -C simple-dir ls-files --other --directory

Before it was "empty", now it is "./".

This causes bash's completion to be botched; "git add simple-dir/"
adds "simple-dir/./".

Cheers.

-- 
Felipe Contreras
