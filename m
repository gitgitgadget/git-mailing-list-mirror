From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/2] pretty: support right alignment
Date: Thu, 20 Sep 2012 21:38:03 +0700
Message-ID: <20120920143803.GA9527@lanh>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com>
 <1348143976-4506-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 16:38:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEhtG-00053T-3c
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 16:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab2ITOh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 10:37:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44115 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab2ITOh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 10:37:56 -0400
Received: by pbbrr4 with SMTP id rr4so344769pbb.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=80rRTPfxUoq0tD+7jjRvFGXoT9tSTVohbpbKLeYQGh4=;
        b=e5LRd0wOWOY8Xen5AwsUVGR4p48ShlIQPEs6UA0x9XFHAotimI/JXipMSV40VpHfq0
         0v3ivQs5OvRl45xOmpiYz/JmLCVdU/DdCm3sZsgIeSOrtNuq6Skaj1nyfBXTZ4Y1SPSR
         PtG/f3EHyT70WSeD3k8JKi/OiRswQ2MxmlPU8HCAOMfFaGRMWzyr+hjLZ1rkX0OiL2yL
         TOVPqA+6GoOfZCsUiNGV8hha2b5K28R2wgBMsKtOH0mu8csBP8RXqlFfqSl2ASIlg4Ch
         WuGCBgYHSau/JEUCT2uqalDdQc9Vqpd+0cE2vQ7jJMartUo9yLr9Xnyo5h+h6/z9LCdS
         RTIw==
Received: by 10.68.131.5 with SMTP id oi5mr7363616pbb.56.1348151875841;
        Thu, 20 Sep 2012 07:37:55 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id m5sm2537375pax.10.2012.09.20.07.37.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2012 07:37:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Sep 2012 21:38:03 +0700
Content-Disposition: inline
In-Reply-To: <1348143976-4506-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206049>

And this is a for-fun patch that adds %| to right align everything
after that. I'm ignoring problems with line wrapping, i18n and so
on. "%C+%h %s%|%d" looks quite nice. I'm not sure how much useful it
is beyond --oneline though. It looks something like this

cc543b2 pretty: support placeholders %C+ and %C-                                                (HEAD, master)
da6001e pretty: share code between format_decoration and show_decorations
b0576a6 Update draft release notes to 1.8.0                                       (origin/master, origin/HEAD)
3d7535e Merge branch 'jc/maint-log-grep-all-match'
06e211a Merge branch 'jc/make-static'
8db3865 Merge branch 'pw/p4-submit-conflicts'
3387423 Merge branch 'mv/cherry-pick-s'
d71abd9 Merge branch 'nd/fetch-status-alignment'
3c7d509 Sync with 1.7.12.1
304b7d9 Git 1.7.12.1                                                            (tag: v1.7.12.1, origin/maint)
39e2e02 Merge branch 'er/doc-fast-import-done' into maint
8ffc331 Merge branch 'jk/config-warn-on-inaccessible-paths' into maint
01f7d7f Doc: Improve shallow depth wording
8093ae8 Documentation/git-filter-branch: Move note about effect of removing commits

-- 8< --
diff --git a/pretty.c b/pretty.c
index b1cec71..6e96f83 100644
--- a/pretty.c
+++ b/pretty.c
@@ -624,6 +624,7 @@ struct format_commit_context {
 	unsigned commit_message_parsed:1;
 	unsigned commit_signature_parsed:1;
 	unsigned use_color:1;
+	unsigned right_alignment:1;
 	struct {
 		char *gpg_output;
 		char good_bad;
@@ -645,6 +646,8 @@ struct format_commit_context {
 	struct chunk abbrev_tree_hash;
 	struct chunk abbrev_parent_hashes;
 	size_t wrap_start;
+
+	struct strbuf *right_sb;
 };
 
 static int add_again(struct strbuf *sb, struct chunk *chunk)
@@ -944,6 +947,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			return end - placeholder + 1;
 		} else
 			return 0;
+
+	case '|':
+		c->right_alignment = 1;
+		return 1;
 	}
 
 	/* these depend on the commit */
@@ -1099,9 +1106,44 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	return 0;	/* unknown placeholder */
 }
 
