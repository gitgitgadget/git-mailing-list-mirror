From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 2/6] tg-remote: use default remote if non is given
Date: Sun,  3 Oct 2010 23:25:53 +0200
Message-ID: <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
 <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:26:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2W4R-0003UE-NI
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190Ab0JCV0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:26:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41867 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab0JCV0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:26:03 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3198195bwz.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=xe0cwFLS1WhUJTf21rYHTQlGFjx/WTEr+KdSboll5Yk=;
        b=M5436583nGH4UQE69YztLbhP+1bE7MhvyOvDoIihqgqCjvbXPurho/Rjmifho8JloX
         Nl2ewrUJ+O67HXLaKlnFS+ppqXB07fYfLs0eFv/aCj26R8BfbTCz9za4CophDTowMxuF
         bvVscb9Cs62clOmTGhvMVtisSeB7YMcIZGozA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X15MuiT2KREClwGY3yIWvSIK7FbtUGPa4NKioT5PXRP2q18WnmLNlV3FSSbc/xLKsD
         aAynNcfdM75f75OWGi1BCX0xMfS0xte749U85OKfjfsm/A2ccjxsUQ7+MBSdZ2R1criq
         8++nAvINfr2qH1ky/0T9tXBZv3MY47YGGt0bk=
Received: by 10.204.113.20 with SMTP id y20mr6184151bkp.170.1286141162726;
        Sun, 03 Oct 2010 14:26:02 -0700 (PDT)
Received: from localhost (p5B0F7E04.dip.t-dialin.net [91.15.126.4])
        by mx.google.com with ESMTPS id f10sm3047147bkl.5.2010.10.03.14.26.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 14:26:01 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157929>

This is usefull if the remote has new topics and you need to populate the local
top-bases.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 README       |    2 +-
 tg-remote.sh |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/README b/README
index c418ff4..5a54468 100644 README
--- a/README
+++ b/README
@@ -327,7 +327,7 @@ tg remote
 	and 'git push' to operate on them. (Do NOT use 'git push --all'
 	for your pushes - plain 'git push' will do the right thing.)
 
-	It takes a mandatory remote name argument, and optional
+	It takes a optional remote name argument, and optional
 	'--populate' switch - use that for your origin-style remote,
 	it will seed the local topic branch system based on the
 	remote topic branches. '--populate' will also make 'tg remote'
diff --git a/tg-remote.sh b/tg-remote.sh
index 86dcd9a..61774d7 100644 tg-remote.sh
--- a/tg-remote.sh
+++ b/tg-remote.sh
@@ -15,13 +15,16 @@ while [ -n "$1" ]; do
 	--populate)
 		populate=1;;
 	-*)
-		echo "Usage: tg [...] remote [--populate] REMOTE" >&2
+		echo "Usage: tg [...] remote [--populate] [REMOTE]" >&2
 		exit 1;;
 	*)
 		name="$arg";;
 	esac
 done
 
+[ -n "$name" ] ||
+	name="$base_remote"
+
 git config "remote.$name.url" >/dev/null || die "unknown remote '$name'"
 
 
-- 
tg: (29ab4cf..) bw/tg-remote-use-defualt-remote (depends on: master)
