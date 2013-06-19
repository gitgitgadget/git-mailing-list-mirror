From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] config doc: rewrite push.default section
Date: Wed, 19 Jun 2013 16:41:40 +0530
Message-ID: <1371640304-26019-3-git-send-email-artagnon@gmail.com>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 13:15:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpGLw-00036l-Vr
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 13:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934364Ab3FSLO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 07:14:59 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:35934 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933666Ab3FSLO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 07:14:57 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so4950804pbc.35
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HT2nd74QSfK/vetgafeI/MsLV6wrhIi1MB0L5s9tuzs=;
        b=z7GLWVfkguMvrjKecJczFVFLB0Z7q0ga7RH0fjrMsDZUTZG0uEvg2dFU/4DIEroW6b
         HzNGftwHAbQAI6rn8J4qAWUNC4JCoq2Ljy/m/j8VatszRn/RZQmFBmi5rwJ3L6xHHak4
         74+3+a89yj+1viaUzUHtsqW0nH5YORnxAdspGmb+TAQMFHPmRyrk7fLxMIswwwCZj7V0
         w8aodWdkqOOyj37/zsLthrXT/QEYHZ5/C1GmLe8sOd5W5RsyO0GavItaIZXsI4M42BRF
         T32vKk293RffZ9RSPdUzh9GwN8C+rFUiIU8BFw0eo0z3Aoqk3lZwqkivSoljh7Xl0ibC
         at+Q==
X-Received: by 10.68.196.37 with SMTP id ij5mr2197934pbc.214.1371640497163;
        Wed, 19 Jun 2013 04:14:57 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id iq2sm22746579pbb.19.2013.06.19.04.14.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 04:14:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.454.gff6ba36
In-Reply-To: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228385>

4d3592 (Merge branch 'rr/triangle', 2013-04-07) introduced support for
triangular workflows in Git, but the push.default values still assume
central workflows.  Rewrite the descriptions of `nothing`, `current`,
`upstream` and `matching` for greater clarity, and explicitly explaining
how they behave in triangular workflows.  Leave `simple` as it is for
the moment, as we plan to change its meaning to accommodate triangular
workflows in a later patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 56 ++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7fd4035..9f04f74 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1826,39 +1826,43 @@ pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
 push.default::
-	Defines the action `git push` should take if no refspec is given
-	on the command line, no refspec is configured in the remote, and
-	no refspec is implied by any of the options given on the command
-	line. Possible values are:
+	Defines the action `git push` should take if no refspec is
+	explicitly given.  Different values are well-suited for
+	specific workflows; for instance, in a purely central workflow
+	(i.e. the fetch source is equal to the push destination),
+	`upstream` is probably what you want.  Possible values are:
 +
 --
-* `nothing` - do not push anything.
-* `matching` - push all branches having the same name in both ends.
-  This is for those who prepare all the branches into a publishable
-  shape and then push them out with a single command.  It is not
-  appropriate for pushing into a repository shared by multiple users,
-  since locally stalled branches will attempt a non-fast forward push
-  if other users updated the branch.
-  +
-  This is currently the default, but Git 2.0 will change the default
-  to `simple`.
-* `upstream` - push the current branch to its upstream branch
-  (`tracking` is a deprecated synonym for this).
-  With this, `git push` will update the same remote ref as the one which
-  is merged by `git pull`, making `push` and `pull` symmetrical.
-  See "branch.<name>.merge" for how to configure the upstream branch.
+* `nothing` - do not push anything (error out) unless a refspec is
+  explicitly given.  Very safe, but not very convenient.
+
+* `current` - push the current branch to update a branch with the same
+  name on the receiving end.  Works in both central and non-central
+  workflows.  Equivalent to pushing the refspec "$branch" ($branch is
+  the name of the current branch).
+
+* `upstream` - push the current branch to a branch with the name
+  branch.$branch.merge on the receiving end, and error out if the push
+  destination is not the same as branch.$branch.remote.  The name
+  "upstream" refers to "@{u[pstream]}" in linkgit:gitrevisions[7],
+  which makes sense only if both branch.$branch.remote and
+  branch.$branch.merge are set.  It makes sure that a `push` is
+  symmetrical to `pull` in central workflows, and cannot be used in
+  non-central workflows.
+
 * `simple` - like `upstream`, but refuses to push if the upstream
   branch's name is different from the local one. This is the safest
   option and is well-suited for beginners. It will become the default
   in Git 2.0.
-* `current` - push the current branch to a branch of the same name.
+
+* `matching` - push all branches having the same name on both ends
+  (essentially ignoring all newly created local branches).
+  Well-suited for those who want to batch-update a specific set of
+  branches they consistently work on.  Use with caution, especially
+  when pushing with '--force'.  Equivalent to pushing the refspec ":".
+  This is currently the default, but Git 2.0 will change the default
+  to `simple`.
 --
-+
-The `simple`, `current` and `upstream` modes are for those who want to
-push out a single branch after finishing work, even when the other
-branches are not yet ready to be pushed out. If you are working with
-other people to push into the same shared repository, you would want
-to use one of these.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
-- 
1.8.3.1.454.g30263f3.dirty
