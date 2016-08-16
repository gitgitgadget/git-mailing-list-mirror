Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 149991FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 08:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbcHPIR4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 04:17:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34871 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbcHPIRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 04:17:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so15054317wmg.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 01:17:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pXHll8dk+idQsc4MjA8RUCiPqwT6axAwpituLS7zKOA=;
        b=Z72jglVLquCSFqC0DXxQlE2YBtoqgMmYywKsS9RL90dl7RiE6uD5x65wZcli2QqVyQ
         5vJs/e9ISy/YWoSzV+6D4FFCoxEvfXYG8nwC0tNas6oySKFyPNtRTv9wGk3NhfJBivFJ
         UWQK3XATF4rnhyIIeyl/0xabAxFOxINCZY2TW6+Q4vtoP1h2y5Sf/ZQQCo5Zxi1GqM3x
         sQs6HSPED9ZcwjVOMjxxkQYcSa4CToxHKOmGGfo9hbJfs2Y/q6/xSXaE3bQnhuntiihw
         LH48qlLtm6eJzN7InWnI4mOj/WlTKCUVrHG7f+d0jKoQXovpZuN8pqpMnYqU81RFLpYP
         lZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pXHll8dk+idQsc4MjA8RUCiPqwT6axAwpituLS7zKOA=;
        b=l6CfwM1xBC3U57ZygO7t8ndYlZRb+06/AjUinihxSqDODwhffmqwBUQSoSCo15vWqS
         yKYlIuruFzlOmrkSiiuhmpnSdowvNbbtsr0PdWdMa9p1IrAVJUsGs//3elZOggsqdPM8
         2gNOhTIK1p08IHBxUYyZylAYqZPwUlAx391x9c6OHMJ8Qx9JCi2r1D4xBeVDLf57TwHL
         RvZa63/NHrMu6Pk0TV1o4f5d7eCuSfPnNuOhArYLS2W4/9bfmGHjM+X13Kzue3a5MoYE
         6Cx4NRz9lqzu1fxmXBRz6XE7qcFJhGMj5jY+dgUVaLQmG4iwNw0c8azis10XJWBWP88Z
         hiNA==
X-Gm-Message-State: AEkoousWZxA0J094nJeM6sEAqftZggl/b+2mug9Az01DMCEc8FTWtfWKPTJ/OtERtf+Fug==
X-Received: by 10.28.48.71 with SMTP id w68mr19537600wmw.4.1471335471125;
        Tue, 16 Aug 2016 01:17:51 -0700 (PDT)
Received: from localhost.localdomain ([80.215.5.33])
        by smtp.gmail.com with ESMTPSA id 142sm20461121wmh.12.2016.08.16.01.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Aug 2016 01:17:50 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] receive-pack: allow a maximum input size to be specified
Date:	Tue, 16 Aug 2016 10:17:01 +0200
Message-Id: <20160816081701.29949-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.3.g8535b4c
In-Reply-To: <20160816081701.29949-1-chriscool@tuxfamily.org>
References: <20160816081701.29949-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff King <peff@peff.net>

Receive-pack feeds its input to either index-pack or
unpack-objects, which will happily accept as many bytes as
a sender is willing to provide. Let's allow an arbitrary
cutoff point where we will stop writing bytes to disk.

Cleaning up what has already been written to disk is a
related problem that is not addressed by this patch.

The problem is that git-gc can clean up tmp_pack_* files
after their grace time expired, but that may not be
enough if someone tries to "git push" in a loop.

A simple fix is to call register_tempfile() in
open_pack_file(), and just have index-pack clean up the
file on its way out.

But there are harder cases. For instance, if somebody
pushes a 500MB file, and there is a pre-receive hook that
says "too big; I won't accept this". And then they push in
a loop, the incoming pack has already been accepted into
the repository by the time the pre-receive hook runs.
It's not possible to just delete it, because we don't know
if other simultaneous processes have started to depend on
the objects.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt           |  5 +++++
 Documentation/git-receive-pack.txt |  3 +++
 builtin/receive-pack.c             | 12 +++++++++++
 t/t5546-push-limits.sh             | 42 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100755 t/t5546-push-limits.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb679..f5b6061 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2517,6 +2517,11 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+receive.maxsize::
+	If the size of a pack file is larger than this limit, then
+	git-receive-pack will error out, instead of accepting the pack
+	file. If not set or set to 0, then the size is unlimited.
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
index 92e1213..8c2943d 100644
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
+		max_input_size = git_config_int64(var, value);
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
+			argv_array_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+				(uintmax_t)max_input_size);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1678,6 +1687,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 				fsck_msg_types.buf);
 		if (!reject_thin)
 			argv_array_push(&child.args, "--fix-thin");
+		if (max_input_size)
+			argv_array_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+				(uintmax_t)max_input_size);
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
diff --git a/t/t5546-push-limits.sh b/t/t5546-push-limits.sh
new file mode 100755
index 0000000..b38d508
--- /dev/null
+++ b/t/t5546-push-limits.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='check input limits for pushing'
+. ./test-lib.sh
+
+test_expect_success 'create remote repository' '
+	git init --bare dest
+'
+
+# Let's run tests with different unpack limits: 1 and 10
+# When the limit is 1, `git receive-pack` will call `git index-pack`.
+# When the limit is 10, `git receive-pack` will call `git unpack-objects`.
+
+while read unpacklimit filesize filename
+do
+
+	test_expect_success "create known-size ($filesize bytes) commit '$filename'" '
+		test-genrandom foo "$filesize" >"$filename" &&
+		git add "$filename" &&
+		test_commit "$filename"
+	'
+
+	test_expect_success "set unpacklimit to $unpacklimit" '
+		git --git-dir=dest config receive.unpacklimit "$unpacklimit"
+	'
+
+	test_expect_success 'setting receive.maxsize to 512 rejects push' '
+		git --git-dir=dest config receive.maxsize 512 &&
+		test_must_fail git push dest HEAD
+	'
+
+	test_expect_success 'bumping limit to 4k allows push' '
+		git --git-dir=dest config receive.maxsize 4k &&
+		git push dest HEAD
+	'
+
+done <<\EOF
+1 1024 one-k-file
+10 2048 two-k-file
+EOF
+
+test_done
-- 
2.10.0.rc0.3.g8535b4c

