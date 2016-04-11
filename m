From: Stan Hu <stanhu@gmail.com>
Subject: [PATCH] fetch-pack: Add missing line-feed character when sending depth-request packet line
Date: Mon, 11 Apr 2016 00:48:48 -0700
Message-ID: <1460360928-95956-1-git-send-email-stanhu@gmail.com>
Cc: git@vger.kernel.org, Stan Hu <stanhu@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 11 09:49:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apWai-0003uk-8J
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 09:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbcDKHsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 03:48:55 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35881 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbcDKHsy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 03:48:54 -0400
Received: by mail-pf0-f175.google.com with SMTP id e128so119006554pfe.3
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 00:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DGk/FGfpc53nxZGxFGeL3Yp3Vu1HdsrKoe54JeadCY8=;
        b=H89LDKuA9hkcGA6RH8Z5ZIZmF3YMK4getmetYe9xe2xTUimfCl/0tj3QLRXrDb9DRy
         zf26mUxlpq+N9KUm2c5glACwatIu1HAQOwNgsa1GlBgBSugv8f2KN6vMJaSbs9+1U0f6
         J8wfdWwO/LM/0/Y8nHqIusOFuSKMpXzQ9F5KJbAxGt8SJzRw8fyOPrbgIYPO4F2o8Jcn
         Tn8TmYYnaH88+QmcZtKtcoH3UdxmJ6/FOrapVKxSFH+d5oxe+ksSunV7wGruESLqjpg1
         fRMb1l7rrOgt4kcjBc9EZlBhgc9i2hmjXqKKTBI4hbGoQnzy+ncygUfngiGzNwOk9rHi
         j6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DGk/FGfpc53nxZGxFGeL3Yp3Vu1HdsrKoe54JeadCY8=;
        b=KyBu8/G5QQQXA56ULzyzCe8Ke2Z1Zk02d16JlHbe3sNDKswDJ66JHxPsO+iHzlP1XN
         VOlst0tWwOxXJfwcoVC8xoTwu6pWLJtmYwhfCI4pqmOhkvv7FH61YB2+4KdSc3wWcumu
         OSdHa8tE+3bFl+4G/k5suv/9YBw4fqDJuzgH1NW7z+lBoHpVancDA4zsxzVgfsL4IevV
         B6bgF/VxK0RQ6uFm0B4ox6PXN3S97RhnpOuqf54Gcml0slMpROzzTaX9Hde+QaBm95ug
         GQIJ82uYpanjA6C5nqH/llxHnQkebd4dxls9e41Y2Em6OU47BQFn+ux/PdXeZVrfDnm0
         v/4w==
X-Gm-Message-State: AD7BkJIaBOlMWF4Y+A7gWslScgY6y6ptBXDk7dzAOL0xlINGkjH/tPfUdZuYhMTZ4uA/Bw==
X-Received: by 10.98.69.75 with SMTP id s72mr31091281pfa.66.1460360933454;
        Mon, 11 Apr 2016 00:48:53 -0700 (PDT)
Received: from smtp.gmail.com (c-24-6-246-163.hsd1.ca.comcast.net. [24.6.246.163])
        by smtp.gmail.com with ESMTPSA id q20sm33791929pfi.63.2016.04.11.00.48.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 11 Apr 2016 00:48:53 -0700 (PDT)
Received: by smtp.gmail.com (Postfix, from userid 501)
	id 782339310503; Mon, 11 Apr 2016 00:48:50 -0700 (PDT)
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291207>

The pkt-line format mandates: "a sender should include a LF, but the
receive MUST NOT complain if it is not present." This patch
is not absolutely necessary since receivers handle the missing the LF,
but this patch adds it for good measure.

Signed-off-by: Stan Hu <stanhu@gmail.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f96f6df..77299d9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -330,7 +330,7 @@ static int find_common(struct fetch_pack_args *args,
 	if (is_repository_shallow())
 		write_shallow_commits(&req_buf, 1, NULL);
 	if (args->depth > 0)
-		packet_buf_write(&req_buf, "deepen %d", args->depth);
+		packet_buf_write(&req_buf, "deepen %d\n", args->depth);
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
-- 
2.7.3
