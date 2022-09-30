Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1179C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiI3SLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiI3SKw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:10:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF1BF15
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j7so2638800wrr.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=N5mthH+K5Njxp3dcTaJmTbYgZkASpKhFvJxdQwYDxOM=;
        b=kg5ako7Ta0T8DItdWhIhY4278J5tYx7uEMtgddXNQdSEINAwsOtmhMq55mFvPfwZbN
         yyeQ1zOgK9bSer75XQVWQRDNa+rDYzWfV2U3Sxypd/zKvKdFxSeBqgwnXTO1CILli9tj
         7uAx7P/B4HM5FDn2NWVUVDIG59kqMmgux8GamK48SMWCsa6aZkefbPMOWEJmpA95LaWF
         1avvbk9zX8u4DQUKOy/6BhPfAK7gM1PJTcloAfjMXk75/3s7UZSlXSThGSMXFWFnWdGI
         Yd+uAFd6AiywDNCyyiKwhOBJQ7Kp+lq/Fk+1rmAKrs+5KxIOuvKIRPF8n/K+vNbmAr+A
         h8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=N5mthH+K5Njxp3dcTaJmTbYgZkASpKhFvJxdQwYDxOM=;
        b=HezoKSpxDJDaEoVsnthx9DZXNXmleKwOnj7vJ/XS3FdvfAfxoiAOAFr8Pv8/VQ157/
         tYWeDrVV9lsfiW8bEO3DN8IOQ7+TbuDWKzAHwOs46gw38ZXCWQCodUUsez7eaHaFr53f
         Wz/j4syz/fu6H79ketJO07l9feeYXL1e4fXiQAGZ2cftPUR+IgLyNLoy65Zsw0Tg0j6N
         55Fr8KtkpvYTTQRX8B3pEoDaLpbOp9HYf1rnHeaBVUK+EJCvw9gLirVb958h49da6rCe
         RhERNrylCMIAlrE+pOBaI6SedR/r5R7FV0kjJlo+2IKb+qsV7vxVxU3Cjc5u9fndWktf
         v5pQ==
X-Gm-Message-State: ACrzQf144V7Udv7hTENI2Z8pIuuM1SxyMBM4TzEQeEC0eDTUP3Nn2ZUf
        x1vEoCg21g2woRwUGrJjsbDTFNfFU86/pQ==
X-Google-Smtp-Source: AMsMyM5lU4Wmr0lmijEHAcDMEPp/lMJcvGb5RUVcckZUOm4J4/EnZXVAl7KF1t+3ghTjb8Xp4LI2kg==
X-Received: by 2002:a5d:5a85:0:b0:22a:34a8:eda7 with SMTP id bp5-20020a5d5a85000000b0022a34a8eda7mr6541753wrb.687.1664561374350;
        Fri, 30 Sep 2022 11:09:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 25/36] doc txt & -h consistency: use "git foo" form, not "git-foo"
Date:   Fri, 30 Sep 2022 20:07:48 +0200
Message-Id: <patch-v3-25.36-ab109f73264-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "git cmd" form instead of "git-cmd" for both "git
receive-pack" and "git credential-cache--daemon".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-receive-pack.txt | 2 +-
 builtin/credential-cache--daemon.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index eec1268b10f..92452334ac4 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -9,7 +9,7 @@ git-receive-pack - Receive what is pushed into the repository
 SYNOPSIS
 --------
 [verse]
-'git-receive-pack' <git-dir>
+'git receive-pack' <git-dir>
 
 DESCRIPTION
 -----------
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index d4eb0097d24..f3c89831d4a 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -267,7 +267,7 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 	const char *socket_path;
 	int ignore_sighup = 0;
 	static const char *usage[] = {
-		"git-credential-cache--daemon [--debug] <socket-path>",
+		"git credential-cache--daemon [--debug] <socket-path>",
 		NULL
 	};
 	int debug = 0;
@@ -305,7 +305,7 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 {
 	const char * const usage[] = {
-		"git credential-cache--daemon [options] <action>",
+		"git credential-cache--daemon [--debug] <socket-path>",
 		"",
 		"credential-cache--daemon is disabled in this build of Git",
 		NULL
-- 
2.38.0.rc2.935.g6b421ae1592

