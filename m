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
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE801F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbeBEL15 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:27:57 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:59194
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752722AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=zxo/rZ1iAkfXHGKbnveFVWM473n2mroqIR54PBZUTgk=;
        b=ijQWz0DckZaLKZOaQU0C3X4lQPkzvhNBOHfOA1jBY2FJvCnTIZf14x/J0p+eb3OZ
        BSqMcliTodmUT34V5teDahZ19vMUk5LeVTRwY5zTStdtthHYehYZGGRW/k0lmY2A/YQ
        H7Vzz/ow3Y6IQiB/jlmFX9Zwv5N+sEKueVQCbKkA=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b43b-65f0cf49-6159-40d8-9bee-de4205e5532f-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 11/25] ref-filter: rename field in ref_array_item
 stuct
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:39 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename objectname field to oid in struct ref_array_item.
Next commit will add objectname field that will contain
string representation of object id.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c |  4 ++--
 ref-filter.c       | 10 +++++-----
 ref-filter.h       |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 61b7acc79155d..367b1bd5802dc 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -186,7 +186,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			 struct ref_array_item *item)
 {
 	if (is_atom("objectname", atom, len))
-		strbuf_addstr(sb, oid_to_hex(&item->objectname));
+		strbuf_addstr(sb, oid_to_hex(&item->oid));
 	else if (is_atom("objecttype", atom, len))
 		strbuf_addstr(sb, typename(item->type));
 	else if (is_atom("objectsize", atom, len))
@@ -294,7 +294,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 		return;
 	}
 
-	item.objectname = data->oid;
+	item.oid = data->oid;
 	item.type = data->type;
 	item.size = data->size;
 	item.disk_size = data->disk_size;
diff --git a/ref-filter.c b/ref-filter.c
index 4acd391b5dfac..d09ec1bde6d54 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1489,7 +1489,7 @@ int populate_value(struct ref_array_item *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname.hash, v, atom)) {
+		} else if (!deref && grab_objectname(name, ref->oid.hash, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
@@ -1534,13 +1534,13 @@ int populate_value(struct ref_array_item *ref)
 	if (used_atom_cnt <= i)
 		return 0;
 
-	buf = get_obj(&ref->objectname, &obj, &size, &eaten);
+	buf = get_obj(&ref->oid, &obj, &size, &eaten);
 	if (!buf)
 		die(_("missing object %s for %s"),
-		    oid_to_hex(&ref->objectname), ref->refname);
+		    oid_to_hex(&ref->oid), ref->refname);
 	if (!obj)
 		die(_("parse_object_buffer failed on %s for %s"),
-		    oid_to_hex(&ref->objectname), ref->refname);
+		    oid_to_hex(&ref->oid), ref->refname);
 
 	grab_values(ref->value, 0, obj, buf, size);
 	if (!eaten)
@@ -1890,7 +1890,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 {
 	struct ref_array_item *ref;
 	FLEX_ALLOC_STR(ref, refname, refname);
-	hashcpy(ref->objectname.hash, objectname);
+	hashcpy(ref->oid.hash, objectname);
 	ref->flag = flag;
 
 	return ref;
diff --git a/ref-filter.h b/ref-filter.h
index e16ea2a990119..87b026b8b76d0 100644
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
https://github.com/git/git/pull/452
