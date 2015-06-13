From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 02/11] for-each-ref: clean up code
Date: Sun, 14 Jun 2015 01:07:20 +0530
Message-ID: <1434224249-21476-2-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
 <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 21:38:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rGB-0002BW-Bi
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 21:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbbFMTi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 15:38:28 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34902 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbFMTi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 15:38:26 -0400
Received: by pacyx8 with SMTP id yx8so40811476pac.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vECtb0Ft6mVgt8XF1OStj8suAOTzPLPXwaw7E6qr0wg=;
        b=v10L5IgElpW8hjiStv5at8fnLxUvF34wfb/7fwogzARk5irQsseqB8gcmGj3R5j8gq
         Q1PLOCIzFplQ44FP++VRwedncDHUJmEsFyrEWpUgftAdE6frTymEMIwoW4t48TMjw4gn
         TxuyJGP1xFV0Nou7vEWz46dzDCP9PqAv/0CBA9MSDtXCXEZBAqjKBaoIxJGmt+ZzdjzR
         EVsr1ssbOX+PsCcWtz9J6ipLtBPBll/OGCYiZck5DEdPsn7OoEMaYGtXT5wzdwr+Cuzq
         X/E4BgzjgXSbkr2umWALLJdqj1jGsnvlW8A6YHYhLcORmVwHzUnR9mL96QRHMzwdVG+O
         I8Kw==
X-Received: by 10.68.215.66 with SMTP id og2mr33696886pbc.20.1434224306005;
        Sat, 13 Jun 2015 12:38:26 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nn6sm7388954pdb.79.2015.06.13.12.38.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 12:38:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271565>

In 'grab_single_ref()' remove the extra count variable 'cnt' and
use the variable 'grab_cnt' of structure 'grab_ref_cbdata' directly
instead.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index cc65620..f0d7d44 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -897,7 +897,6 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 {
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
-	int cnt;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -914,10 +913,8 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 	 */
 	ref = new_refinfo(refname, oid->hash, flag);
 
-	cnt = cb->grab_cnt;
-	REALLOC_ARRAY(cb->grab_array, cnt + 1);
-	cb->grab_array[cnt++] = ref;
-	cb->grab_cnt = cnt;
+	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
+	cb->grab_array[cb->grab_cnt++] = ref;
 	return 0;
 }
 
-- 
2.4.3.435.g2403634.dirty
