From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg-info: pretty print dependencies
Date: Tue,  5 Aug 2008 13:19:07 +0200
Message-ID: <1217935147-25927-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 05 13:20:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQKaj-00080G-H3
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 13:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760708AbYHELTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 07:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760696AbYHELTQ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 07:19:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:24702 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758557AbYHELTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 07:19:13 -0400
Received: by nf-out-0910.google.com with SMTP id d3so884607nfc.21
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 04:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=FVC/1LF8rDLvRYWqAVZu0CMj/Kc5v25a1tt2EaTNVNA=;
        b=FQ78pyL9xDZFY09yPYaTkdzum0WUC+O2syCFdb8HA+I4lmZR0hC8UG2ReUhirmE3N+
         N3XBLsyYtITcu1FjI/wgksLoL8px3R1/oGyd6ahxeTkU0bYq9TX7GN7gTRdLRJ0JIqWQ
         neGnxkC6xWKY/mMf+5f0QksR1bnvJrG0b1vls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IBr5HFcCv1k4udcUoHBfpC4Df+5QOmGfH7gkeqRQbz2X/Ah4Oe+WPQVOtK6W12rYly
         uTDld+HPVwSHCu4oAj0cry7YE4yKMr58sJakAOVcpY6amuIA4HYZmoP7Iti57iqEriWg
         BdJ0N+htJg3I8PYiB+1GQ7xRQ0KlLAupdxRHs=
Received: by 10.103.208.15 with SMTP id k15mr519999muq.84.1217935151196;
        Tue, 05 Aug 2008 04:19:11 -0700 (PDT)
Received: from localhost ( [217.234.93.170])
        by mx.google.com with ESMTPS id u26sm4051777mug.4.2008.08.05.04.19.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Aug 2008 04:19:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91435>

Print one dependency per line in tg-info output.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg-info.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tg-info.sh b/tg-info.sh
index ce99809..9e09039 100644
--- a/tg-info.sh
+++ b/tg-info.sh
@@ -38,8 +38,13 @@ echo "Base: $base_rev"
 branch_contains "$name" "$base_rev" ||
 	echo "Base is newer than head! Please run \`tg update\`."
 
-deps="$(git cat-file blob "$name:.topdeps")"
-echo "Depends: $deps"
+prefix="Depends:"
+prefixlen=${#prefix}
+git cat-file blob "$name:.topdeps" 2>/dev/null |
+	while read _dep; do 
+		printf "%-*s %s\n" $prefixlen "$prefix" "$_dep"
+		prefix=""
+	done
 
 depcheck="$(mktemp)"
 needs_update "$name" >"$depcheck"
-- 
1.5.5.GIT
