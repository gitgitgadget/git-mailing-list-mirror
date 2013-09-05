From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 05 Sep 2013 16:38:53 -0700
Message-ID: <xmqq7geug7oy.fsf@gitster.dls.corp.google.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John Keeping" <john@keeping.me.uk>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, "Andreas Krey" <a.krey@gmx.de>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Sep 06 01:39:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHj8h-0001sW-Iz
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 01:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab3IEXi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 19:38:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108Ab3IEXi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 19:38:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A3CB3FCD8;
	Thu,  5 Sep 2013 23:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pnv67MJJ3RtgQ7nZIFYhX42XDo8=; b=lsQ10S
	d/sgL/O6T9mlCc9vy2adYfEY9QW627S3LaC2vm1+Av+Oeay1bWLltJvfAArGCGhP
	KQEQhJvHOXuJVOpWqPEpPHNv451lhxxGZ1HbP9m+02tFdSS/4VgEBE2nVGQRy+H4
	1lpDc42uk/YPxLnc0zd1GBlI5e7rL3avw3W6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g0Rd+//LpFbLEomuGV9PsKmzYdpJ0g5U
	GCyZBhHMVFf2EA2fnRrBJP6oUMX2tB2ktvsmQbutKJYYF9HjFxtrIrRQjWUEAs+e
	tzU6mtEfObRDw1P79IToSdJRsa7qw+JDTIqsGAhzBGQU/sRdWFNP5kILKt9k4a1l
	2ek2JVYBKYQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DD233FCD7;
	Thu,  5 Sep 2013 23:38:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 554333FCD2;
	Thu,  5 Sep 2013 23:38:55 +0000 (UTC)
In-Reply-To: <xmqqr4d4jird.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 Sep 2013 15:59:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 541F9F72-1684-11E3-992F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234004>

Junio C Hamano <gitster@pobox.com> writes:

> I can imagine users might want to say "when I am on these small
> number of branches, I want to merge (or rebase), but when I am on
> other, majority of my branches, because they are private, unfinished
> and unpublished work, please stop me from accidentally messing their
> histories with changes from upstream or anywhere else for that
> matter".  If that is the issue you are trying to raise, because
> there is no
>
> 	[pull]
>         	rebase = fail
> 	[branch "master"]
>         	rebase = yes
>
> to force "git pull" to fail by default on any branch while allowing
> it to rebase (or merge, for that matter) only on a few selected
> branches, we fall a bit short.
>
> Which can be solved by adding the above "fail" option, and then
> renaming them to "pull.integrate" and "branch.<name>.integrate" to
> clarify what these variables are about (it is no longer "do you
> rebase or not---if you choose not to rebase, by definition you are
> going to merge", as there is a third choice to "fail"), while
> retaining "pull.rebase" and "branch.<name>.rebase" as a deprecated
> synonym.

The first step of such an enhancement may look like this patch.  It
introduces "pull.integrate" and "branch.<name>.integrate" that will
eventually deprecate "*.rebase", but at this step only supports
values "rebase" and "merge" (i.e. no "fail" yet).

The steps after this change would be to

 * Enhance addition to t5520 made by 949e0d8e (pull: require choice
   between rebase/merge on non-fast-forward pull, 2013-06-27) to
   make sure that setting pull.integrate and branch.<name>.integrate
   will squelch the safety added by that patch;

 * Teach "branch.c" to set "branch.<name>.integrate" either instead
   of or in addition to "branch.<name>.rebase", and adjust tests
   that expect to see "branch.<name>.rebase" to expect to see that
   "branch.<name>.integrate" is set to "rebase";

 * Add "fail" to the set of valid values for "*.integrate", and teach
   "git pull" honor it; and

 * Update builtin/remote.c to show cases where branch.<name>.integrate
   is set to "fail" in some different way.

I do not plan to do these follow-up steps myself soonish (hint,
hint).

 builtin/remote.c | 12 ++++++++++--
 git-pull.sh      | 60 +++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5e54d36..d3b6d0b5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -274,7 +274,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		char *name;
 		struct string_list_item *item;
 		struct branch_info *info;
-		enum { REMOTE, MERGE, REBASE } type;
+		enum { REMOTE, MERGE, REBASE, INTEGRATE } type;
 
 		key += 7;
 		if (!postfixcmp(key, ".remote")) {
@@ -286,6 +286,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		} else if (!postfixcmp(key, ".rebase")) {
 			name = xstrndup(key, strlen(key) - 7);
 			type = REBASE;
+		} else if (!postfixcmp(key, ".integrate")) {
+			name = xstrndup(key, strlen(key) - 10);
+			type = INTEGRATE;
 		} else
 			return 0;
 
@@ -309,8 +312,13 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				space = strchr(value, ' ');
 			}
 			string_list_append(&info->merge, xstrdup(value));
