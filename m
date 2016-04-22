From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 03/16] ref-filter: modify "%(objectname:short)" to take length
Date: Sat, 23 Apr 2016 00:33:54 +0530
Message-ID: <1461351847-22903-4-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:04:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgNf-0007zU-JV
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbcDVTEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:04:35 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35120 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbcDVTEd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:04:33 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so10918737pac.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QdI29mH0gHVqqcos7b3NoXWuOROANuZUlv6D2TRp2jI=;
        b=Ak80Z63+kGrXI3o6chi1xOhQ6DtN6oOR+nU/BmMdJ+u0MwXQxiYgFfkmAg+qdk2dor
         bxRNO7jCayldf9AuxVshjwyMtI70MmqtpA82yutfzW6fqFrfRjXsNAKpLcNSjZ2Y/dyP
         NRKUMWUZyLtmgfZhacZD32j6PgM/taNwqo9bmijqajTxkzh9SPVQFmP56Yej2pMygcKW
         o4v/eIkx0s69i/+DIa3NV3988cjPb2jJyeod3ghyRM9Rp6wZju8sfG5JtwMw5yl5dGwv
         OzMHd/LOP7hvy5DTgtqVWle3Xj79F8CTAjOx2n0b5GdmX6Mp2abes7S2U/i9fU0PQOy9
         Okpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QdI29mH0gHVqqcos7b3NoXWuOROANuZUlv6D2TRp2jI=;
        b=fAKhhBzsIsZfIghA9HpFSX/PQTnKxz2PgqBNi9WfTgZOXSRHLWeCoevbceUGx4QEIb
         z2OjtBe7b79JN6eDuMpfMXWsWtipZ+qEv7nBAHpS8Ubu+A1Xlxbe1lvFJbzVZhGayQq4
         dGN+1SP1tQcqSqztPbkl8tAcTCC7RH/ZiBagVtPh9Pfvzyn57oOH3nun575dCGi996dD
         0QpS1mDd9tJF2O2gz/eVPlQuGp2E1gFkmY8lg4eR9imILaMKcmTY3XjGmgMXToTnENC6
         aBWGaDvMPDATgf0eA3ou+nw0k2/HN1atGXyUDUP69GX67FQjEx/QwWnwrrvP1l8pkA+f
         DXyQ==
X-Gm-Message-State: AOPr4FX4As0FzUmJYmQsWcPkSr6re0Ij4ZwQ0SvpDKW83N2NNjEioQfdh+d7ANna53psrg==
X-Received: by 10.66.180.68 with SMTP id dm4mr31060435pac.76.1461351873143;
        Fri, 22 Apr 2016 12:04:33 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:04:32 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292247>

Add support for %(objectname:short=<length>) which would print the
abbreviated unique objectname of given length. When no length is
specified, the length is 'DEFAULT_ABBREV'. The minimum length is
'MINIMUM_ABBREV'. The length may be exceeded to ensure that the provided
object name is unique.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 ref-filter.c                       | 25 +++++++++++++++++++------
 t/t6300-for-each-ref.sh            | 10 ++++++++++
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 3e7db10..5370fe5 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -107,6 +107,10 @@ objectsize::
 objectname::
 	The object name (aka SHA-1).
 	For a non-ambiguous abbreviation of the object name append `:short`.
+	For an abbreviation of the object name with desired length append
+	`:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
+	length may be exceeded to ensure unique object names.
+
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
diff --git a/ref-filter.c b/ref-filter.c
index 857a8b5..7d3af1c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,7 +55,10 @@ static struct used_atom {
 			const char *if_equals,
 				*not_equals;
 		} if_then_else;
-		enum { O_FULL, O_SHORT } objectname;
+		struct {
+			enum { O_FULL, O_LENGTH, O_SHORT } option;
+			unsigned int length;
+		} objectname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -118,10 +121,17 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
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
+		atom->u.objectname.option = O_LENGTH;
+		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
+		    atom->u.objectname.length == 0)
+			die(_("positive value expected objectname:short=%s"), arg);
+		if (atom->u.objectname.length < MINIMUM_ABBREV)
+			atom->u.objectname.length = MINIMUM_ABBREV;
+	} else
 		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
@@ -591,12 +601,15 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
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
2.8.0
