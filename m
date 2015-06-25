From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 07/11] for-each-ref: add '--merged' and '--no-merged' options
Date: Thu, 25 Jun 2015 14:27:09 +0530
Message-ID: <1435222633-32007-7-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 10:57:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82yq-0000gK-7G
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbbFYI5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:57:52 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35767 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbFYI5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:57:50 -0400
Received: by pactm7 with SMTP id tm7so46103682pac.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r1FmKU6j7zYngxg4LAoMh0Qkm5EpUcX8hNruFHV4pow=;
        b=Y8rbt1SD6OVUNxqDHaflZjMfpfNfgWty7PKDt/k4PK7YhF58BxFmK1XOS/VL1oOmlB
         mknsft0CkXxqdk9uScSgVgFYUHpKZ6dXjmyCibxYaARN9idTH1SOCZ+SugM+PgFhg6KK
         J7Kly7ohKBUrx8UCKeU4vQbgvIBbtZcz5hZNaDZCm1X/jbvwtZZCuxvf4OMPYLviHjSF
         PJMxayGj23KjdkRFurhp+wb0+S8ixyRe0PetI5AwhB5qplFo8+3SBHAvvR3fKfjAyMnF
         A7rKa1E1CIjbkRvaKpoxHmjf/WCQa8QcykFLoBQlfTPfphYLi02jT0YDT5RKye2fBKQl
         PObQ==
X-Received: by 10.68.224.10 with SMTP id qy10mr90587582pbc.23.1435222669206;
        Thu, 25 Jun 2015 01:57:49 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id wa4sm29391000pab.17.2015.06.25.01.57.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 01:57:48 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272648>

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
 t/t6302-for-each-ref-filter.sh     | 22 ++++++++++++++++++++++
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
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 7269a66..f5ccfb9 100644
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
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
