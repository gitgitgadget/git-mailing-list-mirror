From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2 4/7] mailmap: Add mailmap structure to rev_info and pp
Date: Sat, 15 Dec 2012 19:05:51 +0100
Message-ID: <1355594754-27589-5-git-send-email-apelisse@gmail.com>
References: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 19:06:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw8E-0001Hn-Nh
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab2LOSGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:06:12 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:50234 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab2LOSGH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:06:07 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1888853wgb.1
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 10:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UaD7k19R5PBAkSOUD87UAtMq2l5QDjJu+t/zvltLim0=;
        b=LWAcItSZ60wcrT55VLuDabnmSUI/o5M3hAmpx3qynDFFGHtO95XA/nqDjyuHsMwHx+
         69hngMONcIaqPP+w0V0UJvXNOZlyk50vQCgHVqzNVjh1jtw/v/7PZtIKzdYHTCKuvvG1
         ODoMPKwfiVF3grOZapukQV1YQFS4wFhef+5OIcb5EEP1kFW7NCyBHw3C/3sOtltKie0x
         z3wGoFKmT63+CV8CvMP8YXcTGSoHML8dTzjPjrFhXoGv7cW35LLrMjizS9hQ3f1o5g2c
         nyAAry6LtnNTXwH/ePcBY2kN8pMD7fTAvnr6LHdDXkRdewHUOB41LwfMBUnV959vDFfb
         8lUA==
Received: by 10.180.106.34 with SMTP id gr2mr8294135wib.18.1355594766201;
        Sat, 15 Dec 2012 10:06:06 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bd7sm3570983wib.8.2012.12.15.10.06.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 10:06:05 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211549>

the mailmap string_list structure filled with mailmap
information is passed along from rev_info to pretty_print_context
to provide mailmap information to pretty print each commits
with the correct username and email.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 commit.h   |    1 +
 log-tree.c |    1 +
 revision.h |    1 +
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
1.7.9.5
