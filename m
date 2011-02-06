From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 22/31] rebase: make -v a tiny bit more verbose
Date: Sun,  6 Feb 2011 13:43:51 -0500
Message-ID: <1297017841-20678-23-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eF-0005ZO-DH
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab1BFSqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:31 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58927 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab1BFSq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:26 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so3422584qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=4z/YDikY08gL0oyXLfZ61HRxEROdBTgl3gqXQEDB8EA=;
        b=q46CPsyPsGHnVoofnnrYLokpolC9oyK8BGPndcQZPH/1+Ee8hIsrjeYQKkrKEfrEk0
         3q9m8dlw7Ew5y2M7AXeBm2ipDcWY67JR0fxePCGNv08WltbkPN93jFYdbmjSOFQWAA/b
         pEVtYN1HjMFwZcLJaCTXn3TV1mTNmjQDZRBpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HxeUBYp+tzPCVKc3t7/8PfIcsYjh+IpWDDdOWDP7OkrQ/LgK7QAm5kP8v1Zro1ILPP
         YmgqmshyWXzq5cpfOEUHBe4iKvAHXNhvzlNK4AIvV3frOYqZIR7KvNeTmVMqR+Pcidon
         lkMe7Cs1vfiVB9wxExS05TDS2spDwrKSVWfvE=
Received: by 10.224.210.195 with SMTP id gl3mr13512993qab.67.1297017985783;
        Sun, 06 Feb 2011 10:46:25 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:25 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166180>

To make it possible to later remove the handling of --abort from
git-rebase--interactive.sh, align the implementation in git-rebase.sh
with the former by making it a bit more verbose.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
What do we really want to print when -v is passed? Interactive rebase
is currently quite a bit more verbose than non-interactive rebase.


 git-rebase--interactive.sh |   14 --------------
 git-rebase.sh              |   18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index fa8bfda..affa467 100755
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
index c60221b..42d635b 100755
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
@@ -263,7 +277,7 @@ continue)
 	run_specific_rebase
 	;;
 skip)
-	git reset --hard HEAD || exit $?
+	output git reset --hard HEAD || exit $?
 	read_basic_state
 	run_specific_rebase
 	;;
@@ -276,7 +290,7 @@ abort)
 		die "Could not move back to $head_name"
 		;;
 	esac
-	git reset --hard $orig_head
+	output git reset --hard $orig_head
 	rm -r "$state_dir"
 	exit
 	;;
-- 
1.7.4.rc2.33.g8a14f
