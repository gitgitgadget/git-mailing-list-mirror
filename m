Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADBCC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D399206DC
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbhAUDrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393390AbhAUCyP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 21:54:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0785AC061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 18:53:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id kx7so671498pjb.2
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 18:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0idAtKjk/T4tj4o9r/o9hM9FGdClvbDpJ7ry64grCMs=;
        b=tjjzA7IhzwfEwz19bnpotTFjqpFNbN3zk8LidHpLf4aFqJzFoLW7i1gEi2ed9PcIbB
         IAthtltZfD/Sx/yTUoDZNRcWxFh0aiDhYzoN9qoLPqaMh8fyq26G2W/kr0Eh5zDutJWn
         Pr3tNW0OS5pEXtCP9i44GCxezFY4qIxcG7yKruIBokasZidCmMnAYMNoe4740zCBVpVp
         MliMs4+yqYRM4CtEsVpc1BtxU/ryj/ptyKa9Tj2KOOY2zb31hrMYI3D/cPiJzDw/ErDD
         yUTVdeE8Y8M2ibFD8gPGNz1da+TpGEYA0Djui44/R9Jel7rM/YghuFQMJtllZr/Ndecc
         AyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0idAtKjk/T4tj4o9r/o9hM9FGdClvbDpJ7ry64grCMs=;
        b=U7KD8QosUBgzNZRt3neqAi0nCkLpBEpgRHN1XsUs2njs/lldXbNdvHW7HWINQx5wjm
         0ETU1bQzgvvC8TBoviYW8Mh/wU4+lOqIfs2HH83RVlox/IsBqfaJ02eiTOA+Ez1iFohh
         4gQYnjSSlSDAc2bv7CIAyGs5G+41vdn5b8ho9PCoTzjh0C1Wj6g5O8JNE4eO8w2zyQcK
         Ro+/Xvl6OUYRHY3lIKWRoXvur17FDexkdt7YK96w9bVzqz8xpSOAqzrGdFKtv1IXjSUv
         uXO7YN3F1oDkYlK2zQ3mMs0YPidsF5JQ2tIgC6AG8SAMGrtHkSEx9YiMY/T1JxzcAH/w
         WaRQ==
X-Gm-Message-State: AOAM530+eSbaMqXLteBMIvg94K01U3br9oFipY6jQY6k9i3as/Nre5KX
        ePtCGPCnriVPt6IPnnoUdgA=
X-Google-Smtp-Source: ABdhPJyuB10VVhgocuJorrg5TPWnbK+7VaeRp+1ayLpxc9tURYpLSKNkKLu/MuTxPgtD05rBEzpYZQ==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr9103454pjb.199.1611197614387;
        Wed, 20 Jan 2021 18:53:34 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y10sm3561624pff.197.2021.01.20.18.53.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 18:53:33 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 0/2] use unique out file in t5411
Date:   Wed, 20 Jan 2021 21:53:29 -0500
Message-Id: <20210121025331.21658-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20210120124906.GA8396@szeder.dev>
References: <20210120124906.GA8396@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

t5411 has some test cases for the behavior of failed 'git push'
commands.  Even the 'git push' command ended, the output file
may still be updated with messages from 'git-receive-pack' command
running in background.  This breaks test cases which reuse the
same 'out' file.

## Changes since v2

+ Use unique 'out' file by appending the '-$test_count' suffix to
  prevent accidental overwriting by internal 'git-receive-pack'
  process.

--

Jiang Xin (2):
  t5411: use different out file to prevent overwriting
  t5411: refactor check of refs using test_cmp_refs

 t/t5411/common-functions.sh                   | 15 +++
 t/t5411/once-0010-report-status-v1.sh         |  5 +-
 t/t5411/test-0000-standard-git-push.sh        | 32 +++----
 .../test-0001-standard-git-push--porcelain.sh | 32 +++----
 t/t5411/test-0002-pre-receive-declined.sh     | 10 +-
 ...st-0003-pre-receive-declined--porcelain.sh | 10 +-
 t/t5411/test-0011-no-hook-error.sh            | 20 ++--
 t/t5411/test-0012-no-hook-error--porcelain.sh | 20 ++--
 t/t5411/test-0013-bad-protocol.sh             | 95 +++++++------------
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 95 +++++++------------
 t/t5411/test-0020-report-ng.sh                | 20 ++--
 t/t5411/test-0021-report-ng--porcelain.sh     | 20 ++--
 t/t5411/test-0022-report-unexpect-ref.sh      | 10 +-
 ...est-0023-report-unexpect-ref--porcelain.sh | 10 +-
 t/t5411/test-0024-report-unknown-ref.sh       | 10 +-
 ...test-0025-report-unknown-ref--porcelain.sh | 10 +-
 t/t5411/test-0026-push-options.sh             | 22 ++---
 t/t5411/test-0027-push-options--porcelain.sh  | 22 ++---
 t/t5411/test-0030-report-ok.sh                |  6 +-
 t/t5411/test-0031-report-ok--porcelain.sh     |  6 +-
 t/t5411/test-0032-report-with-options.sh      |  9 +-
 ...est-0033-report-with-options--porcelain.sh |  9 +-
 t/t5411/test-0034-report-ft.sh                |  6 +-
 t/t5411/test-0035-report-ft--porcelain.sh     |  6 +-
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 18 ++--
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 18 ++--
 t/t5411/test-0038-report-mixed-refs.sh        | 10 +-
 .../test-0039-report-mixed-refs--porcelain.sh | 10 +-
 t/t5411/test-0040-process-all-refs.sh         |  6 +-
 .../test-0041-process-all-refs--porcelain.sh  |  6 +-
 ...t-0050-proc-receive-refs-with-modifiers.sh | 18 ++--
 31 files changed, 224 insertions(+), 362 deletions(-)

-- 
2.28.0.15.gba9e81f0bd

