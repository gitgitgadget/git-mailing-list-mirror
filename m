Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809BCEB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjFNT03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjFNT0J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:26:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530D1FDD
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8c9cb3144so9284575e9.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686770766; x=1689362766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHrLhqhiua3psCWQsrZsPnfXmvVY5FIK3NCVO6BpoNg=;
        b=gOpIz2fHMsc4gyoT5l8TwxrybmDSp0Bihl2jO4ingyHWGHpwcHdA2FpHO7YOV3/YZH
         uG66PwKE+su1yQhdajBQcR3nVKRc6d40TcbPakcMTmNHRPEADcIyUY0sboR2h6BVFfuI
         Znb2nrEWzdvkIfUxiuG9zYsgv2f+DJFJP5+jSi3gh0u+7ltXqFmtTI7ytP/woQFyebfa
         nPPtjNsz6ixZ3YM6dbxlR0U659aWXpZI8LG7uj87LRJz6XLziGBjLeMaTXHaLTrdcvmw
         YDmy2iRfv4urpoXUwk2lmdtN7XjLw9SdzgsjkBqIvJyQLnvzhjjixOR+QHVkAeebFQMS
         3TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770766; x=1689362766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHrLhqhiua3psCWQsrZsPnfXmvVY5FIK3NCVO6BpoNg=;
        b=GajeoA7G7OkQhzetirBcfwLZazx3xf6AyovfpB0U36Tj5GveadOH5nbJLSKfWN3oSF
         fhxxiquEU+fEqotCnl4Bb9mieo14qSAc5zjwvARFOrRDJnNynW8fGmr7mFbRuzq7Os29
         CAISUemqFOg7H7e6WPmPyIt3ekvSw9GH1OkPRPzyVmQjSDkc531Z6E58IR/2ORbf+KAJ
         GcchzBR4bEyCS+EfUBIFY3gnyT/d8T+8KibLPZlsKbTKNdSeg8q729lNVh8JwvsrOLIw
         QnHasgMYBL5FsrtRYEnKVXHVXZyR8puZTAeLulQFyBDnhQrW95yD+Zd9fj4FACf3vcrC
         I9hw==
X-Gm-Message-State: AC+VfDwHhlvMJSsVbylwFxNBgX22/CmkfMdIloQY/mn4ThLb+SkmywJ5
        jghSZHpQfEJnElXZmsXTg31FP/w2D0I=
X-Google-Smtp-Source: ACHHUZ6afieRH8VhTTAXKEXRByTX88jgvPqxpYGsuaO0xzf1iafmLn8vmbKYfT25nqwigU1d/7Zyvg==
X-Received: by 2002:a05:600c:2204:b0:3f6:be1:b8d9 with SMTP id z4-20020a05600c220400b003f60be1b8d9mr11129765wml.6.1686770765905;
        Wed, 14 Jun 2023 12:26:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e164:efe0:8fdb:6ba])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm18370365wmm.39.2023.06.14.12.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:26:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/9] repack: refactor piping an oid to a command
Date:   Wed, 14 Jun 2023 21:25:36 +0200
Message-ID: <20230614192541.1599256-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.37.gae45d9845e
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new write_oid_hex_cmd() function to send an oid to the standard
input of a running command. This new function will be used in a
following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/repack.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0541c3ce15..e591c295cf 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -182,6 +182,17 @@ static void prepare_pack_objects(struct child_process *cmd,
 	cmd->out = -1;
 }
 
+static void write_oid_hex_cmd(const char *oid_hex,
+			      struct child_process *cmd,
+			      const char *err_msg)
+{
+	if (cmd->in == -1 && start_command(cmd))
+		die("%s", err_msg);
+
+	xwrite(cmd->in, oid_hex, the_hash_algo->hexsz);
+	xwrite(cmd->in, "\n", 1);
+}
+
 /*
  * Write oid to the given struct child_process's stdin, starting it first if
  * necessary.
@@ -192,13 +203,8 @@ static int write_oid(const struct object_id *oid,
 {
 	struct child_process *cmd = data;
 
-	if (cmd->in == -1) {
-		if (start_command(cmd))
-			die(_("could not start pack-objects to repack promisor objects"));
-	}
-
-	xwrite(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
-	xwrite(cmd->in, "\n", 1);
+	write_oid_hex_cmd(oid_to_hex(oid), cmd,
+			  _("could not start pack-objects to repack promisor objects"));
 	return 0;
 }
 
-- 
2.41.0.37.gae45d9845e

