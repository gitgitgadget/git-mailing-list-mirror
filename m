From: Mustafa Orkun Acar <mustafaorkunacar@gmail.com>
Subject: [PATCH v2] Rewrite strbuf.c:strbuf_cmp() replace memcmp() with starts_with()
Date: Sat, 22 Mar 2014 23:25:16 +0200
Message-ID: <1395523516-10181-1-git-send-email-mustafaorkunacar@gmail.com>
Cc: Mustafa Orkun Acar <mustafaorkunacar@gmail.com>
To: sunshine@sunshineco.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 22:26:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRTQb-0000pc-HK
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 22:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbaCVVZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 17:25:42 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:38072 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaCVVZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 17:25:21 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so3051341eei.0
        for <git@vger.kernel.org>; Sat, 22 Mar 2014 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jPnPgjHuKyeAk+6dofRwfK1PyIcnyBQFSAbgBGPkpRI=;
        b=IHNFyhy6pwUwHIPm9Z+pu3PAcdRGX0rE4MMRHvNhRCB6aaChiGsWC+02BNresTd9u1
         F/9Em5zT1qwaJMeLt6K6Ehv/3wqqI+MS1Y8PoZXxj/Nfe54XTbWfRpSJSmN2cb//4NWo
         eLd2T5JHz9YfOA01hBjTGLxret5YE9bVM38QFLwJSlA8j0TYApYZKvGwSdsWuVXitQvj
         r/dWb109xIeRGtSht4qwrKeP3EOXSe55KYl/oW7SQm1BC+NN7T+PqA1Ianqw8FfpcJgd
         D5ve2O+4rwqypEnIYTfMplA6TOU+EhNOArRMj/SoWMNzSz41ryz5i05aU9lKmXnT/CUF
         0zLg==
X-Received: by 10.15.90.201 with SMTP id q49mr30265450eez.65.1395523520189;
        Sat, 22 Mar 2014 14:25:20 -0700 (PDT)
Received: from localhost.localdomain ([144.122.187.225])
        by mx.google.com with ESMTPSA id m1sm21543246een.7.2014.03.22.14.25.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Mar 2014 14:25:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.286.g5172cb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244783>

I reviewed all functions using memcmp(). It generally makes code more understandable. But here it might be used for the sake of simplicity.

Signed-off-by: Mustafa Orkun Acar <mustafaorkunacar@gmail.com>
---
I applied to GSoC 2014. I expect your feedbacks and comments!
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index ee96dcf..50d0875 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -147,7 +147,7 @@ void strbuf_list_free(struct strbuf **sbs)
 int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
 {
 	int len = a->len < b->len ? a->len: b->len;
-	int cmp = memcmp(a->buf, b->buf, len);
+	int cmp = !starts_with(a->buf, b->buf);
 	if (cmp)
 		return cmp;
 	return a->len < b->len ? -1: a->len != b->len;
-- 
1.9.1.286.g5172cb3
