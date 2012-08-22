From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Support generate poison .mo files for testing
Date: Wed, 22 Aug 2012 12:27:26 +0700
Message-ID: <1345613246-4053-1-git-send-email-pclouds@gmail.com>
References: <7va9xofbgo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 07:27:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T43Tx-0005P3-Jf
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 07:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab2HVF1u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 01:27:50 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39916 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab2HVF1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 01:27:48 -0400
Received: by dady13 with SMTP id y13so456585dad.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 22:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KvLz3ZtmUGLFRK+CrBaZlBMKpPVaJP8cGQSSyA6FFig=;
        b=elfub/Y2KWuiU8OKK9iOA9kQWurZeZeN1JD3CUffGWdLNzDvOq8RhKG7KMfGZXZRR1
         diLSqarHdQjm+yZn2dqhjl7DwulTIEK6r5+wEZRVolURIgCRPJaNZ96d8guZZpxWNY4L
         lzB+uzuKo2z6+HO4gzboaqbQBiNhHmeI53rIQIdcQZoSytFAaYJyVVjGN2PXqO4YWiK7
         EPyUBcFHTNrAVgRam4HdnQ+2dyExw72mijRewx6Xsjc4ohpo2LKSWQEeIAJbVjiFAFzL
         QsTbEZaA8Xj/n8jZfL5pFPMgetZIO/yvxCApd+g3kLCoPMNNjjfuPDWZpMHlW1xvi4PG
         KuVw==
Received: by 10.68.222.9 with SMTP id qi9mr49594373pbc.164.1345613268148;
        Tue, 21 Aug 2012 22:27:48 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id wh7sm2959619pbc.33.2012.08.21.22.27.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 22:27:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 22 Aug 2012 12:27:29 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <7va9xofbgo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204006>

test-poisongen does a similar job to gettext poison feature except
that it does it at build time. Gibberish .mo files are generated for
all supported langauges and put in po/build/poison-locale. Target
"poison-locale" is for this.

User can run the test with these .mo files by setting POISON_LOCALE
while running the test suite. User must also set LANG/LC_* correctly
(and the system is supposed to support that locale).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Tue, Aug 21, 2012 at 11:37 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
 > I would say it is not worse than just "annoying"; if the cost will
 > go away, I'd rather see this conversion postponed and is done as
 > part of (and preferrably at the end of) the "poison with a
 > poison-locale" series.

 OK let me redo step one. test-poisongen requires libgettextpo. I'm
 not sure if this library if gnu specific. We may need another flag
 for it instead of NO_GETTEXT. We don't need a fake language code with
 this approach.

 Makefile         |  19 ++++++++
 t/test-lib.sh    |  10 +++-
 test-poisongen.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 wrap-for-bin.sh  |   6 ++-
 4 files changed, 171 insertions(+), 3 deletions(-)
 mode change 100644 =3D> 100755 t/test-lib.sh
 create mode 100644 test-poisongen.c
 mode change 100644 =3D> 100755 wrap-for-bin.sh

diff --git a/Makefile b/Makefile
index 6b0c961..6ea2665 100644
--- a/Makefile
+++ b/Makefile
@@ -496,6 +496,9 @@ TEST_PROGRAMS_NEED_X +=3D test-mergesort
 TEST_PROGRAMS_NEED_X +=3D test-mktemp
 TEST_PROGRAMS_NEED_X +=3D test-parse-options
 TEST_PROGRAMS_NEED_X +=3D test-path-utils
+ifndef NO_GETTEXT
+TEST_PROGRAMS_NEED_X +=3D test-poisongen
+endif
 TEST_PROGRAMS_NEED_X +=3D test-revision-walking
 TEST_PROGRAMS_NEED_X +=3D test-run-command
 TEST_PROGRAMS_NEED_X +=3D test-scrap-cache-tree
