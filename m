Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2C7C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB256126A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbhHWNTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbhHWNTN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 09:19:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8092C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:18:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v10so15023404wrd.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFo1eNfgV8JLlPxXGI2COzglMYCjJFMUGexH73/CZKc=;
        b=YxwA9Zb2km0mXIbldGxXyedjdOrTvmDTZDi0Omq5+swCJRo+Kkoqgy85sX0bVp6W1S
         O19MIEqEPQk29Fapms07iY1Y579vh5FMghj6ZYyRx1xCaG/fVyUVuYFgyAqFuhtHz3VE
         CaTNPNewxRdETdHgPHOM0t25ZE8Bslh8stDafik99Aev7F7CFaGjg45LTtxt9JR4z70U
         jeeUuQ5HgNlIvEbupe9dPj7ogkGeyX1diH1MnC91j99XHOnIKqCA892j05gwl5ER6RhF
         IrGc/+LUSU0GteMWV/MDShtRDkBzJ00F9F8UpBashSiHrTQP69kYHkHwTMPyqzRkjW2K
         Oi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFo1eNfgV8JLlPxXGI2COzglMYCjJFMUGexH73/CZKc=;
        b=p/Y6rKcXUgMNHTFd9NgcZxYHCJaCoALMdgTHd0TLoBJFm8Y4mEaEFWUe6i/Naf8bzX
         NJFSo8RRe4m2k2xveIDeJfTPXIcH+hA3xVOJVoMGMlOaC7qPPALmoAkAyntyok89T7sJ
         NuydbwcxhiqHN6ybpmADF16L3qmq4mRb9+Dzg/gzbkkywMxlSeusHXEFjWDCRiz0kiCr
         XfhwhhETXC7an6c0hews4MoBN0LewJNuhRl9p7ukBBC+1IvV00jaKHXEfASl358ZD21b
         G+xcLqk6viyPZ3E+7CHo4SFXdY1IdvW+PFkv1naeMBVI4OFgD3MrFsB+OSAPnzt7Mnv1
         6H8g==
X-Gm-Message-State: AOAM532/GzF3uXXCG+qSGUZZnWh2VBgoGTi1GnUduFA2jTWAYVRKtrlk
        3o+4qkbysjmRlbvsR2h4ob0VxBSMGrn3Cbxs
X-Google-Smtp-Source: ABdhPJwmxPfncfcKtEYWc/UJEGJWHj8cVO2bIYf+clbkqTJzhuooZY/7QRD8/N+mokPHXICqqME11g==
X-Received: by 2002:a5d:64e6:: with SMTP id g6mr2365786wri.288.1629724709213;
        Mon, 23 Aug 2021 06:18:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f23sm1561495wmc.3.2021.08.23.06.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:18:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] ls-remote: set packet_trace_identity(<name>)
Date:   Mon, 23 Aug 2021 15:17:49 +0200
Message-Id: <patch-1.1-5d3a2b96500-20210823T131533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set packet_trace_identity() for ls-remote. This replaces the generic
"git" identity in GIT_TRACE_PACKET=<file> traces to "ls-remote", e.g.:

    [...] packet:  upload-pack> version 2
    [...] packet:  upload-pack> agent=git/2.32.0-dev
    [...] packet:    ls-remote< version 2
    [...] packet:    ls-remote< agent=git/2.32.0-dev

Where in an "git ls-remote file://<path>" dialog ">" is the sender (or
"to the server") and "<" is the recipient (or "received by the
client").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-remote.c    | 2 ++
 t/t5702-protocol-v2.sh | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1794548c711..f4fd823af83 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -84,6 +84,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest = argv[0];
 
+	packet_trace_identity("ls-remote");
+
 	UNLEAK(sorting);
 
 	if (argc > 1) {
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 78de1ff2ad5..d3687b1a2e7 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -27,9 +27,9 @@ test_expect_success 'list refs with git:// using protocol v2' '
 		ls-remote --symref "$GIT_DAEMON_URL/parent" >actual &&
 
 	# Client requested to use protocol v2
-	grep "git> .*\\\0\\\0version=2\\\0$" log &&
+	grep "ls-remote> .*\\\0\\\0version=2\\\0$" log &&
 	# Server responded using protocol v2
-	grep "git< version 2" log &&
+	grep "ls-remote< version 2" log &&
 
 	git ls-remote --symref "$GIT_DAEMON_URL/parent" >expect &&
 	test_cmp expect actual
@@ -151,7 +151,7 @@ test_expect_success 'list refs with file:// using protocol v2' '
 		ls-remote --symref "file://$(pwd)/file_parent" >actual &&
 
 	# Server responded using protocol v2
-	grep "git< version 2" log &&
+	grep "ls-remote< version 2" log &&
 
 	git ls-remote --symref "file://$(pwd)/file_parent" >expect &&
 	test_cmp expect actual
-- 
2.33.0.662.gbc81f8cbdca

