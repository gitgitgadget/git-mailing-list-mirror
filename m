From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 06/15] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Sun,  6 Mar 2016 17:34:53 +0530
Message-ID: <1457265902-7949-7-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXRP-00026H-PZ
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbcCFMFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:34 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36156 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbcCFMF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:27 -0500
Received: by mail-pa0-f51.google.com with SMTP id fi3so59816275pac.3
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e4Kt8qPtEMmLeO2DFliAJdtRDVNbfZ7LF3bdXNulKSA=;
        b=muLJma8P3VMom45ukPIgoHrudv09krMF5056f1LM7b8+/UA2p6GH/vBktpTT4ubpmJ
         6kzM2XXBaJ+DcKRDU2MMuGnpGsZnsWL3+Nl2WEP0aGCP01rhixxMDStca5yCJiih9kPD
         BRqe+pswXidSt/muQ5pqocFejiM5PTdxtev049xt8C+YR1Nh6klThRRMTe5SAzxzXC39
         Edn/9ladxYNktTqdfJkM2j++s8scdOMSxuJdSLcS80mU7ZFuWuOM0X6fUkH2QiyvvoMK
         3MrmYWzXRZdaRg1Ok69LkYXMGvm6HAhw8WlYhWwHWeJfXG3BOKszLBaOAM1wE4OMwWFy
         LBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e4Kt8qPtEMmLeO2DFliAJdtRDVNbfZ7LF3bdXNulKSA=;
        b=f1/5IMzABXY1Vp1W61h0AORueIVkMYhvDE9Ql665ZjHUFxNaZD6A2xEx7jDasCdhkP
         JEjKVOYp63YiZWszM6CicwiZ0UjBdIcM7bMKl13BNoDFuH+uZgMUUNPzm/mi4Yv4yhzf
         rL1gLDUP/jXvfoRzg7nONogO1LgCKsGW511aiorJE7/0iYmDh1C/V6WUqYcD246YZ/Hr
         UdC27pFltjIIImXUL9xQMWEdcOzjZNLKlMl3L4Y0Gv0/gMW0GLeJkwNd/CFzpAiy+bY8
         R/C7jO1niF13aBsIFCCvCs2nRnQGqOVJYjnybe4HzoBJiiuzqYAjwf8rTdSyksKFgnI0
         Grdg==
X-Gm-Message-State: AD7BkJJ08MfSIWkXXwfZFC/k134JPT7RSYE+SlSzx5HXHVrFqkpH9wvDNB625al4JQ0ZBQ==
X-Received: by 10.66.124.226 with SMTP id ml2mr25777323pab.90.1457265921571;
        Sun, 06 Mar 2016 04:05:21 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:20 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288352>

Borrowing from branch.c's implementation print "[gone]" whenever an
unknown upstream ref is encountered instead of just ignoring it.

This makes sure that when branch.c is ported over to using ref-filter
APIs for printing, this feature is not lost.

Make changes to t/t6300-for-each-ref.sh to reflect this change.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c            | 4 +++-
 t/t6300-for-each-ref.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 2896cde..c8ba68f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1039,8 +1039,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->u.remote_ref == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL))
+				       &num_theirs, NULL)) {
+			*s = "[gone]";
 			return;
+		}
 
 		if (!num_ours && !num_theirs)
 			*s = "";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2be0a3f..a92b36f 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -382,7 +382,7 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 
 test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	cat >expected <<-\EOF &&
-
+	[gone]
 
 	EOF
 	test_when_finished "git config branch.master.merge refs/heads/master" &&
-- 
2.7.2
