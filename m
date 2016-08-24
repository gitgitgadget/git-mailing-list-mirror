Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD001F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 18:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933023AbcHXSmY (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:42:24 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33452 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755413AbcHXSmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:42:19 -0400
Received: by mail-qk0-f194.google.com with SMTP id n66so1836730qkf.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nfZmTGdI/HwLkVwTZEBYVlZxO/KoPo4/YSN3XmdYWTc=;
        b=HRLRfpMJA5vgcxLpVfnTlauH6CAiyRF1pVXJdHR9DVQp0zrQhAmXzTd2MBvzbfTWF6
         O2n0WHcVRaePee+eyV7rslmuiSHl820dzGTOWn0C95mVg/eZ+jJ4hSlS1TQ2gFLmlcOS
         zd71vijqvU2WDJ2NYPjZ4N/KjuwIz6pMl0Y5USzCpu9w+sp6JzUe4StqhMFwZEphzzqr
         QbGcjCcTBN3/m5zOU7NIlby5jcUdamm782QDk4aoJY6AM9MmrHz4uZCcLq8WeuNGMK2G
         Vl7o8lZcr7McpYS5bs283g+G2cJBZHeUpX6lbPG1yM2j/v8QtjEHnCalNo12ijjc5QkQ
         1FFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nfZmTGdI/HwLkVwTZEBYVlZxO/KoPo4/YSN3XmdYWTc=;
        b=kiTkuPVoIKizE3XSWMSlV9j2Agt7EqR4ZzLCawMz1JDiWiOg413txu7IgaKhiZCIhh
         utEimPVwHPpybNs1D5urtIFMT8AvvlFxQ/PNSpL6xo9ZgY0RZkA789mNu0Jwb6Rg0dCl
         XYVENTPt3BQMPiKyRP4ti7vyeHcYSMiakwz/EirsXZFmZH2flwC91ZdoLg3emCggIjF/
         yHJL6OtykDFR5jhfwTyyULvXXyTHgC8SL5EnfJjTM1yoFEMRYC7roepUXzAfjCLwl9xQ
         jBjQhDhShJq78jdi+CnrOkQIDEF6IdJOXpjOjr/PmYZtJzazzA4JCQ8I9rhFX3V3rBkI
         okZA==
X-Gm-Message-State: AE9vXwOWaikY/EDHkJsMBAUwZ3fasEcaTMDHNuQNeMZAvZv1gOZMWQfVaBt0S7SXPwYkLA==
X-Received: by 10.55.151.198 with SMTP id z189mr5325633qkd.70.1472064136041;
        Wed, 24 Aug 2016 11:42:16 -0700 (PDT)
Received: from christian-Latitude-E6330.event.rightround.com ([75.98.193.200])
        by smtp.gmail.com with ESMTPSA id k20sm5412874qkl.2.2016.08.24.11.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Aug 2016 11:42:15 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/3] receive-pack: allow a maximum input size to be specified
Date:   Wed, 24 Aug 2016 20:41:57 +0200
Message-Id: <20160824184157.19264-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc1.3.g93be2b9
In-Reply-To: <20160824184157.19264-1-chriscool@tuxfamily.org>
References: <20160824184157.19264-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Receive-pack feeds its input to either index-pack or
unpack-objects, which will happily accept as many bytes as
a sender is willing to provide. Let's allow an arbitrary
cutoff point where we will stop writing bytes to disk.

Cleaning up what has already been written to disk is a
related problem that is not addressed by this patch.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt           |  6 +++++
 Documentation/git-receive-pack.txt |  3 +++
 builtin/receive-pack.c             | 12 +++++++++
 t/t5546-receive-limits.sh          | 55 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)
 create mode 100755 t/t5546-receive-limits.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb679..8a115b3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2517,6 +2517,12 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+receive.maxInputSize::
+	If the size of the incoming pack stream is larger than this
+	limit, then git-receive-pack will error out, instead of
+	accepting the pack file. If not set or set to 0, then the size
+	is unlimited.
+
 receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 000ee8d..0ccd5fb 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -33,6 +33,9 @@ post-update hooks found in the Documentation/howto directory.
 option, which tells it if updates to a ref should be denied if they
 are not fast-forwards.
 
+A number of other receive.* config options are available to tweak
+its behavior, see linkgit:git-config[1].
+
 OPTIONS
 -------
 <directory>::
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 011db00..f1ce05c 100644
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
 
+	if (strcmp(var, "receive.maxinputsize") == 0) {
+		max_input_size = git_config_int64(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -1648,6 +1654,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (fsck_objects)
 			argv_array_pushf(&child.args, "--strict%s",
 				fsck_msg_types.buf);
+		if (max_input_size)
+			argv_array_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+				(uintmax_t)max_input_size);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1676,6 +1685,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 				fsck_msg_types.buf);
 		if (!reject_thin)
 			argv_array_push(&child.args, "--fix-thin");
+		if (max_input_size)
+			argv_array_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+				(uintmax_t)max_input_size);
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
new file mode 100755
index 0000000..10cb0be
--- /dev/null
+++ b/t/t5546-receive-limits.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='check receive input limits'
+. ./test-lib.sh
+
+# Let's run tests with different unpack limits: 1 and 10000
+# When the limit is 1, `git receive-pack` will call `git index-pack`.
+# When the limit is 10000, `git receive-pack` will call `git unpack-objects`.
+
+test_pack_input_limit () {
+	case "$1" in
+	index) unpack_limit=1 ;;
+	unpack) unpack_limit=10000 ;;
+	esac
+
+	test_expect_success 'prepare destination repository' '
+		rm -fr dest &&
+		git --bare init dest
+	'
+
+	test_expect_success "set unpacklimit to $unpack_limit" '
+		git --git-dir=dest config receive.unpacklimit "$unpack_limit"
+	'
+
+	test_expect_success 'setting receive.maxInputSize to 512 rejects push' '
+		git --git-dir=dest config receive.maxInputSize 512 &&
+		test_must_fail git push dest HEAD
+	'
+
+	test_expect_success 'bumping limit to 4k allows push' '
+		git --git-dir=dest config receive.maxInputSize 4k &&
+		git push dest HEAD
+	'
+
+	test_expect_success 'prepare destination repository (again)' '
+		rm -fr dest &&
+		git --bare init dest
+	'
+
+	test_expect_success 'lifting the limit allows push' '
+		git --git-dir=dest config receive.maxInputSize 0 &&
+		git push dest HEAD
+	'
+}
+
+test_expect_success "create known-size (1024 bytes) commit" '
+	test-genrandom foo 1024 >one-k &&
+	git add one-k &&
+	test_commit one-k
+'
+
+test_pack_input_limit index
+test_pack_input_limit unpack
+
+test_done
-- 
2.10.0.rc1.3.g93be2b9

