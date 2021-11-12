Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A41C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 04:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC8560F70
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 04:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhKLEZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 23:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKLEZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 23:25:34 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A4C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 20:22:44 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso4987976otf.12
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 20:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=vDUOWLJ4EXXVTfK/JISO8O56bSq1UItFxL5xuQirO2s=;
        b=N2vAUKp3FMElJCB0SZ6Pr4kJpJLFFcYvSLVfBS4HCxht2bk9jpaVSKduKOrLC8ynnw
         7kRyuQjmwWL/ktK3EO1H2NhgFwBmKdyoIBekn+jLEt0MXZdNTOXwrS9hodNuR50bn1kg
         20fXJLMjD6xio56eHfQb2nDRxD1t1VnXCXFXsql1mktzQstmjGLHoF+9kuypOz++77yV
         UfdpqXDbuhhdj8AxZjhbLPQiaeL4QqG9deaUWj26CmUQqi3hXn1OctgKvntCpdOyU3S2
         CzRhMHDA428J9RuEg40TOHGSZKEmx1HR8oZKkMcdbfi0+Z0OqjRPgVHievmffuTWxDPq
         Raew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vDUOWLJ4EXXVTfK/JISO8O56bSq1UItFxL5xuQirO2s=;
        b=on8lZ9JSP9u26wlq9P4SPmekmHqmg22/xDXi2XriuLKQsFIjhREs443kHTaP7c9ibb
         cR1N121pqgWlNC37wnyG43kgXCXlCtXE07b76LDsPU/W3WL4JPVdBIdFL7iMIB5W6ThL
         eLO4OBWlOnaXHyRljze6C0ARC/2EoFWRhC9ns5NcfLsJlVlTdF2tMsB2mU7aLcy8c6lP
         6xKZ5tsYa15Zj0Rj9jgSNZolBiGVozx3DG0TXjA4kuTIRUqN/cvwEOqz4YTZnDc6f19L
         ig6T6VJGPPAOD8UC98NSnbeG31/Jx0NK+mMqAyeTAcz2mYVrY4UBU+vt4IMb/7XkMbKq
         bXfw==
X-Gm-Message-State: AOAM532vnl4Z4JPdR0oi5zMZPsQGm/9b6quzVd0pmWbQvLHaI3Jz4Bce
        SILGPkfvWLZEiP8QZ4kIxWhYU4eIRqkO3vg2gkYWl8M4qFG7dw==
X-Google-Smtp-Source: ABdhPJyWqLyyM6MF4QfOEn5FAphzw84j9vON/2CTA8Vi/O2P8ssFb2mhy9udiWTrRL0LqUlSL26VW2yAv/ibsvlVHi8=
X-Received: by 2002:a9d:2c43:: with SMTP id f61mr9898616otb.255.1636690963335;
 Thu, 11 Nov 2021 20:22:43 -0800 (PST)
MIME-Version: 1.0
From:   Theodore Li <teddy.litheodore@gmail.com>
Date:   Thu, 11 Nov 2021 23:22:32 -0500
Message-ID: <CAHPjYFyzPpUmfoCbvaVg25ZbhkHU8QtxHBmAh2gdT++Xr38HcQ@mail.gmail.com>
Subject: bug report
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
After cloning a remote repository with the --no-checkout option and
executing git sparse-checkout init, the bug occurs with any
sparse-checkout command with the /* pattern (i.e. git sparse-checkout
set /*).

What did you expect to happen? (Expected behavior)
The contents of .git/info/sparse-checkout and the output of git
sparse-checkout list should be '/*'

What happened instead? (Actual behavior)
Instead, the output is the contents of the user's local root directory
(i.e. /bin, /boot, /cdrom, etc.).

What's different between what you expected and what actually happened?
It should set sparse-checkout to the pattern /*, corresponding to the
remote repository's root directory instead of adding all the folders
and files in the root directory of the user's local machine.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
