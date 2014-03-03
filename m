From: Guanglin Xu <mzguanglin@gmail.com>
Subject: [PATCH v5] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon,  3 Mar 2014 17:15:55 +0800
Message-ID: <1393838155-56591-1-git-send-email-mzguanglin@gmail.com>
Content-Type: text/plain; charset="utf-8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 10:16:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKOyv-00039d-UJ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 10:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbaCCJQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 04:16:11 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:65246 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbaCCJQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 04:16:08 -0500
Received: by mail-pa0-f52.google.com with SMTP id rd3so2029499pab.39
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 01:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:content-type;
        bh=HsnQKRMSChNgxDzTiAMKBtblsdPK2gyw+oFjahdWmHk=;
        b=YF4m1uG2S8XIhuzrTcSZhlz79aVsBJ3T/Gch/Jfyx+/BLiOvU7BJkVRoPqQsaaFlL2
         DHPHTFrlDN9Vvp1KQPJRqX+hU2oo9fH0GI6GHU6Qh6M+kNdEDeXf8ohkwCRnmmccrOpJ
         ndc8PR0aQRAEzaUYm5Kh9Yu9Hjfm2r+aM6cjpZOumkw1l4ewY/SkAy+QR9CVjDaIQMif
         K5YxWXgX6N3dslm7RIdLZGAENeBKTsfM3yz3glOHzK5SOHwvkCOgtXlEh1iHt88mhep8
         iJNBKToyLz92EBEmbFoTkCui0KgaRXs4GQ42E0qd795Mug5jzEvXGCvhh7Z0LZfakPIT
         /G9A==
X-Received: by 10.66.142.132 with SMTP id rw4mr18845560pab.6.1393838168240;
        Mon, 03 Mar 2014 01:16:08 -0800 (PST)
Received: from localhost.localdomain ([113.107.25.71])
        by mx.google.com with ESMTPSA id qs1sm33894165pbb.18.2014.03.03.01.16.03
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Mar 2014 01:16:06 -0800 (PST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243202>

to avoid a magic code of 11.

Helped-by: Sun He <sunheeh...@gmail.com>
Helped-by: Eric Sunshine <sunsh...@sunshineco.com>
Helped-by: Jacopo Notarstefano <jaco...@gmail.com>

Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
---

This is an implementation of the idea#2 of GSoC 2014 microproject.

 branch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..fae7715 100644
--- a/branch.c
+++ b/branch.c
@@ -49,8 +49,8 @@ static int should_setup_rebase(const char *origin)
 
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
-	const char *shortname = remote + 11;
-	int remote_is_branch = starts_with(remote, "refs/heads/");
+	const char *shortname = skip_prefix(remote ,"refs/heads/");
+	int remote_is_branch = !!shortname;
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
-- 
1.9.0
