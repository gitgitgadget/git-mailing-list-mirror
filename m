From: Dominique Quatravaux <domq@google.com>
Subject: [PATCHv2 2/2] rebase -i: new option --name-rev
Date: Thu,  8 Mar 2012 14:52:57 +0100
Message-ID: <1331214777-9455-2-git-send-email-domq@google.com>
References: <1331214777-9455-1-git-send-email-domq@google.com>
Cc: Dominique Quatravaux <domq@google.com>
To: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 15:01:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5dub-0000ZY-Fm
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 15:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940Ab2CHOBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 09:01:39 -0500
Received: from mail-gx0-f202.google.com ([209.85.161.202]:44313 "EHLO
	mail-gx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab2CHOBi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 09:01:38 -0500
Received: by ggnd2 with SMTP id d2so56139ggn.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+vlIFxp3eZ1Yd/H+GQL1hxKhwM83P3t18jCtr5QaaCQ=;
        b=chuWy+6hFpnRL5PumM2wAGPgEgL9V/elt4dCnjp6ONId0iw06zzSevWE9Wo7ryx06i
         h3Qhmvsu+1NprJ+XdlDxzEXFdG8GgaUK5BzElRAEDtJP2olDKyAVH9NS8MPoqdSNN0Hz
         KFdAvDel0d2h4IKUx/+KVzeq7rS5UqJ69l+dQMatfWQBsDuxX7LSu/U0HdQPH8H5jznW
         1uavkDVPsL6pUjondPBlHNHC/PcJOYSKG79fS43geuqK4vywiW4h2IkusZhih7hK4GGS
         fUVF30KYsWzVzmG+LiI2C0Bxqc08hJXwqPPjEmf+ryqu38aEHbmlgOHvu1xP26AHKrJU
         KrHg==
Received: by 10.100.230.15 with SMTP id c15mr2104889anh.7.1331214867065;
        Thu, 08 Mar 2012 05:54:27 -0800 (PST)
Received: by 10.100.230.15 with SMTP id c15mr2104873anh.7.1331214866936;
        Thu, 08 Mar 2012 05:54:26 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id t62si643244yhj.2.2012.03.08.05.54.26
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 08 Mar 2012 05:54:26 -0800 (PST)
Received: from alliance-maui.zrh.corp.google.com (alliance-maui.zrh.corp.google.com [172.28.204.12])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id A984C10004D;
	Thu,  8 Mar 2012 05:54:26 -0800 (PST)
Received: by alliance-maui.zrh.corp.google.com (Postfix, from userid 71297)
	id A09F66013A; Thu,  8 Mar 2012 14:54:25 +0100 (CET)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1331214777-9455-1-git-send-email-domq@google.com>
X-Gm-Message-State: ALoCoQmAKwpXriRHlOOY/uA6VPJPhsrydvjAhJ0e8xzY2NFXYjOb5RdzG+aNW0GP+1vc27AWgYlMCXtuRzWJHp/9snR0ALWVwuY8IqLMtwjEehLGVv9gvYm87birjU2fuNQVKFN/0ULzngfxBtr0WlgmDgmOQ/g+bkdygBNizBqbVyba0y9lZ5o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192604>

If set, the second column of the rebase todo contains named revisions (obtained
with git name-rev) instead of short SHA1s.
---
 Documentation/git-rebase.txt  |    7 +++++++
 git-rebase--interactive.sh    |   10 ++++++++--
 git-rebase.sh                 |   10 ++++++++++
 t/t3404-rebase-interactive.sh |   10 ++++++++++
 t/t3415-rebase-autosquash.sh  |   24 ++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 504945c..da2aca7 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -365,6 +365,13 @@ If the '--autosquash' option is enabled by default using the
 configuration variable `rebase.autosquash`, this option can be
 used to override and disable this setting.
 
+--name-rev::
+	Instead of showing short SHA1 hashes in the todo list, show
+	human-readable revisions obtained with linkgit:git-name-rev[1].
++
+This option is only valid when the '--interactive' option is used. It can also
+be set through the `rebase.interactiveNameRev` configuration variable.
+
 --no-ff::
 	With --interactive, cherry-pick all rebased commits instead of
 	fast-forwarding over the unchanged ones.  This ensures that the
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e408e94..c597b6b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -780,9 +780,15 @@ git rev-list $merges_option --format="%m%H %h %s" --abbrev-commit \
 	sed -n "s/^>//p" |
 while read -r sha1 shortsha1 rest
 do
+	if test t = "$name_rev"
+	then
+		rev="$(git name-rev $sha1 | cut -d\  -f2)"
+	else
+		rev="$shortsha1"
+	fi
 	if test t != "$preserve_merges"
 	then
-		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
+		printf '%s\n' "pick $rev $rest" >> "$todo"
 	else
 		if test -z "$rebase_root"
 		then
@@ -800,7 +806,7 @@ do
 		if test f = "$preserve"
 		then
 			touch "$rewritten"/$sha1
-			printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
+			printf '%s\n' "pick $rev $rest" >> "$todo"
 		fi
 	fi
 done
diff --git a/git-rebase.sh b/git-rebase.sh
index 69c1374..9330be3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,6 +43,8 @@ s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
+name-rev           show revisions by name in the list of commits
+no-name-rev        show revisions by short SHA1 in the list (default)
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=! pass the argument through to the merge strategy
 stat!              display a diffstat of what changed upstream
@@ -98,6 +100,8 @@ action=
 preserve_merges=
 autosquash=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
+name_rev=
+test "$(git config --bool rebase.interactivenamerev)" = "true" && name_rev=t
 
 read_basic_state () {
 	head_name=$(cat "$state_dir"/head-name) &&
@@ -287,6 +291,12 @@ do
 	-f|--no-ff)
 		force_rebase=t
 		;;
+	--name-rev)
+		name_rev=t
+		;;
+	--no-name-rev)
+		name_rev=
+		;;
 	--rerere-autoupdate|--no-rerere-autoupdate)
 		allow_rerere_autoupdate="$1"
 		;;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b981572..f3b4214 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -163,6 +163,16 @@ test_expect_success 'exchange two commits' '
 	test G = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+cat > expect-rebase-todo <<EOF
+pick branch1~1 H
+pick branch1 G
+EOF
+
+test_expect_success 'Symbolic revisions in --name-rev' '
+	FAKE_LINES="exec_cp_.git/rebase-merge/git-rebase-todo_rebase-todo 1 2" git rebase -i --name-rev HEAD~2 &&
+	test_cmp expect-rebase-todo rebase-todo
+'
+
 cat > expect << EOF
 diff --git a/file1 b/file1
 index f70f10e..fd79235 100644
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index b38be8e..3062e24 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -169,6 +169,30 @@ test_expect_success 'auto squash that matches longer sha1' '
 	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
 '
 
+test_expect_success 'auto fixup with --name-rev' '
+	git reset --hard base &&
+	echo 2 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "changing file1" &&
+	echo 4 >file2 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "changing file2" &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "fixup! changing file1" &&
+	git tag final-fixup-name-rev &&
+	test_tick &&
+	git rebase -i --autosquash --name-rev HEAD^^^ &&
+	git log --oneline base..HEAD >actual &&
+	test 2 = $(wc -l <actual) &&
+	git diff --exit-code final-fixup-name-rev &&
+	test 2 = "$(git cat-file blob HEAD^:file2)" &&
+	test 1 = $(git cat-file commit HEAD^ | grep changing | wc -l)
+'
+
 test_auto_commit_flags () {
 	git reset --hard base &&
 	echo 1 >file1 &&
-- 
1.7.7.3
