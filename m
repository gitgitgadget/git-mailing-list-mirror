From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 05/10] mailmap: add mailmap structure to rev_info and pp
Date: Sat,  5 Jan 2013 22:26:41 +0100
Message-ID: <1357421206-5014-6-git-send-email-apelisse@gmail.com>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:28:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbHZ-0000ix-EJ
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab3AEV11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:27:27 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:44850 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab3AEV1T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:27:19 -0500
Received: by mail-wg0-f47.google.com with SMTP id dq11so8645208wgb.14
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uVA5CrTwxUQPb5Z/ck+rOHdsHbFzgjs3aIg0HWlhKv0=;
        b=fzsNCtr5qRo3Y1Il8JniTOYI2hHz6xCUpgHwK8bD9l9SLP5Tz5KFTu2t2ryvBHzdSp
         AH7nUbSqS0wfinuKRiktXEzSNm6PLoyoC6wCZHK6QGiEQfjV7fiS5ban1ZaegMg6O4A/
         /uaLOj7atXfFohtKAh8cYG2VtY7hqCOx2Mbjf3LsHJjXMI5d/uRL7qJCHK/l+K0Yhcii
         OQmqR7CttsG2VuaXAKIcze7eI/297wukB3kV7UNnRPKH3BeETJ64SwdhyA1SrHvkv/7j
         NKHJWwwlTG5yUFmNecmepmUEVT4ghKP69JEZVRahA62hQLyKEt6RA0y0vbUo82CiVvam
         QIJg==
X-Received: by 10.180.90.106 with SMTP id bv10mr3178799wib.12.1357421237911;
        Sat, 05 Jan 2013 13:27:17 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id t17sm5623711wiv.6.2013.01.05.13.27.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 13:27:17 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.15.g5ddde70
In-Reply-To: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212724>

the mailmap string_list structure filled with mailmap
information is passed along from rev_info to pretty_print_context
to provide mailmap information to pretty print each commits
with the correct username and email.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 commit.h   | 1 +
 log-tree.c | 1 +
 revision.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/commit.h b/commit.h
index b6ad8f3..7f8f987 100644
--- a/commit.h
+++ b/commit.h
@@ -89,6 +89,7 @@ struct pretty_print_context {
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
+	struct string_list *mailmap;
 };
 
 struct userformat_want {
diff --git a/log-tree.c b/log-tree.c
index 4f86def..92254fd 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -671,6 +671,7 @@ void show_log(struct rev_info *opt)
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
+	ctx.mailmap = opt->mailmap;
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/revision.h b/revision.h
index 059bfff..83a79f5 100644
--- a/revision.h
+++ b/revision.h
@@ -143,6 +143,7 @@ struct rev_info {
 	const char	*subject_prefix;
 	int		no_inline;
 	int		show_log_size;
+	struct string_list *mailmap;
 
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
-- 
1.7.12.4.3.g2036a08.dirty
