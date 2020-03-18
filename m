Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D212C4332B
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 20:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABC52076F
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 20:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkGDujbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgCRUlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:41:17 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51157 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRUlR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 16:41:17 -0400
Received: by mail-wm1-f43.google.com with SMTP id z13so5070391wml.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=f2Hq9FktnVYov8GeejBLLHMj0GhB++1HsYNPARexAB0=;
        b=CkGDujbxo/w8/Rd4r9r3KnSP8xSWCz9I8udi77CgLSle8aJ6DourN6Ruex9Ck/qMJo
         dVqMIrc30yeQHYU2+XUZf2UP5UxKNuQZsG/fgaxpGhW6K5UMWf9F+vxlo0Cmqp8WeVdu
         yWLcNMUxXsr/xMQk8baq3m15clwH7cAsGUAoQpYG7CGszOjw7IQtEZujbeqwhkElPUrd
         ykIjNwEd3Ty5T4O/AxpxOfYSyXcSoilvgFnrlwg8FtZyqjDsORMbf3OHLws62yAsaRHe
         kjGHnWIRaicp6JwYCfgAm4FqhKSBe4br3WUPZvN2c4CV9lPD8xX/O3E8cCMnz1AwFf0Y
         tPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=f2Hq9FktnVYov8GeejBLLHMj0GhB++1HsYNPARexAB0=;
        b=dznmd/A4rRMd8lW/ukKaFYFrRn1f9V4qfpN4hoqrwgK+P2EqxGVu3osIxbor/5vCNK
         Y1wVh9bNkuY1WaYptQuBu8NEevAEdaIM12cdR+ZrGQP4v7N2VA9xMiOuS3lLXcQMYTSv
         AzAWbXPoRhbsPwuWtWPplSa/axXQRT+wmsA5xnon7+skeg2c23+kgk5+WYt+EquhuKyI
         KuSQFmicwTntgUaUQcyGUSVEFWJDHBu+2iq5RStW++w0Hn2f+vLS3r26PFyySWCvTF9z
         mg9W+z0olAybymx4wCO0cY7N8la/JDRe6I83kwhU89EE50adCQlyQFxocikQ0KTToJYM
         ktnQ==
X-Gm-Message-State: ANhLgQ2V5rnwVTCU0a/qP4HIDkFvvYGRJc96wUvq1ChkV9XvWEmbwRw+
        4Ef5pF8/KQmpux141phDo5BA/50O3o8=
X-Google-Smtp-Source: ADFU+vtYTduB7ABpuYNAJ7ZvF2IjGnf0P039hwEahEK5eulFnMKlLuavM06XD8Zp8RWiqiLLL3qMMg==
X-Received: by 2002:a1c:8097:: with SMTP id b145mr7451827wmd.159.1584564074532;
        Wed, 18 Mar 2020 13:41:14 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:299a:790d:ef4b:8b42? ([2a02:a210:ca2:9c00:299a:790d:ef4b:8b42])
        by smtp.gmail.com with ESMTPSA id b5sm33127wrj.1.2020.03.18.13.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 13:41:13 -0700 (PDT)
From:   Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Broken Git-diff on master
Message-Id: <20BFEDB4-738A-4DD7-9316-8DE73999C633@gmail.com>
Date:   Wed, 18 Mar 2020 21:41:12 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey folks,

I am testing out the latest changes in master =
be8661a3286c67a5d4088f4226cbd7f8b76544b0 and observe the following

> mkdir test
> cd test
> echo a > a
> echo b > b
> git diff a b | cat
diff --git a/a b/b
index 7898192..6178079 100644
--- a/a
+++ b/b
@@ -1 +1 @@
-a
+b
> git init
> git diff a b | cat
> GIT_TRACE2_PERF=3D1 git diff a b | cat
21:38:36.615653 common-main.c:48             | d0 | main                 =
    | version      |     |           |           |              | =
2.26.0.rc2.27.gbe8661a328
21:38:36.616258 common-main.c:49             | d0 | main                 =
    | start        |     |  0.004075 |           |              | git =
diff a b
21:38:36.616307 git.c:440                    | d0 | main                 =
    | cmd_name     |     |           |           |              | diff =
(diff)
21:38:36.616696 repository.c:130             | d0 | main                 =
    | def_repo     | r1  |           |           |              | =
worktree:/Users/sluongngoc/work/some-dir/test
21:38:36.617589 read-cache.c:2303            | d0 | main                 =
    | region_enter | r1  |  0.005408 |           | index        | =
label:do_read_index .git/index
21:38:36.617615 read-cache.c:2308            | d0 | main                 =
    | region_leave | r1  |  0.005435 |  0.000027 | index        | =
label:do_read_index .git/index
21:38:36.617656 git.c:674                    | d0 | main                 =
    | exit         |     |  0.005476 |           |              | code:0
21:38:36.617668 trace2/tr2_tgt_perf.c:213    | d0 | main                 =
    | atexit       |     |  0.005489 |           |              | code:0

> git version
git version 2.26.0.rc2.27.gbe8661a328

I think git-diff is broken. Hope that this get address before 2.26.0 =
come out.

Cheers,
Son Luong.=
