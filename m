From: Greg Price <price@MIT.EDU>
Subject: [PATCH 2/6] pretty: Add %D for script-friendly decoration
Date: Wed, 18 Nov 2009 18:22:17 -0500
Message-ID: <9d9e18b8c062380025f52a6ff992fae51a17f5d1.1309133817.git.greg@quora.com>
References: <cover.1309133817.git.greg@quora.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 02:42:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QazuR-0006H7-4g
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 02:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039Ab1F0AlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 20:41:15 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:51276 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755507Ab1F0Ajo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2011 20:39:44 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jun 2011 20:39:44 EDT
X-AuditID: 1209190d-b7bdeae0000004f8-55-4e07cfd2c2a1
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.DA.01272.2DFC70E4; Sun, 26 Jun 2011 20:33:22 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p5R0YfI1001610;
	Sun, 26 Jun 2011 20:34:41 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5R0Ye8m019005;
	Sun, 26 Jun 2011 20:34:41 -0400 (EDT)
In-Reply-To: <cover.1309133817.git.greg@quora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixG6nonvpPLufwb+rRhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFJdNSmpOZllqkb5dAlfG/fZDrAWHxCsebr3A3MA4SbiLkZNDQsBEYsOT
	fewQtpjEhXvr2boYuTiEBPYxStzefpMdwtnAKDF90kQWCOcLo8SG7/tZQVqEBNQlbrYdYoSw
	dSQmrnwMVMQBZFtJ9DyzhggbSjw5egdsA69AiMS7jb+ZQEo4BYwkXjYqwJTcv9DEBmKzCShI
	/Ji/jhnEFhFQk5jYdogFxGYWEJdYN/c82BgWAVWJd8/Wg9UICzhJ/H+0lWUCo+ACRoZVjLIp
	uVW6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYQSHHKcm7g/HdQaVDjAIcjEo8vI8S2P2E
	WBPLiitzDzFKcjApifKKAgNWiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvuzCgHG9KYmVValE+
	TEqag0VJnFfN+7+vkEB6YklqdmpqQWoRTFaGg0NJgjcIZKhgUWp6akVaZk4JQpqJgxNkOA/Q
	8FCQGt7igsTc4sx0iPwpRkUpcV5tkIQASCKjNA+uF5YSXjGKA70izCsIUsUDTCdw3a+ABjMB
	De67zAYyuCQRISXVwKjmXnHDLPCjiPcr/XAvK24/6wdaSjsyF6/V6Zn5K1S0x0ujdPaP+Kvr
	P5o4myp3+kbLRtls1L3y++aev93+229/WuO3O7X5xp7IuzcLvC3qYvT2hS3JnbdW8Raf9cmS
	2nMc/6fbMNlO89k99y3jxvXLVHgZd1p8U+lZfZ+n74VuKqeK+B6DT0osxRmJhlrM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176342>

When in a script or porcelain one wants to identify what refs point to
which commits in a series, the functionality of 'git log --decorate'
is extremely useful.  This is available with the %d format code in a
form optimized for humans, but for scripts a more raw format is better.
Make such a format available through a new format code %D.

Signed-off-by: Greg Price <price@mit.edu>
---
 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |   33 +++++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 561cc9f..217f11b 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -124,6 +124,7 @@ The placeholders are:
 - '%ct': committer date, UNIX timestamp
 - '%ci': committer date, ISO 8601 format
 - '%d': ref names, like the --decorate option of linkgit:git-log[1]
+- '%D': full ref names, like the --decorate=full option of linkgit:git-log[1]
 - '%e': encoding
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
diff --git a/pretty.c b/pretty.c
index f45eb54..0c7e723 100644
--- a/pretty.c
+++ b/pretty.c
@@ -776,21 +776,35 @@ static void parse_commit_message(struct format_commit_context *c)
 	c->commit_message_parsed = 1;
 }
 
-static void format_decoration(struct strbuf *sb, const struct commit *commit)
+
+static void format_decoration(struct strbuf *sb, const struct commit *commit,
+			      int decoration_style, const char *affixes[3])
 {
 	struct name_decoration *d;
-	const char *prefix = " (";
+	const char *affix = affixes[0];
 
-	load_ref_decorations(DECORATE_SHORT_REFS);
+	load_ref_decorations(decoration_style);
 	d = lookup_decoration(&name_decoration, &commit->object);
 	while (d) {
-		strbuf_addstr(sb, prefix);
-		prefix = ", ";
+		strbuf_addstr(sb, affix);
+		affix = affixes[1];
 		strbuf_addstr(sb, d->name);
 		d = d->next;
 	}
-	if (prefix[0] == ',')
-		strbuf_addch(sb, ')');
+	if (affix == affixes[1])
+		strbuf_addstr(sb, affixes[2]);
+}
+
+static void format_decoration_short(struct strbuf *sb, const struct commit *commit)
+{
+	const char *affixes[3] = {" (", ", ", ")"};
+	format_decoration(sb, commit, DECORATE_SHORT_REFS, affixes);
+}
+
+static void format_decoration_full(struct strbuf *sb, const struct commit *commit)
+{
+	const char *affixes[3] = {"", " ", ""};
+	format_decoration(sb, commit, DECORATE_FULL_REFS, affixes);
 }
 
 static void strbuf_wrap(struct strbuf *sb, size_t pos,
@@ -947,7 +961,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decoration(sb, commit);
+		format_decoration_short(sb, commit);
+		return 1;
+	case 'D':
+		format_decoration_full(sb, commit);
 		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
-- 
1.7.5.4
