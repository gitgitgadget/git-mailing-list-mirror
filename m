From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 25/31] rebase: remember verbose option
Date: Sun,  6 Feb 2011 13:43:54 -0500
Message-ID: <1297017841-20678-26-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eJ-0005ZO-97
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab1BFSqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:42 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48348 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab1BFSqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:31 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so1045841qyj.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Q9rnH8ZO51wbl9Urk21xsdEfJ7bOuQWcn357dD6tPTI=;
        b=l/sfxpbpO0TKDDeMH1iQKyPM++LHbAsNu7lnn4i2bkClZ4vLJY8caY5myUCKYeAIVk
         P2Wc1nQt1ztFGB2oknQkhJQLnaEJCsYNrzEL/bDfhjvy5bV79XBo33HNNOeoT0yJ4Xqo
         sLvNB/n0ukqQMXLtGp9rO2zVJEQyJdyWpwI3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IyiFvh2AD0hMytofn8Uhopt29CYIZFZXD6LuQzA21btQNrq7JrkBVDRvCKQJOpMKgQ
         MKyECfd37yyjkciOuQ7d/N7Gu+f9/gJxD4ey9w+i2q0c+P6y58ywlzc4jqnvD8pkrUAe
         cwiDCkXrDPlGNbFmQCwJBUkJniYyH1uro3d+Q=
Received: by 10.229.247.10 with SMTP id ma10mr12872243qcb.4.1297017990867;
        Sun, 06 Feb 2011 10:46:30 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:30 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166182>

Currently, only interactive rebase remembers the value of the '-v'
flag from the initial invocation. Make non-interactive rebase also
remember it.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |    2 --
 git-rebase.sh              |    6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 437cc52..f076a6e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -585,7 +585,6 @@ skip_unnecessary_picks () {
 get_saved_options () {
 	test -d "$rewritten" && preserve_merges=t
 	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
-	test -f "$state_dir"/verbose && verbose=t
 	test -f "$state_dir"/rebase-root && rebase_root=t
 }
 
@@ -715,7 +714,6 @@ case "$rebase_root" in
 	: >"$state_dir"/rebase-root ;;
 esac
 test -z "$strategy" || echo "$strategy" > "$state_dir"/strategy
-test t = "$verbose" && : > "$state_dir"/verbose
 if test t = "$preserve_merges"
 then
 	if test -z "$rebase_root"
diff --git a/git-rebase.sh b/git-rebase.sh
index 5a399aa..8a36e7a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -79,14 +79,16 @@ read_basic_state () {
 	else
 		orig_head=$(cat "$state_dir"/head)
 	fi &&
-	GIT_QUIET=$(cat "$state_dir"/quiet)
+	GIT_QUIET=$(cat "$state_dir"/quiet) &&
+	test -f "$state_dir"/verbose && verbose=t
 }
 
 write_basic_state () {
 	echo "$head_name" > "$state_dir"/head-name &&
 	echo "$onto" > "$state_dir"/onto &&
 	echo "$orig_head" > "$state_dir"/orig-head &&
-	echo "$GIT_QUIET" > "$state_dir"/quiet
+	echo "$GIT_QUIET" > "$state_dir"/quiet &&
+	test t = "$verbose" && : > "$state_dir"/verbose
 }
 
 output () {
-- 
1.7.4.rc2.33.g8a14f
