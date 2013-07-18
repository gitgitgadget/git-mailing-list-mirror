From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] pull: require choice between rebase/merge on non-fast-forward pull
Date: Thu, 18 Jul 2013 12:35:11 -0700
Message-ID: <7vvc471x1s.fsf_-_@alter.siamese.dyndns.org>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130718143009.GC2337@serenity.lan> <871u6v93a8.fsf@igel.home>
	<7vmwpj3g0l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 21:35:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uztz2-0003Dw-Di
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 21:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302Ab3GRTfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 15:35:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60585 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758908Ab3GRTfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 15:35:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2222032AAA;
	Thu, 18 Jul 2013 19:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qmsov6/EiTV1E+DFPgNAQtSePvw=; b=Z4KyV1
	2mf0MHCFF/0mubYDSe2WjUjsAJ2+lqvNdIayfMCqNG0/Xb61vG6DmXRhiiiM4OWx
	/72Acl7BSDJZQU+VCUyDD8sbasMS6nk8kcOFuXvEXo3meryvd6YFXBjBRiQUKABU
	xQxV0vvnMq7h3udFTYf170dDQo1VLWIIIkPio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qt004eBmIZ3r7rMDgoe91juiqZH3i+Fw
	5nKHUfk4uhee/791M7OuXtl6/RbRszMx9VXMromRbFUgcr0FiccqIVc2oYGLsdZq
	x2uVG9fxWJBP46svueW+0gVXiS3NRXe7b5tow+p4InJkDcA6GLlQBdUuFiJCTyTD
	/kqOy6Yl7us=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1735432AA9;
	Thu, 18 Jul 2013 19:35:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D61A32AA8;
	Thu, 18 Jul 2013 19:35:13 +0000 (UTC)
In-Reply-To: <7vmwpj3g0l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 18 Jul 2013 11:00:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2AE1FAF2-EFE1-11E2-9BEE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230729>

Because it is so easy to let Git handle automatically a trivial
merge with "git pull", a person who is new to Git may not realize
that the project s/he is interacting with may prefer a "rebase"
workflow.

Add a safety valve to fail "git pull" that does not explicitly
specify what branch from which repository to integrate your history
with, when it is neither a fast-forward or "already up-to-date",
until/unless the user expressed her preference between the two ways
of integration.

This can be an irritating backward incompatible change for old
timers, but it can be a one time irritation by doing:

    git config --global pull.rebase false

once to say "I will always --merge", and they'd not even notice.

    http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225326

for a full discussion.

Helped-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with updates to the documentation and the test suite.

 Documentation/git-pull.txt |  9 ++++++++
 git-pull.sh                | 40 +++++++++++++++++++++++++++++++++++-
 t/t5520-pull.sh            | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t5524-pull-msg.sh        |  2 +-
 4 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 24ab07a..86f5170 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -97,6 +97,14 @@ must be given before the options meant for 'git fetch'.
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
+When `git pull` that does not explicitly specify what branch from
+which repository is to be integrated with your history on the
+command line, recent Git will refuse to work until you specify how
+that integration should happen, either with a command line option
+(`--merge` or `--rebase`) or a configuration variable (`pull.rebase`
+or `branch.<name>.rebase`, which is the same as `--merge`
+(`--rebase`) when set to `false` (`true`) respectively.
+
 include::merge-options.txt[]
 
 :git-pull: 1
@@ -119,6 +127,7 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
+--merge::
 --no-rebase::
 	Override earlier --rebase.
 
diff --git a/git-pull.sh b/git-pull.sh
index 638aabb..88c198f 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -41,13 +41,21 @@ test -f "$GIT_DIR/MERGE_HEAD" && die_merge
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
 log_arg= verbosity= progress= recurse_submodules= verify_signatures=
 merge_args= edit=
+
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
+
+# See if we are configured to rebase by default.
+# The value $rebase is, throughout the main part of the code:
+#    (empty) - the user did not have any preference
+#    true    - the user told us to integrate by rebasing
+#    false   - the user told us to integrate by merging
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
 if test -z "$rebase"
 then
 	rebase=$(git config --bool pull.rebase)
 fi
+
 dry_run=
 while :
 do
@@ -113,7 +121,8 @@ do
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
 		rebase=true
 		;;
-	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
+	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase|\
+	-m|--m|--me|--mer|--merg|--merge)
 		rebase=false
 		;;
 	--recurse-submodules)
@@ -219,6 +228,7 @@ test true = "$rebase" && {
 		fi
 	done
 }
+
 orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0
@@ -264,6 +274,34 @@ case "$merge_head" in
 		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
 	;;
+*)
+	# integrating with a single other history; be careful not to
+	# trigger this check when we will say "fast-forward" or "already
+	# up-to-date".
+	merge_head=${merge_head% }
+	if test -z "$rebase$no_ff$ff_only${squash#--no-squash}" &&
+		test -n "$orig_head" &&
+		test $# = 0 &&
+		! git merge-base --is-ancestor "$orig_head" "$merge_head" &&
+		! git merge-base --is-ancestor "$merge_head" "$orig_head"
+	then
+echo >&2 "orig-head was $orig_head"
+echo >&2 "merge-head is $merge_head"
+git show >&2 --oneline -s "$orig_head" "$merge_head"
+
+		die "The pull does not fast-forward; please specify
+if you want to merge or rebase.
+
+Use either
+
+    git pull --rebase
+    git pull --merge
+
+You can also use 'git config pull.rebase true' (if you want --rebase) or
+'git config pull.rebase false' (if you want --merge) to set this once for
+this project and forget about it."
+	fi
+	;;
 esac
 
 if test -z "$orig_head"
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 6af6c63..1e91eca 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,4 +255,55 @@ test_expect_success 'git pull --rebase against local branch' '
 	test file = "$(cat file2)"
 '
 
+test_expect_success 'git pull that does not say how to integrate' '
+	git checkout -b other master^1 &&
+	>new &&
+	git add new &&
+	git commit -m "add new file" &&
+
+	git checkout -b test-to-integrate master &&
+
+	test_config branch.test-to-integrate.remote . &&
+	test_config branch.test-to-integrate.merge other &&
+
+	# need real integration
+	test_must_fail git pull &&
+	git reset --hard master &&
+
+
+	# configuration is explicit enough
+	for how in false true
+	do
+		test_config pull.rebase $how &&
+		git pull &&
+		git reset --hard master || break
+	done &&
+
+	# per branch configuration is explicit enough
+	test_unconfig pull.rebase &&
+	for how in false true
+	do
+		test_config branch.test-to-integrate.rebase $how &&
+		git pull &&
+		git reset --hard master || break
+	done &&
+
+	test_unconfig pull.rebase &&
+	test_unconfig branch.test-to-integrate &&
+
+	# already up to date
+	git reset --hard master &&
+	git branch -f other master^1
+	git pull &&
+
+	# fast forward
+	git reset --hard master &&
+	git checkout -B other master &&
+	>new &&
+	git add new &&
+	git commit -m "add new file" &&
+	git checkout -B test-to-integrate master &&
+	git pull
+'
+
 test_done
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index 8cccecc..660714b 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 test_expect_success pull '
 (
 	cd cloned &&
-	git pull --log &&
+	git pull --log --merge &&
 	git log -2 &&
 	git cat-file commit HEAD >result &&
 	grep Dollar result
-- 
1.8.3.3-992-gf0e5e44
