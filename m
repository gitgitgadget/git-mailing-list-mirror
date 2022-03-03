Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0115C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiCCAVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiCCAVo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:21:44 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEC45FF35
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:20:59 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id w4so2774254ilj.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rzAK6KV5383vhhOfHxdpZCKzzhHayX+JyBviHEbbJ8c=;
        b=Gfth5qPvMQ8o3/aEZaXGc+IsbFXjzxePEXAHP1UZYgQNU4+0cX3Ubjs1g/xLAA5JLI
         d0iDLVbDBO5+IJ+9kgvMnEJuVfZ93WCyUMeJiOvqlqvh2EgnyY2CoGIooEf2GhgVI2Vj
         lVbBKRhfNkgcMmk4EUiVkVCS6ANHSp/8hpiYQy7k+I7REshQOLTXbFMXuFihy1qigzuI
         V+IbzwkgC6hmmGHszBMT8mWN26jDjd4FjoRUVjN/hhi1qRvhK44gJSiEduv7A1nrxhwX
         CBcsrJzyorVYNOxqRRSdHi/pUgCybvywFWhm06PxZM0uQW/IgJh05vl69GkQadlyHXIc
         su4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rzAK6KV5383vhhOfHxdpZCKzzhHayX+JyBviHEbbJ8c=;
        b=2TYZQtfUmIh7pUjHO14av7UlT0rdfPqH/3Wk7C6QOBNhnOxpBquqLXutYpR1cTY08I
         KiQjNkTLaY8JL+uBQCNsaseA5y3hHpsTgXSz6Tg9ZkqLwrTyfHwdSBq6XNj8MAnJ65F1
         Uh2H+PTvkob1fCkQoX9BKmbsxFp/O7eN7BXDuO93UR06QqTEaHbOEgsIxduJlPNLzy31
         YvAGjBJxcVR+ze0+FUukAjVtLO9LEqf5/PIdPj+phVXY2j5LONn5Y+x4o7PpJkquT/rS
         COLc92fxF2vI9LT2iTU+LxwwlAOrv3y0tyNt0Po1WUIK0Rp3cM3cIl9psiz/uBFGzvSW
         xnPw==
X-Gm-Message-State: AOAM5329pCCwpbfo7DaHTEvtKaqoQzpsHwzuP3YTT1v2B9E3BqfBjWtu
        uAAzjiGWRBUNH7cnGzjBz9udYx877X9UrD9L
X-Google-Smtp-Source: ABdhPJxbRzczP9BmycJLe+33+d6jEGwjkqg1UUi1Egld1ijs5KJ6nQ903B4TSgnr1PdUAszHG9NZ3w==
X-Received: by 2002:a05:6e02:b2d:b0:2be:46c3:aa74 with SMTP id e13-20020a056e020b2d00b002be46c3aa74mr29974549ilu.217.1646266858488;
        Wed, 02 Mar 2022 16:20:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d15-20020a056e02214f00b002bc80da7cc6sm367771ilv.72.2022.03.02.16.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:20:58 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:20:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 06/17] t/helper: add 'pack-mtimes' test-tool
Message-ID: <4780c8437bd2dcdf2c038d84160a4c575e92e58d.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
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

