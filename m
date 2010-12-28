From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 22/31] rebase: make -v a tiny bit more verbose
Date: Tue, 28 Dec 2010 10:30:39 +0100
Message-ID: <1293528648-21873-23-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYn-0005Wr-UB
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab0L1PdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:10 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60539 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab0L1PdC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:02 -0500
Received: by qwa26 with SMTP id 26so9392227qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C1f7SR6BDXME17GRNJMobr5GOLuYfK3CdOWEvfkUtBk=;
        b=NlQAOA6bxm+ES8Z+s+QC8paM/V9JM/Wav1DTNiu6sSUmpNYl+9LHKL69EtUmZxmij3
         Refa21lgJ6fMlclebCSp0ZenMczqTnWVlvpUAJZroMFmhCDL0qHbBn3GqYg7zIzpDHfj
         ePpL6WTBrT1PRFibABDGNd1XKvI3PGuA2kCI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A7frL4Et+AaoeqDX1hj0nn8gw+60JcBk+5mjSgC5wlwmPjChc5NkRsYYpje62Kcsx1
         dBeTRewup3LWdjcuMvfNAK9De64FuBgWPx61N1b6mU7Ys+XyObD+gWpZYHfZH9QeqQ3p
         /ZtXVmfT7Q1JVE5Q69qfM7L+oZa1FjCzx7RZc=
Received: by 10.224.37.145 with SMTP id x17mr13010451qad.8.1293550381608;
        Tue, 28 Dec 2010 07:33:01 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.33.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:33:01 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164260>

To make it possible to later remove the handling of --abort from
git-rebase--interactive.sh, align the implementation in git-rebase.sh
with the former by making it a bit more verbose.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

What do we really want to print when -v is passed? Interactive rebase
is currently quite a bit more verbose than non-interactive rebase.

 git-rebase--interactive.sh |   14 --------------
 git-rebase.sh              |   20 +++++++++++++++++---
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index eace4e5..acd0258 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -86,20 +86,6 @@ warn () {
 	printf '%s\n' "$*" >&2
 }
 
-output () {
-	case "$verbose" in
-	'')
-		output=$("$@" 2>&1 )
-		status=$?
-		test $status != 0 && printf "%s\n" "$output"
-		return $status
-		;;
-	*)
-		"$@"
-		;;
-	esac
-}
-
 # Output the commit message for the specified commit.
 commit_message () {
 	git cat-file commit "$1" | sed "1,/^$/d"
diff --git a/git-rebase.sh b/git-rebase.sh
index 615d9dd..0322f27 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -74,6 +74,20 @@ read_basic_state () {
 	GIT_QUIET=$(cat "$state_dir"/quiet)
 }
 
+output () {
+	case "$verbose" in
+	'')
+		output=$("$@" 2>&1 )
+		status=$?
+		test $status != 0 && printf "%s\n" "$output"
+		return $status
+		;;
+	*)
+		"$@"
+		;;
+	esac
+}
+
 move_to_original_branch () {
 	case "$head_name" in
 	refs/*)
@@ -95,7 +109,7 @@ run_specific_rebase () {
 	force_rebase action preserve_merges upstream switch_to head_name \
 	state_dir orig_head onto_name GIT_QUIET revisions RESOLVEMSG \
 	allow_rerere_autoupdate git_am_opt
-	export -f move_to_original_branch
+	export -f move_to_original_branch output
 	exec git-rebase--$type
 }
 
@@ -268,7 +282,7 @@ continue)
 	run_specific_rebase
 	;;
 skip)
-	git reset --hard HEAD || exit $?
+	output git reset --hard HEAD || exit $?
 	read_basic_state
 	run_specific_rebase
 	;;
@@ -281,7 +295,7 @@ abort)
 		die "Could not move back to $head_name"
 		;;
 	esac
-	git reset --hard $orig_head
+	output git reset --hard $orig_head
 	rm -r "$state_dir"
 	exit
 	;;
-- 
1.7.3.2.864.gbbb96
