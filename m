Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E966C1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757225AbeAINGH (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:06:07 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:37318
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756999AbeAINFZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503123;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=V/tFOIAJ+AA7p//KfbF9NPJ5IxgKzVLRVbrdBrjCV2k=;
        b=MFoKPpjeqlWqHxlgZC/DQa+cRTdtDeb0WmDsTWnEZ6CkINazh3UtsWTEnDoRNMYX
        YbkPGHVnq7dVKWN1OfX3x16krxaiRnN1SqFw8bMh/BJ3rFnVpX5m9kgBZtWDQ1oPDhH
        ZLKhbinl0q3cyxccPaan4zHDwVY8wLhDQXb5Lmuk=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067af3-3108a276-f04a-4eb0-8434-5006f6596f56-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 12/20] cat-file: rename variable in ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename variable for easier reading.
It points not to values, but to arrays.
Added "s" ending so that it could be obvious.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 16 ++++++++--------
 ref-filter.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1b8c8787190a9..56d2687e07df9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1418,7 +1418,7 @@ static void need_object(struct ref_array_item *ref) {
 		die(_("parse_object_buffer failed on %s for %s"),
 		    oid_to_hex(&ref->objectname), ref->refname);
 
-	grab_values(ref->value, 0, obj, buf, size);
+	grab_values(ref->values, 0, obj, buf, size);
 	if (!eaten)
 		free(buf);
 
@@ -1448,7 +1448,7 @@ static void need_object(struct ref_array_item *ref) {
 	if (!obj)
 		die(_("parse_object_buffer failed on %s for %s"),
 		    oid_to_hex(tagged), ref->refname);
-	grab_values(ref->value, 1, obj, buf, size);
+	grab_values(ref->values, 1, obj, buf, size);
 	if (!eaten)
 		free(buf);
 }
@@ -1460,7 +1460,7 @@ static void populate_value(struct ref_array_item *ref)
 {
 	int i;
 
-	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
+	ref->values = xcalloc(used_atom_cnt, sizeof(struct atom_value));
 
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
@@ -1473,7 +1473,7 @@ static void populate_value(struct ref_array_item *ref)
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atoms[i];
 		const char *name = used_atoms[i].name;
-		struct atom_value *v = &ref->value[i];
+		struct atom_value *v = &ref->values[i];
 		int deref = 0;
 		const char *refname;
 		struct branch *branch = NULL;
@@ -1571,7 +1571,7 @@ static void populate_value(struct ref_array_item *ref)
 	}
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		struct atom_value *v = &ref->value[i];
+		struct atom_value *v = &ref->values[i];
 		if (v->s == NULL) {
 			need_object(ref);
 			break;
@@ -1586,11 +1586,11 @@ static void populate_value(struct ref_array_item *ref)
  */
 static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom_value **v)
 {
-	if (!ref->value) {
+	if (!ref->values) {
 		populate_value(ref);
-		fill_missing_values(ref->value);
+		fill_missing_values(ref->values);
 	}
-	*v = &ref->value[atom];
+	*v = &ref->values[atom];
 }
 
 /*
diff --git a/ref-filter.h b/ref-filter.h
index 590a60ffe034d..de3fd3263ac64 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -39,7 +39,7 @@ struct ref_array_item {
 	unsigned int kind;
 	const char *symref;
 	struct commit *commit;
-	struct atom_value *value;
+	struct atom_value *values;
 	char refname[FLEX_ARRAY];
 };
 

--
https://github.com/git/git/pull/450
