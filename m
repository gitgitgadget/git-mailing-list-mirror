From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 02/11] for-each-ref: clean up code
Date: Sat,  6 Jun 2015 19:18:07 +0530
Message-ID: <1433598496-31287-2-git-send-email-karthik.188@gmail.com>
References: <5572F904.1080608@gmail.com>
 <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 15:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ESk-0004hm-1l
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 15:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbbFFNse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 09:48:34 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34513 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbFFNsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 09:48:32 -0400
Received: by pabli10 with SMTP id li10so11569866pab.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=17MgCifyqjbq+3Eb5BhXV/nacPodwI5pAwBmaCD7vzE=;
        b=Q5q5k6/hXciyKiBTmREBiQpTEpuvSJwiOhCdjanmfPXuw77BcC7dynGjg7CM9NBego
         Jmexcb9L1XckSHfN9WO/J6IZSMX3M7vSSFwtr7mA0HHVYxF8h22uHU4v2xjk2Ii4pZF8
         G3t2E34d7xZF24equgMQpqN387IoeLuHq7EeIZ9wQBf0r/5IZSA6T+HjQx6zLsr9szPE
         9N4sXvDZFVl32BlOfBetcTmcSLSiEvBP3DO39ssvPPzKwKGSQwTAxwD64fjHEYZETugW
         IGYsU7cMuE2lIsPS76XwubPW9jWhmQH02jFUiMicbX9AdBoxSvQrD7jJ1XcEbORq4SWs
         OpJQ==
X-Received: by 10.70.92.34 with SMTP id cj2mr14401731pdb.116.1433598512498;
        Sat, 06 Jun 2015 06:48:32 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id p9sm9715427pds.92.2015.06.06.06.48.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 06:48:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270924>

In 'grab_single_ref()' remove the extra count variable 'cnt' and
use the variable 'grab_cnt' of structure 'grab_ref_cbdata' directly
instead.

Change comment in 'struct ref_sort' to reflect changes in code.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index f939fd3..406de88 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -27,7 +27,7 @@ struct atom_value {
 
 struct ref_sort {
 	struct ref_sort *next;
-	int atom; /* index into used_atom array */
+	int atom; /* index into 'struct atom_value *' array */
 	unsigned reverse : 1;
 };
 
@@ -896,7 +896,6 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 {
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
-	int cnt;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -913,10 +912,8 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
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
2.4.2
