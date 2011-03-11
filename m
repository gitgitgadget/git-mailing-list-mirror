From: Andrey Borzenkov <arvidjaar@gmail.com>
Subject: [PATCH TopGit] tg.sh: check for removed branch in branch_annihilated
Date: Fri, 11 Mar 2011 10:28:06 +0300
Message-ID: <1299828486-13167-1-git-send-email-arvidjaar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 08:28:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxwlw-0006SW-1P
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 08:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab1CKH2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 02:28:23 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47700 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab1CKH2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 02:28:22 -0500
Received: by bwz15 with SMTP id 15so2473637bwz.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 23:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:message-id:x-mailer;
        bh=XTllkLe6MLAjoGNBbvTSN6P83dSgzJQiWzfcN32+sSg=;
        b=ZhrNhNJ6JMk5ZzaRopJ1z1wbwwEzHOGRXFXCv63RjwvIaHh4ZeXrrvw0KLqssR+KhI
         d7vWkkhX365D9XRCyHCEJZwDiuV+UmcHb4l3jBTo+OKT+rpjXYRknL2FpjRPBLJfMWhy
         H6MKfHd5lBSeETmFR2r0cSu7jWl46ct5krmhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=fBvziVMi4an95u0usccApoHsxd/nECeL1xah62CjHUCu+TngLgYqADpoPVkOai6BlB
         uEEoASW4fukvAg0XeFM3suYzUEE57WSZAUHD2uFRO0euUhwXBNFDyiiYoDmLFjTLAave
         V9zcK+MF6QHvGf38q28txJLCXQlhtomAbVdZM=
Received: by 10.204.48.33 with SMTP id p33mr6672094bkf.153.1299828501450;
        Thu, 10 Mar 2011 23:28:21 -0800 (PST)
Received: from localhost.localdomain (ppp85-140-30-252.pppoe.mtu-net.ru [85.140.30.252])
        by mx.google.com with ESMTPS id w3sm2687443bkt.5.2011.03.10.23.28.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 23:28:21 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168886>

Check that branch was not deleted by external means; prevents
errors from further git commands due to non-existing refs.

Signed-off-by: Andrey Borzenkov <arvidjaar@gmail.com>

---
 tg.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tg.sh b/tg.sh
index 9082d88..e8447cb 100644
--- a/tg.sh
+++ b/tg.sh
@@ -175,9 +175,9 @@ branch_annihilated()
 	_name="$1";
 
 	# use the merge base in case the base is ahead.
-	mb="$(git merge-base "refs/top-bases/$_name" "$_name")";
+	mb="$(git merge-base "refs/top-bases/$_name" "$_name" 2> /dev/null)";
 
-	test "$(git rev-parse "$mb^{tree}")" = "$(git rev-parse "$_name^{tree}")";
+	test -z "$mb" || test "$(git rev-parse "$mb^{tree}")" = "$(git rev-parse "$_name^{tree}")";
 }
 
 # is_sha1 REF
-- 
tg: (d279e29..) u/removed-branch (depends on: origin/master)
