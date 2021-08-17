Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2999AC4320E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125AD60F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbhHQImS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbhHQImR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:42:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A67C0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so10266472wrn.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+9WPc7uXYwJoHuuTJOk0eAugjjy3PRlOC+2S+kz5SvQ=;
        b=il3Y85l4RH42CoJwa0ab8L8ztwnt0+qcEHa+9Rtzfkzidx9Jxh3uQyt/cSuzmceHih
         3rJ/Z1M4QIAHEcGJRDvTklmqH/Mahq98rxr+gPCKg6BpS4eKr1l4Q+y6r+WwEFYLJg9E
         SGRQ9LKMHWGt8oIAJ2ovWGeUr4DEaZjPxzRQHtxNSz9GCmmxURCMokSTRp7gBQhKVrMu
         dB2RUp3AFpUykl2zBV2Iv6Dsxs5oRvKSBE094xmZDQSTA+YkrVFD1k1DlrDyEuctx8Ul
         y7kBEMpaEY1jVA20ui5N1yGJ14d924TLu5pRKNNUFerG2cVMmUBDHwc8NxOYWiWfL0RA
         OZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+9WPc7uXYwJoHuuTJOk0eAugjjy3PRlOC+2S+kz5SvQ=;
        b=l1WRiyA69K6waXzeZ+EGdOtGph4aoMkIuOUADO49f/ZuhOyh4CQUJYBDAgVRjU3tOi
         q3YpwGkS5oysxA4ehKXClcKBRSjVDeVneJkHbrNnpVl18J9696Oail9HexLycdpQnwKi
         1hSyLGwBirGwH+UvAZYrmiULvZmMaMaVg7WQKwbaIYNruHP7s5Too5VwzQ9896TXmkPg
         Kx28Aaju04xuLo7EqkNuN3CsYOYMiSHmcZlAFBpY4GvckWDNhdetS2cHtH5Lhh8WSlP9
         TnC7AdCv4F34o+Vop5YbEeHuDbs8si7ksdQCdLvyrupUgf2v5MIDau7Uyn+FB9rqu0lf
         hHYQ==
X-Gm-Message-State: AOAM530pubpAimSgE3NSD5TQLOLy3WUsjCzx2YAd31mrva6iJGh4VdhR
        IER6nnH26e4ob5+YhgufaOZn9elC6Wo=
X-Google-Smtp-Source: ABdhPJxo09qzR6kXTB1nA0ukVd0b6K8eEa43NUcDJmn0nzLodQX96LJEuXJSx/HUYvGt2aqtWk0sPg==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr2551189wrx.280.1629189702845;
        Tue, 17 Aug 2021 01:41:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4sm1598399wrz.35.2021.08.17.01.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:41:42 -0700 (PDT)
Message-Id: <14c8a0bdb8051737bfade9c761a647daac7ea12a.1629189701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
References: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 08:41:34 +0000
Subject: [PATCH 1/8] [GSOC] ref-filter: remove grab_oid() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Because "atom_type == ATOM_OBJECTNAME" implies the condition
of `starts_with(name, "objectname")`, "atom_type == ATOM_TREE"
implies the condition of `starts_with(name, "tree")`, so the
check for `starts_with(name, field)` in grab_oid() is redundant.

Remove the grab_oid() from ref-filter, to reduce repeated check.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 93ce2a6ef2e..e38046ca141 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1065,16 +1065,6 @@ static const char *do_grab_oid(const char *field, const struct object_id *oid,
 	}
 }
 
-static int grab_oid(const char *name, const char *field, const struct object_id *oid,
-		    struct atom_value *v, struct used_atom *atom)
-{
-	if (starts_with(name, field)) {
-		v->s = xstrdup(do_grab_oid(field, oid, atom));
-		return 1;
-	}
-	return 0;
-}
-
 /* See grab_values */
 static void grab_common_values(struct atom_value *val, int deref, struct expand_data *oi)
 {
@@ -1100,8 +1090,9 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			}
 		} else if (atom_type == ATOM_DELTABASE)
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
-		else if (atom_type == ATOM_OBJECTNAME && deref)
-			grab_oid(name, "objectname", &oi->oid, v, &used_atom[i]);
+		else if (atom_type == ATOM_OBJECTNAME && deref) {
+			v->s = xstrdup(do_grab_oid("objectname", &oi->oid, &used_atom[i]));
+		}
 	}
 }
 
@@ -1142,9 +1133,10 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			continue;
 		if (deref)
 			name++;
-		if (atom_type == ATOM_TREE &&
-		    grab_oid(name, "tree", get_commit_tree_oid(commit), v, &used_atom[i]))
+		if (atom_type == ATOM_TREE) {
+			v->s = xstrdup(do_grab_oid("tree", get_commit_tree_oid(commit), &used_atom[i]));
 			continue;
+		}
 		if (atom_type == ATOM_NUMPARENT) {
 			v->value = commit_list_count(commit->parents);
 			v->s = xstrfmt("%lu", (unsigned long)v->value);
@@ -1917,9 +1909,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && atom_type == ATOM_OBJECTNAME &&
-			   grab_oid(name, "objectname", &ref->objectname, v, atom)) {
-				continue;
+		} else if (!deref && atom_type == ATOM_OBJECTNAME) {
+			   v->s = xstrdup(do_grab_oid("objectname", &ref->objectname, atom));
+			   continue;
 		} else if (atom_type == ATOM_HEAD) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
 				v->s = xstrdup("*");
-- 
gitgitgadget

