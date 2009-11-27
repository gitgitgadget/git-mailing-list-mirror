From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v3] Give the hunk comment its own color
Date: Fri, 27 Nov 2009 07:55:18 +0100
Message-ID: <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 07:55:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDuju-0003mN-IO
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 07:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbZK0GzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 01:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbZK0GzQ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 01:55:16 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43898 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbZK0GzP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 01:55:15 -0500
Received: by bwz27 with SMTP id 27so970036bwz.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 22:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/vR/hWPcd5lXyIKtK3x1JtSgwrVF2kiIiCEABeuxt3s=;
        b=mN2moFbjSBeJNWgckDyBDVft+b0KUC43V0AK2WCg82wo1xF9FboBQtQg+k1DVIqG2J
         uN7j/OorkVTOIIxYr8i2lrXhIr+Om6t0Hzor7QMlL+PdldJOFWW4jis9CEVBtveSFRZe
         8cqo3yEPAVWv+6bCDgV2YT7P1GR6mdlYYlOv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FVUH6Oe5qUmTdX22VPv8Qb6VWKqQRceiWL1jwM2CGRvLKFUFsn2upC2EBp85yniw1e
         5+z9tB7NAL2djCWuv5Hfvd5JHEYU2695yZa+1W4kIIKouJPg29Re90iWYXMDvrKDMzVZ
         07RH9bJQ/BnRK5t88bPOjtAtZh9lxTJO6aT6U=
Received: by 10.204.154.135 with SMTP id o7mr633016bkw.201.1259304920080;
        Thu, 26 Nov 2009 22:55:20 -0800 (PST)
Received: from localhost (p5B0F5706.dip.t-dialin.net [91.15.87.6])
        by mx.google.com with ESMTPS id g28sm1679094fkg.38.2009.11.26.22.55.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 22:55:19 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.307.gd603
In-Reply-To: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133863>

Inspired by the coloring of quilt.

Introduce a separate color for the hunk comment part, i.e. the current function.
Whitespace between hunk header and hunk comment is now printed as plain.

The current default is plain.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 Documentation/config.txt |    8 +++---
 combine-diff.c           |    5 +++-
 diff.c                   |   64 +++++++++++++++++++++++++++++++++++++++++++--
 diff.h                   |    1 +
 t/t4034-diff-words.sh    |    4 ++-
 5 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a8e0876..a1e36d7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -635,10 +635,10 @@ color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
 	of `plain` (context text), `meta` (metainformation), `frag`
-	(hunk header), `old` (removed lines), `new` (added lines),
-	`commit` (commit headers), or `whitespace` (highlighting
-	whitespace errors). The values of these variables may be specified as
-	in color.branch.<slot>.
+	(hunk header), 'func' (function in hunk header), `old` (removed lines),
+	`new` (added lines), `commit` (commit headers), or `whitespace`
+	(highlighting whitespace errors). The values of these variables may be
+	specified as in color.branch.<slot>.
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
diff --git a/combine-diff.c b/combine-diff.c
index 5b63af1..6162691 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -524,6 +524,7 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 	int i;
 	unsigned long lno = 0;
 	const char *c_frag = diff_get_color(use_color, DIFF_FRAGINFO);
+	const char *c_func = diff_get_color(use_color, DIFF_FUNCINFO);
 	const char *c_new = diff_get_color(use_color, DIFF_FILE_NEW);
 	const char *c_old = diff_get_color(use_color, DIFF_FILE_OLD);
 	const char *c_plain = diff_get_color(use_color, DIFF_PLAIN);
@@ -588,7 +589,9 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 				    comment_end = i;
 			}
 			if (comment_end)
-				putchar(' ');
+				printf("%s%s %s%s", c_reset,
+						    c_plain, c_reset,
+						    c_func);
 			for (i = 0; i < comment_end; i++)
 				putchar(hunk_comment[i]);
 		}
diff --git a/diff.c b/diff.c
index 0d7f5ea..fd999fb 100644
--- a/diff.c
+++ b/diff.c
@@ -39,6 +39,7 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_GREEN,	/* NEW */
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
+	GIT_COLOR_NORMAL,	/* FUNCINFO */
 };
 
 static void diff_filespec_load_driver(struct diff_filespec *one);
