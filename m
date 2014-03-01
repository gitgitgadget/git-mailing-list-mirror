From: Faiz Kothari <faiz.off93@gmail.com>
Subject: [PATCH] implemented strbuf_write_or_die()
Date: Sat,  1 Mar 2014 18:59:27 +0530
Message-ID: <1393680567-2166-1-git-send-email-faiz.off93@gmail.com>
References: <CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
Cc: Faiz Kothari <faiz.off93@gmail.com>
To: git@vger.kernel.org, sunheehnus@gmail.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Mar 01 14:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJjzs-0000Eo-Sd
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 14:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbaCAN3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 08:29:54 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:43836 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAN3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 08:29:53 -0500
Received: by mail-pb0-f42.google.com with SMTP id rr13so1945174pbb.15
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 05:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T+hUHhI481iTNiH82SuadIERdT8xu+//WpljjaRX2nc=;
        b=vZw/y31qjHpLC/81h1WAfeX06WSlxFGWX7soIgXrOApVXMLJKmiJf+yDQI5Us+KFYF
         4/msrMIM9Cu38onSxNW4sZje8cP++FXjXcaBv5iDaglit/fBRb6AZEsV73qEUTKZaC75
         cMBi/1Q7ffYxoDYp8jQAi5NvKplR17xZn63dXLFMS5TPEfrVwFGYnnfFjbvXCUi573sk
         YrUvj8Xr7loTolu6f+IfLUvcwAoBEuf1DguM+c0juiCtqLtIb5qeq+S04Vo4K55ZAo7V
         pfRZiQy0GoL+5aNFeZDOA19S10s/OylyQKnip4jzI2otGA2KAVEyOqEAfpYHOf69Al4z
         rejQ==
X-Received: by 10.68.233.200 with SMTP id ty8mr9513079pbc.1.1393680593294;
        Sat, 01 Mar 2014 05:29:53 -0800 (PST)
Received: from dj-pc.bits-goa.ac.in ([115.248.130.148])
        by mx.google.com with ESMTPSA id nv7sm16433896pbc.31.2014.03.01.05.29.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 05:29:52 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243096>

Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
---
> > -               write_or_die(1, rpc.result.buf, rpc.result.len);
> > +               strbuf_write_or_die(1, &(rpc.result.buf));

> May be this should be
> strbuf_write_or_die(1, &(rpc.result));

Yes, I changed that :-) Thanks again.

> Maybe we just call write_or_die() in strbuf_write_or_die(), in case that if we
> wanna change something in write_or_dir(), we don't have to do duplicate jobs.

Yes I changed it. It was unnecessary to reimplement it.

Thanks :)

 builtin/cat-file.c     |    2 +-
 builtin/notes.c        |    4 ++--
 builtin/receive-pack.c |    2 +-
 builtin/send-pack.c    |    2 +-
 builtin/stripspace.c   |    2 +-
 builtin/tag.c          |    2 +-
 bundle.c               |    2 +-
 cache.h                |    1 +
 credential-store.c     |    2 +-
 fetch-pack.c           |    2 +-
 http-backend.c         |    2 +-
 remote-curl.c          |    8 +++++---
 write_or_die.c         |    6 ++++++
 13 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d5a93e0..c756cd5 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -255,7 +255,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 
 	strbuf_expand(&buf, opt->format, expand_format, data);
 	strbuf_addch(&buf, '\n');
-	write_or_die(1, buf.buf, buf.len);
+	strbuf_write_or_die(1, &buf);
 	strbuf_release(&buf);
 
 	if (opt->print_contents) {
diff --git a/builtin/notes.c b/builtin/notes.c
index 2b24d05..ef40183 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -140,7 +140,7 @@ static void write_commented_object(int fd, const unsigned char *object)
 	if (strbuf_read(&buf, show.out, 0) < 0)
 		die_errno(_("could not read 'show' output"));
 	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len);
-	write_or_die(fd, cbuf.buf, cbuf.len);
+	strbuf_write_or_die(fd, &cbuf);
 
 	strbuf_release(&cbuf);
 	strbuf_release(&buf);
@@ -174,7 +174,7 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 		strbuf_addch(&buf, '\n');
 		strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
 		strbuf_addch(&buf, '\n');
-		write_or_die(fd, buf.buf, buf.len);
+		strbuf_write_or_die(fd, &buf);
 
 		write_commented_object(fd, object);
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 85bba35..9434516 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1114,7 +1114,7 @@ static void report(struct command *commands, const char *unpack_status)
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
 	else
-		write_or_die(1, buf.buf, buf.len);
+		strbuf_write_or_die(1, &buf);
 	strbuf_release(&buf);
 }
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f420b74..d053f0a 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -86,7 +86,7 @@ static void print_helper_status(struct ref *ref)
 		}
 		strbuf_addch(&buf, '\n');
 
