From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/14] apply: add --stage option
Date: Mon, 14 Oct 2013 17:29:21 -0500
Message-ID: <1381789769-9893-7-git-send-email-felipe.contreras@gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 00:36:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqkD-0007Do-0l
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169Ab3JNWgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:36:02 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45287 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150Ab3JNWgA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:36:00 -0400
Received: by mail-ob0-f174.google.com with SMTP id wm4so5298409obc.33
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jD5wzQWJ1KOkWo7cjHb42rVMetPlCmESWfYIrU26wMk=;
        b=ygKoZhfxjOvXdXt4ZHZ4nackiN9mf9hq6OmYLZ/4ALdwt0ybTsK7P5DGpVkIeFAjLn
         +kafVUvDeOYU1uSfJUx3lPN1Xbrn2er2GRxqVaY9CzjpZXd2wGT8vHoIrUY85yW9rHFo
         5tThpGGBsRPG9nWjvC2tF5F3Lel7KF+xOKe3uJHAhJo+liGkogkAaVRwgPBb5lt7NDDR
         ehIUNWliYslkB2lxSCKQV/lA6FtOzRiE8nVO0Pw0bB3MTZzzLXm/wmbI5iu1GJMpFIlT
         to5e35V8acWjhNy0/EM+P+/YUCpynRrnNJLgG/dSXCR0a5r2XQxeKKdEADatF9AXJM8A
         s6jQ==
X-Received: by 10.60.60.105 with SMTP id g9mr30105410oer.8.1381790160363;
        Mon, 14 Oct 2013 15:36:00 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm44531530obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:35:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236133>

Synonym for --index.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-apply.txt | 5 ++++-
 builtin/apply.c             | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f605327..8c047ef 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,7 +9,7 @@ git-apply - Apply a patch to files and/or to the index
 SYNOPSIS
 --------
 [verse]
-'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
+'git apply' [--stat] [--numstat] [--summary] [--check] [--index|--stage] [--3way]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
@@ -67,6 +67,9 @@ OPTIONS
 	up-to-date, it is flagged as an error.  This flag also
 	causes the index file to be updated.
 
+--stage::
+	Synonym for --index.
+
 --cached::
 	Apply a patch without touching the working tree. Instead take the
 	cached data, apply the patch, and store the result in the index
diff --git a/builtin/apply.c b/builtin/apply.c
index 50912c9..42b5a4b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4377,6 +4377,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOLEAN(0, "index", &check_index,
 			N_("make sure the patch is applicable to the current index")),
+		OPT_BOOLEAN(0, "stage", &check_index,
+			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOLEAN(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
 		OPT_BOOLEAN(0, "apply", &force_apply,
-- 
1.8.4-fc