@@ -60,6 +61,8 @@ static int parse_diff_color_slot(const char *var, int ofs)
 		return DIFF_COMMIT;
 	if (!strcasecmp(var+ofs, "whitespace"))
 		return DIFF_WHITESPACE;
+	if (!strcasecmp(var+ofs, "func"))
+		return DIFF_FUNCINFO;
 	die("bad config variable '%s'", var);
 }
 
@@ -344,6 +347,63 @@ static void emit_add_line(const char *reset,
 	}
 }
 
+static void emit_hunk_line(struct emit_callback *ecbdata,
+			   const char *line, int len)
+{
+	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
+	const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
+	const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
+	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
+	const char *orig_line = line;
+	int orig_len = len;
+	const char *frag_start;
+	int frag_len;
+	const char *part_end = NULL;
+	int part_len = 0;
+
+	/* determine length of @ */
+	while (part_len < len && line[part_len] == '@')
+		part_len++;
+
+	/* find end of frag, (Ie. find second @@) */
+	part_end = memmem(line + part_len, len - part_len,
+			  line, part_len);
+	if (!part_end)
+		return emit_line(ecbdata->file, frag, reset, line, len);
+	/* calculate total length of frag */
+	part_len = (part_end + part_len) - line;
+
+	/* remember frag part, we emit only if we find a space separator */
+	frag_start = line;
+	frag_len = part_len;
+
+	/* consume hunk header */
+	len -= part_len;
+	line += part_len;
+
+	/*
+	 * for empty reminder or empty space sequence (exclusive any newlines
+	 * or carriage returns) emit complete original line as FRAGINFO
+	 */
+	if (!len || !(part_len = strspn(line, " \t")))
+		return emit_line(ecbdata->file, frag, reset,
+				 orig_line, orig_len);
+
+	/* now emit the hunk header as FRAGINFO */
+	emit_line(ecbdata->file, frag, reset, frag_start, frag_len);
+
+	/* print whitespace sep as PLAIN */
+	emit_line(ecbdata->file, plain, reset, line, part_len);
+
+	/* consume whitespace sep */
+	len -= part_len;
+	line += part_len;
+
+	/* print reminder as FUNCINFO */
+	if (len)
+		emit_line(ecbdata->file, func, reset, line, len);
+}
+
 static struct diff_tempfile *claim_diff_tempfile(void) {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
@@ -781,9 +841,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			diff_words_flush(ecbdata);
 		len = sane_truncate_line(ecbdata, line, len);
 		find_lno(line, ecbdata);
-		emit_line(ecbdata->file,
-			  diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
-			  reset, line, len);
+		emit_hunk_line(ecbdata, line, len);
 		if (line[len-1] != '\n')
 			putc('\n', ecbdata->file);
 		return;
diff --git a/diff.h b/diff.h
index 2740421..15fcecd 100644
--- a/diff.h
+++ b/diff.h
@@ -130,6 +130,7 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
+	DIFF_FUNCINFO = 8,
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 21db6e9..186eff8 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -8,6 +8,7 @@ test_expect_success setup '
 
 	git config diff.color.old red
 	git config diff.color.new green
+	git config diff.color.func magenta
 
 '
 
@@ -16,6 +17,7 @@ decrypt_color () {
 		-e 's/.\[1m/<WHITE>/g' \
 		-e 's/.\[31m/<RED>/g' \
 		-e 's/.\[32m/<GREEN>/g' \
+		-e 's/.\[35m/<MAGENTA>/g' \
 		-e 's/.\[36m/<BROWN>/g' \
 		-e 's/.\[m/<RESET>/g'
 }
@@ -70,7 +72,7 @@ cat > expect <<\EOF
 <WHITE>+++ b/post<RESET>
 <BROWN>@@ -1 +1 @@<RESET>
 <RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
-<BROWN>@@ -3,0 +4,4 @@ a = b + c<RESET>
+<BROWN>@@ -3,0 +4,4 @@<RESET> <RESET><MAGENTA>a = b + c<RESET>
 
 <GREEN>aa = a<RESET>
 
-- 
tg: (ad7ace7..) bw/func-color (depends on: master)
