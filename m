Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940B4C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1CE206F6
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVqCIc3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHEVv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgHEVvw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:51:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3628C061757
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:51:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 3so7771630wmi.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zh/SM7bEToiUSBKDmzJ3iJ6Bqe83IxresQCCJLW6RrI=;
        b=XVqCIc3ISKW+GwV8LiQU64utTEB9xBjgdzDSiSnpg3n9XZBKkpI2jNbOnp2fIKtKVR
         0opOKJIygTFmBAXeVhQhdCcPtdSR+noNw2IkBqA0XxOV34gFcqHmxfm+sd8VPUj5cftC
         jFqpMLZJl7R8Mvqo+/3n2roUaRiDqrtPKvyJsQKpfpgXjXK4ru1NczLZZZI0uiNzysRh
         Rb8b/afaV1Y5jMameGlCwA9gEJ95uBky4dTYc0Hs4ZV/hZi1DbK5y5kwZPJ9Aa+6Ka8o
         0PWFbmBNi3T0sdGNFQtd7654ZHEHVASGUtys7MNxZxkjQZb+GS5++etqJUgcVjwj0bQh
         UKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zh/SM7bEToiUSBKDmzJ3iJ6Bqe83IxresQCCJLW6RrI=;
        b=o0V/6p55CqnZBUwbVz9m2P/IDDtHpbWjIdVm7JtGnRkEE0kxzn8aMjH/GCM+pwEKPR
         0dYuGr04HdabmCZb8/PVKCjS8oSGOU995585Rr6Vdh60lPj8wPCsosvtMjYHyh+teNhh
         Slrxf0ZPNIC5WvXNApnwsTpGlmx5atbwjJ32XhdE15RQkm3JHGB/SKJFZwtOaq+enojm
         9Igpt2Nt0htrc7LDIRwP0gnkKX7Vb+cnRX2eXEM9JuZDJzhAi0q5AoP5+3bHXoUmUVFu
         IFGtt8EsmcETMUCERBNm6RUW6u6dlVMHnl3t0acMeeXtOuwMr+It8rLYnw+K2/Als/58
         m2ZA==
X-Gm-Message-State: AOAM533uqgYg7B/6Sw08jMDmkQInJ7mzVxKrVboDJ8FDeRpOscramTEI
        ctnHELGtpsmiZlK8aU/rtUaJymiX
X-Google-Smtp-Source: ABdhPJw6qrEst2B/XNZV0B9VxLC3AgMOLrhE7gYuhcIAtdLVPpYs6cELKVhowQRp0g+rFwm6SbYQkA==
X-Received: by 2002:a1c:2e4e:: with SMTP id u75mr3973458wmu.134.1596664310254;
        Wed, 05 Aug 2020 14:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 15sm3888335wmo.33.2020.08.05.14.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:51:49 -0700 (PDT)
Message-Id: <b6b6acab9af222c4c2b43836c357addd6e7e239d.1596664306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 21:51:38 +0000
Subject: [PATCH v2 2/9] ref-filter: refactor `grab_objectname()`
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
index 307069219f..d078f893ff 100644
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

