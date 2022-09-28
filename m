Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB4C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiI1Ild (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiI1IkL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D96D8C034
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c11so18583777wrp.11
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TOQwNl/S29h5k2Byu7R6T1e0/iPkTnYZ4IbPZ+7Vf1w=;
        b=kYhNjY4S3UEN+hD8MPj5SRaeKxGngEP8r+bKKHPtxLwDFip7iVJs6lZxQSDktvvyI4
         S1VoifjO/bk923JeJqLmY46dF9SKOxHj+NKRwArkF89KYIwFfMhlpCeoBz/GQjjFh7iq
         YhOMutZ5wW3YHgKxpw/jLhITBhhWOAC7NWjCsWN+8owwvmsdboeLroN8Xse20A9oUvd7
         AcPOtv7JGdKX/YRaQNuntHdP9Q5paSGG62OWsftFJodNMJfKBACZC9xibLfsicPTMfDC
         lo5erNAv1DKyQLKMNG/dnbOQ46gLbYWhmzs28ob/HF58OSC4S+nOqrqG1GBosGtltpU2
         dT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TOQwNl/S29h5k2Byu7R6T1e0/iPkTnYZ4IbPZ+7Vf1w=;
        b=yRfmDE4DWV3ByGtP08ZkJ4VfnmENz2ohGyoBFdg4ZlxYoWENDfHSJE4oomcuxDTzCw
         5WongvFN1ynQbqW8ZZBOsQN6/u1to2yBMjJ4YDbR11ZAMRS2X0PJFcrdqjWPV1o01orM
         3DhGDC9oDUVfAjqAuSp/eUtM1npdPO6TWs+sREZplbSwUmBpgFmgz3khgu2NHQI1glmw
         Yz0EDMbSjY9kd2na+qZZzJtTsCKNbZFTSJqB6NJgoDqyd1Z7SouY2HQcbrmlVM/0FCwL
         6vXqjD4pSnH2fv5jJvakFU+Rvy/mFdiptcaHPDKy/vw6/amGJ9u9jxj8CO1drFYbNjer
         PqxQ==
X-Gm-Message-State: ACrzQf1fhtuW6eHDevecrsZ1u62+OxGGm6xcyXfUlxvZgOsnv2suC7tp
        LyDdi8S1QCmubgSrP+iDL68VB+0AQPwUzg==
X-Google-Smtp-Source: AMsMyM4n+VhnAH0imRN5ofzY8w39qad0B0nwM6/KhmSI/BY6jCiBgEqbu7Zwe6ENXyeJBSXTO4431g==
X-Received: by 2002:a05:6000:1d83:b0:22c:aa0a:12 with SMTP id bk3-20020a0560001d8300b0022caa0a0012mr8202579wrb.471.1664354401406;
        Wed, 28 Sep 2022 01:40:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:40:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 24/35] doc txt & -h consistency: use "git foo" form, not "git-foo"
Date:   Wed, 28 Sep 2022 10:39:19 +0200
Message-Id: <patch-v2-24.35-a4feebc5434-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
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
2.38.0.rc1.925.gb61c5ccd7da

