From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 4/6] Teach --d to "git commit"
Date: Wed,  5 Aug 2009 17:51:44 +0800
Message-ID: <1249465906-3940-5-git-send-email-ayiehere@gmail.com>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-2-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-3-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-4-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYdFR-0005iz-KZ
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934056AbZHEJ5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933810AbZHEJ5O
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:57:14 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:65447 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933297AbZHEJ5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:57:13 -0400
Received: by mail-pz0-f196.google.com with SMTP id 34so3444152pzk.4
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TePGxL0H39aa4gVXMtWbR2PTuDoyrGWr/VOxsPFfNO0=;
        b=WdIwKsOrqiOPkYS4JnLIilWJb25IGuBwJWifZ63Ia3NQMMQP9Ol1KCqXkCwJuyP2o5
         MHKMjBCp2bATu91aYiP+QkJchsCnzFuStHhrbfe0iE+Is8DGAdOkUYdOejMkTMJlCrQb
         owlvZMR8DNgeJicUfF6pqmEq/9lrF7ECwxc8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k6SMESnvuqvWMdJvyruml4R6wlqhN2cjfnzJAWFykd7jQHeeZdjgTF7Htw9OAzf0gE
         nkFq1SzTuF3zfp9bD3W9TROwUp3J8jXVVJAtau5E7zDXGPOjmTuSy3uTKoQxRdzF54WK
         zgCguWcCYjJHEqGOgL7J/Cr0wo+TDuqi+EcgE=
Received: by 10.114.202.11 with SMTP id z11mr11343168waf.192.1249465821609;
        Wed, 05 Aug 2009 02:50:21 -0700 (PDT)
Received: from localhost.localdomain ([115.132.128.228])
        by mx.google.com with ESMTPS id k14sm13017099waf.25.2009.08.05.02.50.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 02:50:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.13.ge6580
In-Reply-To: <1249465906-3940-4-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124890>

---
 builtin-commit.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 4bcce06..a0bda66 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -50,7 +50,7 @@ static const char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
-static int all, edit_flag, also, interactive, only, amend, signoff;
+static int all, edit_flag, also, interactive, only, amend, signoff, id_flag;
 static int quiet, verbose, no_verify, allow_empty;
 static char *untracked_files_arg;
 /*
@@ -96,6 +96,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
+	OPT_BOOLEAN('d', "id", &id_flag, "show file id"),
 
 	OPT_GROUP("Commit contents options"),
 	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
@@ -352,6 +353,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 		s.reference = "HEAD^1";
 	}
 	s.verbose = verbose;
+	s.show_file_id = id_flag;
 	s.untracked = (show_untracked_files == SHOW_ALL_UNTRACKED_FILES);
 	s.index_file = index_file;
 	s.fp = fp;
-- 
1.6.4.13.ge6580
