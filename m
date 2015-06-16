From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 07/11] for-each-ref: add '--merged' and '--no-merged' options
Date: Tue, 16 Jun 2015 19:50:53 +0530
Message-ID: <1434464457-10749-7-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 16:27:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4rpN-0007sD-Pn
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbbFPO05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 10:26:57 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34513 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbFPO0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:26:55 -0400
Received: by pacgb13 with SMTP id gb13so13921792pac.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BOhEAvpxwsXwEQjliz2hvrWLIXU2MafA12LTwXKJTkA=;
        b=FQ0y6wQb6R1RD1q0r9r185xNwJ+mwDlIQYYvs/4beLUqMRKtipv/sSoRs60jPvqZXy
         joOjWvDrYbuUFcb7StnLeGG28aZdHi0Laz3NGHZ3aZnhtfOU1LTduKoo+sGwVM0mwUBj
         RR9KMX5+eQ5UyzdijrQIZlt4F0JWwW7IX33OZ018gqgdOAYxML2VtKMdtEoMcnud0Z8J
         OScoR246X4xnAklV61tOw/PlmSzfJDQB7tQ8cu0GGbVxDCaY4l5rn9/a6SPNUjhMra7s
         pSkpJ6tPm5zewIWas1JEY6gSIy2g3kJcdticL0MjDM1j4vaViidlchGFBvfXkxfHyyXG
         LQ6A==
X-Received: by 10.66.121.101 with SMTP id lj5mr1020653pab.113.1434464814613;
        Tue, 16 Jun 2015 07:26:54 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm1594145pda.54.2015.06.16.07.26.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 07:26:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.436.g722e2ce.dirty
In-Reply-To: <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271762>

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
 t/t6301-for-each-ref-filter.sh     | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 0524ac4..d61a756 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
-		   [--points-at <object>]
+		   [--points-at <object>] [(--merged | --no-merged) <object>]
 
 DESCRIPTION
 -----------
@@ -66,6 +66,14 @@ OPTIONS
 --points-at <object>::
 	Only list refs of the given object.
 
+--merged [<commit>]::
+	Only list refs whose tips are reachable from the
+	specified commit (HEAD if not specified).
+
+--no-merged [<commit>]::
+	Only list refs whose tips are not reachable from the
+	specified commit (HEAD if not specified).
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 2dee149..00913f4 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,6 +8,7 @@
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
+	N_("git for-each-ref [(--merged | --no-merged) <object>]"),
 	NULL
 };
 
@@ -38,6 +39,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
 			     N_("object"), N_("print only refs of the object"),
 			     parse_opt_object_name),
+		OPT_MERGED(&filter, N_("print only refs that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
 		OPT_END(),
 	};
 
diff --git a/t/t6301-for-each-ref-filter.sh b/t/t6301-for-each-ref-filter.sh
index 1ad65f0..593c3cb 100755
--- a/t/t6301-for-each-ref-filter.sh
+++ b/t/t6301-for-each-ref-filter.sh
@@ -43,4 +43,25 @@ test_expect_success 'filtering with --points-at' '
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
+	EOF
+	git for-each-ref --format="%(refname)" --no-merged=master >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.3.436.g722e2ce.dirty
