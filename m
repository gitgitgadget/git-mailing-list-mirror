Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9FEC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiCBA66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbiCBA64 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:58:56 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4EA5DA78
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:14 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q8so165664iod.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rzAK6KV5383vhhOfHxdpZCKzzhHayX+JyBviHEbbJ8c=;
        b=4jfaKPjF5SRaEu3ahAQ8qEqA9V13VqdZ6q187NCWLBAK9DE8JRnk+10aC3wAxNq5WR
         Bk8bHIehTwjy8Xjwb0w8IBNBMhfutoWoDCzaJNoFU6nrwjacyiO/2A7ZmQfhtjCJoWUP
         dYj3Nx28tpg5vkY0eT1Kp4n/j8eQZ6j5blZBZu/UxrXSNY8qt8UeGDuewku5f8iH3hor
         AMw4ZAeVWRige6uV0kTVYMn6fE6QSaWoqqCPC21Uf+cvetJnBbnBPR8cq/z5HZA6nxAu
         POX1E2PX9bYaSqQPVeKBjyXGERFmR4sm26j1whbTXg6qMv1RIVXkkpv6k8obFV1TljKy
         Va1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rzAK6KV5383vhhOfHxdpZCKzzhHayX+JyBviHEbbJ8c=;
        b=dlgfy/Rn4OsK2it0fWTvtjfKV9JhlOBB9GnMngI8so4/nBgQTtyOUtujDwov4VusJK
         BcIvTlC3R7Odg2x/PPHWCqGHiA97K+w7aNG0CZ+M+f9SMjpu+MBydfW8eVCDCDH8eCl3
         pRlHvsnzv+2P2A0bu4zpoU1duefLvbST/fj4V18GgqFiDbIHLeGaTNzXGakKPG0pLRLu
         bE/iQL0Pp7O2vjtFsivd8aUA6Uy7/ss9OdnV5PN3VNGtvM95I5LOD5/j3sIfmSHJonIB
         ZOJ+XXZgGxpcmLxSU80x4IiHfGdFLz+zzPsQ7jA5R9Tsf6BsZv6ZOepcFNhC6m3mlZkx
         UzvQ==
X-Gm-Message-State: AOAM5304Z5uevB2/W+oCPaC64mDcjVlD+R316ENJ94nyw2S9FSF1luHT
        Hd5oOUbWojJKWsB0BhKkALag+FiuP7xMhE6h
X-Google-Smtp-Source: ABdhPJxHlb+pg2mldkkshSKNKUgVpUODGCMWMjHhoJATDI+qvwSIIeVzxgBmlsJ967a1hWc1xOQmZg==
X-Received: by 2002:a05:6638:69d:b0:314:ac09:428d with SMTP id i29-20020a056638069d00b00314ac09428dmr12589000jab.0.1646182693685;
        Tue, 01 Mar 2022 16:58:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m1-20020a056e021c2100b002c2ec1c8012sm4355762ilh.53.2022.03.01.16.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:13 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 06/17] t/helper: add 'pack-mtimes' test-tool
Message-ID: <78313bc4412fd480c91cc36d6032914ee79368c3.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
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
 t/helper/test-pack-mtimes.c | 56 +++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 4 files changed, 59 insertions(+)
 create mode 100644 t/helper/test-pack-mtimes.c

diff --git a/Makefile b/Makefile
index 1b186f4fd7..5c0ed1ade7 100644
--- a/Makefile
+++ b/Makefile
@@ -727,6 +727,7 @@ TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-oidtree.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
+TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-partial-clone.o
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
new file mode 100644
index 0000000000..f7b79daf4c
--- /dev/null
+++ b/t/helper/test-pack-mtimes.c
@@ -0,0 +1,56 @@
+#include "git-compat-util.h"
+#include "test-tool.h"
+#include "strbuf.h"
+#include "object-store.h"
+#include "packfile.h"
+#include "pack-mtimes.h"
+
+static void dump_mtimes(struct packed_git *p)
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
+	if (!p)
+		die("could not find pack '%s'", argv[1]);
+
+	dump_mtimes(p);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index e6ec69cf32..7d472b31fd 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -47,6 +47,7 @@ static struct test_cmd cmds[] = {
 	{ "oidmap", cmd__oidmap },
 	{ "oidtree", cmd__oidtree },
 	{ "online-cpus", cmd__online_cpus },
+	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "partial-clone", cmd__partial_clone },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 20756eefdd..0ac4f32955 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -37,6 +37,7 @@ int cmd__mktemp(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
 int cmd__oidtree(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
+int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__partial_clone(int argc, const char **argv);
-- 
2.35.1.73.gccc5557600

