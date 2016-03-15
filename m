From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 07/16] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Tue, 15 Mar 2016 22:17:07 +0530
Message-ID: <1458060436-1215-8-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:47:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8N-0000rQ-OB
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbcCOQrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:43 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33380 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965097AbcCOQrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:40 -0400
Received: by mail-pf0-f180.google.com with SMTP id 124so35893470pfg.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8iDUOoRnx7XcM/hVIN6SUfgAScuEwgPlkDNrDPnpesE=;
        b=q8jWi+Exgvu8sepFzpDQ0QxoL3PgirJdhrf9ZioeQJALEqjjfvJ8gHEMu/S2EPHRMW
         X4i1OB+toySxZGJnQHpjb6k4CPK7Lc3yY6eGpOGSaf2SCpqIZqhs28VQsGX9kzlqgKzK
         OPMYjWTgkLmSOth4RKCGqwIG+GI9pSX6zphGuPoKmLUX8i45WPTSWuijrap1m0BypQNK
         v6W4OvKblTFhSHjbSBOjVqu8tmkp/lfzVY3USHdq4d3GURiwIb8cDV2bTUpYkspByF7+
         TAtdVey74cNCrDcm8+OL6KoXA8Tt/B51mOa3bpqofTzwpNL8xwndTRJb0tv0giWxRiD+
         hKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8iDUOoRnx7XcM/hVIN6SUfgAScuEwgPlkDNrDPnpesE=;
        b=Fliyv8WfxdQov/E11PT4cBuloX3VOjp99Aq49yZFBq3BY8F+F6yNFNNt5cKZgDLY+5
         tDFhPSPrQhmEMa6FxHCWMvb7aOmJTsD+DtTMiGuNWFK8nNFKQuBgTSvmmETfaeQQ2mKQ
         Eiu0jNqw6rzsUPf5O9fVXsfjSOB2A9OojNdJYN218WnwsF7l/mR7HWR5XJ4xrMtmbRoO
         8x0/wv7b0Z7tfKQBgYQSmzZm/PJB1ILJIdZ9rK+cDNCnJfAcsyVbfuJNO3OBTjYpFqu/
         0hpucYLESSIYPVuVenByHsAYU3+3LKupsJRGSUfk2bLXb7EltlVdA/vK2a0NcxuB6mtK
         IIsg==
X-Gm-Message-State: AD7BkJLXcIpSmiynaWeR9WbvQuXZJxqWWZhFbsvwgoJXRiN7EOyDOpjk5Rve7JCxW0wNbQ==
X-Received: by 10.98.80.206 with SMTP id g75mr39970793pfj.127.1458060459725;
        Tue, 15 Mar 2016 09:47:39 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:39 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288869>

Borrowing from branch.c's implementation print "[gone]" whenever an
unknown upstream ref is encountered instead of just ignoring it.

This makes sure that when branch.c is ported over to using ref-filter
APIs for printing, this feature is not lost.

Make changes to t/t6300-for-each-ref.sh and
Documentation/git-for-each-ref.txt to reflect this change.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by : Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 ref-filter.c                       | 4 +++-
 t/t6300-for-each-ref.sh            | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e1b1a66..6dbd7bd 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -115,7 +115,8 @@ upstream::
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
 	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	tracking information associated with it. `:track` also prints
+	"[gone]" whenever unknown upstream ref is encountered.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index 3bb474f..4d7e0c0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1049,8 +1049,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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
2.7.3
