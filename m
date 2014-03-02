From: Faiz Kothari <faiz.off93@gmail.com>
Subject: [PATCH v3 2/2] use strbuf_write_or_die()
Date: Sun,  2 Mar 2014 13:04:24 +0530
Message-ID: <1393745664-21077-2-git-send-email-faiz.off93@gmail.com>
References: <CAPig+cR0gTeB1oUUPQ=W_wWGPMDaY4gkG7+531HT-ktnwn5L-Q@mail.gmail.com>
 <1393745664-21077-1-git-send-email-faiz.off93@gmail.com>
Cc: Faiz Kothari <faiz.off93@gmail.com>
To: git@vger.kernel.org, j6t@kdbg.org, sunshine@sunshineco.com,
	mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sun Mar 02 08:34:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK0vI-0001GY-6w
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 08:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbaCBHew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 02:34:52 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45689 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaCBHev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 02:34:51 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so120925pab.18
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 23:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4O+bDDXj3E3XG4QuoFJ9wENdq0tjlxVdHp/s8r+JFa0=;
        b=DEaLN0eEPXTkGSJlVSBxogGWy2kLm0mUDqm3A3Xh0mtbJ5ZbHLkLv3D0oTYUWBdRBr
         PrpLV0uU5HwnFK9RQPxZ3z7SbGIyE+Iw87DbEhlFGqTyrHWNnw8j6UT/TXihachH7jcS
         N4Bb/lrG+sIzGk9HfUD1889eT35lKVGCujc5qMwa9UVE1QHfITiJsse5xcXGs047Kxpe
         0w5sO39O7id5bfpkW/ndfOcYY8kcWXWP10Mj+Y/CzRnfukZVxXl3nq9hWNZZZUu03vZF
         VTtEwL/uaAhuuR/09CfrVdtJCbA5oNqwaysm8P8SLl+Q2fo7Q+RaeF2ar6fEY4JWS0an
         SSOg==
X-Received: by 10.66.175.4 with SMTP id bw4mr13032249pac.56.1393745691319;
        Sat, 01 Mar 2014 23:34:51 -0800 (PST)
Received: from dj-pc.bits-goa.ac.in ([115.248.130.148])
        by mx.google.com with ESMTPSA id xs1sm55608874pac.7.2014.03.01.23.34.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 23:34:50 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1393745664-21077-1-git-send-email-faiz.off93@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243137>

Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>

Used strbuf.c:strbuf_write_or_die() instead of
write_or_die.c:write_or_die() at relevant places.
---
 builtin/cat-file.c     |    2 +-
 builtin/notes.c        |    6 +++---
 builtin/receive-pack.c |    2 +-
 builtin/send-pack.c    |    2 +-
 builtin/stripspace.c   |    2 +-
 builtin/tag.c          |    2 +-
 bundle.c               |    2 +-
 credential-store.c     |    2 +-
 fetch-pack.c           |    2 +-
 http-backend.c         |    2 +-
 remote-curl.c          |    6 +++---
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d5a93e0..d07a0be 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -255,7 +255,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 
 	strbuf_expand(&buf, opt->format, expand_format, data);
 	strbuf_addch(&buf, '\n');
-	write_or_die(1, buf.buf, buf.len);
+	strbuf_write_or_die(&buf, 1);
 	strbuf_release(&buf);
 
 	if (opt->print_contents) {
diff --git a/builtin/notes.c b/builtin/notes.c
index 2b24d05..a208d56 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -140,7 +140,7 @@ static void write_commented_object(int fd, const unsigned char *object)
 	if (strbuf_read(&buf, show.out, 0) < 0)
 		die_errno(_("could not read 'show' output"));
 	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len);
-	write_or_die(fd, cbuf.buf, cbuf.len);
+	strbuf_write_or_die(&cbuf, fd);
 
 	strbuf_release(&cbuf);
 	strbuf_release(&buf);
@@ -167,14 +167,14 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 			die_errno(_("could not create file '%s'"), path);
 
 		if (msg->given)
-			write_or_die(fd, msg->buf.buf, msg->buf.len);
+			strbuf_write_or_die(&(msg->buf), fd);
 		else if (prev && !append_only)
 			write_note_data(fd, prev);
 
 		strbuf_addch(&buf, '\n');
 		strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
 		strbuf_addch(&buf, '\n');
-		write_or_die(fd, buf.buf, buf.len);
+		strbuf_write_or_die(&buf, fd);
 
 		write_commented_object(fd, object);
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 85bba35..d590993 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1114,7 +1114,7 @@ static void report(struct command *commands, const char *unpack_status)
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
 	else
