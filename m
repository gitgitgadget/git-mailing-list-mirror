From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v3 06/12] list_deps: accept -i/-w
Date: Wed, 20 Oct 2010 22:17:51 +0200
Message-ID: <e3ce8e49edc363c62c6135ffe94dd1e5990cce6a.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
 <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
 <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
 <d9fc8653e6e4c7eb7197a0fb92cd3b8c6e058187.1287605587.git.bert.wesarg@googlemail.com>
 <d1c407c33f446a6e5c7329ba521871732a136fa6.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:19:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f7o-0005GB-1P
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab0JTUS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52724 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab0JTUSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:23 -0400
Received: by mail-gw0-f46.google.com with SMTP id a12so42351gwa.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=vNVLjtMUSNQbHnbnFZjejJ/gIhMY9CeFMPW1OG113d0=;
        b=Y4RFA914nDQuuiVLlulggTWlLypEA11YA9iZyo2HSZPqzJmbU35pXqrHhal4J3noSz
         UF33DnBfoyTZAyclJcBuTJdYhHF9Mil6PWZ/MdcBYvmYs4dxmLnhHSiWco4sN9kXROL6
         XSFZoOuOkGMjNaKG3ngFJrrCS9ue9hotSo9xM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=asSG2cgSmq+SqOHBpyZU4qZIF7tUMizhqJMf3QGqhy459Qyk50N475fU1Yxuv1SYo+
         nx/H9+GSNW4T+0rq0ucmJQTOkFhezgy1klC/dxm9cLAchfpLDVD4hnygIv5X0DgPR4IK
         4F4eOUfvynR/2VJbhQNxe7K8xlb3gXTR0ynIg=
Received: by 10.103.198.14 with SMTP id a14mr1888muq.4.1287605902845;
        Wed, 20 Oct 2010 13:18:22 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id r22sm404595fax.45.2010.10.20.13.18.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <d1c407c33f446a6e5c7329ba521871732a136fa6.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159428>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tg.sh b/tg.sh
index 949d2a4..4b6820b 100644
--- a/tg.sh
+++ b/tg.sh
@@ -288,9 +288,13 @@ branch_empty()
 	[ "$(pretty_tree "$1" -b)" = "$(pretty_tree "$1" ${2-})" ]
 }
 
-# list_deps
+# list_deps [-i | -w]
+# -i/-w apply only to HEAD
 list_deps()
 {
+	head="$(git symbolic-ref HEAD)"
+	head="${head#refs/heads/}"
+
 	git for-each-ref refs/top-bases |
 		while read rev type ref; do
 			name="${ref#refs/top-bases/}"
@@ -298,7 +302,10 @@ list_deps()
 				continue;
 			fi
 
-			git cat-file blob "$name:.topdeps" | while read dep; do
+			from=$head_from
+			[ "$name" = "$head" ] ||
+				from=
+			cat_file "$name:.topdeps" $from | while read dep; do
 				dep_is_tgish=true
 				ref_exists "refs/top-bases/$dep"  ||
 					dep_is_tgish=false
-- 
1.7.3.1.1069.g89486
