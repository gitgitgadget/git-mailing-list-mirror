From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 07/11] for-each-ref: add '--merged' and '--no-merged' options
Date: Tue,  7 Jul 2015 21:36:13 +0530
Message-ID: <1436285177-12279-7-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
 <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 18:07:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVPX-0001oz-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044AbbGGQHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:07:50 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34338 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006AbbGGQHc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:07:32 -0400
Received: by pdbep18 with SMTP id ep18so128197297pdb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jMGGWat3nGcSmsgdqgwL/0DPC4tzv0f0TywRFwWRsKs=;
        b=0iJvEoGV9J7IQ75+8p10jaJ13+Xfx5f9a3o7LNvjD8+oOBS/t1ZX/FDX3sn7wyJT/1
         74j1WWbgctr10XUcPlaOM53pmNQEo7ezU1MsJ4GtmLhFkuVmAcEMgwcuAynli0tH/PMj
         P/URjYaGAD5qPbAAYEfjDuoDz6H6X9/DKlPS5tp/QeFawZm/4nbdaX4gLhC/M3Qlz83r
         5qC9vSoyyDqnqRPyppRG5Fl3BLNgj47ylvUVT8HnVgxOqYcP8Bdgx2PxmQA+u5ZABakw
         5C/Kr07HtcXS/1eccVz3jtGTPEkc2UFLvTr1wSFlP1zcTvPnFi+zEzDI1MwA+AaQVbRp
         rOfw==
X-Received: by 10.70.59.41 with SMTP id w9mr10294406pdq.5.1436285251596;
        Tue, 07 Jul 2015 09:07:31 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nt6sm22295515pbc.18.2015.07.07.09.07.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 09:07:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273578>

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
 t/t6302-for-each-ref-filter.sh     | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index ff0283b..2842195 100644
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
 	Only list refs which points at the given object.
 
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
index ae5419e..7521850 100644
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
 			     N_("object"), N_("print only refs which points at the given object"),
 			     parse_opt_object_name),
+		OPT_MERGED(&filter, N_("print only refs that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
 		OPT_END(),
 	};
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 457991f..73dbf53 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -37,4 +37,27 @@ test_expect_success 'check signed tags with --points-at' '
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
+	refs/tags/double-tag
+	refs/tags/four
+	refs/tags/signed-tag
+	EOF
+	git for-each-ref --format="%(refname)" --no-merged=master >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.5
