Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE2420D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbdFTH4e (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35003 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbdFTH4a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id d64so21286159wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HlI5Ftzz04Cvvse5dzBOG5NBOZAofXYI3+ppKgM9waQ=;
        b=aqdYaP+EDSPILhuafYje8dowa/Ip7lfFl08yuwyyW+pSZUSb6VXhFvjj5AvPaEcczS
         MFOPMfOoK81+INd1ztxnORB5qt6JjUJ8PM5VNUW8fKrRlarZImuphEivyGNPTI2hTEDA
         +IfKkutL3Sn6qC4lYUEnX0xqOky5fnHXlR6h+yFJdKsHEeyz71Xo7N/u5OKy09pZRC9v
         5Y3UPoEkdHY0sba/f9JcWnUJqUbYZaO2cHFcSLMhO+oOUyH2zSNfeiWa4o5Tn95OsLsm
         GcteDyOwbpoLDUJ/Lp4JmfjJ/QkG1b82HSo6cF+/lC9gJzeUbr6OpSyukmUvC/TBjQyJ
         IMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HlI5Ftzz04Cvvse5dzBOG5NBOZAofXYI3+ppKgM9waQ=;
        b=s1tMC/13wE0+qsZJWVo9CW1P8YGymqeU+gVD3NjOf0EvZ+552wyWsxRq4HJvrClKE9
         w6UeS/74r02VAVjaG7qvj11/hlH5yEKIOSqItrEHOjI+J2sC0No2cADm6TU/LI3pBog7
         NkJy0koLGNRjV9wo2BrsEEIkUmKUUMHxlq05UyNxlvEoHgIiRpYyAcMoxrix54MaoUA9
         GeEAAl8uppWRkbyM1qMtXjRcCMbQDIB3n+NefQRp8gKQjK/uApZ2LQVsFmO7DDh3TTFr
         e9pS+xzNTsJOJ1Qa/L8NnyeYY6/JTSYak2hVnvyR4teZIFKmqFN24+o2+sW6kmcAy9lp
         AvBw==
X-Gm-Message-State: AKS2vOykMZbChEYHB0exCQ3NYYc0nfs+pEs7GDo0uOydhYtZ2ep7FvJj
        VR/Mbayw1eqeq3x+
X-Received: by 10.28.74.218 with SMTP id n87mr1706134wmi.16.1497945388589;
        Tue, 20 Jun 2017 00:56:28 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:28 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: [RFC/PATCH v4 30/49] odb-helper: add read_object_process()
Date:   Tue, 20 Jun 2017 09:55:04 +0200
Message-Id: <20170620075523.26961-31-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 odb-helper.h |   5 ++
 sha1_file.c  |  33 +++++++++-
 3 files changed, 227 insertions(+), 13 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index 5fb56c6135..20e83cb55a 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -4,6 +4,187 @@
 #include "odb-helper.h"
 #include "run-command.h"
 #include "sha1-lookup.h"
+#include "sub-process.h"
+#include "pkt-line.h"
+#include "sigchain.h"
+
+struct read_object_process {
+	struct subprocess_entry subprocess;
+	unsigned int supported_capabilities;
+};
+
+static int subprocess_map_initialized;
+static struct hashmap subprocess_map;
+
+static void parse_capabilities(char *cap_buf,
+			       unsigned int *supported_capabilities,
+			       const char *process_name)
+{
+	struct string_list cap_list = STRING_LIST_INIT_NODUP;
+
+	string_list_split_in_place(&cap_list, cap_buf, '=', 1);
+
+	if (cap_list.nr == 2 && !strcmp(cap_list.items[0].string, "capability")) {
+		const char *cap_name = cap_list.items[1].string;
+
+		if (!strcmp(cap_name, "get")) {
+			*supported_capabilities |= ODB_HELPER_CAP_GET;
+		} else if (!strcmp(cap_name, "put")) {
+			*supported_capabilities |= ODB_HELPER_CAP_PUT;
+		} else if (!strcmp(cap_name, "have")) {
+			*supported_capabilities |= ODB_HELPER_CAP_HAVE;
+		} else {
+			warning("external process '%s' requested unsupported read-object capability '%s'",
+				process_name, cap_name);
+		}
+	}
+
+	string_list_clear(&cap_list, 0);
+}
+
+static int start_read_object_fn(struct subprocess_entry *subprocess)
+{
+	int err;
+	struct read_object_process *entry = (struct read_object_process *)subprocess;
+	struct child_process *process = &subprocess->process;
+	char *cap_buf;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = packet_writel(process->in, "git-read-object-client", "version=1", NULL);
+	if (err)
+		goto done;
+
+	err = strcmp(packet_read_line(process->out, NULL), "git-read-object-server");
+	if (err) {
+		error("external process '%s' does not support read-object protocol version 1", subprocess->cmd);
+		goto done;
+	}
+	err = strcmp(packet_read_line(process->out, NULL), "version=1");
+	if (err)
+		goto done;
+	err = packet_read_line(process->out, NULL) != NULL;
+	if (err)
+		goto done;
+
+	err = packet_writel(process->in, "capability=get", NULL);
+	if (err)
+		goto done;
+
+	while ((cap_buf = packet_read_line(process->out, NULL)))
+		parse_capabilities(cap_buf, &entry->supported_capabilities, subprocess->cmd);
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	return err;
+}
+
+static struct read_object_process *launch_read_object_process(const char *cmd)
+{
+	struct read_object_process *entry;
+
+	if (!subprocess_map_initialized) {
+		subprocess_map_initialized = 1;
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
+		entry = NULL;
+	} else {
+		entry = (struct read_object_process *)subprocess_find_entry(&subprocess_map, cmd);
+	}
+
+	fflush(NULL);
+
+	if (!entry) {
+		entry = xmalloc(sizeof(*entry));
+		entry->supported_capabilities = 0;
+
+		if (subprocess_start(&subprocess_map, &entry->subprocess, cmd, start_read_object_fn)) {
+			free(entry);
+			return 0;
+		}
+	}
+
+	return entry;
+}
+
+static int check_object_process_error(int err,
+				      const char *status,
+				      struct read_object_process *entry,
+				      const char *cmd,
+				      unsigned int capability)
+{
+	if (!err)
+		return;
+
+	if (!strcmp(status, "error")) {
+		/* The process signaled a problem with the file. */
+	} else if (!strcmp(status, "notfound")) {
+		/* Object was not found */
+		err = -1;
+	} else if (!strcmp(status, "abort")) {
+		/*
+		 * The process signaled a permanent problem. Don't try to read
+		 * objects with the same command for the lifetime of the current
+		 * Git process.
+		 */
+		if (capability)
+			entry->supported_capabilities &= ~capability;
+	} else {
+		/*
+		 * Something went wrong with the read-object process.
+		 * Force shutdown and restart if needed.
+		 */
+		error("external object process '%s' failed", cmd);
+		subprocess_stop(&subprocess_map, &entry->subprocess);
+		free(entry);
+	}
+
+	return err;
+}
+
+static int read_object_process(const unsigned char *sha1)
+{
+	int err;
+	struct read_object_process *entry;
+	struct child_process *process;
+	struct strbuf status = STRBUF_INIT;
+	const char *cmd = "read-object";
+	uint64_t start;
+
+	start = getnanotime();
+
+	entry = launch_read_object_process(cmd);
+	process = &entry->subprocess.process;
+
+	if (!(ODB_HELPER_CAP_GET & entry->supported_capabilities))
+		return -1;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = packet_write_fmt_gently(process->in, "command=get\n");
+	if (err)
+		goto done;
+
+	err = packet_write_fmt_gently(process->in, "sha1=%s\n", sha1_to_hex(sha1));
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;
+
+	subprocess_read_status(process->out, &status);
+	err = strcmp(status.buf, "success");
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	err = check_object_process_error(err, status.buf, entry, cmd, ODB_HELPER_CAP_GET);
+
+	trace_performance_since(start, "read_object_process");
+
+	return err;
+}
 
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
@@ -350,20 +531,21 @@ static int odb_helper_fetch_git_object(struct odb_helper *o,
 int odb_helper_fault_in_object(struct odb_helper *o,
 			       const unsigned char *sha1)
 {
-	struct odb_helper_object *obj;
-	struct odb_helper_cmd cmd;
+	struct odb_helper_object *obj = odb_helper_lookup(o, sha1);
 
-	obj = odb_helper_lookup(o, sha1);
 	if (!obj)
 		return -1;
 
-	if (odb_helper_start(o, &cmd, 0, "get %s", sha1_to_hex(sha1)) < 0)
-		return -1;
-
-	if (odb_helper_finish(o, &cmd))
-		return -1;
-
-	return 0;
+	if (o->script_mode) {
+		struct odb_helper_cmd cmd;
+		if (odb_helper_start(o, &cmd, 0, "get %s", sha1_to_hex(sha1)) < 0)
+			return -1;
+		if (odb_helper_finish(o, &cmd))
+			return -1;
+		return 0;
+	} else {
+		return read_object_process(sha1);
+	}
 }
 
 int odb_helper_fetch_object(struct odb_helper *o,
diff --git a/odb-helper.h b/odb-helper.h
index 44c98bbf56..b23544aa4a 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -9,11 +9,16 @@ enum odb_helper_fetch_kind {
 	ODB_FETCH_KIND_FAULT_IN
 };
 
+#define ODB_HELPER_CAP_GET    (1u<<0)
+#define ODB_HELPER_CAP_PUT    (1u<<1)
+#define ODB_HELPER_CAP_HAVE   (1u<<2)
+
 struct odb_helper {
 	const char *name;
 	const char *cmd;
 	enum odb_helper_fetch_kind fetch_kind;
 	int script_mode;
+	unsigned int supported_capabilities;
 
 	struct odb_helper_object {
 		unsigned char sha1[20];
diff --git a/sha1_file.c b/sha1_file.c
index 9d8e37432e..38a0404506 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -698,7 +698,17 @@ int check_and_freshen_file(const char *fn, int freshen)
 
 static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 {
-	return check_and_freshen_file(sha1_file_name(sha1), freshen);
+	int ret;
+	int tried_hook = 0;
+
+retry:
+	ret = check_and_freshen_file(sha1_file_name(sha1), freshen);
+	if (!ret && !tried_hook) {
+		tried_hook = 1;
+		if (!external_odb_fault_in_object(sha1))
+			goto retry;
+	}
+	return ret;
 }
 
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
@@ -3000,7 +3010,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	int rtype;
 	enum object_type real_type;
 	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
+	int tried_hook = 0;
 
+retry:
 	co = find_cached_object(real);
 	if (co) {
 		if (oi->typep)
@@ -3026,8 +3038,14 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
-		if (!find_pack_entry(real, &e))
+		if (!find_pack_entry(real, &e)) {
+			if (!tried_hook) {
+				tried_hook = 1;
+				if (!external_odb_fault_in_object(sha1))
+					goto retry;
+			}
 			return -1;
+		}
 	}
 
 	/*
@@ -3121,7 +3139,9 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 	unsigned long mapsize;
 	void *map, *buf;
 	struct cached_object *co;
+	int tried_hook = 0;
 
+retry:
 	co = find_cached_object(sha1);
 	if (co) {
 		*type = co->type;
@@ -3139,7 +3159,14 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 		return buf;
 	}
 	reprepare_packed_git();
-	return read_packed_sha1(sha1, type, size);
+	buf = read_packed_sha1(sha1, type, size);
+	if (!buf && !tried_hook) {
+		tried_hook = 1;
+		if (!external_odb_fault_in_object(sha1))
+			goto retry;
+	}
+
+	return buf;
 }
 
 /*
-- 
2.13.1.565.gbfcd7a9048

