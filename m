Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FC320259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbcLGPhq (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:46 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32802 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so23837775pgd.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Em1Wj6NJtdFoIJ2SqiJhg92VJEVotY10p4jvTHphM0U=;
        b=qwAq/kgQdd+xFVU5Uh0WUCRQmmUZ3Z7QTEMOg8mUwGgnvD3N+E0PBA1CphfRMcNziA
         ikNhQHzfiQXVAWjzLgJg+XJnKDtK/ydTVI4Ibj0wb7yqhw7jlg0syzSpWHrHlmQT2P7b
         omblyqmEjZjeF1dPJAZV9pcWy3OhDysmR5lnIreoZLvS3BcHftOtS7NmAvGqj4ByNYme
         zgX5ieUXTpX4t82dAdT9jEkDwxAMgpsaDBjECIE83UgBgPtgTkNIjJou+53tpYanNzVP
         h9qDSmGbziijcgt0ntvxaq2D31EuNbWUoFnAeqLL16BZM34UHftlYACCIkNU6SuwtL1V
         Sm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Em1Wj6NJtdFoIJ2SqiJhg92VJEVotY10p4jvTHphM0U=;
        b=l+Q77DJvHsE93obb2LmFB6Zhua1YAsSdk3OQrxPp4dUk5a06de9be6jlpzL33Yuxuf
         KoycmubB8nuJqKpxCfRcEzwP5BVQUSmf5oHCvFtGKMuDSOCfPu5qYjGG1CrbZjzhzHwB
         zTmEi/BH3m4XGIiyrcLE21PPKXuDVPIDnfE5bfAJ2P6Giwihe2ltikRfAwMzhWm0FI+b
         zqOIySsw6LP8JS8DoaN+6V6vkEKI5+HgmaE0lGf9RSY8yam2jTFQ6E0aRAyx1AOgOCLp
         e9WV7zt/ztLVxVPT3pTgefqBB5B0ZfKh0vg/Cn1oLrMBGxxB9+LWv3/bIKI9/OkCse8T
         YT/w==
X-Gm-Message-State: AKaTC036vJtgvH/r48u7PUXwmFpVu/DsDK5+1ROQOH5yBW7cTbJNvOnccjWRtZ5i+/0xxQ==
X-Received: by 10.99.115.82 with SMTP id d18mr120100545pgn.56.1481124973037;
        Wed, 07 Dec 2016 07:36:13 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:12 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 04/19] ref-filter: modify "%(objectname:short)" to take length
Date:   Wed,  7 Dec 2016 21:06:12 +0530
Message-Id: <20161207153627.1468-5-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Add support for %(objectname:short=<length>) which would print the
abbreviated unique objectname of given length. When no length is
specified, the length is 'DEFAULT_ABBREV'. The minimum length is
'MINIMUM_ABBREV'. The length may be exceeded to ensure that the
provided object name is unique.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       | 25 +++++++++++++++++++------
 t/t6300-for-each-ref.sh            | 10 ++++++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 392df6b..b730735 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -107,6 +107,9 @@ objectsize::
 objectname::
 	The object name (aka SHA-1).
 	For a non-ambiguous abbreviation of the object name append `:short`.
+	For an abbreviation of the object name with desired length append
+	`:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
+	length may be exceeded to ensure unique object names.
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
diff --git a/ref-filter.c b/ref-filter.c
index 7a21256..d1534d0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -56,7 +56,10 @@ static struct used_atom {
 			cmp_status cmp_status;
 			const char *str;
 		} if_then_else;
-		enum { O_FULL, O_SHORT } objectname;
+		struct {
+			enum { O_FULL, O_LENGTH, O_SHORT } option;
+			unsigned int length;
+		} objectname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -119,10 +122,17 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
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
 
@@ -595,12 +605,15 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
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
index 039509a..644f169 100755
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
2.10.2

