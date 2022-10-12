Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D41C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJLJDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJLJC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BBA8F964
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk15so25218174wrb.13
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdHbmIww9B7aTqOeTOmToJ+eVkGDXXVo3L8SPSVlDPo=;
        b=qyq+UVbsGtUaSVgTw1NCeFdueZ8zAUcDlAgXknoz23yxfy0B3dNfOH6S+DH+/DOaEU
         3IcuquwcAeNd+MnfIXjzaN4naoDURF7LIxm4+0o5QOr86UjSU9LgwTMkDE3f0UuLX4MF
         zy6eYWO0SAIRfUzQGxxmacm9r1lO4QVTO0tmNyHB/TrqG3FnkAcTcjfuvaIwAkAylGSm
         OHUSNoUb9YG2TAD4fC0tCmhMx7bTl9r1zRCVg2gRqJHOVc6TqIT3eN/2oa9oo/cQQrjC
         coIDqEgL+BG4F3zHFKm4ll6jMC+gapJXW8JhszyxD0UwzpygZgSvO/JdEJ/KgmWVB4wU
         GWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdHbmIww9B7aTqOeTOmToJ+eVkGDXXVo3L8SPSVlDPo=;
        b=DFkd/5QmI7LPEeexccAntyEESAipPKIllNgbYx0C0jBKMKGjTMSfbspD2otZteu2js
         ZKUKud3cgmwvyTOI0qWQEErHuviOR8wd9NIomR6sBTATcmTF+4v2b5r9w5IFpyHiQ1/h
         +FDqHXWZgdfh5IeXx2DElo2O+EZ2+QQhZ8Ft0x7FtmF9gAvxukdjPTL7Z9OTxVD5LnZn
         SslTA48kou+ad54Z/rpVyvrzzlEfndl4AEi6Afw8R35XElgbDGrNmbd3LlyoFhRD+VsZ
         f+DJynv6wv/3fW3dxfKi7/KPSHpT6fg6FImDHKU3iiPmoEgw1gi7dCpGXnlUqVgGN5Be
         CBtw==
X-Gm-Message-State: ACrzQf0qDUTNAsOLSqAlAx2Y37C+WaMfNf6fnsdBZv3oyD6hdYtrK1v0
        PFwHsByUxI/wPWmf64NlnGCasDM3qwy6+g==
X-Google-Smtp-Source: AMsMyM4WniFzVGqkfY120EtciitgRlUDW9JzHFbPATr6+1Sha8dZ/0dJS9WW1tfCNVfj4KgKDikwGw==
X-Received: by 2002:adf:f58b:0:b0:22e:3c4:cf83 with SMTP id f11-20020adff58b000000b0022e03c4cf83mr18192963wro.379.1665565319747;
        Wed, 12 Oct 2022 02:01:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/22] run-command.c: make "struct parallel_processes" const if possible
Date:   Wed, 12 Oct 2022 11:01:24 +0200
Message-Id: <patch-v2-16.22-acac50cc1a5-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "const" to two "struct parallel_processes" parameters where
we're not modifying anything in "pp". For kill_children() we'll call
it from both the signal handler, and from run_processes_parallel()
itself. Adding a "const" there makes it clear that we don't need to
modify any state when killing our children.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 64fa0299175..6c343b9b77b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1538,7 +1538,7 @@ static int default_task_finished(int result,
 	return 0;
 }
 
-static void kill_children(struct parallel_processes *pp, int signo)
+static void kill_children(const struct parallel_processes *pp, int signo)
 {
 	for (size_t i = 0; i < pp->max_processes; i++)
 		if (pp->children[i].state == GIT_CP_WORKING)
@@ -1694,7 +1694,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 	}
 }
 
-static void pp_output(struct parallel_processes *pp)
+static void pp_output(const struct parallel_processes *pp)
 {
 	size_t i = pp->output_owner;
 
-- 
2.38.0.971.ge79ff6d20e7

