From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v3 04/12] branch_empty: use pretty_tree and therefore respect -i/-w
Date: Wed, 20 Oct 2010 22:17:49 +0200
Message-ID: <d9fc8653e6e4c7eb7197a0fb92cd3b8c6e058187.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
 <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
 <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:18:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f79-00051g-EI
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab0JTUSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:21 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34020 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab0JTUSU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:20 -0400
Received: by yxm8 with SMTP id 8so1901803yxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=hEpOrQAQjrLLp9Q4OEHukiuj1IyBI9H8rbEmUbSflT0=;
        b=kgC7yrV4BJ6Gnfn7VwXx1Adi9p+sGX2NrgHTo5KQu8ezldVdyO9orld246F6u+o9vD
         k635+4fUF5xzt2NZpUlLp6F+KHhNXABUJLqiWBY4wJHnfWcXENlQkdoBiwHloIFr76BL
         smexu5R3E+7l3sf5CScQ1eTJkywAx9pbty550=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wEa/pjnLmbodELuqgEsAEmA4YM//NtmRa4FgAC40H976uvVDdhv/IeWDCGusrJUu07
         9gNsijrmUiDdGhkEuUkzXomQ+zaDW4lNg1CA3q8TrY/DlZuUsSIzzSAp/9xOHFZXQ71M
         ldPXmbCppBxLmHNzYGtJBcPCfonKLKqDFlKPU=
Received: by 10.103.217.11 with SMTP id u11mr1896674muq.84.1287605899043;
        Wed, 20 Oct 2010 13:18:19 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id a16sm405547fak.19.2010.10.20.13.18.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159426>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tg.sh b/tg.sh
index 81cbf7d..949d2a4 100644
--- a/tg.sh
+++ b/tg.sh
@@ -282,10 +282,10 @@ needs_update()
 	recurse_deps branch_needs_update "$@"
 }
 
-# branch_empty NAME
+# branch_empty NAME [-i | -w]
 branch_empty()
 {
-	[ -z "$(git diff-tree "refs/top-bases/$1" "$1" -- | fgrep -v "	.top")" ]
+	[ "$(pretty_tree "$1" -b)" = "$(pretty_tree "$1" ${2-})" ]
 }
 
 # list_deps
-- 
1.7.3.1.1069.g89486
