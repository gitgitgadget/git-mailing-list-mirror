Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D2EC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290D62065D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN0vTcb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbgHQSKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbgHQSK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:10:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA9C061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l2so15874558wrc.7
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PSLsgbsMTwXOlHbD5s/hbx0sdlArgiwvBIPDoMGVOgM=;
        b=XN0vTcb+UH/C5LwD8FRut0VGr+hseFWANaG1I8dZn//R4VU52XBQerwCxTDze6pKKC
         R2M+1m9uK/Jne6v9rVh8vSO3PqWTkevFzk5/iDOllRwMBLdihkBu+3yCMvbRYdAxx+ZG
         R1ECwjeBWR6RwkCYfohf3iCdJjpjMdM2Z0hlWmWmS95aJkPW0qzc6hByqXJ/20T/OLjP
         Uww0/NwcIyOtYmSPRpS5zWf4f3AHmNmropFZ3hbn7S7pnsg4ktlIUDSgfEn/xy/d7bCg
         mmPJSODUJ5hnhYUMiNyIKROoAe9I2rjvYU24uBcfgYBflmNvWDG3ZAezS8CpW+eNOXrG
         IryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PSLsgbsMTwXOlHbD5s/hbx0sdlArgiwvBIPDoMGVOgM=;
        b=QNwKa6mYZmmh2oRkav6qEp5ruYz02lff8SMtVNu79k/bs/SM4pR8kGRboLkb6pcyRb
         jlg0OFHJq24QiDTuWixS2bx0Hp/g8a1lHD2TI3/X0ZnYdEwAQginuaXloS9KMsrffNeu
         GdI5qANvnOWAoiEmLj381ytrm0UGkncJeKUq4CQmGiTMDS3bJxf/FClbm6D3BVxM1f4K
         t13Qt7aq5pJbkaJrfEFCUpgEWJDIwXT/5YpJe0j6ltDANxd9TUfLiQQn/a5v3+zj1w+X
         Lc532GXHFALwoUyhhuVs4MP+3oT3KX9j7sdiUkGvjAKN2UhxqO5Yz5VDj6BAoBr0YTdp
         fsjQ==
X-Gm-Message-State: AOAM532AmwaSxVUIogAXIVqwJR41ZYS7y+r+f5+72kZklldt6pqnIg80
        cajlLN8aaootWBYa6ofespoRnV4UsJ8=
X-Google-Smtp-Source: ABdhPJyd8WTGaULx3bZB5HCZ29wqHkXEMRJJdJTRoOiFTUfRMtRksHgmIvmOhDPMZ/W1Xm8JY/2TSw==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr17629004wru.170.1597687825097;
        Mon, 17 Aug 2020 11:10:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b123sm30904055wme.20.2020.08.17.11.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:10:24 -0700 (PDT)
Message-Id: <5268b973dace3f453821a7800b5ec0dd0dfbe848.1597687822.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 18:10:15 +0000
Subject: [PATCH v3 2/9] ref-filter: refactor `grab_objectname()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Prepares `grab_objectname()` for more generic usage.
This change will allow us to reuse `grab_objectname()` for
the `tree` and `parent` atoms in a following commit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e60765f156..9bf92db6df 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -918,21 +918,27 @@ int verify_ref_format(struct ref_format *format)
 	return 0;
 }
 
-static int grab_objectname(const char *name, const struct object_id *oid,
+static const char *do_grab_objectname(const char *field, const struct object_id *oid,
+				      struct used_atom *atom)
+{
+	switch (atom->u.objectname.option) {
+	case O_FULL:
+		return oid_to_hex(oid);
+	case O_LENGTH:
+		return find_unique_abbrev(oid, atom->u.objectname.length);
+	case O_SHORT:
+		return find_unique_abbrev(oid, DEFAULT_ABBREV);
+	default:
+		BUG("unknown %%(%s) option", field);
+	}
+}
+
+static int grab_objectname(const char *name, const char *field, const struct object_id *oid,
 			   struct atom_value *v, struct used_atom *atom)
 {
-	if (starts_with(name, "objectname")) {
-		if (atom->u.objectname.option == O_SHORT) {
-			v->s = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
-			return 1;
-		} else if (atom->u.objectname.option == O_FULL) {
-			v->s = xstrdup(oid_to_hex(oid));
-			return 1;
-		} else if (atom->u.objectname.option == O_LENGTH) {
-			v->s = xstrdup(find_unique_abbrev(oid, atom->u.objectname.length));
-			return 1;
-		} else
-			BUG("unknown %%(objectname) option");
+	if (starts_with(name, field)) {
+		v->s = xstrdup(do_grab_objectname(field, oid, atom));
+		return 1;
 	}
 	return 0;
 }
@@ -960,7 +966,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 		} else if (!strcmp(name, "deltabase"))
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
 		else if (deref)
-			grab_objectname(name, &oi->oid, v, &used_atom[i]);
+			grab_objectname(name, "objectname", &oi->oid, v, &used_atom[i]);
 	}
 }
 
@@ -1740,7 +1746,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, &ref->objectname, v, atom)) {
+		} else if (!deref && grab_objectname(name, "objectname", &ref->objectname, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
-- 
gitgitgadget

