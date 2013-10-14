From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/14] rm: add --staged option
Date: Mon, 14 Oct 2013 17:29:23 -0500
Message-ID: <1381789769-9893-9-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Oct 15 00:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqkJ-0007HQ-RW
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229Ab3JNWgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:36:11 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:50870 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab3JNWgH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:36:07 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so5307992obc.17
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cgGNg6iL73Z/eeNgkG+FPWDUhJKSkw8Boo6R9JoegUQ=;
        b=VGcY62ql60wanIEpQJmss2RSm7qtw3fo6m8QeaSiFc2kq7llYbBXhXB5+Hdysr5yCs
         TSW125fKvaw7mHWeuFPTqg34Ergf0gg2uw16WvXG6Nm3luue3xSZv/6AqFmjp3EGCXHE
         nGzw2rtBdJt6vdrWF3NejqejTTxSmBdHm4OdD50C8BVeuDqB/9Bdj5GhnG+EcXb04utP
         zQtn7cM+hUbQC4d+Rpil+L5K/hNpvQx9OxKy9IPLUGFfH6aramMMvC2TlLSok+G8dnjl
         3UIKJ0i8h3wRUU40gpTYnJly7xk8aIMIcIfAtIOMLuZId33liYKc4XwiQVERxkBJdhoO
         PDwA==
X-Received: by 10.60.41.164 with SMTP id g4mr3599419oel.44.1381790167316;
        Mon, 14 Oct 2013 15:36:07 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm44541277obc.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:36:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236136>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-rm.txt | 5 ++++-
 builtin/rm.c             | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 1d876c2..156b40d 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,7 +8,7 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
+'git rm' [-f | --force] [-n] [-r] [--cached | --staged] [--ignore-unmatch] [--quiet] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -60,6 +60,9 @@ OPTIONS
 	Working tree files, whether modified or not, will be
 	left alone.
 
+--staged::
+	Synonym for --cached.
+
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
 
diff --git a/builtin/rm.c b/builtin/rm.c
index 0df0b4d..919911f 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -268,6 +268,7 @@ static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOLEAN( 0 , "cached",         &index_only, N_("only remove from the index")),
+	OPT_BOOLEAN( 0 , "staged",         &index_only, N_("only remove from the index")),
 	OPT__FORCE(&force, N_("override the up-to-date check")),
 	OPT_BOOLEAN('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
-- 
1.8.4-fc
