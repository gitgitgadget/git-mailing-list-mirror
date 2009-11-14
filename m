From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH] Check the format of more printf-type functions
Date: Sat, 14 Nov 2009 13:33:13 -0800
Message-ID: <1258234393-5093-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 22:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9QGC-00022t-Rx
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 22:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbZKNVd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 16:33:59 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbZKNVd7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 16:33:59 -0500
Received: from mail-px0-f180.google.com ([209.85.216.180]:46015 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZKNVd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 16:33:58 -0500
Received: by pxi10 with SMTP id 10so369783pxi.33
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 13:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=gIgIzgjyiPJoJNAdsyrzDHYHbkAnPKuVKHpYPTC1iL0=;
        b=bDNO3e6RLwszLJpiM4dpjpR8fHCUp9yn/wvG+Cm2fUZhquqDwBOBZoPqVIGxe/bTMp
         +CS8gq2TPNKl11IT/vGiWsQ6H8mpz+nXOEuwVhZM8qrVdEcus32kd/IguZDKCG6poL+R
         87mAzqFvZGeq6YxGVxjrXlNogSiJlFYWxBd+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=QiUukggobHEs5SCc1weVHuGmd99IrdOprgxP5hPaEpSq80Rm20ZYDJSEDoFguchIkZ
         RAfnWr/ARhO6QKq1/TTBj8q2aBgYmjQTGKyo915lLSNvP7WC4UUuY7r+khhNuD1Id5fZ
         uBhxH5W179iadvG0aRxhQxDHiWhgERKy5CgcQ=
Received: by 10.115.102.18 with SMTP id e18mr4065798wam.174.1258234442829;
        Sat, 14 Nov 2009 13:34:02 -0800 (PST)
Received: from localhost.localdomain (host-98-127-69-228.bln-mt.client.bresnan.net [98.127.69.228])
        by mx.google.com with ESMTPS id 22sm3145773pzk.10.2009.11.14.13.34.00
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Nov 2009 13:34:02 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.373.g37d64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132889>

We already have these checks in many printf-type functions that have
prototypes which are in header files.  Add these same checks to some
more prototypes in header functions and to static functions in .c
files.

cc: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---

Junio, please consider this for next.  It will hopefully catch some bug=
s like
the Content-Length one in http-backend.c.

One extra warning is
    CC merge-recursive.o
merge-recursive.c: In function =E2=80=98write_tree_from_memory=E2=80=99=
:
merge-recursive.c:218: warning: field precision should have type =E2=80=
=98int=E2=80=99, but argument 5 has type =E2=80=98size_t=E2=80=99

A fix that might work in practice (because pathnames won't be longer th=
an=20
an int?) is:
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -215,7 +215,9 @@ struct tree *write_tree_from_memory(struct merge_op=
tions *o)
                for (i =3D 0; i < active_nr; i++) {
                        struct cache_entry *ce =3D active_cache[i];
                        if (ce_stage(ce))
-                               output(o, 0, "%d %.*s", ce_stage(ce), c=
e_namelen(ce), ce->name);
+                               output(o, 0, "%d %.*s", ce_stage(ce), (=
int)ce_namelen(ce), ce->name);
+                       if (ce_namelen(ce) > INT_MAX)
+                               die("A filename was too long");
                }
                return NULL;
        }

but I don't think that is likely to be an acceptable fix, so I'm leavin=
g
it for others to make a proper fix.  Looks like Miklos touched that lin=
e
last, so perhaps he knows of a better fix.

 builtin-fsck.c           |    2 ++
 builtin-update-index.c   |    1 +
 builtin-upload-archive.c |    1 +
 cache.h                  |    2 ++
 color.h                  |    2 ++
 daemon.c                 |    2 ++
 fsck.h                   |    1 +
 imap-send.c              |    6 ++++++
 merge-recursive.c        |    1 +
 strbuf.h                 |    2 +-
 10 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 2d88e45..0e5faae 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -47,6 +47,7 @@ static void objreport(struct object *obj, const char =
*severity,
 	fputs("\n", stderr);
 }
=20
+__attribute__((format (printf, 2, 3)))
 static int objerror(struct object *obj, const char *err, ...)
 {
 	va_list params;
@@ -57,6 +58,7 @@ static int objerror(struct object *obj, const char *e=
rr, ...)
 	return -1;
 }
