From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 07/11] for-each-ref: add '--merged' and '--no-merged' options
Date: Thu, 25 Jun 2015 01:23:48 +0530
Message-ID: <1435175632-27803-7-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTbXCRFx6xEv+cB7DQhu92=ePb_MJ5zeEjsr_-=HPAU6g@mail.gmail.com>
 <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 21:54:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qkd-0007zz-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbbFXTyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:54:23 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35445 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbbFXTyS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:54:18 -0400
Received: by pdbci14 with SMTP id ci14so37062915pdb.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/oPfPRf3sqV2TafLDX9BRiZbupV6ksbYeOlSGt0rS4k=;
        b=VlWpQDf83BGmqjwZjDr9GbRnf7JdK0JYQs1lQ5zGlm8sGqdSzdWws6f/JXpOubiR6O
         CczzHR2lrW0TVC+bMorlsfM0ixWSfnl1ohHuPSzGtXS/5kfejO4xPo4QIJES0sS/m5lp
         lofEgtHKklXaCeJeDxcXvMWLHWP21K4h8vGEJ3tU4QsAHdwFbA+d8LDtI4BzjnCpfj7a
         fx73EKU4+DhyGUcx8wR84C4PNFddB4TLaqL4rWMkdOBycMeLC4IPvuyda1wOxjWtxewL
         Db/aOET7279jTj5Tdivoo2NKp2tEn7xLrU9L/egM+Ots3sjVsecUSoy164auksL6Y/NJ
         EsOg==
X-Received: by 10.68.130.226 with SMTP id oh2mr82306554pbb.156.1435175657891;
        Wed, 24 Jun 2015 12:54:17 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id zx1sm27583483pbb.73.2015.06.24.12.54.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:54:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272598>

Add the '--merged' and '--no-merged' options provided by 'ref-filter'.
The '--merged' option lets the user to only list refs merged into the
named commit. The '--no-merged' option lets the user to only list refs
not merged into the named commit.

Add documentation and tests for the same.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 10 +++++++++-
 builtin/for-each-ref.c             |  3 +++
 t/t6301-for-each-ref-filter.sh     | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 0ede41d..290a5c1 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
-		   [--points-at <object>]
+		   [--points-at <object>] [(--merged | --no-merged) [<object>]]
 
 DESCRIPTION
 -----------
@@ -66,6 +66,14 @@ OPTIONS
 --points-at <object>::
 	Only list refs pointing to the given object.
 
+--merged [<object>]::
+	Only list refs whose tips are reachable from the
+	specified commit (HEAD if not specified).
+
+--no-merged [<object>]::
+	Only list refs whose tips are not reachable from the
+	specified commit (HEAD if not specified).
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 46f9b05..ba70798 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,6 +8,7 @@
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
+	N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
 	NULL
 };
 
@@ -38,6 +39,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
 			     N_("object"), N_("print only refs pointing to the given object"),
 			     parse_opt_object_name),
+		OPT_MERGED(&filter, N_("print only refs that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
 		OPT_END(),
 	};
 
diff --git a/t/t6301-for-each-ref-filter.sh b/t/t6301-for-each-ref-filter.sh
index 7269a66..f5ccfb9 100755
--- a/t/t6301-for-each-ref-filter.sh
+++ b/t/t6301-for-each-ref-filter.sh
@@ -36,4 +36,26 @@ test_expect_success 'check signed tags with --points-at' '
 	test_cmp expect actual
 '
 
+test_expect_success 'filtering with --merged' '
+	cat >expect <<-\EOF &&
+	refs/heads/master
+	refs/odd/spot
+	refs/tags/one
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --merged=master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'filtering with --no-merged' '
+	cat >expect <<-\EOF &&
+	refs/heads/side
+	refs/tags/four
+	refs/tags/signed-tag
+	EOF
+	git for-each-ref --format="%(refname)" --no-merged=master >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.4
