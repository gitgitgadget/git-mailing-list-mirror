From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 1/2] Add a basic idea section for git-blame.
Date: Wed,  7 Apr 2010 23:51:29 -0700
Message-ID: <1270709490-19163-2-git-send-email-struggleyb.nku@gmail.com>
References: <1270709490-19163-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 08 08:51:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlaZ-000159-Dq
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758369Ab0DHGv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:51:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:27695 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758359Ab0DHGv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:51:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so688261qwh.37
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 23:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XV9bEKi1S1xjr8WgzBJw1k1aJOakITN04iMzNHSHVqw=;
        b=dGZ/iMHkIE3TwPGuzsDFkmGwcqQ5WHY7JD2Vo839LU/SGiH6omdHgvvmcN/tC2sr43
         wzMVmPwFlZ7xAR1PHnIxL9G2w2Ci7FQUmJMme3HLdpacntCfUHw6W3sHfLijPpJInS2K
         9HcuV0HiXENC7Gz5JeJOLL608BMghIRw1/VrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FjkeaBo1sRbF05PGHUBYcjQIn9xNS12aBuEwTlhFUOh8xz16G9FJls4GgBhZeOZZYY
         WI5PlmA5NP/xJkPFLPiSFElxVZ4EHbprUk8EHh1R/9Qz6HY3L0EQtK3dallLo6EBust4
         MTKuowBIIrfm008LCvb+FTNjT/rdssqu5uuyY=
Received: by 10.229.91.16 with SMTP id k16mr1585064qcm.40.1270709487331;
        Wed, 07 Apr 2010 23:51:27 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id 22sm3689059iwn.12.2010.04.07.23.51.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 23:51:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1270709490-19163-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144331>

Explain the basic idea about blame shifting with
'-M' or '-C' given.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/git-blame.txt |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index a27f439..e31b87f 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -36,6 +36,38 @@ $ git log --pretty=oneline -S'blame_usage'
 ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
 -----------------------------------------------------------------------------
 
+
+BASIC IDEA
+----------
+
+This section briefly explains the basic idea behind 'git-blame'.  You
+do not have to understand it to use git-blame, but it helps in
+understanding the `-M` and `-C` options.  For the sake of simplicity,
+we assume that history is linear.
+
+A call to `git-blame <rev> -- <file>` works as follows:
+
+- Look at `git diff <rev>^ <rev>` to see what the commit did.
+
+- Discard all `-` lines in the diff, since they are no longer part of
+  `<file>`.
+
+- Take blame for all `+` lines; i.e., the newly added lines according
+  to the diff are attributed to `<rev>`.
+
+- Shift blame for all unchanged lines to the parent; i.e., these lines
+  are attributed as in a call to `git blame <rev>^ -- <file>`.
+
+Note that this does not expend any effort to shift blame of `+`
+lines.  This can be changed with the `-M` and `-C` options.
+
+With `-M`, this command detects same lines of the current blaming code
+inside the current file. And it will shift the blame to the author of
+the original lines instead of author of current blaming code. It does
+the same for `-C` except that it will search across file boundary and
+multiple commits.
+
+
 OPTIONS
 -------
 include::blame-options.txt[]
-- 
1.6.0.4
