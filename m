From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
Subject: [PATCH 2/2] entry.c: convert write_entry to use strbuf
Date: Wed, 23 Oct 2013 19:55:07 +0700
Message-ID: <1382532907-30561-2-git-send-email-pclouds@gmail.com>
References: <20131021193223.GC29681@sigill.intra.peff.net>
 <1382532907-30561-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=83=C2=B6gershausen?= <tboegi@web.de>,
	Wataru Noguchi <wnoguchi.0727@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?Ren=C3=83=C2=A9=20Scharfe?= <l.s.r@web.de>,
	msysGit <msysgit@googlegroups.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBC2ZN5PHQUMBBR4MT6JQKGQEQ6MOCMY@googlegroups.com Wed Oct 23 14:51:23 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBBR4MT6JQKGQEQ6MOCMY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f189.google.com ([209.85.216.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBR4MT6JQKGQEQ6MOCMY@googlegroups.com>)
	id 1VYxuD-0001Bx-B8
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 14:51:21 +0200
Received: by mail-qc0-f189.google.com with SMTP id c9sf172615qcz.26
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 05:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=UOmSiU0oThIIVRkActWCM4N461Kp4GCrfxFx7JqGETs=;
        b=sfq+NXNPChUSdnre+SrQ61Pr5+xYvzXGXQE6uIycpnlCsnPvzVeptGH8lhtyFrbelb
         8LSqtoMg4BWnPROaBG2jFv78tTdLCWcKqTpvDDBygzYCDkWtEas/9yYUfgdWLa8t3wtP
         vdkGWMPJKxNkgAo0bIp/jHQO4DAb2T3Ymkubp/4OSZ4VrE7cQhrhsWcInO5d06p3iu3w
         PDCd8MPh6qCC+4dZGm+k/+xGOA5RixhMOBqiFV5Tj2222LFOzcwI1+Ax0SlPzGTha3Mt
         qgtYM3fpWJ3vBlZMFfSvmofHic2IxIB1KHqJfrh4qoucSEQnpNySIvbmsGXHBWbDLZBj
         49GA==
X-Received: by 10.50.127.229 with SMTP id nj5mr28343igb.2.1382532680569;
        Wed, 23 Oct 2013 05:51:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.40.36 with SMTP id u4ls732755igk.2.gmail; Wed, 23 Oct 2013
 05:51:19 -0700 (PDT)
X-Received: by 10.50.85.109 with SMTP id g13mr577201igz.1.1382532679739;
        Wed, 23 Oct 2013 05:51:19 -0700 (PDT)
Received: from mail-pb0-x22d.google.com (mail-pb0-x22d.google.com [2607:f8b0:400e:c01::22d])
        by gmr-mx.google.com with ESMTPS id dk16si5512398pac.0.2013.10.23.05.51.19
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 05:51:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400e:c01::22d as permitted sender) client-ip=2607:f8b0:400e:c01::22d;
Received: by mail-pb0-x22d.google.com with SMTP id mc17so894995pbc.4
        for <msysgit@googlegroups.com>; Wed, 23 Oct 2013 05:51:19 -0700 (PDT)
X-Received: by 10.68.216.132 with SMTP id oq4mr1550429pbc.50.1382532679558;
        Wed, 23 Oct 2013 05:51:19 -0700 (PDT)
Received: from lanh ([115.73.233.152])
        by mx.google.com with ESMTPSA id qp10sm41041360pab.13.2013.10.23.05.51.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 05:51:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 23 Oct 2013 19:55:16 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1382532907-30561-1-git-send-email-pclouds@gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400e:c01::22d
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236506>

The strcpy call in open_output_fd() implies that the output buffer
must be at least 25 chars long. And it's true. The only caller that
can trigger that code is checkout-index, which has the buffer of
PATH_MAX chars (and any systems that have PATH_MAX shorter than 25
chars are just insane).

But in order to say that, one has to walk through a dozen of
functions. Just convert it to strbuf to avoid the constraint and
confusion.

Although my original motivation was simpler than that. I just wanted
to change "char *path" to "const char *path" in checkout_entry() to
make sure no funny business regarding "path" in that function.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
---
 builtin/checkout-index.c | 19 ++++++++++++-------
 cache.h                  |  2 +-
 entry.c                  | 29 ++++++++++++++++-------------
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 69e167b..6d88c0c 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -14,7 +14,12 @@
 static int line_termination =3D '\n';
 static int checkout_stage; /* default to checkout stage0 */
 static int to_tempfile;
-static char topath[4][PATH_MAX + 1];
+static struct strbuf topath[4] =3D {
+	STRBUF_INIT,
+	STRBUF_INIT,
+	STRBUF_INIT,
+	STRBUF_INIT
+};
=20
 static struct checkout state;
=20
@@ -26,19 +31,19 @@ static void write_tempfile_record(const char *name, int=
 prefix_length)
 		for (i =3D 1; i < 4; i++) {
 			if (i > 1)
 				putchar(' ');
-			if (topath[i][0])
-				fputs(topath[i], stdout);
+			if (topath[i].len)
+				fputs(topath[i].buf, stdout);
 			else
 				putchar('.');
 		}
 	} else
-		fputs(topath[checkout_stage], stdout);
+		fputs(topath[checkout_stage].buf, stdout);
=20
 	putchar('\t');
 	write_name_quoted(name + prefix_length, stdout, line_termination);
=20
 	for (i =3D 0; i < 4; i++) {
-		topath[i][0] =3D 0;
+		strbuf_reset(&topath[i]);
 	}
 }