-		write_or_die(1, buf.buf, buf.len);
+		strbuf_write_or_die(1, &buf);
 	}
 	strbuf_release(&buf);
 }
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1259ed7..cf5c876 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -115,7 +115,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 	else
 		comment_lines(&buf);
 
-	write_or_die(1, buf.buf, buf.len);
+	strbuf_write_or_die(1, &buf);
 	strbuf_release(&buf);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index 74d3780..5af6ea3 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -349,7 +349,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 				strbuf_commented_addf(&buf, _(tag_template), comment_line_char);
 			else
 				strbuf_commented_addf(&buf, _(tag_template_nocleanup), comment_line_char);
-			write_or_die(fd, buf.buf, buf.len);
+			strbuf_write_or_die(fd, &buf);
 			strbuf_release(&buf);
 		}
 		close(fd);
diff --git a/bundle.c b/bundle.c
index e99065c..435505d 100644
--- a/bundle.c
+++ b/bundle.c
@@ -279,7 +279,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	while (strbuf_getwholeline(&buf, rls_fout, '\n') != EOF) {
 		unsigned char sha1[20];
 		if (buf.len > 0 && buf.buf[0] == '-') {
-			write_or_die(bundle_fd, buf.buf, buf.len);
+			strbuf_write_or_die(bundle_fd, &buf);
 			if (!get_sha1_hex(buf.buf + 1, sha1)) {
 				struct object *object = parse_object_or_die(sha1, buf.buf);
 				object->flags |= UNINTERESTING;
diff --git a/cache.h b/cache.h
index db223e8..8f953a2 100644
--- a/cache.h
+++ b/cache.h
@@ -1227,6 +1227,7 @@ extern int copy_fd(int ifd, int ofd);
 extern int copy_file(const char *dst, const char *src, int mode);
 extern int copy_file_with_time(const char *dst, const char *src, int mode);
 extern void write_or_die(int fd, const void *buf, size_t count);
+extern void strbuf_write_or_die(int fd, const struct strbuf *sbuf);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
 extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
 extern void fsync_or_die(int fd, const char *);
diff --git a/credential-store.c b/credential-store.c
index f9146e5..5d2f211 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -48,7 +48,7 @@ static void print_entry(struct credential *c)
 static void print_line(struct strbuf *buf)
 {
 	strbuf_addch(buf, '\n');
-	write_or_die(credential_lock.fd, buf->buf, buf->len);
+	strbuf_write_or_die(credential_lock.fd, buf);
 }
 
 static void rewrite_credential_file(const char *fn, struct credential *c,
diff --git a/fetch-pack.c b/fetch-pack.c
index f061f1f..a2bf881 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -216,7 +216,7 @@ static void send_request(struct fetch_pack_args *args,
 		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
 		packet_flush(fd);
 	} else
-		write_or_die(fd, buf->buf, buf->len);
+		strbuf_write_or_die(fd, buf);
 }
 
 static void insert_one_alternate_ref(const struct ref *ref, void *unused)
diff --git a/http-backend.c b/http-backend.c
index d2c0a62..0204529 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -157,7 +157,7 @@ static void send_strbuf(const char *type, struct strbuf *buf)
 	hdr_int(content_length, buf->len);
 	hdr_str(content_type, type);
 	end_headers();
-	write_or_die(1, buf->buf, buf->len);
+	strbuf_write_or_die(1, buf);
 }
 
 static void send_local_file(const char *the_type, const char *name)
diff --git a/remote-curl.c b/remote-curl.c
index 10cb011..7d45e5e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -634,7 +634,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	if (start_command(&client))
 		exit(1);
 	if (preamble)
-		write_or_die(client.in, preamble->buf, preamble->len);
+		strbuf_write_or_die(client.in, preamble);
 	if (heads)
 		write_or_die(client.in, heads->buf, heads->len);
 
@@ -767,7 +767,8 @@ static int fetch_git(struct discovery *heads,
 
 	err = rpc_service(&rpc, heads);
 	if (rpc.result.len)
-		write_or_die(1, rpc.result.buf, rpc.result.len);
+		strbuf_write_or_die(1, &(rpc.result));
+	
 	strbuf_release(&rpc.result);
 	strbuf_release(&preamble);
 	free(depth_arg);
@@ -889,7 +890,8 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 
 	err = rpc_service(&rpc, heads);
 	if (rpc.result.len)
-		write_or_die(1, rpc.result.buf, rpc.result.len);
+		strbuf_write_or_die(1, &(rpc.result));
+	
 	strbuf_release(&rpc.result);
 	argv_array_clear(&args);
 	return err;
diff --git a/write_or_die.c b/write_or_die.c
index b50f99a..7ed9821 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "strbuf.h"
 
 static void check_pipe(int err)
 {
@@ -64,6 +65,11 @@ void write_or_die(int fd, const void *buf, size_t count)
 	}
 }
 
+void strbuf_write_or_die(int fd, const struct strbuf *sbuf)
+{
+	write_or_die(fd, sbuf->buf, sbuf->len);
+}
+
 int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-- 
1.7.9.5
