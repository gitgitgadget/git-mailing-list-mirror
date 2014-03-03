From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 01/14] builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()
Date: Tue,  4 Mar 2014 02:31:49 +0400
Message-ID: <1393885922-21616-2-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:32:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbPf-0002IJ-H5
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbaCCWch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:37 -0500
Received: from forward6l.mail.yandex.net ([84.201.143.139]:44872 "EHLO
	forward6l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbaCCWcg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:36 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward6l.mail.yandex.net (Yandex) with ESMTP id D6C8914E0D8E;
	Tue,  4 Mar 2014 02:32:34 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 8EE551E1112;
	Tue,  4 Mar 2014 02:32:34 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-WYviQOgd;
	Tue,  4 Mar 2014 02:32:34 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: b4be9474-2ae1-436e-9830-4365043385d9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885954;
	bh=oTvXGviNx6dOhJAAqpOYHrwCMesRfTB9E6p5qRWjyYw=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=vrisGwZht+C1spnIv5reXs4K2oZO5/FX8GhqfJyE/TUiqu6Cd5DLq4fd1VCkb7Qfh
	 6YNUjLd5P2M/DUxur5+DvAB7sZfSwS7a2h9eIgn4x9Zk9pUub8vGlhGPyP5jYH5vjU
	 t8923psdd6vW8+UOYVK4RyNMxPdBhypolhWewU4Y=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243279>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 builtin/pack-objects.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..0ffad6f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1213,12 +1213,9 @@ static int check_pbase_path(unsigned hash)
 	if (0 <= pos)
 		return 1;
 	pos = -pos - 1;
-	if (done_pbase_paths_alloc <= done_pbase_paths_num) {
-		done_pbase_paths_alloc = alloc_nr(done_pbase_paths_alloc);
-		done_pbase_paths = xrealloc(done_pbase_paths,
-					    done_pbase_paths_alloc *
-					    sizeof(unsigned));
-	}
+	ALLOC_GROW(done_pbase_paths,
+		   done_pbase_paths_num + 1,
+		   done_pbase_paths_alloc);
 	done_pbase_paths_num++;
 	if (pos < done_pbase_paths_num)
 		memmove(done_pbase_paths + pos + 1,
-- 
1.8.3.2