@@ -2428,6 +2431,19 @@ endif
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
=20
+ifndef NO_GETTEXT
+POISON_MOFILES :=3D $(patsubst po/%.po,po/build/poison-locale/%/LC_MES=
SAGES/git.mo,$(POFILES))
+
+po/build/poison-locale/%.po: po/%.po test-poisongen$X po/git.pot
+	$(QUIET_MSGFMT)mkdir -p $(dir $@) && \
+	./test-poisongen po/git.pot $@
+
+po/build/poison-locale/%/LC_MESSAGES/git.mo: po/build/poison-locale/%.=
po
+	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+
+poison-locale: $(POISON_MOFILES)
+endif
+
 FIND_SOURCE_FILES =3D ( git ls-files '*.[hcS]' 2>/dev/null || \
 			$(FIND) . \( -name .git -type d -prune \) \
 				-o \( -name '*.[hcS]' -type f -print \) )
@@ -2564,6 +2580,9 @@ test-svn-fe$X: vcs-svn/lib.a
=20
 .PRECIOUS: $(TEST_OBJS)
=20
+test-poisongen$X: test-poisongen.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(filter %.a,$^) $(LIBS) -lgettextpo
+
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(filter %.a,$^) $(LIBS)
=20
diff --git a/t/test-lib.sh b/t/test-lib.sh
old mode 100644
new mode 100755
index bb4f886..d4060e8
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -55,8 +55,10 @@ GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
 export PERL_PATH SHELL_PATH
=20
 # For repeatability, reset the environment to known value.
-LANG=3DC
-LC_ALL=3DC
+if [ -z "$POISON_LOCALE" ]; then
+	LANG=3DC
+	LC_ALL=3DC
+fi
 PAGER=3Dcat
 TZ=3DUTC
 TERM=3Ddumb
