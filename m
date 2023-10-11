Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46240CD8C9D
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 08:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbjJKInO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 04:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbjJKInL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 04:43:11 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A97C6
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 01:43:09 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9b98a699f45so1106832666b.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 01:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697013788; x=1697618588;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pJSHafMKa4AuB78D9L/YVPHC7IO0WF1MGGyGjy6Btk=;
        b=KHn1R4mjCEhbGwx7ZjD1jcOM0QxIGEMKunOuOGYFA3trsfXVf4ouEJuzJ4ORr90HV7
         hd4nwl/aLB5wPpe4leog4IwUgZeAuM0OrMOj/cv661Wv+EjEX3TGoZ+HqU3EFmMF9eL7
         5CnTzufNFGaomgUH+evfPepO2VE2jU0F9CQrMmaUzQF4NkM3AKHMo9NsGvZaKHKU4nPl
         WQkj2I01Jss5AyzBj54v1Fv6tetpSMMiA9H/3xAtwnV/W1mdztOqYMkd5HoATLigVinv
         oGxignStLGJkAi9HNoYwlPVEH0Qa1pKiJypjTPNuWbZcUztDCiWIFLJyOFaN+EnUj7+H
         lTtw==
X-Gm-Message-State: AOJu0Yy/Tw3FpxkXbUDAfK1xFJtxO/vIhy2SvDdHeLuUQGWi10jhglDV
        7wcGtwnnINipN6VSisSBNpwiSWRqgpV/vhQGKk/Fs2M/vDc=
X-Google-Smtp-Source: AGHT+IEYGQ9CphtD/o5lW2zp8mdlxL6E4ZLkI8uXnr8mcv3DVp360AY4tmxBMD/Wdy3rbQ1H2vZElRYEa/flCw9tQ9Y=
X-Received: by 2002:a17:907:77c9:b0:9b2:6d09:847c with SMTP id
 kz9-20020a17090777c900b009b26d09847cmr16656364ejc.10.1697013787688; Wed, 11
 Oct 2023 01:43:07 -0700 (PDT)
MIME-Version: 1.0
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 11 Oct 2023 10:42:31 +0200
Message-ID: <CA+JQ7M_effxh9BSOhF67N+rsvBVTULe0dWZzp-kq1yOiDq3+hQ@mail.gmail.com>
Subject: Bug: git stash store can create stash entries that can't be dropped
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

  git stash store HEAD && git stash drop

What did you expect to happen? (Expected behavior)

To either fail storing HEAD or the ability to drop the stash entry, even if it
wasn't created using
  git stash create

What happened instead? (Actual behavior)

A stash entry is created that cannot be dropped, because it's not
stash-like commit.

  git stash drop
  fatal: 'refs/stash@{0}' is not a stash-like commit

What's different between what you expected and what actually happened?

A corrupt entry is added to the stash and it cannot be removed, expect probably
  git stash clear

Anything else you want to add:

Any guidance in modifying the stash reflog so that I can remove the stash entry
manually, or other suggestions are appreciated.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.90.1-microsoft-standard-WSL2 #1 SMP Fri Jan 27
02:56:13 UTC 2023 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
pre-commit
