From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 10/11] for-each-ref: introduce filter_refs()
Date: Sat,  6 Jun 2015 19:18:15 +0530
Message-ID: <1433598496-31287-10-git-send-email-karthik.188@gmail.com>
References: <5572F904.1080608@gmail.com>
 <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 16:01:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1EfX-0001I2-Ty
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 16:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbbFFOBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 10:01:47 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33287 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbFFOBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 10:01:46 -0400
Received: by pablj1 with SMTP id lj1so11632050pab.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/lUL8k8vzxa6ktk/xBUk82HsJcR/Hvghl5/i5qN6tuI=;
        b=FLfPVEkGFSLSiHlRLsUrXEhx8IMqr+/M9hPzEMUJAzLtCfobr6j0QYS0U7aZz8Opnb
         1dCEqYs4njvWYZ9a1GFQW3oSOCCgRZR6CF9tllsoYihg3/w8aO079Sp4GHWtT7WfsynF
         zQzmp5Bmw8CNHKM/FX2BHMFeT7cMvBLrqedTUbJk4fjUpFX4YR3Wbijnmsdk0x45fztu
         vsKVUQgu3ZhMM498d67OUZWu97qswGytrKU0eSbJFg1aN3xewqJkK6GJp1BOdsDiCISL
         3IKnFa3A0nmKMc7VkyeJF8F6Vor2ydUF6SBNNboJCxyGChyAzHXkrmyAOeMyZq9eRk69
         gDJQ==
X-Received: by 10.70.128.34 with SMTP id nl2mr14378245pdb.43.1433598544118;
        Sat, 06 Jun 2015 06:49:04 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id p9sm9715427pds.92.2015.06.06.06.49.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 06:49:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270933>

Introduce filter_refs() which will act as an API for users to
call and provide a function which will iterate over a set of refs
while filtering out the required refs.

Currently this will wrap around ref_filter_handler(). Hence,
ref_filter_handler is made file scope static.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index ece16a1..91a6ec9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -904,6 +904,16 @@ void ref_array_clear(struct ref_array *array)
 	array->nr = array->alloc = 0;
 }
 
+/*
+ * API for filtering a set of refs. The refs are provided and iterated
+ * over using the for_each_ref_fn(). The refs are stored into and filtered
+ * based on the ref_filter_cbdata structure.
+ */
+int filter_refs(int (for_each_ref_fn)(each_ref_fn, void *), struct ref_filter_cbdata *data)
+{
+	return for_each_ref_fn(ref_filter_handler, data);
+}
+
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
-- 
2.4.2
