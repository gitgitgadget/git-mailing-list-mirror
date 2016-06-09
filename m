From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: [PATCHv4] Documentation: triangular workflow
Date: Thu,  9 Jun 2016 14:35:08 +0200
Message-ID: <1465475708-1912-1-git-send-email-jordan.de-gea@grenoble-inp.org>
References: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mhagger@alum.mit.edu, philipoakley@iee.org, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org, Matthieu.Moy@grenoble-inp.fr,
	peff@peff.net, artagnon@gmail.com,
	Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 09 14:35:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAzBH-0001jA-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 14:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbcFIMfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2016 08:35:24 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:51077 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbcFIMfX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 08:35:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 1A90C25AE;
	Thu,  9 Jun 2016 14:35:20 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h5nRm5l6N0bQ; Thu,  9 Jun 2016 14:35:20 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0A6BF2585;
	Thu,  9 Jun 2016 14:35:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 0765F2066;
	Thu,  9 Jun 2016 14:35:20 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LmhwzXabcgln; Thu,  9 Jun 2016 14:35:19 +0200 (CEST)
Received: from eduroam-032230.grenet.fr (eduroam-032230.grenet.fr [130.190.32.230])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id E07912055;
	Thu,  9 Jun 2016 14:35:19 +0200 (CEST)
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296884>

Currently, triangular workflow can be configured, but there is no
documentation about it. A documentation is useful to keep
configuration possibilities up-to-date.

A new subsection is created in gitworkflow.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
---
Changes since v3:
 * Text reorganized to follow:
   - Introduction
   - Preparation
   - Staying up-to-date
   - Alternatively
 * Texts added to explain why we use commands in:
   - Preparation
   - Alternatively

 Documentation/gitworkflows.txt | 177 +++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 176 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflow=
s.txt
index f16c414..1ec1f63 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -463,6 +463,178 @@ if you get conflicts: `git am -3` will use index =
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
+- Taking the last version of the project by fetching from **UPSTREAM**
+- Writing modifications and push them to a fork (e.g. **PUBLISH**)
+- Opening a pull request
+- If the maintainer accepts the changes, he merges them into the
+  **UPSTREAM** repository.
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
+Motivations
+~~~~~~~~~~~
+
+* Allows contributors to work with Git even though they do not have
+write access to **UPSTREAM**.
+
+* Allows maintainers to receive code from contributors they may not
+trust.
+
+* Code review is more efficient
+
+* Encourages clean history by using `rebase -i` and `push --force` to=20
+your public fork before the code is merged
+
+Preparation
+~~~~~~~~~~~
+
+Cloning from **PUBLISH**, which is a fork of **UPSTREAM** or an empty
+repository.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git clone <PUBLISH_url>`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Setting the behavior of push for the triangular workflow:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+`git config push.default current`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+Adding **UPSTREAM** remote:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git remote add upstream <UPSTREAM_url>`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+With the `remote add` above, using `git pull upstream` pulls there,
+instead of saying its URL. In addition, `git pull` can pull from
+**UPSTREAM** without argument.
+
+For each branch requiring a triangular workflow, set
+`branch.<branch>.remote` and `branch.<branch>.pushRemote`.
+
+Example with master as <branch>:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+* `git config branch.master.remote upstream`
+* `git config branch.master.pushRemote origin`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Stay up-to-date
+~~~~~~~~~~~~~~~
+
+Retrieve updates from **UPSTREAM** with `git pull` and send them to
+**PUBLISH** with `git push`.
+
+Checks
+~~~~~~
+
+.Display the push remote's name:
+[caption=3D"Recipe: "]
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git rev-parse --abbrev-ref @{push}`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The shorthand `<branch>@{push}` denotes the remote-tracking branch
+where the <branch> would be pushed to. If no <branch> is specified
+(`@{push}`), <branch> takes the value of the current branch.
+
+
+.Display the fetch remote's name:
+[caption=3D"Recipe: "]
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git rev-parse --abbrev-ref @{upstream}`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The shorthand `<branch>@{upstream}` substitutes the upstream name of
+the branch. If no <branch> is specified (`@{upstream}`), <branch>
+takes the value of the current branch.
+
+.Display commits added to the current branch since last push:
+[caption=3D"Recipe: "]
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git log @{push}..`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.Display commits added to a specific branch since last push:
+[caption=3D"Recipe: "]
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+`git log <branch_name>@{push}..`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+Alternative configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.Cloning from **UPSTREAM**
+[caption=3D"Recipe: "]
+
+In the preparation above, a clone from **PUBLISH** was used. Starting
+with a clone of **UPSTREAM** is possible too.
+
+Cloning from **UPSTREAM**
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git clone <UPSTREAM_url>`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Setting the behavior of push for the triangular workflow:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+`git config push.default current`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+Because modifications will be often pushed into the **PUBLISH** reposi=
tory,
+instead of having to type its URL every time, a short name can be used
+to call it.
+
+Adding **PUBLISH** remote:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git remote add publish <PUBLISH_url>`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+With the `remote add` above, using `git push publish` pushes there,
+instead of saying its URL. In addition, `git push` can push to
+**PUBLISH** without argument.
+
+'Method 1: One option for all branches'
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git config remote.pushDefault publish`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+'Method 2: Each branch its option'
+
+Example with master as <branch>:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git config branch.master.pushRemote publish`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 SEE ALSO
 --------
@@ -473,7 +645,10 @@ linkgit:git-merge[1],
 linkgit:git-rebase[1],
 linkgit:git-format-patch[1],
 linkgit:git-send-email[1],
-linkgit:git-am[1]
+linkgit:git-am[1],
+linkgit:git-config[1],
+linkgit:git-log[1],
+linkgit:git-rev-parse[1]
=20
 GIT
 ---
--=20
2.7.4 (Apple Git-66)