-		} else
+		} else if (type == REBASE) {
 			info->rebase = git_config_bool(orig_key, value);
+		} else if (type == INTEGRATE) {
+			if (!value)
+				return config_error_nonbool(orig_key);
+			info->rebase = !strcmp(value, "rebase");
+		}
 	}
 	return 0;
 }
diff --git a/git-pull.sh b/git-pull.sh
index 88c198f..5c557b7 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -45,16 +45,34 @@ merge_args= edit=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
 
-# See if we are configured to rebase by default.
-# The value $rebase is, throughout the main part of the code:
+# See what we are configured to do by default.
+# The value $integration is, throughout the main part of the code:
 #    (empty) - the user did not have any preference
-#    true    - the user told us to integrate by rebasing
-#    false   - the user told us to integrate by merging
-rebase=$(git config --bool branch.$curr_branch_short.rebase)
-if test -z "$rebase"
-then
-	rebase=$(git config --bool pull.rebase)
-fi
+#    rebase  - the user told us to integrate by rebasing
+#    merge   - the user told us to integrate by merging
+
+integration=
+
+set_integration () {
+	integration=$(git config branch.$curr_branch_short.integrate)
+	test -n "$integration" && return
+
+	case "$(git config --bool branch.$curr_branch_short.rebase)" in
+	true)	integration=rebase ;;
+	false)	integration=merge ;;
+	esac
+	test -n "$integration" && return
+
+	integration=$(git config pull.integrate)
+	test -n "$integration" && return
+
+	case "$(git config --bool pull.rebase)" in
+	true)	integration=rebase ;;
+	false)	integration=merge ;;
+	esac
+}
+
+set_integration
 
 dry_run=
 while :
@@ -119,11 +137,11 @@ do
 		merge_args="$merge_args$xx "
 		;;
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
-		rebase=true
+		integration=rebase
 		;;
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase|\
 	-m|--m|--me|--mer|--merg|--merge)
-		rebase=false
+		integration=merge
 		;;
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
@@ -166,7 +184,7 @@ error_on_no_merge_candidates () {
 		esac
 	done
 
-	if test true = "$rebase"
+	if test "$integration" = rebase
 	then
 		op_type=rebase
 		op_prep=against
@@ -180,7 +198,8 @@ error_on_no_merge_candidates () {
 	remote=$(git config "branch.$curr_branch.remote")
 
 	if [ $# -gt 1 ]; then
-		if [ "$rebase" = true ]; then
+		if test "$integration" = rebase
+		then
 			printf "There is no candidate for rebasing against "
 		else
 			printf "There are no candidates for merging "
@@ -203,7 +222,8 @@ error_on_no_merge_candidates () {
 	exit 1
 }
 
-test true = "$rebase" && {
+if test "$integration" = rebase
+then
 	if ! git rev-parse -q --verify HEAD >/dev/null
 	then
 		# On an unborn branch
@@ -227,7 +247,7 @@ test true = "$rebase" && {
 			break
 		fi
 	done
-}
+fi
 
 orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
@@ -269,7 +289,7 @@ case "$merge_head" in
 	then
 		die "$(gettext "Cannot merge multiple branches into empty head")"
 	fi
-	if test true = "$rebase"
+	if test "$integration" = rebase
 	then
 		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
@@ -279,7 +299,7 @@ case "$merge_head" in
 	# trigger this check when we will say "fast-forward" or "already
 	# up-to-date".
 	merge_head=${merge_head% }
-	if test -z "$rebase$no_ff$ff_only${squash#--no-squash}" &&
+	if test -z "$integration$no_ff$ff_only${squash#--no-squash}" &&
 		test -n "$orig_head" &&
 		test $# = 0 &&
 		! git merge-base --is-ancestor "$orig_head" "$merge_head" &&
@@ -311,7 +331,7 @@ then
 	exit
 fi
 
-if test true = "$rebase"
+if test "$integration" = rebase
 then
 	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
 	if test "$oldremoteref" = "$o"
@@ -321,8 +341,8 @@ then
 fi
 
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
-case "$rebase" in
-true)
+case "$integration" in
+rebase)
 	eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
