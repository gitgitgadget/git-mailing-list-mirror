Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6921F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbcHOT7P (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 15:59:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34327 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbcHOT7O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 15:59:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so12840392wma.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 12:59:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=naDtCyED8jlrbfZNbHSBNYdoW7VgZvWa5H5CYcp/Ad4=;
        b=iLeWuwhXFX73xNa7YlHQZTGrGeZWGGtyHloH+uFgC9aW3SWYZr1wvnQeMxoQyHEdSl
         imwIDkhAJKRJB77BMnrdXbYl5d/TY0ijMoA1M34ls9nujgpWBTpq1WxE3RZJKTHa09jY
         0QraRMH+H98/v0Yj5Ziylhd9WQ4Vjg0jtCaH7TYqRU1L9qnnEslWlzElBBZUJejCsrdm
         gxNbEkgS02TlbqZZfUZDrj0nGzsWw+d+9QGUMgKHEort6wlrLy5BZ+NAafadYTEPSQ6o
         utRair2pgQ3nlknI5hbi1+O9Vpi82Rf/+g5Lc0Xgf8TD7Z5+Z4LRIufEdqawM/+EzKCH
         KSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=naDtCyED8jlrbfZNbHSBNYdoW7VgZvWa5H5CYcp/Ad4=;
        b=PG9xp0cXJhXLQLynisB3lsapo+oXWjSDOoGYuuq5um8Gz+0c/mcVgbYPJ6m5yek5uT
         u1garlC8x9C/L38q/VNluaUxU4OUPCVsR+5nvHUclMeq6Ga7KBVHOAcism8ITE25u2c3
         aE9JBksl+xzsYhR8sYlljCg/5BRYK1BOHc1pzBsojm67eTXo1z/xdGX74wtJAm9Vu1Aw
         tQr1GFGcte0BUUyHw+e+Y3pOAT5teuQ9V0eewGPR5GuDS6MRFw7SrmAvtyuU+tbJ21u9
         it1dUeTflpmVY1PJR1YJzH7Tg6T7eHiw7IKNWcjKUpCUFdS9+jB2MlAMgAIfcxXncAR0
         J6OQ==
X-Gm-Message-State: AEkoouvoY+EHKYPeKoaGSJkMVIX/YsiNGq3oDLVcrLWe8ILJQduKH92JvBfBmW1yBPjzVg==
X-Received: by 10.28.43.129 with SMTP id r123mr18139370wmr.27.1471291147686;
        Mon, 15 Aug 2016 12:59:07 -0700 (PDT)
Received: from localhost.localdomain ([80.215.5.33])
        by smtp.gmail.com with ESMTPSA id p1sm23065623wjd.37.2016.08.15.12.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 12:59:07 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 3/3] receive-pack: allow a maximum input size to be specified
Date:	Mon, 15 Aug 2016 21:57:29 +0200
Message-Id: <20160815195729.16826-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.4.g229e32c.dirty
In-Reply-To: <20160815195729.16826-1-chriscool@tuxfamily.org>
References: <20160815195729.16826-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff King <peff@peff.net>

Receive-pack feeds its input to either index-pack or
unpack-objects, which will happily accept as many bytes as
a sender is willing to provide. Let's allow an arbitrary
cutoff point where we will stop writing bytes to disk.

What has already been written to disk can be cleaned
outside of receive-pack.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/receive-pack.c | 12 ++++++++++++
 t/t5546-push-limits.sh | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100755 t/t5546-push-limits.sh

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 92e1213..7627f7f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,7 @@ static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
 static int advertise_push_options;
 static int unpack_limit = 100;
+static off_t max_input_size;
 static int report_status;
 static int use_sideband;
 static int use_atomic;
@@ -212,6 +213,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.maxsize") == 0) {
+		max_input_size = git_config_ulong(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -1650,6 +1656,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (fsck_objects)
 			argv_array_pushf(&child.args, "--strict%s",
 				fsck_msg_types.buf);
+		if (max_input_size)
+			argv_array_pushf(&child.args, "--max-input-size=%lu",
+				max_input_size);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1678,6 +1687,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 				fsck_msg_types.buf);
 		if (!reject_thin)
 			argv_array_push(&child.args, "--fix-thin");
+		if (max_input_size)
+			argv_array_pushf(&child.args, "--max-input-size=%lu",
+				max_input_size);
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
diff --git a/t/t5546-push-limits.sh b/t/t5546-push-limits.sh
new file mode 100755
index 0000000..d3a4d1a
--- /dev/null
+++ b/t/t5546-push-limits.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='check input limits for pushing'
+. ./test-lib.sh
+
+test_expect_success 'create known-size commit' '
+	test-genrandom foo 1024 >file &&
+	git add file &&
+	test_commit one-k
+'
+
+test_expect_success 'create remote repository' '
+	git init --bare dest &&
+	git --git-dir=dest config receive.unpacklimit 1
+'
+
+test_expect_success 'receive.maxsize rejects push' '
+	git --git-dir=dest config receive.maxsize 512 &&
+	test_must_fail git push dest HEAD
+'
+
+test_expect_success 'bumping limit allows push' '
+	git --git-dir=dest config receive.maxsize 4k &&
+	git push dest HEAD
+'
+
+test_expect_success 'create another known-size commit' '
+	test-genrandom bar 2048 >file2 &&
+	git add file2 &&
+	test_commit two-k
+'
+
+test_expect_success 'change unpacklimit' '
+	git --git-dir=dest config receive.unpacklimit 10
+'
+
+test_expect_success 'receive.maxsize rejects push' '
+	git --git-dir=dest config receive.maxsize 512 &&
+	test_must_fail git push dest HEAD
+'
+
+test_expect_success 'bumping limit allows push' '
+	git --git-dir=dest config receive.maxsize 4k &&
+	git push dest HEAD
+'
+
+test_done
-- 
2.10.0.rc0.4.g229e32c.dirty

