From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 1/6] Let tg-update take a branch parameter
Date: Sun,  3 Oct 2010 23:25:52 +0200
Message-ID: <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:26:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2W4R-0003UE-6Z
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180Ab0JCV0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:26:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41867 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab0JCV0B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:26:01 -0400
Received: by bwz11 with SMTP id 11so3198195bwz.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=QiV0xCRS6JrIyE9wce7DFvE8SLJYZVl699GThITs9Co=;
        b=OK9flYAmFya0Xr+ZBp2ZRAk7vhmBq+4/aj7xtd2DxF2HmB5Igb9cJMWVyrRAU5J8E1
         uF5qXaMGyvft6DMrRkQdQNBEMugAAiwl/RT+xahtt2/XL/mTI77Cugffp0NU5QSrA3wW
         lAevtHRk6Ldk2TjIiCD7YkPRLMPX8LYlIs8r4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HtNMs/2uJ50ogekofxIFW6xEJNVwuw+tP1Thcnl2Tlbgjyx8RzrmL/ZD9d2XW9TnOJ
         iPRSWCL5ca++J5eLvdhUp3Ecr0lcj/PtSZmheYU+oYmcJPFNExOafqUGi8jdCw0xFLWJ
         BCSbz+y5Wh5pxcBIM0LfhyJ/1KnOqZC8+mezM=
Received: by 10.204.65.71 with SMTP id h7mr6100935bki.175.1286141160030;
        Sun, 03 Oct 2010 14:26:00 -0700 (PDT)
Received: from localhost (p5B0F7E04.dip.t-dialin.net [91.15.126.4])
        by mx.google.com with ESMTPS id v7sm3041821bkx.16.2010.10.03.14.25.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 14:25:59 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157928>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 README                     |    6 ++++--
 contrib/tg-completion.bash |    7 ++++++-
 tg-update.sh               |   18 ++++++++++++------
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/README b/README
index c418ff4..dba2345 100644 README
--- a/README
+++ b/README
@@ -472,13 +472,15 @@ tg import
 
 tg update
 ~~~~~~~~~
-	Update the current topic branch wrt. changes in the branches
-	it depends on and remote branches.
+	Update the current or specified topic branch wrt. changes in the
+	branches it depends on and remote branches.
 	This is performed in two phases - first,
 	changes within the dependencies are merged to the base,
 	then the base is merged into the topic branch.
 	The output will guide you in case of conflicts.
 
+	After the update the current branch is the specified one.
+
 	In case your dependencies are not up-to-date, tg update
 	will first recurse into them and update these.
 
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index 0ee233c..5aabc92 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -423,7 +423,12 @@ _tg_summary ()
 
 _tg_update ()
 {
-	COMPREPLY=()
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
 }
 
 ### }}}
diff --git a/tg-update.sh b/tg-update.sh
index 73280c6..b256c7c 100644 tg-update.sh
--- a/tg-update.sh
+++ b/tg-update.sh
@@ -8,13 +8,19 @@ name=
 
 ## Parse options
 
-if [ -n "$1" ]; then
-	echo "Usage: tg [...] update" >&2
-	exit 1
-fi
-
-
-name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-*)
+		echo "Usage: tg [...] update [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
-- 
tg: (29ab4cf..) bw/update-does-checkout (depends on: master)
