From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 12/14] builtin/mktree.c: use ALLOC_GROW() in append_to_tree()
Date: Tue,  4 Mar 2014 02:32:00 +0400
Message-ID: <1393885922-21616-13-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQ0-0002Y2-VJ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbaCCWcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:47 -0500
Received: from forward7l.mail.yandex.net ([84.201.143.140]:44288 "EHLO
	forward7l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbaCCWcp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:45 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward7l.mail.yandex.net (Yandex) with ESMTP id CDC84BC0DD5;
	Tue,  4 Mar 2014 02:32:44 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 8F9C71E1112;
	Tue,  4 Mar 2014 02:32:44 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-WivW5vQI;
	Tue,  4 Mar 2014 02:32:44 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 9e888adc-eea0-48e6-b730-bc59a84b981c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885964;
	bh=RJpZMWxx9YMae/3OLLc3fCUdVT7Op5BNzvl8yWgtLG0=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=iEwgf0QIgFPRdfWxi5VVwZem3WUqz9Bv9DDJmPubjNARkV+1U7dkRUBg69MelefwI
	 k5/EvXUv57i184d+M3waoesjKNmQr6Phx7KogUKEuMb57jiLcDCpNqQT7bViWpf6RE
	 gvHgiiX8D9ypu22U8V53yb0GA1tC0BfgXtdxF3pA=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243282>

Helped-by: He Sun <sunheehnus@gmail.com>
Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 builtin/mktree.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index f92ba40..a964d6b 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -23,10 +23,7 @@ static void append_to_tree(unsigned mode, unsigned char *sha1, char *path)
 	if (strchr(path, '/'))
 		die("path %s contains slash", path);
 
-	if (alloc <= used) {
-		alloc = alloc_nr(used);
-		entries = xrealloc(entries, sizeof(*entries) * alloc);
-	}
+	ALLOC_GROW(entries, used + 1, alloc);
 	ent = entries[used++] = xmalloc(sizeof(**entries) + len + 1);
 	ent->mode = mode;
 	ent->len = len;
-- 
1.8.3.2
