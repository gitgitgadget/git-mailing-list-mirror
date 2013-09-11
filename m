From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Improve documentation concerning the status.submodulesummary
 setting
Date: Wed, 11 Sep 2013 21:07:15 +0200
Message-ID: <5230BF63.30006@web.de>
References: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com> <522F486A.1000705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 21:07:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJplB-0004J1-3a
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 21:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756959Ab3IKTHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 15:07:25 -0400
Received: from mout.web.de ([212.227.15.4]:53751 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab3IKTHW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 15:07:22 -0400
Received: from [192.168.178.41] ([91.3.184.145]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0McFQF-1VdQ0W2BsN-00JcNz for <git@vger.kernel.org>;
 Wed, 11 Sep 2013 21:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <522F486A.1000705@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:ul8eewZP4TT56gHCrQyw/DV76BbczHD9EdlOx0QFzIXBSBjBAJ4
 +KplF8b3vsvplbxK4iSgk4wfBXZaUf6gMntqSMLlYy0PkzQOLDaDLSyz/FFPVBemSQ2k4MA
 qwBb5vKm2O8feYJqZUFvckO68VeJa2FiARrpKLNNCUb1Y+lZnApZv22+ws/3K7e3u2nZFVd
 T0f2YkFkX8bY5hh5kVdWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234600>

'git status' and 'git commit' can be told to also show the output of "git
submodule summary" by setting the "status.submodulesummary" config option.
But status and commit also honor the "diff.ignoreSubmodules" and the
"submodule.<name>.ignore" settings, which then disable the summary partly
or completely. This - and the fact that the last two settings do not
affect the "git submodule" commands at all - is not well documented.

Extend the documentation in those places where "status.submodulesummary",
"diff.ignoreSubmodules" and "submodule.<name>.ignore" are described to
better explain these dependencies.

Thanks-to: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 10.09.2013 18:27, schrieb Jens Lehmann:
> Am 10.09.2013 00:53, schrieb Junio C Hamano:
>> * bc/submodule-status-ignored (2013-09-04) 2 commits
>>  - submodule: don't print status output with ignore=all
>>  - submodule: fix confusing variable name
>>
>>  Originally merged to 'next' on 2013-08-22
>>
>>  Will merge to 'next'.
> 
> I propose to cook this some time in next to give submodule
> users who have configured ignore=all the opportunity to test
> and comment on that. And as Matthieu noticed the documentation
> is not terribly clear here, I'll prepare one or two patches to
> fix that which should go in together with these changes.

And here we go. Matthieu, does that make it more obvious?


 Documentation/config.txt      | 12 ++++++++++--
 Documentation/diff-config.txt |  6 +++++-
 Documentation/git-status.txt  |  8 +++++++-
 Documentation/gitmodules.txt  |  3 ++-
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 44e7873..52f20ab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2207,7 +2207,14 @@ status.submodulesummary::
 	If this is set to a non zero number or true (identical to -1 or an
 	unlimited number), the submodule summary will be enabled and a
 	summary of commits for modified submodules will be shown (see
-	--summary-limit option of linkgit:git-submodule[1]).
+	--summary-limit option of linkgit:git-submodule[1]). Please note
+	that the summary output command will be suppressed for all
+	submodules when `diff.ignoreSubmodules` is set to 'all' or only
+	for those submodules where `submodule.<name>.ignore=all`. To
+	also view the summary for ignored submodules you can either use
+	the --ignore-submodules=dirty command line option or the 'git
+	submodule summary' command, which shows a similar output but does
+	not honor these settings.

 submodule.<name>.path::
 submodule.<name>.url::
@@ -2242,7 +2249,8 @@ submodule.<name>.ignore::
 	submodules that have untracked files in their work tree as changed.
 	This setting overrides any setting made in .gitmodules for this submodule,
 	both settings can be overridden on the command line by using the
-	"--ignore-submodules" option.
+	"--ignore-submodules" option. The 'git submodule' commands are not
+	affected by this setting.

 tar.umask::
 	This variable can be used to restrict the permission bits of
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index ac77050..223b931 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -73,7 +73,11 @@ diff.ignoreSubmodules::
 	Sets the default value of --ignore-submodules. Note that this
 	affects only 'git diff' Porcelain, and not lower level 'diff'
 	commands such as 'git diff-files'. 'git checkout' also honors
-	this setting when reporting uncommitted changes.
+	this setting when reporting uncommitted changes. Setting it to
+	'all' disables the submodule summary normally shown by 'git commit'
+	and 'git status' when 'status.submodulesummary' is set unless it is
+	overridden by using the --ignore-submodules command line option.
+	The 'git submodule' commands are not affected by this setting.

 diff.mnemonicprefix::
 	If set, 'git diff' uses a prefix pair that is different from the
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 9046df9..a4acaa0 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -210,7 +210,13 @@ directory.
 If `status.submodulesummary` is set to a non zero number or true (identical
 to -1 or an unlimited number), the submodule summary will be enabled for
 the long format and a summary of commits for modified submodules will be
-shown (see --summary-limit option of linkgit:git-submodule[1]).
+shown (see --summary-limit option of linkgit:git-submodule[1]). Please note
+that the summary output from the status command will be suppressed for all
+submodules when `diff.ignoreSubmodules` is set to 'all' or only for those
+submodules where `submodule.<name>.ignore=all`. To also view the summary for
+ignored submodules you can either use the --ignore-submodules=dirty command
+line option or the 'git submodule summary' command, which shows a similar
+output but does not honor these settings.

 SEE ALSO
 --------
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 6a1ca4a..f7be93f 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -75,7 +75,8 @@ submodule.<name>.ignore::
 	the superproject, the setting there will override the one found in
 	.gitmodules.
 	Both settings can be overridden on the command line by using the
-	"--ignore-submodule" option.
+	"--ignore-submodule" option. The 'git submodule' commands are not
+	affected by this setting.


 EXAMPLES
-- 
1.8.4.444.gf9f2042
