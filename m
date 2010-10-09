From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 05/11] list_deps: accept -i/-w
Date: Sat,  9 Oct 2010 22:56:56 +0200
Message-ID: <b765e0da80781182bf6c3af8f28d9496ed49cc1b.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
 <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
 <6e000c8cf21fac6cd4cf8608c8dc021b039e6f83.1286657607.git.bert.wesarg@googlemail.com>
 <ec70ec8e15013f663bba7f62885abe6881a1512a.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:58:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gUl-0008SF-M7
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760606Ab0JIU6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:58:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760545Ab0JIU6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:58:11 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=NLLWgoFZWrtpGiaNNAPnps68FaMDgHndI947XI0LpCU=;
        b=HKyT7n+HQOucNaZTJwBcO+ErFcufWRYYB6SrXST2vMC5P82vR+J8Pr9I5X+OMyNHkt
         VZhRd4pNXmn4RjTboFrX/PVJhTIXBuGo7DgT5I0VxYprUkuFd/DK2mwlu8PBx/XhUmTW
         y+vBkMh8OThJ9NYc6NDOpHN2Ki2H81I/Yd3/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q4H+iqqCxNf/bzkJa6kwfVhmlxjb/gmhhfgIvxKFrho+v7BsOUa7gDcJPFqPGiR0VH
         vYFGej003arJ7/qmfW5bzxAPMzWPY0r+gXcsbS5moHHvBYHJEoJ6yWbFMweRZ262MOtQ
         PVg0WBzxDDCHVLp9SMFZKehC92/CgMXaIY/TQ=
Received: by 10.14.119.10 with SMTP id m10mr935052eeh.10.1286657891128;
        Sat, 09 Oct 2010 13:58:11 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id u9sm7833099eeh.5.2010.10.09.13.58.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:58:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <ec70ec8e15013f663bba7f62885abe6881a1512a.1286657607.git.bert.wesarg@googlemail.com>
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158615>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tg.sh b/tg.sh
index a166a70..72ee9f5 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -289,9 +289,13 @@ branch_empty()
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
@@ -299,7 +303,10 @@ list_deps()
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
1.7.1.1067.g5aeb7