=20
@@ -65,7 +70,7 @@ static int checkout_file(const char *name, int prefix_len=
gth)
 			continue;
 		did_checkout =3D 1;
 		if (checkout_entry(ce, &state,
-		    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)
+		    to_tempfile ? &topath[ce_stage(ce)] : NULL) < 0)
 			errs++;
 	}
=20
@@ -109,7 +114,7 @@ static void checkout_all(const char *prefix, int prefix=
_length)
 				write_tempfile_record(last_ce->name, prefix_length);
 		}
 		if (checkout_entry(ce, &state,
-		    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)
+		    to_tempfile ? &topath[ce_stage(ce)] : NULL) < 0)
 			errs++;
 		last_ce =3D ce;
 	}
diff --git a/cache.h b/cache.h
index 51d6602..276182f 100644
--- a/cache.h
+++ b/cache.h
@@ -962,7 +962,7 @@ struct checkout {
 		 refresh_cache:1;
 };
=20
-extern int checkout_entry(struct cache_entry *ce, const struct checkout *s=
tate, char *topath);
+extern int checkout_entry(struct cache_entry *ce, const struct checkout *s=
tate, struct strbuf *topath);
=20
 struct cache_def {
 	char path[PATH_MAX + 1];
diff --git a/entry.c b/entry.c
index d955af5..a76942d 100644
--- a/entry.c
+++ b/entry.c
@@ -92,15 +92,15 @@ static void *read_blob_entry(const struct cache_entry *=
ce, unsigned long *size)
 	return NULL;
 }
=20
-static int open_output_fd(char *path, const struct cache_entry *ce, int to=
_tempfile)
+static int open_output_fd(struct strbuf *path, const struct cache_entry *c=
e, int to_tempfile)
 {
 	int symlink =3D (ce->ce_mode & S_IFMT) !=3D S_IFREG;
 	if (to_tempfile) {
-		strcpy(path, symlink
-		       ? ".merge_link_XXXXXX" : ".merge_file_XXXXXX");
-		return mkstemp(path);
+		strbuf_reset(path);
+		strbuf_addstr(path, symlink ? ".merge_link_XXXXXX" : ".merge_file_XXXXXX=
");
+		return mkstemp(path->buf);
 	} else {
-		return create_file(path, !symlink ? ce->ce_mode : 0666);
+		return create_file(path->buf, !symlink ? ce->ce_mode : 0666);
 	}
 }
=20
@@ -115,7 +115,7 @@ static int fstat_output(int fd, const struct checkout *=
state, struct stat *st)
 	return 0;
 }
=20
-static int streaming_write_entry(const struct cache_entry *ce, char *path,
+static int streaming_write_entry(const struct cache_entry *ce, struct strb=
uf *path,
 				 struct stream_filter *filter,
 				 const struct checkout *state, int to_tempfile,
 				 int *fstat_done, struct stat *statbuf)
@@ -132,12 +132,12 @@ static int streaming_write_entry(const struct cache_e=
ntry *ce, char *path,
 	result |=3D close(fd);
=20
 	if (result)
-		unlink(path);
+		unlink(path->buf);
 	return result;
 }
=20
 static int write_entry(struct cache_entry *ce,
-		       char *path, const struct checkout *state, int to_tempfile)
+		       struct strbuf *path_buf, const struct checkout *state, int to_tem=
pfile)
 {
 	unsigned int ce_mode_s_ifmt =3D ce->ce_mode & S_IFMT;
 	int fd, ret, fstat_done =3D 0;
@@ -146,15 +146,17 @@ static int write_entry(struct cache_entry *ce,
 	unsigned long size;
 	size_t wrote, newsize =3D 0;
 	struct stat st;
+	const char *path;
=20
 	if (ce_mode_s_ifmt =3D=3D S_IFREG) {
 		struct stream_filter *filter =3D get_stream_filter(ce->name, ce->sha1);
 		if (filter &&
-		    !streaming_write_entry(ce, path, filter,
+		    !streaming_write_entry(ce, path_buf, filter,
 					   state, to_tempfile,
 					   &fstat_done, &st))
 			goto finish;
 	}
+	path =3D path_buf->buf;
=20
 	switch (ce_mode_s_ifmt) {
 	case S_IFREG:
@@ -183,7 +185,8 @@ static int write_entry(struct cache_entry *ce,
 			size =3D newsize;
 		}
=20
-		fd =3D open_output_fd(path, ce, to_tempfile);
+		fd =3D open_output_fd(path_buf, ce, to_tempfile);
+		path =3D path_buf->buf;
 		if (fd < 0) {
 			free(new);
 			return error("unable to create file %s (%s)",
@@ -235,10 +238,10 @@ static int check_path(const char *path, int len, stru=
ct stat *st, int skiplen)
 }
=20
 int checkout_entry(struct cache_entry *ce,
-		   const struct checkout *state, char *topath)
+		   const struct checkout *state, struct strbuf *topath)
 {
 	static struct strbuf path_buf =3D STRBUF_INIT;
-	char *path;
+	const char *path;
 	struct stat st;
 	int len;
=20
@@ -278,5 +281,5 @@ int checkout_entry(struct cache_entry *ce,
 	} else if (state->not_new)
 		return 0;
 	create_directories(path, len, state);
-	return write_entry(ce, path, state, 0);
+	return write_entry(ce, &path_buf, state, 0);
 }
--=20
1.8.2.83.gc99314b

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
