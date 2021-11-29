Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E97AC43217
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhK2W3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhK2W24 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:56 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B17C09676C
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:19 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id x10so23586903ioj.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SFn3xr3SlTKELMLo6Xxs6aGRma5/b1r9A0LHLj8ntcs=;
        b=WtFqUWQ3/yPImamBnHYxXvvD2E7QRqSfU5dG8tMW33bKmgRDuQFEyEesl+e9MthSwJ
         RLSqrSllNtEjmtvHZLIGf7GvY9QEv8hRz+mqVg1CDN+UiiNPpSmSO7WDwPQU/JyT5lwx
         bAkZcylle3geKZ6836xMBuA0My+JZ6vuz4hACHLC6Wf3XfTv9xDa4nLWlDIS2n+LW/zV
         MjwmPumYinxCg8O0eLOeUkj2tVsEr+dm+Xy3ZEoAEqWQCewIMn6lqUv4Ddnlr78oN5Et
         GOmT6MWTTvRX0XuA5ylelT29KvZyS3K4Q70FJzrWlIlABL8aAlKp9JiKyjRtya6iEzbd
         JkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SFn3xr3SlTKELMLo6Xxs6aGRma5/b1r9A0LHLj8ntcs=;
        b=AmNBvi4McFSL1p4fHSa/rwKw7jICappQejhBySACe7/CLau3nazr+U9RSUlFyT6M/d
         qzVRmwTCMrDmHeBkXpvcsgJHiSOlcyZ1lxxEG7du1bbOcpVmbeRfjUTC/IsG+f8DxUZ5
         iqY6NBwGFGRk9M72efOKdoiwD2VoyIT+TmWr0AkC5MqJ363a76AinVMKDYe1YKywXmE/
         HURtboybh3K7/Cb/3P6NwRA0swEknU42l1YeyM7T3syJHN4EjUCc379DQcba7/rBUmzO
         ipWQi7tgbzUtMoLvSH2irZIhsKdTrqzgJsL8G5soMicWjuW+F3Ig7EQAqeFfhz6aCBlv
         S/Yw==
X-Gm-Message-State: AOAM533JZDSXqIE1nzcKvrlgqzoJXLd18bJWQOGiJV20u7Wfoqd6qQhH
        ZFgyEYtUu7I1kKLvalXSU561x8CyHedkl9o9
X-Google-Smtp-Source: ABdhPJzsH5vZKVijMOd1kqJ62E4GPvvPITvDvahDOwHYMvRG4US0aoGBA3RrTXDivcTV0LpSJ07Wvg==
X-Received: by 2002:a6b:2b12:: with SMTP id r18mr1723264ior.66.1638224718775;
        Mon, 29 Nov 2021 14:25:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y21sm9055532ioj.41.2021.11.29.14.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:18 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 06/17] t/helper: add 'pack-mtimes' test-tool
Message-ID: <e0a7b3b310c69350d8e2c0561e0991bb7045a66d.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch, we will implement and test support for writing a
cruft pack via a special mode of `git pack-objects`. To make sure that
objects are written with the correct timestamps, and a new test-tool
that can dump the object names and corresponding timestamps from a given
`.mtimes` file.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile                    |  1 +
 t/helper/test-pack-mtimes.c | 53 +++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 4 files changed, 56 insertions(+)
 create mode 100644 t/helper/test-pack-mtimes.c

diff --git a/Makefile b/Makefile
index efd5e00717..a7382cbfc1 100644
--- a/Makefile
+++ b/Makefile
@@ -721,6 +721,7 @@ TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-oidtree.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
+TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-partial-clone.o
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
new file mode 100644
index 0000000000..b143f62520
--- /dev/null
+++ b/t/helper/test-pack-mtimes.c
@@ -0,0 +1,53 @@
+#include "git-compat-util.h"
+#include "test-tool.h"
+#include "strbuf.h"
+#include "object-store.h"
+#include "packfile.h"
+#include "pack-mtimes.h"
+
+static int dump_mtimes(struct packed_git *p)
+{
+	uint32_t i;
+	if (load_pack_mtimes(p) < 0)
+		die("could not load pack .mtimes");
+
+	for (i = 0; i < p->num_objects; i++) {
+		struct object_id oid;
+		if (nth_packed_object_id(&oid, p, i) < 0)
+			die("could not load object id at position %"PRIu32, i);
+
+		printf("%s %"PRIu32"\n",
+		       oid_to_hex(&oid), nth_packed_mtime(p, i));
+	}
+
+	return 0;
+}
+
+static const char *pack_mtimes_usage = "\n"
+"  test-tool pack-mtimes <pack-name.mtimes>";
+
+int cmd__pack_mtimes(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct packed_git *p;
+
+	setup_git_directory();
+
+	if (argc != 2)
+		usage(pack_mtimes_usage);
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		strbuf_addstr(&buf, basename(p->pack_name));
+		strbuf_strip_suffix(&buf, ".pack");
+		strbuf_addstr(&buf, ".mtimes");
+
+		if (!strcmp(buf.buf, argv[1]))
+			break;
+
+		strbuf_reset(&buf);
+	}
+
+	strbuf_release(&buf);
+
+	return p ? dump_mtimes(p) : 1;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 3ce5585e53..1bb1c4b562 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -46,6 +46,7 @@ static struct test_cmd cmds[] = {
 	{ "oidmap", cmd__oidmap },
 	{ "oidtree", cmd__oidtree },
 	{ "online-cpus", cmd__online_cpus },
+	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "partial-clone", cmd__partial_clone },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 9f0f522850..07a2d3f94e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,6 +35,7 @@ int cmd__mktemp(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
 int cmd__oidtree(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
+int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__partial_clone(int argc, const char **argv);
-- 
2.34.1.25.gb3157a20e6