@@ -92,6 +94,10 @@ export GIT_MERGE_VERBOSITY GIT_MERGE_AUTOEDIT
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
+if test -n "$POISON_LOCALE"; then
+	GIT_POISON_LOCALE=3Dyes
+	export GIT_POISON_LOCALE
+fi
=20
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
diff --git a/test-poisongen.c b/test-poisongen.c
new file mode 100644
index 0000000..5905aa9
--- /dev/null
+++ b/test-poisongen.c
@@ -0,0 +1,139 @@
+#include <gettext-po.h>
+#include "cache.h"
+#include "strbuf.h"
+
+static void xerror(int severity,
+		   po_message_t message,
+		   const char *filename, size_t lineno, size_t column,
+		   int multiline_p, const char *message_text)
+{
+	die("%s:%d:%d %s", filename, lineno, column, message_text);
+}
+
+static void xerror2(int severity,
+		    po_message_t message1,
+		    const char *filename1, size_t lineno1, size_t column1,
+		    int multiline_p1, const char *message_text1,
+		    po_message_t message2,
+		    const char *filename2, size_t lineno2, size_t column2,
+		    int multiline_p2, const char *message_text2)
+{
+	die("%s:%d:%d %s (%s:%d:%d %s)",
+	    filename1, lineno1, column1, message_text1,
+	    filename2, lineno2, column2, message_text2);
+}
+
+static void translate(const char *msg, struct strbuf *buf)
+{
+	const char *end =3D msg + strlen(msg);
+	const char *text =3D "* GETTEXT POISON *";
+	int text_len =3D strlen(text);
+	int t =3D 0;
+
+	strbuf_reset(buf);
+	/* preserve \n and printf format specifiers because msgfmt
+	   barfs otherwise. */
+	while (msg < end) {
+		/* printf specifiers and shell variables, it's a quite
+		   relax check */
+		if ((*msg =3D=3D '%' || *msg =3D=3D '$') && msg+1 < end) {
+			strbuf_addch(buf, *msg++);
+			do
+			       strbuf_addch(buf, *msg);
+			while (msg < end && !isspace(*msg++));
+		} else if (*msg =3D=3D '\n') {
+			/* we only need to preserve trailing newlines, doing
+			   more does not really harm */
+			strbuf_addch(buf, '\n');
+			msg++;
+		} else {
+			strbuf_addch(buf, text[t]);
+			t =3D (t + 1) % text_len;
+			msg++;
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	const char *project_header =3D "Project-Id-Version: ";
+	const char *charset_header =3D "Content-Type: text/plain; charset=3D"=
;
+	const char *plural_header =3D "Plural-Forms: nplurals=3D";
+	struct po_xerror_handler handler =3D { xerror, xerror2 };
+	po_file_t src;
+	const char *file =3D argv[1];
+	po_message_iterator_t iter;
+	po_message_t msg;
+	struct strbuf buf =3D STRBUF_INIT;
+
+	if (argc !=3D 3)
+		die("usage: test-poisongen <pot file> <poison po file>");
+
+	src =3D po_file_read(file, &handler);
+	if (src =3D=3D NULL)
+		die("could not open %s\n", file);
+
+	iter =3D po_message_iterator(src, "messages");
+	while ((msg =3D po_next_message(iter)) !=3D NULL) {
+		/* msgid "" is the header, special handling */
+		if (po_message_msgid(msg)[0] =3D=3D '\0') {
+			const char *p;
+
+			/* no fuzzy, msgfmt does not like it */
+			po_message_set_fuzzy(msg, 0);
+
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, po_message_msgstr(msg));
+
+			if (!prefixcmp(buf.buf, project_header) &&
+			    !prefixcmp(buf.buf + strlen(project_header),
+				       "PACKAGE VERSION\n")) {
+				strbuf_splice(&buf, strlen(project_header),
+					      strlen("PACKAGE VERSION"),
+					      "git poison",
+					      strlen("git poison"));
+			}
+
+			/* Content-Type: text/plain; charset=3DUTF-8 */
+			if ((p =3D strstr(buf.buf, charset_header)) !=3D NULL &&
+			    !prefixcmp(p + strlen(charset_header), "CHARSET\n")) {
+				p +=3D strlen(charset_header);
+				strbuf_splice(&buf, p - buf.buf, strlen("CHARSET"),
+					      "UTF-8", strlen("UTF-8"));
+			}
+
+			/* Plural-Forms: nplurals=3D2; plural=3D1 */
+			if ((p =3D strstr(buf.buf, plural_header)) !=3D NULL &&
+			    !prefixcmp(p + strlen(plural_header), "INTEGER; plural=3DEXPRES=
SION")) {
+				int offset;
+				p +=3D strlen(plural_header);
+				offset =3D p - buf.buf;
+				strbuf_splice(&buf, offset, strlen("INTEGER"), "2", 1);
+				offset +=3D 1;
+				assert(!prefixcmp(buf.buf + offset, "; plural=3DEXPRESSION"));
+				offset +=3D strlen("; plural=3D");
+				strbuf_splice(&buf, offset, strlen("EXPRESSION"), "1", 1);
+			}
+
+			po_message_set_msgstr(msg, buf.buf);
+			continue;
+		}
+		if (po_message_msgid_plural(msg)) {
+			int index =3D 0;
+
+			translate(po_message_msgid(msg), &buf);
+			po_message_set_msgstr_plural(msg, index++, buf.buf);
+
+			while (po_message_msgstr_plural(msg, index)) {
+				translate(po_message_msgid_plural(msg), &buf);
+				po_message_set_msgstr_plural(msg, index++, buf.buf);
+			}
+		} else {
+			translate(po_message_msgid(msg), &buf);
+			po_message_set_msgstr(msg, buf.buf);
+		}
+	}
+
+	po_file_write(src, argv[2], &handler);
+	return 0;
+}
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
old mode 100644
new mode 100755
index 53a8dd0..99bc816
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -15,7 +15,11 @@ else
 	export GIT_TEMPLATE_DIR
 fi
 GITPERLLIB=3D'@@BUILD_DIR@@/perl/blib/lib'
-GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/locale'
+if test -n "$GIT_POISON_LOCALE"; then
+	GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/poison-locale'
+else
+	GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/locale'
+fi
 PATH=3D'@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
=20
--=20
1.7.12.rc2