=20
+__attribute__((format (printf, 3, 4)))
 static int fsck_error_func(struct object *obj, int type, const char *e=
rr, ...)
 {
 	va_list params;
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 92beaaf..a6b7f2d 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -27,6 +27,7 @@ static int mark_valid_only;
 #define MARK_VALID 1
 #define UNMARK_VALID 2
=20
+__attribute__((format (printf, 1, 2)))
 static void report(const char *fmt, ...)
 {
 	va_list vp;
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index c4cd1e1..b2d1259 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -67,6 +67,7 @@ static int run_upload_archive(int argc, const char **=
argv, const char *prefix)
 	return write_archive(sent_argc, sent_argv, prefix, 0);
 }
=20
+__attribute__((format (printf, 1, 2)))
 static void error_clnt(const char *fmt, ...)
 {
 	char buf[1024];
diff --git a/cache.h b/cache.h
index 7cec30e..9fdf122 100644
--- a/cache.h
+++ b/cache.h
@@ -964,7 +964,9 @@ extern void *alloc_object_node(void);
 extern void alloc_report(void);
=20
 /* trace.c */
+__attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
+__attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, .=
=2E.);
=20
 /* convert.c */
diff --git a/color.h b/color.h
index 18abeb7..7d8da6f 100644
--- a/color.h
+++ b/color.h
@@ -29,7 +29,9 @@ int git_color_default_config(const char *var, const c=
har *value, void *cb);
 int git_config_colorbool(const char *var, const char *value, int stdou=
t_is_tty);
 void color_parse(const char *value, const char *var, char *dst);
 void color_parse_mem(const char *value, int len, const char *var, char=
 *dst);
+__attribute__((format (printf, 3, 4)))
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...=
);
 int color_fwrite_lines(FILE *fp, const char *color, size_t count, cons=
t char *buf);
=20
diff --git a/daemon.c b/daemon.c
index 1b5ada6..641ebe1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -77,6 +77,7 @@ static void logreport(int priority, const char *err, =
va_list params)
 	}
 }
=20
+__attribute__((format (printf, 1, 2)))
 static void logerror(const char *err, ...)
 {
 	va_list params;
@@ -85,6 +86,7 @@ static void logerror(const char *err, ...)
 	va_end(params);
 }
=20
+__attribute__((format (printf, 1, 2)))
 static void loginfo(const char *err, ...)
 {
 	va_list params;
diff --git a/fsck.h b/fsck.h
index 008456b..1e4f527 100644
--- a/fsck.h
+++ b/fsck.h
@@ -17,6 +17,7 @@ typedef int (*fsck_walk_func)(struct object *obj, int=
 type, void *data);
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
 typedef int (*fsck_error)(struct object *obj, int type, const char *er=
r, ...);
=20
+__attribute__((format (printf, 3, 4)))
 int fsck_error_function(struct object *obj, int type, const char *fmt,=
 ...);
=20
 /* descend in all linked child objects
diff --git a/imap-send.c b/imap-send.c
index 6c9938a..854b6a4 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -102,13 +102,16 @@ struct msg_data {
=20
 static int Verbose, Quiet;
=20
+__attribute__((format (printf, 1, 2)))
 static void imap_info(const char *, ...);
+__attribute__((format (printf, 1, 2)))
 static void imap_warn(const char *, ...);
=20
 static char *next_arg(char **);
=20
 static void free_generic_messages(struct message *);
=20
+__attribute__((format (printf, 3, 4)))
 static int nfsnprintf(char *buf, int blen, const char *fmt, ...);
=20
 static int nfvasprintf(char **strp, const char *fmt, va_list ap)
@@ -560,6 +563,7 @@ static struct imap_cmd *v_issue_imap_cmd(struct ima=
p_store *ctx,
 	return cmd;
 }
=20
+__attribute__((format (printf, 3, 4)))
 static struct imap_cmd *issue_imap_cmd(struct imap_store *ctx,
 				       struct imap_cmd_cb *cb,
 				       const char *fmt, ...)
@@ -573,6 +577,7 @@ static struct imap_cmd *issue_imap_cmd(struct imap_=
store *ctx,
 	return ret;
 }
=20
+__attribute__((format (printf, 3, 4)))
 static int imap_exec(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		     const char *fmt, ...)
 {
@@ -588,6 +593,7 @@ static int imap_exec(struct imap_store *ctx, struct=
 imap_cmd_cb *cb,
 	return get_cmd_result(ctx, cmdp);
 }
=20
+__attribute__((format (printf, 3, 4)))
 static int imap_exec_m(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		       const char *fmt, ...)
 {
diff --git a/merge-recursive.c b/merge-recursive.c
index f55b7eb..d198312 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -86,6 +86,7 @@ static void flush_output(struct merge_options *o)
 	}
 }
=20
+__attribute__((format (printf, 3, 4)))
 static void output(struct merge_options *o, int v, const char *fmt, ..=
=2E)
 {
 	int len;
diff --git a/strbuf.h b/strbuf.h
index d05e056..fa07ecf 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -117,7 +117,7 @@ struct strbuf_expand_dict_entry {
 };
 extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *pla=
ceholder, void *context);
=20
-__attribute__((format(printf,2,3)))
+__attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
=20
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
--=20
1.6.5.52.g4544ce0
