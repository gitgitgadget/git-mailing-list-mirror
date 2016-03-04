From: "Sidhant Sharma [:tk]" <tigerkid001@gmail.com>
Subject: [PATCH] stripspace: add --line-count flag
Date: Sat,  5 Mar 2016 00:08:43 +0530
Message-ID: <1457116723-20206-1-git-send-email-tigerkid001@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 19:39:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abud2-0003wa-DQ
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 19:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759598AbcCDSjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 13:39:03 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36606 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489AbcCDSjC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 13:39:02 -0500
Received: by mail-pa0-f45.google.com with SMTP id fi3so37033568pac.3
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 10:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=rGJSDszYYE65MUsSejw3Fzja+CRfNYZnh4u0jclw0lU=;
        b=Mw9WhlmOWBaXlQnPQaoDs+G9Yg2xe6C+EOHYvtFanPiv5nc/Dpz1y823UnhKZR7Qwj
         HXuOZ9j9bLGgGCHquZQjBb0i1wi2y6ZPNu8y+1XVGzrSjlgo4cV58pKizREmThpaIFRz
         J9Bzex2NDntAF2grfrVjPAD9vryvDn9ek/wU0fUi0dPbReZ52ArxerE9gCtrCPSWsJlb
         zhRS2ac1nO6jz2ddMxVvWmIJv2RtNQOTLOBJZISLYknqvB3zz+qTfnmEBp1QaQx+9vX0
         zNXCAQuLIMhmwTzXT41Yi3lTXlum2grXq4fbN13VbwNQP8PePvp4Fi0gePa45BNFKnX8
         EFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=rGJSDszYYE65MUsSejw3Fzja+CRfNYZnh4u0jclw0lU=;
        b=lcXeoY8R95pq96rCj0a5qnw6IHPH583gah9RtLpg8holV4Gws8XiqZLHtjZ690ziSZ
         l6bN8LpAr8v2RVZuAZwQ4dSrlUBticXli4J5Qz+H+Qq9nXCw1k3xJAjG8WDwjQZV4N6o
         5kjl2+Q11+p5iKBKSe9lHM0pdJfu7KKBel75e6MbINok4rn1oXUJ9uoXIJweVPByLVup
         JSNqCN8VUVgp0QTo/7uctSKlcz5pqaIFpbdSbveaBAHzjTgBHy+INsZrs6lNSQ2IiXAv
         4islEsaxGwYVuZlrXE5X5Itykh8vzMNgoJ2x88w0hPgMIbdqJ6zRCPPvn5NVGbUQzLr1
         8IeQ==
X-Gm-Message-State: AD7BkJKAY4BJYYpHhyQ+HiBWqRIV0KMISGx9WffBmDYpprXQlSvfPvagIvi7jgaQDE8XOw==
X-Received: by 10.66.244.233 with SMTP id xj9mr14217625pac.19.1457116741352;
        Fri, 04 Mar 2016 10:39:01 -0800 (PST)
Received: from localhost.localdomain ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id u5sm7147442pfi.15.2016.03.04.10.38.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 10:39:00 -0800 (PST)
X-Mailer: git-send-email 2.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288267>

When used, this flag outputs number of lines after stripspace has removed trailing whitespace.
With `--line-count`, git-rebase--interactive.sh need not rely on `wc -l` for line
count.

Signed-off-by: Sidhant Sharma [:tk] <tigerkid001@gmail.com>
---

 This the first version of the patch for the small project listed here:
 https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#implement_.27--count-lines.27_in_.27git_stripspace.27

 builtin/stripspace.c       | 22 +++++++++++++++++++++-
 git-rebase--interactive.sh |  6 +++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 15e716e..e08da03 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -13,22 +13,38 @@ static void comment_lines(struct strbuf *buf)
 	free(msg);
 }

+static void count_lines(struct strbuf *buf)
+{
+	size_t len = 0;
+	int i;
+
+	for (i = 0; i < buf->len; i++)
+		if (buf->buf[i] == '\n')
+			len++;
+
+	sprintf(buf->buf, "%zu", len);
+	buf->len = strlen(buf->buf);
+}
+
 static const char * const stripspace_usage[] = {
 	N_("git stripspace [-s | --strip-comments]"),
 	N_("git stripspace [-c | --comment-lines]"),
+	N_("git stripspace [-l | --line-count]"),
 	NULL
 };

 enum stripspace_mode {
 	STRIP_DEFAULT = 0,
 	STRIP_COMMENTS,
-	COMMENT_LINES
+	COMMENT_LINES,
+	LINE_COUNT
 };

 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	enum stripspace_mode mode = STRIP_DEFAULT;
+	int count = 0;

 	const struct option options[] = {
 		OPT_CMDMODE('s', "strip-comments", &mode,
@@ -37,6 +53,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('c', "comment-lines", &mode,
 			    N_("prepend comment character and space to each line"),
 			    COMMENT_LINES),
+		OPT_BOOL('l', "line-count", &count, N_("count number of lines")),
 		OPT_END()
 	};

@@ -55,6 +72,9 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 	else
 		comment_lines(&buf);

+	if (count)
+		count_lines(&buf);
+
 	write_or_die(1, buf.buf, buf.len);
 	strbuf_release(&buf);
 	return 0;
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c0cfe88..e8bef37 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -120,9 +120,9 @@ mark_action_done () {
 	sed -e 1q < "$todo" >> "$done"
 	sed -e 1d < "$todo" >> "$todo".new
 	mv -f "$todo".new "$todo"
-	new_count=$(git stripspace --strip-comments <"$done" | wc -l)
+	new_count=$(git stripspace --strip-comments --line-count <"$done")
 	echo $new_count >"$msgnum"
-	total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
+	total=$(($new_count + $(git stripspace --strip-comments --line-count <"$todo")))
 	echo $total >"$end"
 	if test "$last_count" != "$new_count"
 	then
@@ -1251,7 +1251,7 @@ test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
 test -n "$cmd" && add_exec_commands "$todo"

-todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
+todocount=$(git stripspace --strip-comments --line-count <"$todo")
 todocount=${todocount##* }

 cat >>"$todo" <<EOF
--
2.7.2
