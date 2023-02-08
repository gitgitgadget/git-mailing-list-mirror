Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD87C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 19:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBHTkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjBHTkH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 14:40:07 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F34C0C2
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 11:40:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so4147780pjy.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 11:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qIVt/7aAxnuNiogpbg8knc7R51pWaTvAtQHAnRH6nIo=;
        b=WEpYoCU2dVNRt6m6VDeVN/v4sfZk2t0/YlmhPgddOOfbgS8Sbd98M5EGLOMlLikN2W
         H5mWxhDKO8y8G4qXmxWHv4iwlpS9HIhE4pi+itm9MFvIaAS8FxUAS73r8ltgby7b9zIc
         F3753EexMABWlKjZZgTOWxO2U5d/tFCCY7FUTsyrxrNlpeqKkAfPD7eVyoTpDckoVEAV
         dA5ASFPmFxIaO/lW8G5NyX3N0XVcUd5UMAPnYzwp38K7LHgpLyqFcFQ4MbexSgm9S9UO
         LjmUu2uHXh93HvbxeuzrtHn8z2syQHMwTL0X4GV532+m79rlupspv7on/kqhTuBhSNnm
         RPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIVt/7aAxnuNiogpbg8knc7R51pWaTvAtQHAnRH6nIo=;
        b=NSMKDbyKvkke6aAuxqgvyVhCYDwGrcCgXuh7EhF+jTHdYWMDzJxW27wQ4/sU3x5Jdb
         WyVIrbP/8DKwQ2qevp/idPY0CMcYr534hlLaHJdjJOLH87bgQBjfukLPR7dZA7IJtx6t
         I+Ywvq9DgvGwaC6DM8XcMTNAxxALi++Z36+LZ7n4KB46AYZLdlGl44BVUTk6WMrkUuC0
         Gl/o5Wp/sZ7LvXx2j3Wgbk4h/zaUw0ktcHuL7qImDS17mg56JfLF5SoXlO+rRaryF5wq
         bRz59AuMoRfiXBrMf5p8Igv0ZTiHadh6jyEPMUbd1a3LmsdTPGpYQE4z/y1I2OTimHUS
         9J6g==
X-Gm-Message-State: AO0yUKVgUPXGw8751VLvHgKePt9aFWr7EECWCFCVzn1+TFfJKnmBqMQX
        9E7UALvi0cLm+Pv1YgYDUUUjhHrU8sU=
X-Google-Smtp-Source: AK7set97qrdNUQfoqSYx06wnh5OkK8yZYSxYmRsldE0zCk+o/9YE4dtrO7YJ+YHmp2o13EEuBT8xtA==
X-Received: by 2002:a17:902:eccf:b0:195:e834:31de with SMTP id a15-20020a170902eccf00b00195e83431demr9668760plh.27.1675885205062;
        Wed, 08 Feb 2023 11:40:05 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b00189c536c72asm11372985plr.148.2023.02.08.11.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:40:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] test: make SYMLINKS prerequisite more robust
Date:   Wed, 08 Feb 2023 11:40:04 -0800
Message-ID: <xmqqwn4sq73f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see many failures around SYMLINKS prerequisite in Windows tests.
There are too many to point at, but the pattern seems to be the
same.  Here is one example:

  https://github.com/git/git/actions/runs/4127147009/jobs/7130175639#step:5:502

where "ln -s x y && test -h y" succeeds and declares SYMLINKS
lazy prerequisite is satisfied, but then it fails to run

	"ln -s unrelated DS && git update-index --add DS"

with:

	error: readlink("DS"): Function not implemented

I wonder if something like this is in order?

----- >8 -----

We should not just ensure "ln -s" and "test -h" works, but readlink
yields the expected value.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                 |  1 +
 t/helper/test-readlink.c | 19 +++++++++++++++++++
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 t/test-lib.sh            |  3 ++-
 5 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-readlink.c

diff --git a/Makefile b/Makefile
index 45bd6ac9c3..2261e56d31 100644
--- a/Makefile
+++ b/Makefile
@@ -837,6 +837,7 @@ TEST_BUILTINS_OBJS += test-reach.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-read-graph.o
 TEST_BUILTINS_OBJS += test-read-midx.o
+TEST_BUILTINS_OBJS += test-readlink.o
 TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-reftable.o
 TEST_BUILTINS_OBJS += test-regex.o
diff --git a/t/helper/test-readlink.c b/t/helper/test-readlink.c
new file mode 100644
index 0000000000..c300dc8a1a
--- /dev/null
+++ b/t/helper/test-readlink.c
@@ -0,0 +1,19 @@
+#include "test-tool.h"
+#include "strbuf.h"
+
+static const char *usage_msg = "test-tool readlink file";
+
+int cmd__readlink(int ac, const char **av)
+{
+	struct strbuf buf;
+	int ret;
+
+	if (ac != 2 || !av[1])
+		usage(usage_msg);
+
+	ret = strbuf_readlink(&buf, av[1], 0);
+	if (!ret)
+		printf("%s\n", buf.buf);
+	strbuf_release(&buf);
+	return ret;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index abe8a785eb..12054d13d4 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -64,6 +64,7 @@ static struct test_cmd cmds[] = {
 	{ "read-cache", cmd__read_cache },
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
+	{ "readlink", cmd__readlink },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
 	{ "rot13-filter", cmd__rot13_filter },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ea2672436c..efe382d48e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -57,6 +57,7 @@ int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
+int cmd__readlink(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__rot13_filter(int argc, const char **argv);
 int cmd__reftable(int argc, const char **argv);
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 01e88781dd..c8094f643b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1773,7 +1773,8 @@ test_lazy_prereq PIPE '
 
 test_lazy_prereq SYMLINKS '
 	# test whether the filesystem supports symbolic links
-	ln -s x y && test -h y
+	ln -s x y && test -h y && test-tool readlink y >/dev/null &&
+	test "$(test-tool readlink y)" = x
 '
 
 test_lazy_prereq SYMLINKS_WINDOWS '
-- 
2.39.1-418-g7876265d61



