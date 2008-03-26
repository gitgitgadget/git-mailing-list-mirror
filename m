From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-fetch test: test tracking fetch results, not just
 FETCH_HEAD
Date: Wed, 26 Mar 2008 01:33:31 -0700
Message-ID: <7vwsnpevfo.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803251931500.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 09:34:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeR5f-0005vm-KW
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 09:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbYCZIdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 04:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbYCZIdx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 04:33:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYCZIdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 04:33:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F1A1E267C;
	Wed, 26 Mar 2008 04:33:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id ABCDA267A; Wed, 26 Mar 2008 04:33:39 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803251931500.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 25 Mar 2008 19:35:28 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78274>

We really should have done this long time ago.  Existing t5515 test
was written for the specific purpose of catching regression to the
contents of generated FETCH_HEAD file, but it also is a good place
to make sure various fetch configurations do fetch what they intend
to fetch (and nothing else).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Daniel Barkalow <barkalow@iabervon.org> writes:

 > It turns out that .git/branches/foo should fetch into refs/heads/foo.
 >
 > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
 > ---
 > We still don't have a test for that bit of the behavior, so I could have 
 > it still doing the wrong thing. But it at least should do what I think 
 > people want.

 Very true.

 This (sorry for a huge patch) passes with 1.5.3 (that is before C rewrite
 of git-fetch, although the version already had partial optimization based
 on fetch--tool) and more importantly 'maint' with my patch from tonight
 passes.  But somebody should proofread the new test vectors as they were
 generated mechanically from what 1.5.3 did (so by definition 1.5.3 passes
 it).

 t/t5515-fetch-merge-logic.sh                       |   26 ++++++++++++++-----
 t/t5515/refs.br-branches-default                   |   12 +++++++++
 t/t5515/refs.br-branches-default-merge             |   12 +++++++++
 ...refs.br-branches-default-merge_branches-default |   12 +++++++++
 t/t5515/refs.br-branches-default-octopus           |   12 +++++++++
 ...fs.br-branches-default-octopus_branches-default |   12 +++++++++
 t/t5515/refs.br-branches-default_branches-default  |   12 +++++++++
 t/t5515/refs.br-branches-one                       |   12 +++++++++
 t/t5515/refs.br-branches-one-merge                 |   12 +++++++++
 t/t5515/refs.br-branches-one-merge_branches-one    |   12 +++++++++
 t/t5515/refs.br-branches-one-octopus               |   12 +++++++++
 t/t5515/refs.br-branches-one-octopus_branches-one  |   12 +++++++++
 t/t5515/refs.br-branches-one_branches-one          |   12 +++++++++
 t/t5515/refs.br-config-explicit                    |   15 +++++++++++
 t/t5515/refs.br-config-explicit-merge              |   15 +++++++++++
 .../refs.br-config-explicit-merge_config-explicit  |   15 +++++++++++
 t/t5515/refs.br-config-explicit-octopus            |   15 +++++++++++
 ...refs.br-config-explicit-octopus_config-explicit |   15 +++++++++++
 t/t5515/refs.br-config-explicit_config-explicit    |   15 +++++++++++
 t/t5515/refs.br-config-glob                        |   15 +++++++++++
 t/t5515/refs.br-config-glob-merge                  |   15 +++++++++++
 t/t5515/refs.br-config-glob-merge_config-glob      |   15 +++++++++++
 t/t5515/refs.br-config-glob-octopus                |   15 +++++++++++
 t/t5515/refs.br-config-glob-octopus_config-glob    |   15 +++++++++++
 t/t5515/refs.br-config-glob_config-glob            |   15 +++++++++++
 t/t5515/refs.br-remote-explicit                    |   15 +++++++++++
 t/t5515/refs.br-remote-explicit-merge              |   15 +++++++++++
 .../refs.br-remote-explicit-merge_remote-explicit  |   15 +++++++++++
 t/t5515/refs.br-remote-explicit-octopus            |   15 +++++++++++
 ...refs.br-remote-explicit-octopus_remote-explicit |   15 +++++++++++
 t/t5515/refs.br-remote-explicit_remote-explicit    |   15 +++++++++++
 t/t5515/refs.br-remote-glob                        |   15 +++++++++++
 t/t5515/refs.br-remote-glob-merge                  |   15 +++++++++++
 t/t5515/refs.br-remote-glob-merge_remote-glob      |   15 +++++++++++
 t/t5515/refs.br-remote-glob-octopus                |   15 +++++++++++
 t/t5515/refs.br-remote-glob-octopus_remote-glob    |   15 +++++++++++
 t/t5515/refs.br-remote-glob_remote-glob            |   15 +++++++++++
 t/t5515/refs.br-unconfig                           |   11 ++++++++
 t/t5515/refs.br-unconfig_--tags_.._.git            |   11 ++++++++
 t/t5515/refs.br-unconfig_.._.git                   |    5 ++++
 t/t5515/refs.br-unconfig_.._.git_one               |    5 ++++
 ...nfig_.._.git_one_tag_tag-one_tag_tag-three-file |   11 ++++++++
 t/t5515/refs.br-unconfig_.._.git_one_two           |    5 ++++
 ...fig_.._.git_tag_tag-one-tree_tag_tag-three-file |   11 ++++++++
 ...s.br-unconfig_.._.git_tag_tag-one_tag_tag-three |   11 ++++++++
 t/t5515/refs.br-unconfig_branches-default          |   12 +++++++++
 t/t5515/refs.br-unconfig_branches-one              |   12 +++++++++
 t/t5515/refs.br-unconfig_config-explicit           |   15 +++++++++++
 t/t5515/refs.br-unconfig_config-glob               |   15 +++++++++++
 t/t5515/refs.br-unconfig_remote-explicit           |   15 +++++++++++
 t/t5515/refs.br-unconfig_remote-glob               |   15 +++++++++++
 t/t5515/refs.master                                |   11 ++++++++
 t/t5515/refs.master_--tags_.._.git                 |   11 ++++++++
 t/t5515/refs.master_.._.git                        |    5 ++++
 t/t5515/refs.master_.._.git_one                    |    5 ++++
 ...ster_.._.git_one_tag_tag-one_tag_tag-three-file |   11 ++++++++
 t/t5515/refs.master_.._.git_one_two                |    5 ++++
 ...ter_.._.git_tag_tag-one-tree_tag_tag-three-file |   11 ++++++++
 .../refs.master_.._.git_tag_tag-one_tag_tag-three  |   11 ++++++++
 t/t5515/refs.master_branches-default               |   12 +++++++++
 t/t5515/refs.master_branches-one                   |   12 +++++++++
 t/t5515/refs.master_config-explicit                |   15 +++++++++++
 t/t5515/refs.master_config-glob                    |   15 +++++++++++
 t/t5515/refs.master_remote-explicit                |   15 +++++++++++
 t/t5515/refs.master_remote-glob                    |   15 +++++++++++
 65 files changed, 831 insertions(+), 7 deletions(-)
 create mode 100644 t/t5515/refs.br-branches-default
 create mode 100644 t/t5515/refs.br-branches-default-merge
 create mode 100644 t/t5515/refs.br-branches-default-merge_branches-default
 create mode 100644 t/t5515/refs.br-branches-default-octopus
 create mode 100644 t/t5515/refs.br-branches-default-octopus_branches-default
 create mode 100644 t/t5515/refs.br-branches-default_branches-default
 create mode 100644 t/t5515/refs.br-branches-one
 create mode 100644 t/t5515/refs.br-branches-one-merge
 create mode 100644 t/t5515/refs.br-branches-one-merge_branches-one
 create mode 100644 t/t5515/refs.br-branches-one-octopus
 create mode 100644 t/t5515/refs.br-branches-one-octopus_branches-one
 create mode 100644 t/t5515/refs.br-branches-one_branches-one
 create mode 100644 t/t5515/refs.br-config-explicit
 create mode 100644 t/t5515/refs.br-config-explicit-merge
 create mode 100644 t/t5515/refs.br-config-explicit-merge_config-explicit
 create mode 100644 t/t5515/refs.br-config-explicit-octopus
 create mode 100644 t/t5515/refs.br-config-explicit-octopus_config-explicit
 create mode 100644 t/t5515/refs.br-config-explicit_config-explicit
 create mode 100644 t/t5515/refs.br-config-glob
 create mode 100644 t/t5515/refs.br-config-glob-merge
 create mode 100644 t/t5515/refs.br-config-glob-merge_config-glob
 create mode 100644 t/t5515/refs.br-config-glob-octopus
 create mode 100644 t/t5515/refs.br-config-glob-octopus_config-glob
 create mode 100644 t/t5515/refs.br-config-glob_config-glob
 create mode 100644 t/t5515/refs.br-remote-explicit
 create mode 100644 t/t5515/refs.br-remote-explicit-merge
 create mode 100644 t/t5515/refs.br-remote-explicit-merge_remote-explicit
 create mode 100644 t/t5515/refs.br-remote-explicit-octopus
 create mode 100644 t/t5515/refs.br-remote-explicit-octopus_remote-explicit
 create mode 100644 t/t5515/refs.br-remote-explicit_remote-explicit
 create mode 100644 t/t5515/refs.br-remote-glob
 create mode 100644 t/t5515/refs.br-remote-glob-merge
 create mode 100644 t/t5515/refs.br-remote-glob-merge_remote-glob
 create mode 100644 t/t5515/refs.br-remote-glob-octopus
 create mode 100644 t/t5515/refs.br-remote-glob-octopus_remote-glob
 create mode 100644 t/t5515/refs.br-remote-glob_remote-glob
 create mode 100644 t/t5515/refs.br-unconfig
 create mode 100644 t/t5515/refs.br-unconfig_--tags_.._.git
 create mode 100644 t/t5515/refs.br-unconfig_.._.git
 create mode 100644 t/t5515/refs.br-unconfig_.._.git_one
 create mode 100644 t/t5515/refs.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
 create mode 100644 t/t5515/refs.br-unconfig_.._.git_one_two
 create mode 100644 t/t5515/refs.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
 create mode 100644 t/t5515/refs.br-unconfig_.._.git_tag_tag-one_tag_tag-three
 create mode 100644 t/t5515/refs.br-unconfig_branches-default
 create mode 100644 t/t5515/refs.br-unconfig_branches-one
 create mode 100644 t/t5515/refs.br-unconfig_config-explicit
 create mode 100644 t/t5515/refs.br-unconfig_config-glob
 create mode 100644 t/t5515/refs.br-unconfig_remote-explicit
 create mode 100644 t/t5515/refs.br-unconfig_remote-glob
 create mode 100644 t/t5515/refs.master
 create mode 100644 t/t5515/refs.master_--tags_.._.git
 create mode 100644 t/t5515/refs.master_.._.git
 create mode 100644 t/t5515/refs.master_.._.git_one
 create mode 100644 t/t5515/refs.master_.._.git_one_tag_tag-one_tag_tag-three-file
 create mode 100644 t/t5515/refs.master_.._.git_one_two
 create mode 100644 t/t5515/refs.master_.._.git_tag_tag-one-tree_tag_tag-three-file
 create mode 100644 t/t5515/refs.master_.._.git_tag_tag-one_tag_tag-three
 create mode 100644 t/t5515/refs.master_branches-default
 create mode 100644 t/t5515/refs.master_branches-one
 create mode 100644 t/t5515/refs.master_config-explicit
 create mode 100644 t/t5515/refs.master_config-glob
 create mode 100644 t/t5515/refs.master_remote-explicit
 create mode 100644 t/t5515/refs.master_remote-glob

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 31c1081..65c3774 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -131,8 +131,10 @@ do
 	test=`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
 	cnt=`expr $test_count + 1`
 	pfx=`printf "%04d" $cnt`
-	expect="../../t5515/fetch.$test"
-	actual="$pfx-fetch.$test"
+	expect_f="../../t5515/fetch.$test"
+	actual_f="$pfx-fetch.$test"
+	expect_r="../../t5515/refs.$test"
+	actual_r="$pfx-refs.$test"
 
 	test_expect_success "$cmd" '
 		{
@@ -145,14 +147,24 @@ do
 			rm -f .git/refs/tags/*
 			git fetch "$@" >/dev/null
 			cat .git/FETCH_HEAD
-		} >"$actual" &&
-		if test -f "$expect"
+		} >"$actual_f" &&
+		git show-ref >"$actual_r" &&
+		if test -f "$expect_f"
 		then
-			git diff -u "$expect" "$actual" &&
-			rm -f "$actual"
+			git diff -u "$expect_f" "$actual_f" &&
+			rm -f "$actual_f"
 		else
 			# this is to help developing new tests.
-			cp "$actual" "$expect"
+			cp "$actual_f" "$expect_f"
+			false
+		fi &&
+		if test -f "$expect_r"
+		then
+			git diff -u "$expect_r" "$actual_r" &&
+			rm -f "$actual_r"
+		else
+			# this is to help developing new tests.
+			cp "$actual_r" "$expect_r"
 			false
 		fi
 	'
diff --git a/t/t5515/refs.br-branches-default b/t/t5515/refs.br-branches-default
new file mode 100644
index 0000000..21917c1
--- /dev/null
+++ b/t/t5515/refs.br-branches-default
@@ -0,0 +1,12 @@
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default-merge b/t/t5515/refs.br-branches-default-merge
new file mode 100644
index 0000000..21917c1
--- /dev/null
+++ b/t/t5515/refs.br-branches-default-merge
@@ -0,0 +1,12 @@
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default-merge_branches-default b/t/t5515/refs.br-branches-default-merge_branches-default
new file mode 100644
index 0000000..21917c1
--- /dev/null
+++ b/t/t5515/refs.br-branches-default-merge_branches-default
@@ -0,0 +1,12 @@
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default-octopus b/t/t5515/refs.br-branches-default-octopus
new file mode 100644
index 0000000..21917c1
--- /dev/null
+++ b/t/t5515/refs.br-branches-default-octopus
@@ -0,0 +1,12 @@
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default-octopus_branches-default b/t/t5515/refs.br-branches-default-octopus_branches-default
new file mode 100644
index 0000000..21917c1
--- /dev/null
+++ b/t/t5515/refs.br-branches-default-octopus_branches-default
@@ -0,0 +1,12 @@
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default_branches-default b/t/t5515/refs.br-branches-default_branches-default
new file mode 100644
index 0000000..21917c1
--- /dev/null
+++ b/t/t5515/refs.br-branches-default_branches-default
@@ -0,0 +1,12 @@
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one b/t/t5515/refs.br-branches-one
new file mode 100644
index 0000000..8a705a5
--- /dev/null
+++ b/t/t5515/refs.br-branches-one
@@ -0,0 +1,12 @@
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one-merge b/t/t5515/refs.br-branches-one-merge
new file mode 100644
index 0000000..8a705a5
--- /dev/null
+++ b/t/t5515/refs.br-branches-one-merge
@@ -0,0 +1,12 @@
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one-merge_branches-one b/t/t5515/refs.br-branches-one-merge_branches-one
new file mode 100644
index 0000000..8a705a5
--- /dev/null
+++ b/t/t5515/refs.br-branches-one-merge_branches-one
@@ -0,0 +1,12 @@
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one-octopus b/t/t5515/refs.br-branches-one-octopus
new file mode 100644
index 0000000..8a705a5
--- /dev/null
+++ b/t/t5515/refs.br-branches-one-octopus
@@ -0,0 +1,12 @@
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one-octopus_branches-one b/t/t5515/refs.br-branches-one-octopus_branches-one
new file mode 100644
index 0000000..8a705a5
--- /dev/null
+++ b/t/t5515/refs.br-branches-one-octopus_branches-one
@@ -0,0 +1,12 @@
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one_branches-one b/t/t5515/refs.br-branches-one_branches-one
new file mode 100644
index 0000000..8a705a5
--- /dev/null
+++ b/t/t5515/refs.br-branches-one_branches-one
@@ -0,0 +1,12 @@
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-explicit b/t/t5515/refs.br-config-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-explicit-merge b/t/t5515/refs.br-config-explicit-merge
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-explicit-merge
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-explicit-merge_config-explicit b/t/t5515/refs.br-config-explicit-merge_config-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-explicit-merge_config-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-explicit-octopus b/t/t5515/refs.br-config-explicit-octopus
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-explicit-octopus
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-explicit-octopus_config-explicit b/t/t5515/refs.br-config-explicit-octopus_config-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-explicit-octopus_config-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-explicit_config-explicit b/t/t5515/refs.br-config-explicit_config-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-explicit_config-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-glob b/t/t5515/refs.br-config-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-glob-merge b/t/t5515/refs.br-config-glob-merge
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-glob-merge
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-glob-merge_config-glob b/t/t5515/refs.br-config-glob-merge_config-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-glob-merge_config-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-glob-octopus b/t/t5515/refs.br-config-glob-octopus
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-glob-octopus
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-glob-octopus_config-glob b/t/t5515/refs.br-config-glob-octopus_config-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-glob-octopus_config-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-glob_config-glob b/t/t5515/refs.br-config-glob_config-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-config-glob_config-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit b/t/t5515/refs.br-remote-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit-merge b/t/t5515/refs.br-remote-explicit-merge
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-explicit-merge
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit-merge_remote-explicit b/t/t5515/refs.br-remote-explicit-merge_remote-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-explicit-merge_remote-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit-octopus b/t/t5515/refs.br-remote-explicit-octopus
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-explicit-octopus
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit-octopus_remote-explicit b/t/t5515/refs.br-remote-explicit-octopus_remote-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-explicit-octopus_remote-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit_remote-explicit b/t/t5515/refs.br-remote-explicit_remote-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-explicit_remote-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob b/t/t5515/refs.br-remote-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob-merge b/t/t5515/refs.br-remote-glob-merge
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-glob-merge
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob-merge_remote-glob b/t/t5515/refs.br-remote-glob-merge_remote-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-glob-merge_remote-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob-octopus b/t/t5515/refs.br-remote-glob-octopus
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-glob-octopus
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob-octopus_remote-glob b/t/t5515/refs.br-remote-glob-octopus_remote-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-glob-octopus_remote-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob_remote-glob b/t/t5515/refs.br-remote-glob_remote-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-remote-glob_remote-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig b/t/t5515/refs.br-unconfig
new file mode 100644
index 0000000..13e4ad2
--- /dev/null
+++ b/t/t5515/refs.br-unconfig
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_--tags_.._.git b/t/t5515/refs.br-unconfig_--tags_.._.git
new file mode 100644
index 0000000..13e4ad2
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_--tags_.._.git
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_.._.git b/t/t5515/refs.br-unconfig_.._.git
new file mode 100644
index 0000000..70962ea
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_.._.git
@@ -0,0 +1,5 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.br-unconfig_.._.git_one b/t/t5515/refs.br-unconfig_.._.git_one
new file mode 100644
index 0000000..70962ea
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_.._.git_one
@@ -0,0 +1,5 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file b/t/t5515/refs.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
new file mode 100644
index 0000000..13e4ad2
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_.._.git_one_two b/t/t5515/refs.br-unconfig_.._.git_one_two
new file mode 100644
index 0000000..70962ea
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_.._.git_one_two
@@ -0,0 +1,5 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file b/t/t5515/refs.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
new file mode 100644
index 0000000..13e4ad2
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-file
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_.._.git_tag_tag-one_tag_tag-three b/t/t5515/refs.br-unconfig_.._.git_tag_tag-one_tag_tag-three
new file mode 100644
index 0000000..13e4ad2
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_.._.git_tag_tag-one_tag_tag-three
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_branches-default b/t/t5515/refs.br-unconfig_branches-default
new file mode 100644
index 0000000..21917c1
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_branches-default
@@ -0,0 +1,12 @@
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_branches-one b/t/t5515/refs.br-unconfig_branches-one
new file mode 100644
index 0000000..8a705a5
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_branches-one
@@ -0,0 +1,12 @@
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_config-explicit b/t/t5515/refs.br-unconfig_config-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_config-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_config-glob b/t/t5515/refs.br-unconfig_config-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_config-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_remote-explicit b/t/t5515/refs.br-unconfig_remote-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_remote-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_remote-glob b/t/t5515/refs.br-unconfig_remote-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.br-unconfig_remote-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master b/t/t5515/refs.master
new file mode 100644
index 0000000..13e4ad2
--- /dev/null
+++ b/t/t5515/refs.master
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_--tags_.._.git b/t/t5515/refs.master_--tags_.._.git
new file mode 100644
index 0000000..13e4ad2
--- /dev/null
+++ b/t/t5515/refs.master_--tags_.._.git
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_.._.git b/t/t5515/refs.master_.._.git
new file mode 100644
index 0000000..70962ea
--- /dev/null
+++ b/t/t5515/refs.master_.._.git
@@ -0,0 +1,5 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.master_.._.git_one b/t/t5515/refs.master_.._.git_one
new file mode 100644
index 0000000..70962ea
--- /dev/null
+++ b/t/t5515/refs.master_.._.git_one
@@ -0,0 +1,5 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.master_.._.git_one_tag_tag-one_tag_tag-three-file b/t/t5515/refs.master_.._.git_one_tag_tag-one_tag_tag-three-file
new file mode 100644
index 0000000..13e4ad2
--- /dev/null
+++ b/t/t5515/refs.master_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_.._.git_one_two b/t/t5515/refs.master_.._.git_one_two
new file mode 100644
index 0000000..70962ea
--- /dev/null
+++ b/t/t5515/refs.master_.._.git_one_two
@@ -0,0 +1,5 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
diff --git a/t/t5515/refs.master_.._.git_tag_tag-one-tree_tag_tag-three-file b/t/t5515/refs.master_.._.git_tag_tag-one-tree_tag_tag-three-file
new file mode 100644
index 0000000..13e4ad2
--- /dev/null
+++ b/t/t5515/refs.master_.._.git_tag_tag-one-tree_tag_tag-three-file
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_.._.git_tag_tag-one_tag_tag-three b/t/t5515/refs.master_.._.git_tag_tag-one_tag_tag-three
new file mode 100644
index 0000000..13e4ad2
--- /dev/null
+++ b/t/t5515/refs.master_.._.git_tag_tag-one_tag_tag-three
@@ -0,0 +1,11 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_branches-default b/t/t5515/refs.master_branches-default
new file mode 100644
index 0000000..21917c1
--- /dev/null
+++ b/t/t5515/refs.master_branches-default
@@ -0,0 +1,12 @@
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_branches-one b/t/t5515/refs.master_branches-one
new file mode 100644
index 0000000..8a705a5
--- /dev/null
+++ b/t/t5515/refs.master_branches-one
@@ -0,0 +1,12 @@
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_config-explicit b/t/t5515/refs.master_config-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.master_config-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_config-glob b/t/t5515/refs.master_config-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.master_config-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_remote-explicit b/t/t5515/refs.master_remote-explicit
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.master_remote-explicit
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_remote-glob b/t/t5515/refs.master_remote-glob
new file mode 100644
index 0000000..9bbbfd9
--- /dev/null
+++ b/t/t5515/refs.master_remote-glob
@@ -0,0 +1,15 @@
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
+6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
+8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
+22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
+c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
+0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
+525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
-- 
1.5.5.rc1.128.g340c
