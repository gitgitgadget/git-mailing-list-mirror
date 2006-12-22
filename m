From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] libgit.a: add some UTF-8 handling functions
Date: Sat, 23 Dec 2006 00:50:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612230048350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061222221913.GA3071@cepheus> <Pine.LNX.4.63.0612222331581.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1423594909-1166831421=:19693"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Dec 23 00:50:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxuA1-00056p-Nb
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 00:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbWLVXuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 18:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280AbWLVXuZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 18:50:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:44012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753083AbWLVXuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 18:50:23 -0500
Received: (qmail invoked by alias); 22 Dec 2006 23:50:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp005) with SMTP; 23 Dec 2006 00:50:21 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <Pine.LNX.4.63.0612222331581.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35248>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1423594909-1166831421=:19693
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 22 Dec 2006, Johannes Schindelin wrote:

> Dear Mr Zeisberg,
> 
> On Fri, 22 Dec 2006, Uwe Kleine-König wrote:
> 
> > Johannes Schindelin wrote:
> > > Note that we do not go the full nine yards: we could also check that
> > > the character is encoded with the minimum amount of bytes, as pointed
> > > out by Uwe Kleine-Koenig.
> > While we're talking about UTF-8 in commit-logs:  I'd prefer to have my
> > name properly written with o-umlaut.
> 
> I did this because I have no easy way to input UTF-8, and because I am 
> lazy, and because I did not know how many times this patch has to be 
> revised.
> 
> Apart from that, it seems that the checking of UTF-8 is actually quite 
> simple, and we could even copy it from 
> http://www.cl.cam.ac.uk/~mgk25/ucs/utf8_check.c, where the check you 
> proposed is included.
> 
> But I had enough of UTF-8 for a day.

Okay, so I lied (this are both patches revised and combined):

--
 Makefile              |    6 +
 builtin-commit-tree.c |   14 ++
 utf8.c                |  277 +++++++++++++++++++++++++++++++++++++++++++++++++
 utf8.h                |    8 +
 4 files changed, 301 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -234,7 +237,8 @@ LIB_H = \
 	archive.h blob.h cache.h commit.h csum-file.h delta.h grep.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
-	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h
+	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
+	utf8.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -253,7 +257,8 @@ LIB_OBJS = \
 	revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
-	color.o wt-status.o archive-zip.o archive-tar.o shallow.o
+	color.o wt-status.o archive-zip.o archive-tar.o shallow.o \
+	utf8.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 856f3cd..ef7cc91 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "builtin.h"
+#include "utf8.h"
 
 #define BLOCKING (1ul << 14)
 
@@ -32,7 +33,7 @@ static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
 	len = vsnprintf(one_line, sizeof(one_line), fmt, args);
 	va_end(args);
 	size = *sizep;
-	newsize = size + len;
+	newsize = size + len + 1;
 	alloc = (size + 32767) & ~32767;
 	buf = *bufp;
 	if (newsize > alloc) {
@@ -40,7 +41,7 @@ static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
 		buf = xrealloc(buf, alloc);
 		*bufp = buf;
 	}
-	*sizep = newsize;
+	*sizep = newsize - 1;
 	memcpy(buf + size, one_line, len);
 }
 
@@ -127,6 +128,15 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	while (fgets(comment, sizeof(comment), stdin) != NULL)
 		add_buffer(&buffer, &size, "%s", comment);
 