-		write_or_die(1, buf.buf, buf.len);
+		strbuf_write_or_die(&buf, 1);
 	strbuf_release(&buf);
 }
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f420b74..f26ba21 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -86,7 +86,7 @@ static void print_helper_status(struct ref *ref)
 		}
 		strbuf_addch(&buf, '\n');
 
-		write_or_die(1, buf.buf, buf.len);
+		strbuf_write_or_die(&buf, 1);
 	}
 	strbuf_release(&buf);
 }
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1259ed7..33b7f85 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -115,7 +115,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 	else
 		comment_lines(&buf);
 
-	write_or_die(1, buf.buf, buf.len);
+	strbuf_write_or_die(&buf, 1);
 	strbuf_release(&buf);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index 74d3780..53ab280 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -349,7 +349,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 				strbuf_commented_addf(&buf, _(tag_template), comment_line_char);
 			else
 				strbuf_commented_addf(&buf, _(tag_template_nocleanup), comment_line_char);
-			write_or_die(fd, buf.buf, buf.len);
+			strbuf_write_or_die(&buf, fd);
 			strbuf_release(&buf);
 		}
 		close(fd);
diff --git a/bundle.c b/bundle.c
index e99065c..c8bddd8 100644
--- a/bundle.c
+++ b/bundle.c
@@ -279,7 +279,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	while (strbuf_getwholeline(&buf, rls_fout, '\n') != EOF) {
 		unsigned char sha1[20];
 		if (buf.len > 0 && buf.buf[0] == '-') {
-			write_or_die(bundle_fd, buf.buf, buf.len);
+			strbuf_write_or_die(&buf, bundle_fd);
 			if (!get_sha1_hex(buf.buf + 1, sha1)) {
 				struct object *object = parse_object_or_die(sha1, buf.buf);
 				object->flags |= UNINTERESTING;
diff --git a/credential-store.c b/credential-store.c
index f9146e5..6cb5fcb 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -48,7 +48,7 @@ static void print_entry(struct credential *c)
 static void print_line(struct strbuf *buf)
 {
 	strbuf_addch(buf, '\n');
-	write_or_die(credential_lock.fd, buf->buf, buf->len);
+	strbuf_write_or_die(buf, credential_lock.fd);
 }
 
 static void rewrite_credential_file(const char *fn, struct credential *c,
diff --git a/fetch-pack.c b/fetch-pack.c
index f061f1f..af28bd2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -216,7 +216,7 @@ static void send_request(struct fetch_pack_args *args,
 		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
 		packet_flush(fd);
 	} else
-		write_or_die(fd, buf->buf, buf->len);
+		strbuf_write_or_die(buf, fd);
 }
 
 static void insert_one_alternate_ref(const struct ref *ref, void *unused)
diff --git a/http-backend.c b/http-backend.c
index d2c0a62..bed9341 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -157,7 +157,7 @@ static void send_strbuf(const char *type, struct strbuf *buf)
 	hdr_int(content_length, buf->len);
 	hdr_str(content_type, type);
 	end_headers();
-	write_or_die(1, buf->buf, buf->len);
+	strbuf_write_or_die(buf, 1);
 }
 
 static void send_local_file(const char *the_type, const char *name)
diff --git a/remote-curl.c b/remote-curl.c
index 10cb011..677df24 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -634,7 +634,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	if (start_command(&client))
 		exit(1);
 	if (preamble)
-		write_or_die(client.in, preamble->buf, preamble->len);
+		strbuf_write_or_die(preamble, client.in);
 	if (heads)
 		write_or_die(client.in, heads->buf, heads->len);
 
@@ -767,7 +767,7 @@ static int fetch_git(struct discovery *heads,
 
 	err = rpc_service(&rpc, heads);
 	if (rpc.result.len)
-		write_or_die(1, rpc.result.buf, rpc.result.len);
+		strbuf_write_or_die(&rpc.result, 1);
 	strbuf_release(&rpc.result);
 	strbuf_release(&preamble);
 	free(depth_arg);
@@ -889,7 +889,7 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 
 	err = rpc_service(&rpc, heads);
 	if (rpc.result.len)
-		write_or_die(1, rpc.result.buf, rpc.result.len);
+		strbuf_write_or_die(&rpc.result, 1);
 	strbuf_release(&rpc.result);
 	argv_array_clear(&args);
 	return err;
-- 
1.7.9.5
