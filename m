Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E36C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8149520795
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="V7OvSWjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgIJRlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgIJRVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:21:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F6C0613ED
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d20so6878122qka.5
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4y+U4GTGlNUPsaLRPbaZMHdUUBXALPwCNHtrAHuNn4=;
        b=V7OvSWjU5alzdRXWKlhbtd8Bd5shnTdyeSG81HeZJv6txyhVRHjR+8cXcvyIF22Ng6
         XYCJwxBFwrCJJzqtHSxer+wV2KIDPgR1HGO8ZE1VulZ5cNh341yDVMsTVnohPINd3+/7
         FUuzZAUTP3jbOXMFuMX2AbozB0VOJobPBg81pJDzNNrlfGdhOY5SqZAvjpojNe9LP25k
         28kq8fuvT0gCjnDfnVfd1lQy1TAl5ZdD+wNL0bv7RKMuCYhHM5RDQHlBy4B5zlbnlpYe
         IeTKvR2CX4sn2gpZ2GJf+QsMnaas7Q9LyXPe2ILtfgYxptG8/n0+UsMxZkhnLCt2muGN
         69Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4y+U4GTGlNUPsaLRPbaZMHdUUBXALPwCNHtrAHuNn4=;
        b=b2NSv68WK1NuoW6GcmdcP1V2fcgc0etv1wiTkFlYZovS+kJP8NjlXec2JGxpiTJKTN
         M7m1C3ri5pJVx62WkxCTW3NhjpAJlf5c4ILZRV93/I2AVkvw/BEeA4owlD3CI7Os2qjl
         1vljoCc86zZnJ40o+UPawwcdKMtITRzbSuf5Uv/tPxQjH3uqj7/rRIgCMGt8XRpHEfef
         jtU6z0ZRYBtHpeEUqUSK9apWVlIN5zYQ8Lht6aytXZlNb41rh6RTkSLpN09j8Fpa7Axq
         DlpLfZC+bG9sA6UJUT0lc9N4K0LkCc1KZcc6qlkK2I5muOGyO+2RPhwqexI1oRnPpPHI
         LmsA==
X-Gm-Message-State: AOAM531mkSS8voei7OASrdUs9BuNQi+PzN+Zs9PqGRznUK0xF8zBkUW/
        bE0L1ZwQdRttdcKcyRZRgV2hFq5YUn5stQ==
X-Google-Smtp-Source: ABdhPJyDJFjN18ZFcat/G/kW/i2V67D+PodpyGAl5Ca5oiYHWG1S0ugpV+L2uj+mlPA4UG8CZTlVGQ==
X-Received: by 2002:a37:8ec3:: with SMTP id q186mr8838951qkd.233.1599758509450;
        Thu, 10 Sep 2020 10:21:49 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id h18sm7037437qkl.12.2020.09.10.10.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:21:48 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v6 3/9] t/helper/test-config: be consistent with exit codes
Date:   Thu, 10 Sep 2020 14:21:22 -0300
Message-Id: <45d13744b7849ec485f76e0a67e972fdd01ba21a.1599758167.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599758167.git.matheus.bernardino@usp.br>
References: <cover.1599758167.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test-config helper can return at least three different exit codes to
reflect the status of the requested operation. And these codes are
checked in some of the tests. But there is an inconsistent place in the
helper where an usage error returns the same code as a "value not found"
error. Let's fix that and, while we are here, document the meaning of
each exit code in the file's header.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/helper/test-config.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index a6e936721f..9e9d50099a 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -30,6 +30,11 @@
  * iterate -> iterate over all values using git_config(), and print some
  *            data for each
  *
+ * Exit codes:
+ *     0:   success
+ *     1:   value not found for the given config key
+ *     2:   config file path given as argument is inaccessible or doesn't exist
+ *
  * Examples:
  *
  * To print the value with highest priority for key "foo.bAr Baz.rock":
@@ -80,10 +85,10 @@ int cmd__config(int argc, const char **argv)
 
 	git_configset_init(&cs);
 
-	if (argc < 2) {
-		fprintf(stderr, "Please, provide a command name on the command-line\n");
-		goto exit1;
-	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
+	if (argc < 2)
+		die("Please, provide a command name on the command-line");
+
+	if (argc == 3 && !strcmp(argv[1], "get_value")) {
 		if (!git_config_get_value(argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
-- 
2.28.0

