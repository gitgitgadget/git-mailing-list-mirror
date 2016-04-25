From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 07/17] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Mon, 25 Apr 2016 20:47:48 +0530
Message-ID: <1461597478-31855-7-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:18:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHS-0005mc-Kc
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbcDYPSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:25 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35463 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511AbcDYPSX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:23 -0400
Received: by mail-pa0-f51.google.com with SMTP id iv1so16578774pac.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YfkFV0buJSDBstmPB64pwDH8ZXsDyruHpiqRgOYj0rc=;
        b=JrGeaXYk9Pk/PgBFFrEfpbU5BqgzIkS5vhzz2WSwp4LaxpwniRKhlD9SjFWVkHt9Ht
         ik4mZDM1wMZb4pHODQMaHhMTkCXaHKjwpH1aSMBTYSx0Gx0auzFLFP1Uvw6rF6oj7Mt/
         aeYK5YyZR3BfdH5EW1OU2JcBDxxWdYuBH8wGGQz1aQeZpI1YpUZjqswgfaT76GKVnPLq
         3Sg/3Nsr/Xz2YxJok1R3Wv01AXmr8IGOoQW+uz4u2u55IXYRAxXJgZ0PZ3Bwx0E1mzwb
         UmrR88T/Dxrm+l/rRLbsEp/Y1aH7nF/KyM0TMwzOT9aUk3NhNPsOMPpDZdDzFQtmoWyi
         zhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YfkFV0buJSDBstmPB64pwDH8ZXsDyruHpiqRgOYj0rc=;
        b=iAbvrxTBSMuGd3dRUc4WwaUJshxetVeJfxNyvULILgnex0WNRG9VPfn8DXyMKBPFmS
         6sOI0VIlfEvnQqLMCQhk3qAWaeUvDQRJWDuAuxoPtYg1wQ4cMxtSBayQ4sCE3koKnsKW
         E37uBPB2PUwi8idjCjCgL/9g+MP5KnYxFjYD7iLzG6bZF6Dp8R66Y0hHzGaHOqJLS2jY
         tb3YO9xV02p1kD4tmpWTlD1+Rh1B4CxsU9pTFnHHB5xy8PqYWCBfc2YUTQGswaz0phDS
         dg8zG1Oqofn4wrUsawpikANGl0PV3wIwoHTZtf0/TMWLQqK3T0pXBYWphFBUGfKac90L
         AGHA==
X-Gm-Message-State: AOPr4FX36hiTcoqhRT0j0zcjd40qETJRa8ftV30DQCXoNh6s5m1ImOFL7KSFYVYgrl+HLg==
X-Received: by 10.66.156.232 with SMTP id wh8mr49553252pab.153.1461597502494;
        Mon, 25 Apr 2016 08:18:22 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292494>

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
index 5370fe5..f1e46a7 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -119,7 +119,8 @@ upstream::
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
 	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	tracking information associated with it. `:track` also prints
+	"[gone]" whenever unknown upstream ref is encountered.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index da2b9ee..3bb6923 100644
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
2.8.0
