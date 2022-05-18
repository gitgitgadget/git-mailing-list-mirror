Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC5C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiERXLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiERXLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:11:09 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A06E00D
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:08 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id m6so4030897iob.4
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SqASYvmKa442CO3IwI5FZCBpEfKsU3INt4MwBobT+bg=;
        b=uUGfMMX0qS8AMjxhNdUo4FIzKHWdS68tc2fYVXJqwRbNoKrDGjGdjfn30Qx/Nxhez5
         Up4//mqvQWPlPalYz+z9fYdxIucIsBCD5AWE+N3kJX2m8xT6OywfHvZmW08AZTMHbgnt
         x1qiSn5mSubWrfGsOMpDtPk+TPXZoUti0pwZpJBVHRh2gedLoHdTZYLlEU9GkHkIfpel
         esmGriwl4vIECfzuTuk65UsNMfx0LBcT+xGOzXv+J8u9e/ihQ5t61rt/OtdK1LWhrFlx
         R6NWZeVAI4w5KVyk2HwzYeMi1WnzAeyPyJvD2ExS4ZqNaUNXbstAfUyakGV/HJjSAS4e
         0U8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SqASYvmKa442CO3IwI5FZCBpEfKsU3INt4MwBobT+bg=;
        b=insbY7Y50FRDtfMZ9NlziEYQC2rQ6LAuOsMLoo6jNXjFNOdA4pi5KPapE3JBnQJM2O
         mM37KNjg3xZibhzkLLvzWsVD4pmtHHdOLWANPbCv7lzlEYNX6ffnImzji1S2qAOhy2da
         3PQK5EvJxm5V95oJbOg0tORw62Cq3G6qfoYyOV+jrh0nkiQfHYE7nTlhAX2HsD2P6xWe
         tjhKBUqXwkGLbNfdhKnYRT6rQPY3WRe2b/r40tHeKxBsVsx1RubbJdZgwT44+lOgVGuf
         be+Ne2//LjK611QivD/5qVTNpqoYUXgiKe3tqrZEYjwUDgsOr7rvXJ836phGsyB5EFZX
         Fb7g==
X-Gm-Message-State: AOAM5335S2ast/F5ERwhK27v/b8CRzKjQbwudvEMFFrnElCQldQVKIlT
        kwmZI4t3VuINisdEcJYqlS6yKf1eKFJpfatB
X-Google-Smtp-Source: ABdhPJwndhqIXmtsQ9YAHRrf65f7Eyer0dLQhy8qj9WrCDHRx8k59U78TmC/YWhovTs/ZcMIk6l+7Q==
X-Received: by 2002:a05:6638:240d:b0:32e:80af:6a25 with SMTP id z13-20020a056638240d00b0032e80af6a25mr1101925jat.233.1652915467857;
        Wed, 18 May 2022 16:11:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 10-20020a92c64a000000b002cdfeead6basm871460ill.63.2022.05.18.16.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:11:07 -0700 (PDT)
Date:   Wed, 18 May 2022 19:11:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 06/17] t/helper: add 'pack-mtimes' test-tool
Message-ID: <5f9a9a5b7b49a3f6e246ea8cb51aa60d204e0f49.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
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
index a299580b7c..0b6eab0453 100644
--- a/Makefile
+++ b/Makefile
@@ -738,6 +738,7 @@ TEST_BUILTINS_OBJS += test-oid-array.o
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
index 0424f7adf5..d2eacd302d 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -48,6 +48,7 @@ static struct test_cmd cmds[] = {
 	{ "oidmap", cmd__oidmap },
 	{ "oidtree", cmd__oidtree },
 	{ "online-cpus", cmd__online_cpus },
+	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "partial-clone", cmd__partial_clone },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index c876e8246f..960cc27ef7 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -38,6 +38,7 @@ int cmd__mktemp(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
 int cmd__oidtree(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
+int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__partial_clone(int argc, const char **argv);
-- 
2.36.1.94.gb0d54bedca

