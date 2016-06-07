From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: [PATCHv3] Documentation: triangular workflow
Date: Tue,  7 Jun 2016 10:38:13 +0200
Message-ID: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org>
References: <1465206518-1780-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mhagger@alum.mit.edu, philipoakley@iee.org, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org, Matthieu.Moy@grenoble-inp.fr,
	Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 07 10:38:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bACX8-0002Wd-Nl
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 10:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbcFGIif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 04:38:35 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:52706 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbcFGIi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 04:38:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9FE9A20AE;
	Tue,  7 Jun 2016 10:38:25 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eKBO4YIOy_g2; Tue,  7 Jun 2016 10:38:25 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 869AD20AD;
	Tue,  7 Jun 2016 10:38:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 7FD5B2066;
	Tue,  7 Jun 2016 10:38:25 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cTxsTZpx8lYm; Tue,  7 Jun 2016 10:38:25 +0200 (CEST)
Received: from eduroam-033178.grenet.fr (eduroam-033178.grenet.fr [130.190.33.178])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 621CF2064;
	Tue,  7 Jun 2016 10:38:25 +0200 (CEST)
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1465206518-1780-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296615>

Currently, triangular workflow can be configured, but there is no
documentation about it. A documentation is useful to keep
configuration possibilities up-to-date.

A new subsection is created in gitworkflow.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
---
Changes since version 2:
 - PUBLIC-FORK renamed for PUBLISH

Changes since version 1:
 - content moved in gitworktree
 - content improved

 Documentation/gitworkflows.txt | 154 +++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 154 insertions(+)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflow=
s.txt
index f16c414..3b5fd09 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -463,6 +463,156 @@ if you get conflicts: `git am -3` will use index =
information contained
 in patches to figure out the merge base.  See linkgit:git-am[1] for
 other options.
=20
+TRIANGULAR WORKFLOW
+-------------------
+
+In some projects, you cannot push directly to the project but have to
+suggest your commits to the maintainer (e.g. pull requests).
+For these projects, it's common to use what's called a *triangular
+workflow*:
+
+- Taking the last version of the project by fetching (e.g.
+  **UPSTREAM**)
+- Writing modifications and push them to a fork (e.g. **PUBLISH**)
+- Opening a pull request
+- Checking of changes by the maintainer and, merging them into the
+  **UPSTREAM** repository if accepted
+
+
+........................................
+------------------               -----------------
+| UPSTREAM       |  maintainer   | PUBLISH       |
+|  git/git       |- - - - - - - -|  me/remote    |
+------------------       =E2=86=90       -----------------
+              \                     /
+               \                   /
+          fetch=E2=86=93\                 /=E2=86=91push
+                 \               /
+                  \             /
+                   -------------
+                   |   LOCAL   |
+                   -------------
+........................................
+
+Git options to use:
+~~~~~~~~~~~~~~~~~~~
+ - `branch.<branch>.remote`
+ - `branch.<branch>.pushRemote`
+ - `remote.pushDefault`
+ - `push.default`
+
+See linkgit:git-config[1].
+
+Push behaviour
+~~~~~~~~~~~~~~
+
+Setting the behavior of push for the triangular workflow:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+* `git config push.default current`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+
+Case 1: LOCAL is a clone of **PUBLISH**
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+'In this case, the remote named `origin` corresponds to **PUBLISH**.'
+
+Adding **UPSTREAM** remote:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+* `git remote add upstream <UPSTREAM_url>`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Setting `branch.<branch>.remote` and `branch.<branch>.pushRemote` in
+order to:
+
+ - pull from **UPSTREAM** without argument for pull
+ - push to **PUBLISH** (`origin`) without argument for push
+
+Example with master as <branch>:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+* `git config branch.master.remote upstream`
+* `git config branch.master.pushRemote origin`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Case 2: LOCAL is a clone of **UPSTREAM**
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+'In this case, the remote named `origin` corresponds to **UPSTREAM**.'
+
+Adding **PUBLISH** remote:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+* `git remote add publish <PUBLISH_url>`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+**Method 1: One option for all branches**
+
+Setting `remote.pushDefault` in order to push to **PUBLISH** without
+argument for push.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+* `git config remote.pushDefault publish`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+**Method 2: Each branch its option**
+
+Setting `branch.<branch>.pushRemote` in order to push to **PUBLISH**
+without argument to push.
+
+Example with master as <branch>:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+* `git config branch.master.pushRemote publish`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+Stay up-to-date
+~~~~~~~~~~~~~~~
+
+Retrieving updates from **UPSTREAM** with `git pull` and sending
+them to **PUBLISH** with `git push`.
+
+Checks
+~~~~~~
+
+Uses of command line shorthand `@{push}` and `@{upstream}`.
+
+**Display the push remote's name: **
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+* `git rev-parse --abbrev-ref '@{push}'`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The shorthand `<branch>@{push}` denotes the remote-tracking branch
+where the <branch> would be pushed to. If no <branch> is specified
+(`@{push}`), <branch> takes the value of the current branch.
+
+See linkgit:git-rev-parse[1].
+
+**Display the fetch remote's name: **
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+* `git rev-parse --abbrev-ref '@{upstream}'`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The shorthand "<branch>@{upstream}" substitutes the name of the
+"upstream" of the branch. If no <branch> is specified (`@{upstream}`),
+<branch> takes the value of the current branch.
+
+**Display commits added to the current branch since last push: **
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+* `git log @{push}..`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+See linkgit:git-log[1].
+
+**Display commits added to a specific branch since last push: **
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+* `git log <branch_name>@{push}..`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
 SEE ALSO
 --------
@@ -474,6 +624,10 @@ linkgit:git-rebase[1],
 linkgit:git-format-patch[1],
 linkgit:git-send-email[1],
 linkgit:git-am[1]
+linkgit:git-config[1],
+linkgit:git-log[1],
+linkgit:git-rev-parse[1]
+
=20
 GIT
 ---
--=20
2.7.4 (Apple Git-66)
