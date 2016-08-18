Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DDA1F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 13:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1950036AbcHRNQb (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 09:16:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33729 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947262AbcHRNQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 09:16:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so5603237wme.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 06:16:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dN9wtUMjGXblWd+n1AaTlZRVEV/A0mR/6rKkzCb1ZII=;
        b=sUtmAx3BPd5qzg3lmwRiRmE593/SWjSqtmxA4WHUvozdJczW7XrFk01di1Q8HEzhOT
         lk2UWrnaBEb0DSpogdfXiLx0jUQ0t5fQYsMvss1evIf7aGqe1nK7jezgoBEmuKPHHsJK
         gAceYnH6faeLV5OKoeNSzUmDY6J9R5IJqpBmreivh7EGv+QcGNMPH7ORDlfF7Cm7Lnj5
         5+iK8sYZUbJ3Rn0/9iyciKAn5P6fSoKIivOApyTvavq1Ik6xbgZWDWtFO7s+2jJMGwME
         4hxcDMzSKPj9H40iJpWsIBrdOH/aOj/cdooY8ncua8U3YFIYhAimUaSglLeGLMCZRHij
         2vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dN9wtUMjGXblWd+n1AaTlZRVEV/A0mR/6rKkzCb1ZII=;
        b=ln0p0EJIMUz0NjiS55+r7fUhsNNWlEvfXhnm8wdA7aP6C/71tPZf5D6A8ImJLsLtiF
         CQfZfFmfl9/6ftK4go7gyu8eINejfxsfi56DKLwv/REN1Olpj9L51QsFaiowr7IwbKAr
         iVb/LJrEB1UuMZFbXdqivUvSk+RJFrUJmt9pw2cJbO5ye11YaKZIVgS1HghbTlNZY6od
         vrYcYLYJbny4C0eT78jydAh6KvK6jlElb4M8C2WWV8ZOozrmgxO6aYETU0rk5Q+7WfVf
         RhpfXaDNWdDfkVhvlE9GgokjF3d8tjCbqwX8o+E0d39c6cSLPh1l/DBEBiUvwxnI9Y1i
         Qq9w==
X-Gm-Message-State: AEkoouuC977vNYLj7z3R1vSSbMalsTKVIAE5E+aox+JmHzGcZaSzHdYabKZCxhAXhWZr6w==
X-Received: by 10.194.176.165 with SMTP id cj5mr2101913wjc.82.1471526187225;
        Thu, 18 Aug 2016 06:16:27 -0700 (PDT)
Received: from localhost.localdomain ([80.215.38.200])
        by smtp.gmail.com with ESMTPSA id s6sm2225856wjm.25.2016.08.18.06.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Aug 2016 06:16:26 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/3] receive-pack: allow a maximum input size to be specified
Date:	Thu, 18 Aug 2016 15:15:53 +0200
Message-Id: <20160818131553.22580-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.3.geb1f4c9.dirty
In-Reply-To: <20160818131553.22580-1-chriscool@tuxfamily.org>
References: <20160818131553.22580-1-chriscool@tuxfamily.org>
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
index 0000000..09e958f
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
+while read unpacklimit filesize filename seed
+do
+
+	test_expect_success "create known-size ($filesize bytes) commit '$filename'" '
+		test-genrandom "$seed" "$filesize" >"$filename" &&
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
+1 1024 one-k-file foo
+10 1024 other-one-k-file bar
+EOF
+
+test_done
-- 
2.10.0.rc0.3.geb1f4c9.dirty

