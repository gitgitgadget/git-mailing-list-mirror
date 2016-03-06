From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 03/15] ref-filter: modify "%(objectname:short)" to take length
Date: Sun,  6 Mar 2016 17:34:50 +0530
Message-ID: <1457265902-7949-4-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXR6-0001sw-EF
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbcCFMFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:22 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33528 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbcCFMFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:16 -0500
Received: by mail-pa0-f51.google.com with SMTP id fl4so61869995pad.0
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CH6VlPgXT/Rc9rJ+tRBqU+TGL0HO1bzS9OeKfFkRLCU=;
        b=AAHuaBwj+9pO3p56kyXqDOcr2KDfAauk/AgEIz4bLoIQXVqYoGuikBKjTK6v0LRA1A
         PyU0HkfJllLudtrTYOOjreVQJgfSh/T4IwberEAA7Dz2jhWZLPopn0pCPelUengo39Mu
         VbYFA9ppNUkb/kxHO88OkS07Qaiju6n+3btXiBWqUAsfE/iPgkl7IjBMuyIV2aqzSLUz
         Zigqzz8i90K57jIqVVLQZ3ZKemtZO79CpCpb52cStRECay5pGeuI8FCLAGPJk1dPzpMO
         y9SCaOUKnI8YNTzxAJ8RREWRHsvNrXmmd0AAdxUArU6T3Tb+MjUAEOTa6c8ANtr1CAcQ
         iLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CH6VlPgXT/Rc9rJ+tRBqU+TGL0HO1bzS9OeKfFkRLCU=;
        b=KFAC1j0d6LnGLXAF4MB2a1FHIbPVGzJjfPR1gQ9jBmkoHli3bAePngc+EIuuEYXomP
         uOruYiNnD8tHkpbcL9zsxsSSiCXJGsTfaFgccFJODZNmCbN5Z7uc5BNHXSpMyDKGv+Qy
         F4MTKHzlZsCH+HTAQw4d8PPTE9TWysy0jGE3x+43r7i/eH0sntxvslDfZWDmeEu0BOg7
         DrkvwsPPd3Dv3OBgv1TbzrixS3sFkm1pr0P8eJX18U46yqHUsQxxNqIU6bSFiXNQJuNc
         bQ01Th1XWrtod/8dYgoT3rEHNPJ3sW7P8/KvePoQ1878wL/ESw5vfAyb3GPP73biLKsq
         PQcA==
X-Gm-Message-State: AD7BkJLNn5Z1LUMSsuOJuX7ryq9edIaKfG/EMH5St0eIhrq91LyqhgW613n1cLAGogWjEQ==
X-Received: by 10.66.141.110 with SMTP id rn14mr18681704pab.104.1457265914893;
        Sun, 06 Mar 2016 04:05:14 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:14 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288345>

Add support for %(objectname:short=<length>) which would print the
abbreviated unique objectname of given length. When no length is
specified 7 is used. The minimum length is 'MINIMUM_ABBREV'.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c            | 25 +++++++++++++++++++------
 t/t6300-for-each-ref.sh | 10 ++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 440e270..2ab90d4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -51,7 +51,10 @@ static struct used_atom {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
 			unsigned int nlines;
 		} contents;
-		enum { O_FULL, O_SHORT } objectname;
+		struct {
+			enum { O_FULL, O_LENGTH, O_SHORT } option;
+			unsigned int length;
+		} objectname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -114,10 +117,17 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
 static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 {
 	if (!arg)
-		atom->u.objectname = O_FULL;
+		atom->u.objectname.option = O_FULL;
 	else if (!strcmp(arg, "short"))
-		atom->u.objectname = O_SHORT;
-	else
+		atom->u.objectname.option = O_SHORT;
+	else if (skip_prefix(arg, "short=", &arg)) {
+		atom->u.contents.option = O_LENGTH;
+		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
+		    atom->u.objectname.length == 0)
+			die(_("positive value expected objectname:short=%s"), arg);
+		if (atom->u.objectname.length < MINIMUM_ABBREV)
+			atom->u.objectname.length = MINIMUM_ABBREV;
+	} else
 		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
@@ -581,12 +591,15 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
 			   struct atom_value *v, struct used_atom *atom)
 {
 	if (starts_with(name, "objectname")) {
-		if (atom->u.objectname == O_SHORT) {
+		if (atom->u.objectname.option == O_SHORT) {
 			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			return 1;
-		} else if (atom->u.objectname == O_FULL) {
+		} else if (atom->u.objectname.option == O_FULL) {
 			v->s = xstrdup(sha1_to_hex(sha1));
 			return 1;
+		} else if (atom->u.objectname.option == O_LENGTH) {
+			v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
+			return 1;
 		} else
 			die("BUG: unknown %%(objectname) option");
 	}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 19a2823..2be0a3f 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -60,6 +60,8 @@ test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
 test_atom head objectname:short $(git rev-parse --short refs/heads/master)
+test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
+test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
 test_atom head tree $(git rev-parse refs/heads/master^{tree})
 test_atom head parent ''
 test_atom head numparent 0
@@ -99,6 +101,8 @@ test_atom tag objecttype tag
 test_atom tag objectsize 154
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
 test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
+test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
+test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
 test_atom tag tree ''
 test_atom tag parent ''
 test_atom tag numparent ''
@@ -164,6 +168,12 @@ test_expect_success 'Check invalid format specifiers are errors' '
 	test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
 '
 
+test_expect_success 'arguments to %(objectname:short=) must be positive integers' '
+	test_must_fail git for-each-ref --format="%(objectname:short=0)" &&
+	test_must_fail git for-each-ref --format="%(objectname:short=-1)" &&
+	test_must_fail git for-each-ref --format="%(objectname:short=foo)"
+'
+
 test_date () {
 	f=$1 &&
 	committer_date=$2 &&
-- 
2.7.2
