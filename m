From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] Documentation: explain how to check for patch corruption
Date: Thu, 14 Apr 2011 21:24:01 -0500
Message-ID: <20110415022401.GC19829@elie>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net>
 <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
 <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org>
 <20110415021100.GA19829@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:24:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAYhi-0004ZJ-MF
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 04:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab1DOCYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 22:24:09 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56357 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab1DOCYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 22:24:07 -0400
Received: by gxk21 with SMTP id 21so974667gxk.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 19:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WADEa0g2YD/iKQ4LDT+cqeaveJCB5VYricMl5gD7ZFI=;
        b=GBTh9vpSquHjG/3ZrMTc8okHq3mloeAmCHW7whSqvYKY1Do4ncSNj4lPjAwlwL7WiW
         D/Ns6Zd88h1OI3K5gAZ5j2imycN70e2bLmeh8I5Z2kFgydm3Rj4wdqYdsmybr0r1hWAO
         K2I0gvkX8nE4viIK1rwf6R1ymfKEY9V+QHWzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mAcJBNrrqrBilhzgZnubL0jyAJjnZhLmqNd3ub+niq++lalRNkgfAi1/ormn38Vutx
         3SMEHF0l8eRLxRYsZZ0l4tqHxtergUK6tjoqlLDi6ZcnuW+mGWBjmXZD6Ln7dQEssJJq
         PpnoFcZvGfThKhZyZetZCYSkNqH3L0oli4nQI=
Received: by 10.150.141.10 with SMTP id o10mr2371217ybd.50.1302834246201;
        Thu, 14 Apr 2011 19:24:06 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.ameritech.net [69.209.64.230])
        by mx.google.com with ESMTPS id m12sm2959073ybn.27.2011.04.14.19.24.04
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 19:24:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110415021100.GA19829@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171578>

SubmittingPatches has some excellent advice about how to check a patch
for corruption before sending it off.  Move it to the format-patch
manual so it can be installed with git's documentation for use by
people not necessarily interested in the git project's practices.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/SubmittingPatches    |   58 ++++++++---------------------------
 Documentation/git-format-patch.txt |   46 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c6a5032..20b4101 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -344,50 +344,20 @@ MUA specific hints
 
 Some of patches I receive or pick up from the list share common
 patterns of breakage.  Please make sure your MUA is set up
-properly not to corrupt whitespaces.  Here are two common ones
-I have seen:
-
-* Empty context lines that do not have _any_ whitespace.
-
-* Non empty context lines that have one extra whitespace at the
-  beginning.
-
-One test you could do yourself if your MUA is set up correctly is:
-
-* Send the patch to yourself, exactly the way you would, except
-  To: and Cc: lines, which would not contain the list and
-  maintainer address.
-
-* Save that patch to a file in UNIX mailbox format.  Call it say
-  a.patch.
-
-* Try to apply to the tip of the "master" branch from the
-  git.git public repository:
-
-    $ git fetch http://kernel.org/pub/scm/git/git.git master:test-apply
-    $ git checkout test-apply
-    $ git reset --hard
-    $ git am a.patch
-
-If it does not apply correctly, there can be various reasons.
-
-* Your patch itself does not apply cleanly.  That is _bad_ but
-  does not have much to do with your MUA.  Please rebase the
-  patch appropriately.
-
-* Your MUA corrupted your patch; "am" would complain that
-  the patch does not apply.  Look at .git/rebase-apply/ subdirectory and
-  see what 'patch' file contains and check for the common
-  corruption patterns mentioned above.
-
-* While you are at it, check what are in 'info' and
-  'final-commit' files as well.  If what is in 'final-commit' is
-  not exactly what you would want to see in the commit log
-  message, it is very likely that your maintainer would end up
-  hand editing the log message when he applies your patch.
-  Things like "Hi, this is my first patch.\n", if you really
-  want to put in the patch e-mail, should come after the
-  three-dash line that signals the end of the commit message.
+properly not to corrupt whitespaces.
+
+See the DISCUSSION section of git-format-patch(1) for hints on
+checking your patch by mailing it to yourself and applying with
+git-am(1).
+
+While you are at it, check the resulting commit log message from
+a trial run of applying the patch.  If what is in the resulting
+commit is not exactly what you would want to see, it is very
+likely that your maintainer would end up hand editing the log
+message when he applies your patch.  Things like "Hi, this is my
+first patch.\n", if you really want to put in the patch e-mail,
+should come after the three-dash line that signals the end of the
+commit message.
 
 
 Pine
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index a4a9813..5c60418 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -286,6 +286,52 @@ title is likely to be different from the subject of the discussion the
 patch is in response to, so it is likely that you would want to keep
 the Subject: line, like the example above.
 
+Checking for patch corruption
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Many mailers if not set up properly will corrupt whitespace.  Here are
+two common types of corruption:
+
+* Empty context lines that do not have _any_ whitespace.
+
+* Non-empty context lines that have one extra whitespace at the
+  beginning.
+
+One way to test if your MUA is set up correctly is:
+
+* Send the patch to yourself, exactly the way you would, except
+  with To: and Cc: lines that do not contain the list and
+  maintainer address.
+
+* Save that patch to a file in UNIX mailbox format.  Call it a.patch,
+  say.
+
+* Apply it:
+
+    $ git fetch <project> master:test-apply
+    $ git checkout test-apply
+    $ git reset --hard
+    $ git am a.patch
+
+If it does not apply correctly, there can be various reasons.
+
+* The patch itself does not apply cleanly.  That is _bad_ but
+  does not have much to do with your MUA.  You might want to rebase
+  the patch with linkgit:git-rebase[1] before regenerating it in
+  this case.
+
+* The MUA corrupted your patch; "am" would complain that
+  the patch does not apply.  Look in the .git/rebase-apply/ subdirectory and
+  see what 'patch' file contains and check for the common
+  corruption patterns mentioned above.
+
+* While at it, check the 'info' and 'final-commit' files as well.
+  If what is in 'final-commit' is not exactly what you would want to
+  see in the commit log message, it is very likely that the
+  receiver would end up hand editing the log message when applying
+  your patch.  Things like "Hi, this is my first patch.\n" in the
+  patch e-mail should come after the three-dash line that signals
+  the end of the commit message.
+
 
 EXAMPLES
 --------
-- 
1.7.5.rc0
