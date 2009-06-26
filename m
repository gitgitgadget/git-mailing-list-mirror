From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 1/2] read-tree: convert unhelpful usage()'s to helpful die()'s
Date: Thu, 25 Jun 2009 22:14:09 -0700
Message-ID: <1245993250-8213-1-git-send-email-bebarino@gmail.com>
References: <1245817672-25483-1-git-send-email-bebarino@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 07:14:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3lW-0000pl-CX
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 07:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbZFZFOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 01:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbZFZFOL
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 01:14:11 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:24848 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbZFZFOK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 01:14:10 -0400
Received: by wa-out-1112.google.com with SMTP id j5so396335wah.21
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 22:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=4qOJpSOm9dclMhaUCg7L7z/eGDCLRpPZnipgK8Q90RY=;
        b=c3iH3lg2C4hKcwO01eomFCJna20hLb3WwkmWWsws9Mfw1CfuF5IHzR3WZahTCPzvxU
         jocl8YQfxF6Pr2nh0K5W5Ow+gYjDtZbssU+xW02UnAZE8si5uRhiK6RxDnlv9Kkd6F/p
         s454CbbvBGQvDlibk/F8iVnqhG7+0qyn/eP2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YxrC/mFz92fpuIXh9yUCEjqjMiC0HVsjk+FpZzBSxlvomwBTA9KLHnsqkYZ6JsLA0c
         kAfG09XXUrQ2rCLVleSp2nlnUne/dhMh4yHDi5aHC4yDOamjJwFJIV5YHdvhd+l64fpB
         KJvTGiEiari7W86SUwv2dQf6nkii7FuDbMADA=
Received: by 10.114.124.1 with SMTP id w1mr5130096wac.132.1245993253819;
        Thu, 25 Jun 2009 22:14:13 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id m31sm1860161wag.31.2009.06.25.22.14.11
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 22:14:13 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 25 Jun 2009 22:14:10 -0700
X-Mailer: git-send-email 1.6.3.3.334.g916e1
In-Reply-To: <1245817672-25483-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122276>

Printing the usage message when encountering bad option combinations is
not very helpful. Instead, die with a message which tells the user
exactly what combination is invalid.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Added --prefix and --reset to the second die message.

 builtin-read-tree.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 82e25ea..17c9631 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -145,9 +145,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			continue;
 		}
 
-		/* using -u and -i at the same time makes no sense */
 		if (1 < opts.index_only + opts.update)
-			usage(read_tree_usage);
+			die("-u and -i at the same time makes no sense");
 
 		if (get_sha1(arg, sha1))
 			die("Not a valid object name %s", arg);
@@ -156,7 +155,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		stage++;
 	}
 	if ((opts.update||opts.index_only) && !opts.merge)
-		usage(read_tree_usage);
+		die("%s is meaningless without -m, --reset, or --prefix",
+		    opts.update ? "-u" : "-i");
 	if ((opts.dir && !opts.update))
 		die("--exclude-per-directory is meaningless unless -u");
 	if (opts.merge && !opts.index_only)
-- 
1.6.3.3.334.g916e1
