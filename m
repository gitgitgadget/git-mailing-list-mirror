From: Harry Jeffery <harry@exec64.co.uk>
Subject: [PATCH v2] pretty: add %D format specifier
Date: Mon, 15 Sep 2014 22:50:37 +0100
Message-ID: <54175F2D.3070209@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 23:50:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeAP-0000y9-U3
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 23:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983AbaIOVu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 17:50:27 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:63696 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916AbaIOVuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 17:50:25 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so4627961wgh.12
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 14:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=IIten56zpmPuWFBYcxndQOP0+SvYIFE2HyTBWQUgRTk=;
        b=BqWgBQ5BkT7BMX7x35NTqNUnlJsDfPVunMRU4sSoBJtJF91Mjz4x4FeHDpe77wnIs3
         I2TiAwpcSgGhzrNOmq+a5vo5GDrii4la32pjkQIYIYAwHSiCOYA0Qu7PhlGN32FADj2w
         hFtmvgedd7wGvBGiyWi/clN/8/Cu86COsebOWm7HuHRazZIN9gqUPMNz7pqS6sGoNf5T
         IGmtwApEXjDge4EbIIKS6xrarEDpONI4QjVJLP0L0RcY5rSnNr4BYfEBQIqsSpZJuvck
         rMonyIuasZ7b0Xk+0h+v2zt/mPOq8GBOqagZjPwDMJUB+OmYX1lxv2uWXW93TC3jOJWu
         63aQ==
X-Gm-Message-State: ALoCoQn//u/9P+sL+tazDQ6Mi6fTTOhZ048472DVxQ3NYtrtFC02wGTqAMyKi8t5d+LP614PJW5s
X-Received: by 10.180.78.226 with SMTP id e2mr26612349wix.68.1410817821092;
        Mon, 15 Sep 2014 14:50:21 -0700 (PDT)
Received: from [192.168.0.6] (cpc69047-oxfd25-2-0-cust267.4-3.cable.virginm.net. [81.109.93.12])
        by mx.google.com with ESMTPSA id bj7sm16151308wjc.33.2014.09.15.14.50.19
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 14:50:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257083>

Add a new format specifier, '%D' that is identical in behaviour to '%d',
except that it does not include the ' (' prefix or ')' suffix provided
by '%d'.

Signed-off-by: Harry Jeffery <harry@exec64.co.uk>
---
  Documentation/pretty-formats.txt |  6 ++++--
  log-tree.c                       | 24 +++++++++++++-----------
  log-tree.h                       |  8 +++++++-
  pretty.c                         |  4 ++++
  t/t4205-log-pretty-formats.sh    | 11 +++++++++++
  5 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/Documentation/pretty-formats.txt 
b/Documentation/pretty-formats.txt
index eac7909..2632e1a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -128,6 +128,7 @@ The placeholders are:
  - '%ct': committer date, UNIX timestamp
  - '%ci': committer date, ISO 8601 format
  - '%d': ref names, like the --decorate option of linkgit:git-log[1]
+- '%D': ref names without the " (", ")" wrapping.
  - '%e': encoding
  - '%s': subject
  - '%f': sanitized subject line, suitable for a filename
@@ -182,8 +183,9 @@ The placeholders are:
  NOTE: Some placeholders may depend on other options given to the
  revision traversal engine. For example, the `%g*` reflog options will
  insert an empty string unless we are traversing reflog entries (e.g., by
-`git log -g`). The `%d` placeholder will use the "short" decoration
-format if `--decorate` was not already provided on the command line.
+`git log -g`). The `%d` and `%D` placeholders will use the "short"
+decoration format if `--decorate` was not already provided on the command
+line.

  If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
  is inserted immediately before the expansion if and only if the
diff --git a/log-tree.c b/log-tree.c
index 95e9b1d..61d1dea 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -179,14 +179,16 @@ static void show_children(struct rev_info *opt, 
struct commit *commit, int abbre
  }

  /*
- * The caller makes sure there is no funny color before
- * calling. format_decorations makes sure the same after return.
+ * The caller makes sure there is no funny color before calling.
+ * format_decorations_extended makes sure the same after return.
   */
-void format_decorations(struct strbuf *sb,
+void format_decorations_extended(struct strbuf *sb,
  			const struct commit *commit,
-			int use_color)
+			int use_color,
+			const char *prefix,
+			const char *separator,
+			const char *suffix)
  {
-	const char *prefix;
  	struct name_decoration *decoration;
  	const char *color_commit =
  		diff_get_color(use_color, DIFF_COMMIT);
@@ -196,20 +198,20 @@ void format_decorations(struct strbuf *sb,
  	decoration = lookup_decoration(&name_decoration, &commit->object);
  	if (!decoration)
  		return;
-	prefix = " (";
+	strbuf_addstr(sb, color_commit);
+	strbuf_addstr(sb, prefix);
  	while (decoration) {
-		strbuf_addstr(sb, color_commit);
-		strbuf_addstr(sb, prefix);
  		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
  		if (decoration->type == DECORATION_REF_TAG)
  			strbuf_addstr(sb, "tag: ");
  		strbuf_addstr(sb, decoration->name);
  		strbuf_addstr(sb, color_reset);
-		prefix = ", ";
+		strbuf_addstr(sb, color_commit);
+		if (decoration->next)
+			strbuf_addstr(sb, separator);
  		decoration = decoration->next;
  	}
-	strbuf_addstr(sb, color_commit);
-	strbuf_addch(sb, ')');
+	strbuf_addstr(sb, suffix);
  	strbuf_addstr(sb, color_reset);
  }

diff --git a/log-tree.h b/log-tree.h
index d6ecd4d..b26160c 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,7 +13,13 @@ int log_tree_diff_flush(struct rev_info *);
  int log_tree_commit(struct rev_info *, struct commit *);
  int log_tree_opt_parse(struct rev_info *, const char **, int);
  void show_log(struct rev_info *opt);
-void format_decorations(struct strbuf *sb, const struct commit *commit, 
int use_color);
+void format_decorations_extended(struct strbuf *sb, const struct commit 
*commit,
+			     int use_color,
+			     const char *prefix,
+			     const char *separator,
+			     const char *suffix);
+#define format_decorations(strbuf, commit, color) \
+			     format_decorations_extended((strbuf), (commit), (color), " (", 
", ", ")")
  void show_decorations(struct rev_info *opt, struct commit *commit);
  void log_write_email_headers(struct rev_info *opt, struct commit *commit,
  			     const char **subject_p,
diff --git a/pretty.c b/pretty.c
index 44b9f64..46d65b9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1197,6 +1197,10 @@ static size_t format_commit_one(struct strbuf 
*sb, /* in UTF-8 */
  		load_ref_decorations(DECORATE_SHORT_REFS);
  		format_decorations(sb, commit, c->auto_color);
  		return 1;
+	case 'D':
+		load_ref_decorations(DECORATE_SHORT_REFS);
+		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
+		return 1;
  	case 'g':		/* reflog info */
  		switch(placeholder[1]) {
  		case 'd':	/* reflog selector */
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index de0cc4a..38148c1 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -457,4 +457,15 @@ EOF
  	test_cmp expected actual1
  '

+test_expect_success 'clean log decoration' '
+	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
+	cat <<EOF >expected &&
+$head1 tag: refs/tags/tag2
+$head2 tag: refs/tags/message-one
+$old_head1 tag: refs/tags/message-two
+EOF
+	sort actual >actual1 &&
+	test_cmp expected actual1
+'
+
  test_done
-- 
2.1.0
