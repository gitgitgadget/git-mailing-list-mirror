From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 3/3] format-patch: --numbered-files and --stdout aren't mutually exclusive
Date: Sat, 21 Mar 2009 21:32:43 -0700
Message-ID: <1237696363-6819-4-git-send-email-bebarino@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <1237696363-6819-2-git-send-email-bebarino@gmail.com>
 <1237696363-6819-3-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 05:34:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlFOZ-00048I-S1
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 05:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbZCVEdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 00:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbZCVEc6
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 00:32:58 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:61899 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbZCVEc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 00:32:57 -0400
Received: by an-out-0708.google.com with SMTP id d14so1257833and.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 21:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=bElwLQ2FQ9B0QCsZlHI4inCauVqybc2al65Eaq2h/SM=;
        b=WXkefuF9D/dRkH3M2qDqjKB6EKYOvtoHD3sXQloRZnEPTb7fsIbG1BSFYozl23rRrQ
         JapFomWGCUXoE/YgWwtCeAPYKKp1JeWB4CVd7Jr6YGgF0v0StD5CL0m0Kd/h+BS/Y5J5
         qB04nYE58/gCFMjJ074h7yfk5f9qMo79OJBGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pBps0In0q60XlTjav5JXAWiSUjPfJ9sA/XZ/IY/8LMugKrMXB7ihTzyHOJ8h97ArjP
         dwpISx1L5uh6t3GKmttbFzNI4J/9K6m/T/WC91GnTIXGrXSTHBUMihw9SwSKRHXq4NYK
         yOpNe12IPJc8qGnjaameKpFIutDTvm2ZGxFVM=
Received: by 10.142.234.16 with SMTP id g16mr2234264wfh.107.1237696374697;
        Sat, 21 Mar 2009 21:32:54 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 27sm8125656wff.8.2009.03.21.21.32.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 21 Mar 2009 21:32:54 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 21 Mar 2009 21:32:52 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237696363-6819-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114115>

For example:

    git format-patch --numbered-files --stdout --attach HEAD~~

will create two messages with files 1 and 2 attached respectively.
There is no effect when using --numbered-files and --stdout together
without an --attach or --inline, the files simply aren't created.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-format-patch.txt |    1 -
 builtin-log.c                      |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c14e3ee..c2eb5fa 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -97,7 +97,6 @@ include::diff-options.txt[]
 --numbered-files::
 	Output file names will be a simple number sequence
 	without the default first line of the commit appended.
-	Mutually exclusive with the --stdout option.
 
 -k::
 --keep-subject::
diff --git a/builtin-log.c b/builtin-log.c
index 8ea25e0..f81d3a3 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -951,8 +951,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die ("-n and -k are mutually exclusive.");
 	if (keep_subject && subject_prefix)
 		die ("--subject-prefix and -k are mutually exclusive.");
-	if (numbered_files && use_stdout)
-		die ("--numbered-files and --stdout are mutually exclusive.");
 
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
 	if (argc > 1)
-- 
1.6.2
