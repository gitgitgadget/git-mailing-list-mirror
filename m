From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 07/16] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Wed, 30 Mar 2016 15:09:51 +0530
Message-ID: <1459330800-12525-8-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:40:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCc7-0001fQ-MG
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbcC3Jkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:40:31 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33955 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbcC3Jk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:27 -0400
Received: by mail-pf0-f181.google.com with SMTP id x3so37990469pfb.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nuaDEVewMOS0grYAiP7U1sJ+Evdq08M/u2S7Tlk1xwk=;
        b=gPOoLEKv+pM/2QQNmBDJJ/U0LKhG384fHQh3kxBI9XuM9dACD9EXfj9bisKFUMDuKu
         50iB4lUMaqIi0A1GJ82WV3DU0qd6POGx2/XLfGMxo6JfqBMHOvEBKQ3jqVxg8Y7zBeR8
         YGgiyoD6tuFQBXy5Z1w2Q3zd+WRSn7eKtvndubCzF6az/zK6Zl9OjQF33stY6k4DFPge
         zC7sTOLdBbBhbXxDK5bvKZp3XC8M9Z91batdnecNUIx+S44fnWYQs7OwNH2zOHCg67Tw
         3nHqa9nS6/B7wmlSVn4gkZNmmumHaOUjrCFneRF3p1L823Sdo7HCqJkF7S2w17B9qRld
         etiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nuaDEVewMOS0grYAiP7U1sJ+Evdq08M/u2S7Tlk1xwk=;
        b=l+u9TYeLspkG4BShJFUEJ6mGCKBhP/uV/QmGksnkIUTQcQSYn/cVYdHgj2ZpBCU/j9
         Xuh70Q1PdolVeQQItnUv+20DBhW7sAeTBGk/gk0AvI7Y2p/ZcwRZ9KtMLqChFLHjZlDu
         nfqJ4yMRLf9Tn/zyyRdNiGJ9Ge4+B7qT315e+NdkTbgftoYqGFqKz6fwzJJs+h9K9caw
         v+nZW3wOkJH+KvzJCucuH4216sAxQ4pCM6LMhDQV0L01NRudE0DGpDRn6HlG8UOgYd+v
         WfqSRu84XPjqdH5p6RPZaozd9wyL65+6ESgApqNWd5oY4HD+1ofkB/9zagoWCwmMuGFP
         3iEA==
X-Gm-Message-State: AD7BkJIcGbkEA0QaXA6gFOzZY8ybJXC1BXS0Tgj1/eESNwhkED4qR/NkBrpEZYidmpZgCQ==
X-Received: by 10.98.69.193 with SMTP id n62mr11288893pfi.46.1459330826613;
        Wed, 30 Mar 2016 02:40:26 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:25 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290287>

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
index d3223a2..85ac2a8 100644
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
2.7.4