+	/* And check the encoding */
+	buffer[size] = '\0';
+	if (!strcmp(git_commit_encoding, "utf-8") && !is_utf8(buffer)) {
+		fprintf(stderr, "Commit message does not conform to UTF-8.\n"
+			"Please fix the message,"
+			" or set the config variable i18n.commitencoding.\n");
+		return 1;
+	}
+
 	if (!write_sha1_file(buffer, size, commit_type, commit_sha1)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
 		return 0;
diff --git a/utf8.c b/utf8.c
new file mode 100644
index 0000000..8daec78
--- /dev/null
+++ b/utf8.c
@@ -0,0 +1,277 @@
+#include "git-compat-util.h"
+#include "utf8.h"
+
+/* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
+
+struct interval {
+  int first;
+  int last;
+};
+
+/* auxiliary function for binary search in interval table */
+static int bisearch(wchar_t ucs, const struct interval *table, int max) {
+	int min = 0;
+	int mid;
+
+	if (ucs < table[0].first || ucs > table[max].last)
+		return 0;
+	while (max >= min) {
+		mid = (min + max) / 2;
+		if (ucs > table[mid].last)
+			min = mid + 1;
+		else if (ucs < table[mid].first)
+			max = mid - 1;
+		else
+			return 1;
+	}
+
+	return 0;
+}
+
+/* The following two functions define the column width of an ISO 10646
+ * character as follows:
+ *
+ *    - The null character (U+0000) has a column width of 0.
+ *
+ *    - Other C0/C1 control characters and DEL will lead to a return
+ *      value of -1.
+ *
+ *    - Non-spacing and enclosing combining characters (general
+ *      category code Mn or Me in the Unicode database) have a
+ *      column width of 0.
+ *
+ *    - SOFT HYPHEN (U+00AD) has a column width of 1.
+ *
+ *    - Other format characters (general category code Cf in the Unicode
+ *      database) and ZERO WIDTH SPACE (U+200B) have a column width of 0.
+ *
+ *    - Hangul Jamo medial vowels and final consonants (U+1160-U+11FF)
+ *      have a column width of 0.
+ *
+ *    - Spacing characters in the East Asian Wide (W) or East Asian
+ *      Full-width (F) category as defined in Unicode Technical
+ *      Report #11 have a column width of 2.
+ *
+ *    - All remaining characters (including all printable
+ *      ISO 8859-1 and WGL4 characters, Unicode control characters,
+ *      etc.) have a column width of 1.
+ *
+ * This implementation assumes that wchar_t characters are encoded
+ * in ISO 10646.
+ */
+
+static int wcwidth(wchar_t ch)
+{
+	/*
+	 * Sorted list of non-overlapping intervals of non-spacing characters,
+	 * generated by
+	 *   "uniset +cat=Me +cat=Mn +cat=Cf -00AD +1160-11FF +200B c".
+	 */
+	static const struct interval combining[] = {
+		{ 0x0300, 0x0357 }, { 0x035D, 0x036F }, { 0x0483, 0x0486 },
+		{ 0x0488, 0x0489 }, { 0x0591, 0x05A1 }, { 0x05A3, 0x05B9 },
+		{ 0x05BB, 0x05BD }, { 0x05BF, 0x05BF }, { 0x05C1, 0x05C2 },
+		{ 0x05C4, 0x05C4 }, { 0x0600, 0x0603 }, { 0x0610, 0x0615 },
+		{ 0x064B, 0x0658 }, { 0x0670, 0x0670 }, { 0x06D6, 0x06E4 },
+		{ 0x06E7, 0x06E8 }, { 0x06EA, 0x06ED }, { 0x070F, 0x070F },
+		{ 0x0711, 0x0711 }, { 0x0730, 0x074A }, { 0x07A6, 0x07B0 },
+		{ 0x0901, 0x0902 }, { 0x093C, 0x093C }, { 0x0941, 0x0948 },
+		{ 0x094D, 0x094D }, { 0x0951, 0x0954 }, { 0x0962, 0x0963 },
+		{ 0x0981, 0x0981 }, { 0x09BC, 0x09BC }, { 0x09C1, 0x09C4 },
+		{ 0x09CD, 0x09CD }, { 0x09E2, 0x09E3 }, { 0x0A01, 0x0A02 },
+		{ 0x0A3C, 0x0A3C }, { 0x0A41, 0x0A42 }, { 0x0A47, 0x0A48 },
+		{ 0x0A4B, 0x0A4D }, { 0x0A70, 0x0A71 }, { 0x0A81, 0x0A82 },
+		{ 0x0ABC, 0x0ABC }, { 0x0AC1, 0x0AC5 }, { 0x0AC7, 0x0AC8 },
+		{ 0x0ACD, 0x0ACD }, { 0x0AE2, 0x0AE3 }, { 0x0B01, 0x0B01 },
+		{ 0x0B3C, 0x0B3C }, { 0x0B3F, 0x0B3F }, { 0x0B41, 0x0B43 },
+		{ 0x0B4D, 0x0B4D }, { 0x0B56, 0x0B56 }, { 0x0B82, 0x0B82 },
+		{ 0x0BC0, 0x0BC0 }, { 0x0BCD, 0x0BCD }, { 0x0C3E, 0x0C40 },
+		{ 0x0C46, 0x0C48 }, { 0x0C4A, 0x0C4D }, { 0x0C55, 0x0C56 },
+		{ 0x0CBC, 0x0CBC }, { 0x0CBF, 0x0CBF }, { 0x0CC6, 0x0CC6 },
+		{ 0x0CCC, 0x0CCD }, { 0x0D41, 0x0D43 }, { 0x0D4D, 0x0D4D },
+		{ 0x0DCA, 0x0DCA }, { 0x0DD2, 0x0DD4 }, { 0x0DD6, 0x0DD6 },
+		{ 0x0E31, 0x0E31 }, { 0x0E34, 0x0E3A }, { 0x0E47, 0x0E4E },
+		{ 0x0EB1, 0x0EB1 }, { 0x0EB4, 0x0EB9 }, { 0x0EBB, 0x0EBC },
+		{ 0x0EC8, 0x0ECD }, { 0x0F18, 0x0F19 }, { 0x0F35, 0x0F35 },
+		{ 0x0F37, 0x0F37 }, { 0x0F39, 0x0F39 }, { 0x0F71, 0x0F7E },
+		{ 0x0F80, 0x0F84 }, { 0x0F86, 0x0F87 }, { 0x0F90, 0x0F97 },
+		{ 0x0F99, 0x0FBC }, { 0x0FC6, 0x0FC6 }, { 0x102D, 0x1030 },
+		{ 0x1032, 0x1032 }, { 0x1036, 0x1037 }, { 0x1039, 0x1039 },
+		{ 0x1058, 0x1059 }, { 0x1160, 0x11FF }, { 0x1712, 0x1714 },
+		{ 0x1732, 0x1734 }, { 0x1752, 0x1753 }, { 0x1772, 0x1773 },
+		{ 0x17B4, 0x17B5 }, { 0x17B7, 0x17BD }, { 0x17C6, 0x17C6 },
+		{ 0x17C9, 0x17D3 }, { 0x17DD, 0x17DD }, { 0x180B, 0x180D },
+		{ 0x18A9, 0x18A9 }, { 0x1920, 0x1922 }, { 0x1927, 0x1928 },
+		{ 0x1932, 0x1932 }, { 0x1939, 0x193B }, { 0x200B, 0x200F },
+		{ 0x202A, 0x202E }, { 0x2060, 0x2063 }, { 0x206A, 0x206F },
+		{ 0x20D0, 0x20EA }, { 0x302A, 0x302F }, { 0x3099, 0x309A },
+		{ 0xFB1E, 0xFB1E }, { 0xFE00, 0xFE0F }, { 0xFE20, 0xFE23 },
+		{ 0xFEFF, 0xFEFF }, { 0xFFF9, 0xFFFB }, { 0x1D167, 0x1D169 },
+		{ 0x1D173, 0x1D182 }, { 0x1D185, 0x1D18B },
+		{ 0x1D1AA, 0x1D1AD }, { 0xE0001, 0xE0001 },
+		{ 0xE0020, 0xE007F }, { 0xE0100, 0xE01EF }
+	};
+
+	/* test for 8-bit control characters */
+	if (ch == 0)
+		return 0;
+	if (ch < 32 || (ch >= 0x7f && ch < 0xa0))
+		return -1;
+
+	/* binary search in table of non-spacing characters */
+	if (bisearch(ch, combining, sizeof(combining)
+				/ sizeof(struct interval) - 1))
+		return 0;
+
+	/*
+	 * If we arrive here, ch is neither a combining nor a C0/C1
+	 * control character.
+	 */
+
+	return 1 +
+		(ch >= 0x1100 &&
+                    /* Hangul Jamo init. consonants */
+		 (ch <= 0x115f ||
+		  ch == 0x2329 || ch == 0x232a ||
+                  /* CJK ... Yi */
+		  (ch >= 0x2e80 && ch <= 0xa4cf &&
+		   ch != 0x303f) ||
+		  /* Hangul Syllables */
+		  (ch >= 0xac00 && ch <= 0xd7a3) ||
+		  /* CJK Compatibility Ideographs */
+		  (ch >= 0xf900 && ch <= 0xfaff) ||
+		  /* CJK Compatibility Forms */
+		  (ch >= 0xfe30 && ch <= 0xfe6f) ||
+		  /* Fullwidth Forms */
+		  (ch >= 0xff00 && ch <= 0xff60) ||
+		  (ch >= 0xffe0 && ch <= 0xffe6) ||
+		  (ch >= 0x20000 && ch <= 0x2fffd) ||
+		  (ch >= 0x30000 && ch <= 0x3fffd)));
+}
+
+/*
+ * This function returns the number of columns occupied by the character
+ * pointed to by the variable start. The pointer is updated to point at
+ * the next character. If it was not valid UTF-8, the pointer is set to NULL.
+ */
+int utf8_width(const char **start)
+{
+	unsigned char *s = (unsigned char *)*start;
+	wchar_t ch;
+
+	if (*s < 0x80) {
+		/* 0xxxxxxx */
+		ch = *s;
+		*start += 1;
+	} else if ((s[0] & 0xe0) == 0xc0) {
+		/* 110XXXXx 10xxxxxx */
+		if ((s[1] & 0xc0) != 0x80 ||
+				/* overlong? */
+				(s[0] & 0xfe) == 0xc0)
+			goto invalid;
+		ch = ((s[0] & 0x1f) << 6) | (s[1] & 0x3f);
+		*start += 2;
+	} else if ((s[0] & 0xf0) == 0xe0) {
+		/* 1110XXXX 10Xxxxxx 10xxxxxx */
+		if ((s[1] & 0xc0) != 0x80 ||
+				(s[2] & 0xc0) != 0x80 ||
+				/* overlong? */
+				(s[0] == 0xe0 && (s[1] & 0xe0) == 0x80) ||
+				/* surrogate? */
+				(s[0] == 0xed && (s[1] & 0xe0) == 0xa0) ||
+				/* U+FFFE or U+FFFF? */
+				(s[0] == 0xef && s[1] == 0xbf &&
+				 (s[2] & 0xfe) == 0xbe))
+			goto invalid;
+		ch = ((s[0] & 0x0f) << 12) |
+			((s[1] & 0x3f) << 6) | (s[2] & 0x3f);
+		*start += 3;
+	} else if ((s[0] & 0xf8) == 0xf0) {
+		/* 11110XXX 10XXxxxx 10xxxxxx 10xxxxxx */
+		if ((s[1] & 0xc0) != 0x80 ||
+				(s[2] & 0xc0) != 0x80 ||
+				(s[3] & 0xc0) != 0x80 ||
+				/* overlong? */
+				(s[0] == 0xf0 && (s[1] & 0xf0) == 0x80) ||
+				/* > U+10FFFF? */
+				(s[0] == 0xf4 && s[1] > 0x8f) || s[0] > 0xf4)
+			goto invalid;
+		ch = ((s[0] & 0x07) << 18) | ((s[1] & 0x3f) << 12) |
+			((s[2] & 0x3f) << 6) | (s[3] & 0x3f);
+		*start += 4;
+	} else {
+invalid:
+		*start = NULL;
+		return 0;
+	}
+
+	return wcwidth(ch);
+}
+
+int is_utf8(const char *text)
+{
+	while (*text) {
+		if (*text == '\n' || *text == '\t' || *text == '\r') {
+			text++;
+			continue;
+		}
+		utf8_width(&text);
+		if (!text)
+			return 0;
+	}
+	return 1;
+}
+
+static void print_spaces(int count)
+{
+	static const char s[] = "                    ";
+	while (count >= sizeof(s)) {
+		fwrite(s, sizeof(s) - 1, 1, stdout);
+		count -= sizeof(s) - 1;
+	}
+	fwrite(s, count, 1, stdout);
+}
+
+/*
+ * Wrap the text, if necessary. The variable indent is the indent for the
+ * first line, indent2 is the indent for all other lines.
+ */
+void print_wrapped_text(const char *text, int indent, int indent2, int width)
+{
+	int w = indent, assume_utf8 = is_utf8(text);
+	const char *bol = text, *space = NULL;
+
+	for (;;) {
+		char c = *text;
+		if (!c || isspace(c)) {
+			if (w < width || space < 0) {
+				const char *start = bol;
+				if (space)
+					start = space;
+				else
+					print_spaces(indent);
+				fwrite(start, text - start, 1, stdout);
+				if (!c) {
+					putchar('\n');
+					return;
+				} else if (c == '\t')
+					w |= 0x07;
+				space = text;
+				w++;
+				text++;
+			} else {
+				putchar('\n');
+				text = bol = space + 1;
+				space = NULL;
+				w = indent = indent2;
+			}
+			continue;
+		}
+		if (assume_utf8)
+			w += utf8_width(&text);
+		else {
+			w++;
+			text++;
+		}
+	}
+}
diff --git a/utf8.h b/utf8.h
new file mode 100644
index 0000000..a0d7f59
--- /dev/null
+++ b/utf8.h
@@ -0,0 +1,8 @@
+#ifndef GIT_UTF8_H
+#define GIT_UTF8_H
+
+int utf8_width(const char **start);
+int is_utf8(const char *text);
+void print_wrapped_text(const char *text, int indent, int indent2, int len);
+
+#endif
---1148973799-1423594909-1166831421=:19693--