+static void right_align(struct strbuf *sb,
+			struct format_commit_context *c,
+			int flush)
+{
+	const char *p;
+	int llen, rlen, len, total = term_columns() - 1;
+	if (!c->right_alignment)
+		return;
+	p = strchr(c->right_sb->buf, '\n');
+	if (!p && flush)
+		p = c->right_sb->buf + c->right_sb->len;
+	if (!p)
+		return;
+
+	c->right_alignment = 0;
+	len = p - c->right_sb->buf;
+	if (!len)
+		return;
+	if (total > 110)
+		total = 110;
+	rlen = utf8_strnwidth(c->right_sb->buf, len);
+	p = strrchr(sb->buf, '\n');
+	if (!p)
+		p = sb->buf;
+	else
+		p++;
+	llen = utf8_strwidth(p);
+	strbuf_addf(sb, "%*s",
+		    total - llen + (len - rlen),
+		    c->right_sb->buf);
+	strbuf_reset(c->right_sb);
+}
+
 static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 				 void *context)
 {
+	struct format_commit_context *c = context;
+	struct strbuf *real_sb;
 	int consumed;
 	size_t orig_len;
 	enum {
@@ -1127,10 +1169,13 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	if (magic != NO_MAGIC)
 		placeholder++;
 
+	if (c->right_alignment && c->right_sb) {
+		real_sb = sb;
+		sb = c->right_sb;
+	}
+
 	orig_len = sb->len;
 	consumed = format_commit_one(sb, placeholder, context);
-	if (magic == NO_MAGIC)
-		return consumed;
 
 	if ((orig_len == sb->len) && magic == DEL_LF_BEFORE_EMPTY) {
 		while (sb->len && sb->buf[sb->len - 1] == '\n')
@@ -1141,7 +1186,13 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
 			strbuf_insert(sb, orig_len, " ", 1);
 	}
-	return consumed + 1;
+
+	if (real_sb)
+		right_align(real_sb, c, 0);
+
+	if (magic != NO_MAGIC)
+		consumed++;
+	return consumed;
 }
 
 static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
@@ -1180,12 +1231,14 @@ void format_commit_message(const struct commit *commit,
 	struct format_commit_context context;
 	static const char utf8[] = "UTF-8";
 	const char *output_enc = pretty_ctx->output_encoding;
+	struct strbuf right_sb = STRBUF_INIT;
 
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
 	context.pretty_ctx = pretty_ctx;
 	context.wrap_start = sb->len;
 	context.message = commit->buffer;
+	context.right_sb = &right_sb;
 	if (output_enc) {
 		char *enc = get_header(commit, "encoding");
 		if (strcmp(enc ? enc : utf8, output_enc)) {
@@ -1197,8 +1250,11 @@ void format_commit_message(const struct commit *commit,
 	}
 
 	strbuf_expand(sb, format, format_commit_item, &context);
+	if (context.right_alignment)
+		right_align(sb, &context, 1);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
 
+	strbuf_release(&right_sb);
 	if (context.message != commit->buffer)
 		free(context.message);
 	free(context.signature.gpg_output);
diff --git a/utf8.c b/utf8.c
index a544f15..68ca0b4 100644
--- a/utf8.c
+++ b/utf8.c
@@ -9,6 +9,20 @@ struct interval {
   int last;
 };
 
+static size_t display_mode_esc_sequence_len(const char *s)
+{
+	const char *p = s;
+	if (*p++ != '\033')
+		return 0;
+	if (*p++ != '[')
+		return 0;
+	while (isdigit(*p) || *p == ';')
+		p++;
+	if (*p++ != 'm')
+		return 0;
+	return p - s;
+}
+
 /* auxiliary function for binary search in interval table */
 static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
 {
@@ -252,18 +266,25 @@ int utf8_width(const char **start, size_t *remainder_p)
  * string, assuming that the string is utf8.  Returns strlen() instead
  * if the string does not look like a valid utf8 string.
  */
-int utf8_strwidth(const char *string)
+int utf8_strnwidth(const char *string, int len)
 {
 	int width = 0;
 	const char *orig = string;
 
-	while (1) {
-		if (!string)
-			return strlen(orig);
-		if (!*string)
-			return width;
+	if (len == -1)
+		len = strlen(string);
+	while (string && string < orig + len) {
+		int skip;
+		while ((skip = display_mode_esc_sequence_len(string)))
+			string += skip;
 		width += utf8_width(&string, NULL);
 	}
+	return string ? width : len;
+}
+
+int utf8_strwidth(const char *string)
+{
+	return utf8_strnwidth(string, -1);
 }
 
 int is_utf8(const char *text)
@@ -303,20 +324,6 @@ static void strbuf_add_indented_text(struct strbuf *buf, const char *text,
 	}
 }
 
-static size_t display_mode_esc_sequence_len(const char *s)
-{
-	const char *p = s;
-	if (*p++ != '\033')
-		return 0;
-	if (*p++ != '[')
-		return 0;
-	while (isdigit(*p) || *p == ';')
-		p++;
-	if (*p++ != 'm')
-		return 0;
-	return p - s;
-}
-
 /*
  * Wrap the text, if necessary. The variable indent is the indent for the
  * first line, indent2 is the indent for all other lines.
diff --git a/utf8.h b/utf8.h
index 3c0ae76..1727405 100644
--- a/utf8.h
+++ b/utf8.h
@@ -4,6 +4,7 @@
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
 int utf8_width(const char **start, size_t *remainder_p);
+int utf8_strnwidth(const char *string, int len);
 int utf8_strwidth(const char *string);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
-- 8< --
