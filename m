Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D67020248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfBVQGP (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:06:15 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:54602
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727121AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=lOf5DfQhFVtnFBrBmYKYPOM4s6GiVMFus78kCsuQK5U=;
        b=hTgkr3f1eNa43cC0hK3No6zQjk7Y+o6EViOuonA/uSEx8pCysUryya3+CpKlgenf
        F/iEdjdRATSUNa92eo7teym4toih3mrviMnOy2q/mz2XI3wLEVT60Ii8/rmLwCyutze
        XeRauu3z6KBwoqUgeQ4ws8uGzG7PaHNKsL7M5SPs=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a3c-5b22158a-2d4f-4611-9239-8388af61fd8f-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 02/20] ref-filter: rename field in ref_array_item stuct
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename objectname field to oid in struct ref_array_item.
We usually use objectname word for string representation
of object id, so oid explains the content better.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/ls-remote.c | 2 +-
 ref-filter.c        | 8 ++++----
 ref-filter.h        | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1d7f1f5ce2783..ce79aede726c7 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -143,7 +143,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		const struct ref_array_item *ref = ref_array.items[i];
 		if (show_symref_target && ref->symref)
 			printf("ref: %s\t%s\n", ref->symref, ref->refname);
-		printf("%s\t%s\n", oid_to_hex(&ref->objectname), ref->refname);
+		printf("%s\t%s\n", oid_to_hex(&ref->oid), ref->refname);
 		status = 0; /* we found something */
 	}
 
diff --git a/ref-filter.c b/ref-filter.c
index 422a9c9ae3fd2..736e1f9cc38fc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1615,7 +1615,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, &ref->objectname, v, atom)) {
+		} else if (!deref && grab_objectname(name, &ref->oid, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
@@ -1661,7 +1661,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		struct atom_value *v = &ref->value[i];
 		if (v->s == NULL && used_atom[i].source == SOURCE_NONE)
 			return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
-					       oid_to_hex(&ref->objectname), ref->refname);
+					       oid_to_hex(&ref->oid), ref->refname);
 	}
 
 	if (need_tagged)
@@ -1671,7 +1671,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		return 0;
 
 
-	oi.oid = ref->objectname;
+	oi.oid = ref->oid;
 	if (get_object(ref, 0, &obj, &oi, err))
 		return -1;
 
@@ -1898,7 +1898,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	struct ref_array_item *ref;
 
 	FLEX_ALLOC_STR(ref, refname, refname);
-	oidcpy(&ref->objectname, oid);
+	oidcpy(&ref->oid, oid);
 
 	return ref;
 }
diff --git a/ref-filter.h b/ref-filter.h
index 85c8ebc3b904e..4d7d36e9f522d 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -34,7 +34,7 @@ struct ref_sorting {
 };
 
 struct ref_array_item {
-	struct object_id objectname;
+	struct object_id oid;
 	int flag;
 	unsigned int kind;
 	const char *symref;

--
https://github.com/git/git/pull/568
