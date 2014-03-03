From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 04/14] commit.c: use ALLOC_GROW() in register_commit_graft()
Date: Tue,  4 Mar 2014 02:31:52 +0400
Message-ID: <1393885922-21616-5-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQV-0002rx-Ml
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbaCCWdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:33:19 -0500
Received: from forward1l.mail.yandex.net ([84.201.143.144]:58925 "EHLO
	forward1l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457AbaCCWcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:39 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward1l.mail.yandex.net (Yandex) with ESMTP id EBA8C1520E2C;
	Tue,  4 Mar 2014 02:32:37 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id A3EDA1E1112;
	Tue,  4 Mar 2014 02:32:37 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-WbviDpGY;
	Tue,  4 Mar 2014 02:32:37 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: d5796be1-07b1-48ca-b9a1-f59088693ef6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885957;
	bh=ODSlXkRXJxbbC8Nm2Ecz2wsLW8FcwaaKqUp34AVHG8M=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=hLwe+LOrku3riJd/mvLpZsEP2LNXNrciR5TOUIiFF757puR2Vv5pz0lsRt+b3oDmM
	 TnUoRTTzK+bAgW3uMA1mf3UNQaT57IrMRkbCiHiErXGyh+Jc0NwsgmUcM3AQCECOkg
	 SvJNftyjl8xvjONrZ/JQSzsrGbxrEu4uJ5ZYpvfs=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243292>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 commit.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..e004314 100644
--- a/commit.c
+++ b/commit.c
@@ -147,12 +147,8 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 		return 1;
 	}
 	pos = -pos - 1;
-	if (commit_graft_alloc <= ++commit_graft_nr) {
-		commit_graft_alloc = alloc_nr(commit_graft_alloc);
-		commit_graft = xrealloc(commit_graft,
-					sizeof(*commit_graft) *
-					commit_graft_alloc);
-	}
+	ALLOC_GROW(commit_graft, commit_graft_nr + 1, commit_graft_alloc);
+	commit_graft_nr++;
 	if (pos < commit_graft_nr)
 		memmove(commit_graft + pos + 1,
 			commit_graft + pos,
-- 
1.8.3.2
