Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5BEC32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 10:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5820661
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 10:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMi2zwHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgA0KzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:55:13 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:41275 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgA0KzN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 05:55:13 -0500
Received: by mail-qt1-f179.google.com with SMTP id l19so1415333qtq.8
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 02:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EME4WJt2TpvIxU/uQQagP+AiWYLHQ2FIR2U3klHHLg4=;
        b=bMi2zwHOwf0/IKldXGw6bqeUNiX4ncesDN5Sk6hAF3842s1RbVeO3RFGeSX+Enwe55
         r9uK61wsTATBwoW2WqLBUd4aEdmecyFU7Nvsho5HWF4SnpklBNIfbakSt/xCndLttBcy
         5tFxdkjFFtd36BOg9wY8ByQP7APJpH2FTZYiGhtpku/HHc+2HJFxx6BDjcbIcj58yofu
         QrL3ubmjNKfKr9T5UGHwNZUtQWNaKSInkRAIbCwSIJ2s7X/IACMXar8pNEACRlQMPref
         eHcQ8nSy8dCvsSw4gjbKUhCk2/pdRZpfKUprBMehcpD7L8PfDC7puZGwtWI98vwdIglF
         XSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EME4WJt2TpvIxU/uQQagP+AiWYLHQ2FIR2U3klHHLg4=;
        b=IUcEbKBuNTFgpzYNXwdugAtevMCtWYD4RpTG/i+uWEgcUf0omSiaXjpFkXl+wIGzyx
         ozHbW+Wh49lA/196wZFWs1p30WBn955sLeQqp2Z24BaBDj+yXZK4ZckkbvnQa2mldO5F
         ZZ6wor9k07gA5SKcVSDX9Z7QQ6tcvy76Ok7Ermcp4wpJrn7dYztkKgFVySSFuYMB9jAV
         jYX6Rak8C8m9QT/m7ZubCQE3zQhj2FpHPFFVKYB9uTdHoQwU0KkV8EYHnigm7r86I+Je
         /FB3rNXKZJgwAhvfBT0hM2OCODpGHuy/H092Jt61dhQ5OW980U+NGW/Kj3so7tRp5XmH
         GOkQ==
X-Gm-Message-State: APjAAAVcRlqFNTg/ESYmAt2nngHe9jAt6NDgVAMcpEig/zhZOi1yvI9R
        m8b3lEkn0h+reb5Ht96XM5wYgLfn+XhfhNUthFrudzmAsvU=
X-Google-Smtp-Source: APXvYqyJyqWSYKNdYmvU/Ik6e6I2ODGxsFpN5NHxwNm04b3KzISL1GuzF6OeMeprKBHSzAilXp5AKtudW7hjJHCgzxg=
X-Received: by 2002:ac8:461a:: with SMTP id p26mr14465871qtn.317.1580122512161;
 Mon, 27 Jan 2020 02:55:12 -0800 (PST)
MIME-Version: 1.0
From:   Martin Melka <martin.melka@gmail.com>
Date:   Mon, 27 Jan 2020 11:55:01 +0100
Message-ID: <CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com>
Subject: git status --ignored hangs when a deep directory structure present in
 working tree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, I have ran across what might be a bug in git. When there is a
deep directory structure (tried on 100+ nested dirs), then git status
--ignored hangs indefinitely.
Discovered this on OSX (Mojave, git 2.20.1 (Apple Git-117)), but it
reproduces in Ubuntu (19.04, git 2.25.0) Docker container on OSX and
also on baremetal Ubuntu server (16.04, git 2.17.1).

Steps to reproduce:

1. Generate the deep dir structure:

    mkdir gittest; pushd gittest; git init; for i in $(seq 1 120); do
mkdir dir; cd dir; done; touch leaf; popd

2. Try to get git status --ignored

    cd gittest && git status --ignored


If there is a dir depth limit, git should probably exit with an error
rather than getting stuck endlessly.

StackOverflow report:
https://stackoverflow.com/questions/59928800/git-status-ignored-hangs-indefinitely

Best regards,
Martin Melka
