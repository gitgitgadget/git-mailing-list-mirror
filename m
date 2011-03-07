From: Andrey Borzenkov <arvidjaar@gmail.com>
Subject: [TopGit PATCH] tg-create: let format.signoff control adding of Signed-off-by
Date: Mon,  7 Mar 2011 13:42:46 +0300
Message-ID: <1299494566-13021-1-git-send-email-arvidjaar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 11:43:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwXuE-0004s6-Ta
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 11:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab1CGKnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 05:43:10 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36227 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab1CGKnI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 05:43:08 -0500
Received: by ewy6 with SMTP id 6so1325220ewy.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 02:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:message-id:x-mailer;
        bh=XoI3IlBVFfOp9lyxEEmLpV4JfAX05CUpsTYO+K3AOs4=;
        b=p6cidqNlfDr/XGwdN/g1pUJxAC39OgLTVDEMj01b0kkX+/h7qk26Ke6MIGEDzlUQQJ
         Yrfq0FDxb/lLjpytwCRZeHLIPY4zHNbXbGVnUPdW+M2WGaChwmZfrVGelPdsGuT09PRP
         hSUb04ngcq0JmsKZsm/7jIph3FUilhu0v8Shk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=WK4LIEZO8N2AERfdsSawoj2l/UxQtOYqw+Sy/6nVuvPr0tFbKdgpOPhLkR/oODMVKU
         I0R5hAHfFCno2gNz3uqaZrvhNVFu3F5QeZzD9Pbtcf8/fbJn0h5N72IwK6a7FhniblxR
         H6ggld5T7MTc/kP3kQDpjWTWjcoCkvhMkYwV0=
Received: by 10.213.2.202 with SMTP id 10mr2298401ebk.95.1299494586667;
        Mon, 07 Mar 2011 02:43:06 -0800 (PST)
Received: from localhost.localdomain (ppp83-237-195-15.pppoe.mtu-net.ru [83.237.195.15])
        by mx.google.com with ESMTPS id l3sm651479fan.0.2011.03.07.02.43.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 02:43:06 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168573>

GIT manual stresses that adding of Signed-off-by should be explicit
user decision. Some projects do ask for no Signed-off-by lines. So
make sure it is added by tg-create.sh only when explicity requested
by user.

Signed-off-by: Andrey Borzenkov <arvidjaar@gmail.com>

---
 tg-create.sh |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tg-create.sh b/tg-create.sh
index 2edd537..617031b 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -129,11 +129,9 @@ author_addr="${author%> *}>"
 	! subject_prefix="$(git config topgit.subjectprefix)" || subject_prefix="$subject_prefix "
 	echo "Subject: [${subject_prefix}PATCH] $name"
 	echo
-	cat <<EOT
-<patch description>
-
-Signed-off-by: $author_addr
-EOT
+	echo '<patch description>'
+	echo
+	[ "$(git config --bool format.signoff)" = true ] && echo "Signed-off-by: $author_addr"
 } >"$root_dir/.topmsg"
 git add -f "$root_dir/.topmsg"
 
-- 
tg: (d279e29..) u/signed-off-by (depends on: master)
