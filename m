Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39D32047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbdHCJUC (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34080 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdHCJTz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id x64so1444239wmg.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ya3EGjSiB/TMhQ2zvKjrgGeX/zcWry6Z5MhOGuhphGg=;
        b=bCpEZP8gJEB2pgAFuBM1e6LAMkBrjdJuzi/s9v3jakJM+4xfwUI8IiiN2AOEN5lS8e
         PVIhneJTudR1VVCmJgOSMpkC0KVsPPBV40HVH99TheWMCBrg6rQh437METyrsHc0O1XA
         t0j0PmBn8LtsG4R2OZN84Cn7sd4sUziSqlMbNx1VEw1h4rsJyqyvBLNVr+/4c8drrr2J
         sgJqw0RrYnjADDK9tma+VzU8m2axVcTHkNymcJoHRDghDwQDXW/ugz2KyonBmlfL8My7
         1w7DYlj4/bq1ZOc+hTP4c4TPq6SMP/01EaKz6jvI8cdD9ZI5+0zDmL/FuwpfU7JKuw1w
         MI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ya3EGjSiB/TMhQ2zvKjrgGeX/zcWry6Z5MhOGuhphGg=;
        b=hYrWtzOJB3fV0WRWzED9TwMP3XM2RTxBtsTA64xhnHW8hjONc54u5RHkWWglbrS//0
         2IoCAgTBIkWgmx6Vk4YDvWefnQfDI1hYlmhdrDI5ZGqCTVPg/DiCNSZ/tKuh2bZTBcfO
         YtLGZF5zL0fjS6sB6DBhRrcyYt2V07RPbGqyIX83RuHSVridePCowO1xd4bWOEqxD6tg
         WNzTGE1tFRBJZJq3ZRe1TYUsDX6VdvS760LseUhkaWEuvu2FXi767hnZQ5CtJyVb9S4O
         KA1kOA6Fcpd+2RwTfgTigMH/BlNx52Ue1ZFmOVoqTmC2Vt2gttvJkORv2BkLoh+4P1+H
         RExw==
X-Gm-Message-State: AIVw110aSfbdXjlO/U6JM2DVlFFCgS11ICEsE1BdTJDuA8jk/vMhh0vK
        IDyEi22FkiS87bOZ
X-Received: by 10.28.238.85 with SMTP id m82mr714973wmh.107.1501751993844;
        Thu, 03 Aug 2017 02:19:53 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 13/40] external odb: add 'put_raw_obj' support
Date:   Thu,  3 Aug 2017 11:18:59 +0200
Message-Id: <20170803091926.1755-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for a 'put_raw_obj' capability/instruction to send new
objects to an external odb. Objects will be sent as they are (in
their 'raw' format). They will not be converted to Git objects.

For now any new Git object (blob, tree, commit, ...) would be sent
if 'put_raw_obj' is supported by an odb helper. This is not a great
default, but let's leave it to following commits to tweak that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 15 +++++++++++++++
 external-odb.h |  2 ++
 odb-helper.c   | 43 ++++++++++++++++++++++++++++++++++++++-----
 odb-helper.h   |  3 +++
 sha1_file.c    |  2 ++
 5 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 0f0de170b8..82fac702e8 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -118,3 +118,18 @@ int external_odb_get_object(const unsigned char *sha1)
 
 	return -1;
 }
+
+int external_odb_put_object(const void *buf, size_t len,
+			    const char *type, unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		int r = odb_helper_put_object(o, buf, len, type, sha1);
+		if (r <= 0)
+			return r;
+	}
+	return 1;
+}
diff --git a/external-odb.h b/external-odb.h
index 9989490c9e..3e0e6d0165 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -4,5 +4,7 @@
 const char *external_odb_root(void);
 int external_odb_has_object(const unsigned char *sha1);
 int external_odb_get_object(const unsigned char *sha1);
+int external_odb_put_object(const void *buf, size_t len,
+			    const char *type, unsigned char *sha1);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index c6e16b938c..1be4461158 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -71,9 +71,10 @@ static void prepare_helper_command(struct argv_array *argv, const char *cmd,
 	strbuf_release(&buf);
 }
 
-__attribute__((format (printf,3,4)))
+__attribute__((format (printf,4,5)))
 static int odb_helper_start(struct odb_helper *o,
 			    struct odb_helper_cmd *cmd,
+			    int use_stdin,
 			    const char *fmt, ...)
 {
 	va_list ap;
@@ -90,7 +91,10 @@ static int odb_helper_start(struct odb_helper *o,
 
 	cmd->child.argv = cmd->argv.argv;
 	cmd->child.use_shell = 1;
-	cmd->child.no_stdin = 1;
+	if (use_stdin)
+		cmd->child.in = -1;
+	else
+		cmd->child.no_stdin = 1;
 	cmd->child.out = -1;
 
 	if (start_command(&cmd->child) < 0) {
@@ -119,7 +123,7 @@ int odb_helper_init(struct odb_helper *o)
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
-	if (odb_helper_start(o, &cmd, "init") < 0)
+	if (odb_helper_start(o, &cmd, 0, "init") < 0)
 		return -1;
 
 	fh = xfdopen(cmd.child.out, "r");
@@ -179,7 +183,7 @@ static void odb_helper_load_have(struct odb_helper *o)
 		return;
 	o->have_valid = 1;
 
-	if (odb_helper_start(o, &cmd, "have") < 0)
+	if (odb_helper_start(o, &cmd, 0, "have") < 0)
 		return;
 
 	fh = xfdopen(cmd.child.out, "r");
@@ -228,7 +232,7 @@ int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 	if (!obj)
 		return -1;
 
-	if (odb_helper_start(o, &cmd, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
+	if (odb_helper_start(o, &cmd, 0, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
 		return -1;
 
 	memset(&stream, 0, sizeof(stream));
@@ -301,3 +305,32 @@ int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 
 	return 0;
 }
+
+int odb_helper_put_object(struct odb_helper *o,
+			  const void *buf, size_t len,
+			  const char *type, unsigned char *sha1)
+{
+	struct odb_helper_cmd cmd;
+
+	if (odb_helper_start(o, &cmd, 1, "put_raw_obj %s %"PRIuMAX" %s",
+			     sha1_to_hex(sha1), (uintmax_t)len, type) < 0)
+		return -1;
+
+	do {
+		int w = xwrite(cmd.child.in, buf, len);
+		if (w < 0) {
+			error("unable to write to odb helper '%s': %s",
+			      o->name, strerror(errno));
+			close(cmd.child.in);
+			close(cmd.child.out);
+			odb_helper_finish(o, &cmd);
+			return -1;
+		}
+		len -= w;
+	} while (len > 0);
+
+	close(cmd.child.in);
+	close(cmd.child.out);
+	odb_helper_finish(o, &cmd);
+	return 0;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 8e0b9dd9cb..318e0d48dc 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -33,5 +33,8 @@ int odb_helper_init(struct odb_helper *o);
 int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1);
 int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 			  int fd);
+int odb_helper_put_object(struct odb_helper *o,
+			  const void *buf, size_t len,
+			  const char *type, unsigned char *sha1);
 
 #endif /* ODB_HELPER_H */
diff --git a/sha1_file.c b/sha1_file.c
index 4bd790f6f8..6f6406fb36 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3469,6 +3469,8 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	if (!external_odb_put_object(buf, len, type, sha1))
+		return 0;
 	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

