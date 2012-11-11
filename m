From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] submodule: display summary header in bold
Date: Sun, 11 Nov 2012 22:29:06 +0530
Message-ID: <1352653146-3932-4-git-send-email-artagnon@gmail.com>
References: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:59:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXasn-00058n-1s
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab2KKQ7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:59:25 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60413 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab2KKQ7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:59:23 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so3774268pad.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 08:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Huc6x3oqxbZrXG2Rke+s6fiapa1a+Aljl5fAFIQFIbk=;
        b=bX7VqNMYscy4XdpaXwEPKq/LUMGCCqDQp2G5p3ni8n0Ozktnr8//lSTGL4pwwa5e+m
         rCxjqatiR3YMeBITt6qvZa3/P8IL3F+EHF6vmvMxs44geqyi3NBfKXKbOTpkxsjLqHVI
         s+aTrSXCKjsI+m5HlHQ2hBsswlLw3yTF+HplbaQ8R78ARai8X9XuEcL00JogE3Zyb3+l
         B/378i46VqZJRzcy3ugY0he4VTi2xtha8TyiGHmYeoiJbIOKhcYctaRQlmMHJyZ17Yxx
         whVPpQ+JIrCiqUdX2T+l1UbL8aMc3tNtWvZH6z9/ajKTGuvNZdp1mmIOE6m3yfvCOSDo
         wCjA==
Received: by 10.68.135.42 with SMTP id pp10mr51254430pbb.159.1352653163274;
        Sun, 11 Nov 2012 08:59:23 -0800 (PST)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id s1sm2824079paz.0.2012.11.11.08.59.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 08:59:22 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209412>

Currently, 'git diff --submodule' displays output with a bold diff
header for non-submodules.  So this part is in bold:

    diff --git a/file1 b/file1
    index 30b2f6c..2638038 100644
    --- a/file1
    +++ b/file1

For submodules, the header looks like this:

    Submodule submodule1 012b072..248d0fd:

Unfortunately, it's easy to miss in the output because it's not bold.
Change this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 diff.c      |    2 +-
 submodule.c |    8 ++++----
 submodule.h |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index b486070..51c0d6c 100644
--- a/diff.c
+++ b/diff.c
@@ -2267,7 +2267,7 @@ static void builtin_diff(const char *name_a,
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one ? one->path : two->path,
 				one->sha1, two->sha1, two->dirty_submodule,
-				del, add, reset);
+				set, del, add, reset);
 		return;
 	}
 
diff --git a/submodule.c b/submodule.c
index e3e0b45..c10182e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -258,7 +258,7 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
-		unsigned dirty_submodule,
+		unsigned dirty_submodule, const char *set,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
@@ -292,15 +292,15 @@ void show_submodule_summary(FILE *f, const char *path,
 		return;
 	}
 
-	strbuf_addf(&sb, "Submodule %s %s..", path,
+	strbuf_addf(&sb, "%sSubmodule %s %s..", set, path,
 			find_unique_abbrev(one, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
 	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
 	if (message)
-		strbuf_addf(&sb, " %s\n", message);
+		strbuf_addf(&sb, " %s%s\n", message, reset);
 	else
-		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
+		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
 	fwrite(sb.buf, sb.len, 1, f);
 
 	if (!message) {
diff --git a/submodule.h b/submodule.h
index f2e8271..997fd06 100644
--- a/submodule.h
+++ b/submodule.h
@@ -20,7 +20,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
-		unsigned dirty_submodule,
+		unsigned dirty_submodule, const char *set,
 		const char *del, const char *add, const char *reset);
 void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
-- 
1.7.8.1.362.g5d6df.dirty
