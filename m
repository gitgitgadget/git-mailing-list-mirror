Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3C7C433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 20:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB1C20734
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 20:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsSgiZFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgFCUYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgFCUYA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 16:24:00 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC711C08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 13:24:00 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o5so3776769iow.8
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=umtEA9r2lXi3rqey6DpVifHYK5B+iB5RpruudbmSxrY=;
        b=MsSgiZFL6k7roMrNW7H269P9ieBzXDX4AkTGEJQmpmkX/ytr4fmEabWl4PWGL5EgEz
         rJgsodMJxXZvyeBCA4XdaCMSoHTTEhRQd4wjU4uOxcuu0IT8YaY/bptay6PTRCAN2+Ki
         urfSA1Tiz+IlBMdOBCIBFtB8G5WcLXaR6KTxviMWV7kacNNM0z9kTTgZOwKCNwhLc8ud
         ivGjlu68g2VxUTxQA+xR85ootpwpSNSoQZzkF0nqETUS1N4ilsyOyMTrI0/WStbTHNAi
         AAVrWE0aeOAuh8jScSZQNnI0v/N5cJGnRUK49l8O+deAWzPbEViVv5rb5FRlUfNK46Fn
         Z+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=umtEA9r2lXi3rqey6DpVifHYK5B+iB5RpruudbmSxrY=;
        b=iPL5VfVVzs5/il6N/0zcmJfNv0Xg94eS21yuBHNz0z5jdnhuN6PGt5v6mf429YlR2u
         Y3vEycOY775m+IhcfMRWjNoe6cVOH/YDA5s3QyNpHuP30mExTbZcSeD8JB1haHwRYdRK
         Y9sFj48Rs2HjwzLzjsxoEgl71gtmZj37ER6FsAdy1UP8xSFD4V5nV+fk2c6stE10wEAT
         A2q0F+6T3qreyjltA6UCzWPymsoNZr45Cb/lajTDtY9FPJu7gAq0ap7v2f1PxR7B11gE
         n2v7Y0SjqE/3GuVMagIvag8S7UoR4aZU7jDKf406os4AZtjer/tlw/JbG4ePNeNTUuuu
         l1Qw==
X-Gm-Message-State: AOAM5339RHlmIsJ6s47AA7vBwWD9ICibpjg3x/efFg/pK48IEwP+eSvb
        ndhgqlsRxMgeC8yntdWpeLRs/mtyftIlJAEGgkGlZQ==
X-Google-Smtp-Source: ABdhPJyIy7N7eot4O11Y4bc5ve/hE/CLgG4+dXSx29pgkJM4/LoiUmYF0QsSv/ENj3SI5X35hgihbK14exUEh2LLJpY=
X-Received: by 2002:a02:958e:: with SMTP id b14mr1551670jai.126.1591215839867;
 Wed, 03 Jun 2020 13:23:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:8d03:0:0:0:0:0 with HTTP; Wed, 3 Jun 2020 13:23:59 -0700 (PDT)
From:   Martin Ruegg <marrue@gmail.com>
Date:   Wed, 3 Jun 2020 22:23:59 +0200
Message-ID: <CACPN43cgtvsHWn=a9s75hZT3kXNfm-T5K+BgCr1ETUu1Y90jug@mail.gmail.com>
Subject: Crash when opening GIT bash on Window 7 with newest version of GIT 2.27.0-32bit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

After installation of the newest version of GIT versio 2.27.0-32bit on
Windows 7, I wanted tio open GIT bash and it did not open. Instead a
file with name mintty.exe.stackdump appeared in the directory.

The content of the file mintty.exe.stackdump is;

Exception: STATUS_ACCESS_VIOLATION at eip=000A03C8
eax=00000000 ebx=0045028B ecx=0022C5CC edx=777A6B94 esi=004A0410 edi=80000000
ebp=0022CB48 esp=0022C614 program=C:\Program
Files\Git\usr\bin\mintty.exe, pid 1540, thread main
cs=001B ds=0023 es=0023 fs=003B gs=0000 ss=0023
Stack trace:
Frame     Function  Args
0022CB48  000A03C8 (200710B0, 200710BA, 0022CD28, 6100AFA5)
0022CD28  6100AFA5 (00000000, 0022CD84, 61009DD0, 00000000)
0022CD84  610088B2 (00000000, 00000000, 00000000, 00000000)
End of stack trace

Thanks for bugfixing

Martin
