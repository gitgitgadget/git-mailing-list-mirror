From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] git stash: one bug and one feature request
Date: Fri, 4 Jan 2008 17:14:42 +0100
Message-ID: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 17:15:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JApCU-00066W-Lx
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 17:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbYADQOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 11:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYADQOq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 11:14:46 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:3233 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbYADQOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 11:14:45 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6169842rvb.1
        for <git@vger.kernel.org>; Fri, 04 Jan 2008 08:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=RpsOLfBXeM0D01WUqfngp7YDFB60L2bci8NnSz8Zw8I=;
        b=E0/pQgUmz83z+trzEfu48Vx1/7elISPGonxmvbCReV/QK37eitfLLvxVq+iMf0UrVBH+W7b1sVTO4ojis7eO+7kUGhom7jteCeLusy+gTrKj/f0QtjTvNTrjjZv6D1AP0JppsGIF9RJ0hkWfZb4ZpY6JKSh47L1ZcyEg0eEDzpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lAP/itKEWWJIjbKiR+1Rl3lfR7esUgnzqfA/6JQ1bG18FFyePXrGAhpT/q/ukGPIgATL4Rjni+/ATSmB4BFso03Hyave6w4U5R0scOkHGUysHLqBGD1bJ6SKwT7/ranLmUek/XnSqgJWZ2pXv7YIRN4SdIFV5SfyrCoFbL4SUlI=
Received: by 10.140.251.1 with SMTP id y1mr8939341rvh.149.1199463282687;
        Fri, 04 Jan 2008 08:14:42 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 4 Jan 2008 08:14:42 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69580>

Currently git-stash writes to stderr also if there is nothing to error
out, also it would be very nice ;-) if git 'stash clear command' would
support deleting of only one patch, so as example to write

stg stash clear stash@{0}

To remove only the last added.


------------------  cut --------------------------

From: Marco Costalba <mcostalba@gmail.com>
Date: Fri, 4 Jan 2008 17:08:01 +0100
Subject: [PATCH] git-stash: avoid writing to stderr when is not an error

Otherwise git-stash is unusable by scripts that check
stderr to detect fail/success of launched command.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 git-stash.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 06cb177..a05a47a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -86,7 +86,7 @@ save_stash () {

 	if no_changes
 	then
-		echo >&2 'No local changes to save'
+		echo > 'No local changes to save'
 		exit 0
 	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
@@ -99,7 +99,7 @@ save_stash () {

 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
-	printf >&2 'Saved working directory and index state "%s"\n' "$stash_msg"
+	printf > 'Saved working directory and index state "%s"\n' "$stash_msg"
 }

 have_stash () {
@@ -229,7 +229,7 @@ create)
 	if test $# -eq 0
 	then
 		save_stash &&
-		echo >&2 '(To restore them type "git stash apply")' &&
+		echo > '(To restore them type "git stash apply")' &&
 		git-reset --hard
 	else
 		usage
-- 
1.5.4.rc2.18.g530e6
