From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 3/5] mailmap: Add mailmap structure to rev_info and pp
Date: Tue, 11 Dec 2012 23:21:31 +0100
Message-ID: <1355264493-8298-4-git-send-email-apelisse@gmail.com>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Rich Midwinter <rich.midwinter@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYDc-0001RM-Pt
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab2LKWWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:22:12 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:46325 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2LKWWL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:22:11 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq7so2478312wib.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 14:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=u9xCBwR9sj840S6Nt83gTLX493o2xS2kwKZKMhTdD2Q=;
        b=lrjkMS7xxbcPHuuFGnwgHrifQGXSeRvmRFuzZonyeyLnFL005fte/aCh6rnOqotqwg
         66IM0shcPS2yFvH8bStM137Dnp8i9s3hXDOA7//buT5Fx39J4Wpp5//93zCp9KEuglVk
         dZWY/uNdhzWuFBhPAFMCWazajmaz5lfZAaspQ6krFII+ip+RJDSjOpoTWy0tmL+BQF2O
         xaxmKZVOW+8/TuMqTe2PMKQwj5Q/zp5jq2CQIWScvHZpbuxl9C3GEYAc8zTNCXajXre8
         8RzZdcnHmr5tS5nNV0DWzbI806pAyVqnzl2fHVDQJjRSmxft13Cs7yjLFHPmV54Hp8Wb
         PDNA==
Received: by 10.180.92.74 with SMTP id ck10mr14435316wib.9.1355264530723;
        Tue, 11 Dec 2012 14:22:10 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id ec3sm610033wib.10.2012.12.11.14.22.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2012 14:22:10 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.5.g7e0651a
In-Reply-To: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211305>

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
1.8.1.rc1.5.g7e0651a
