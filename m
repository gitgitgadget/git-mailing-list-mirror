Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E2C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C5420724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmSpUYkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHUVmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHUVlz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:41:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C2BC061574
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so3125614wme.4
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PSLsgbsMTwXOlHbD5s/hbx0sdlArgiwvBIPDoMGVOgM=;
        b=bmSpUYkKKjj7u3VWijAPgIEP3j4jAaadmetJlOSyhLWM4KNBArnA6yfQ3HbBSe1NHu
         u+0z7Lk1fB1md01CTmGPFfsTEM1XyZ7mX6hilzClIroQFToNSp+XWHOPMxlc9EooXBH3
         GkJfLqsBkT+iBz5udBuYTlD4K0PIMDUMw5GDsT0TVFJJCBymEc71WAtr2ESNVQ3a3xz0
         1svFAOGfRJdsAHScWBVK/ijL+/ZFkajlvNxOdwZYPJMpES3VjanFHsXZ1tB3dA6Rbriy
         /YXP6nVFsmytGPXCjtg93dE36EyvnignhS6lyHGE7SqaXgFWGTIgav/F3/PE9EB87rFQ
         rUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PSLsgbsMTwXOlHbD5s/hbx0sdlArgiwvBIPDoMGVOgM=;
        b=Dk+IU1MWXbkO5AJ2S5MTdjeYo9FBfzozvcvECCsrobCRO2s4OrZTMCBx84FBFTlZno
         jPWbwQJ/GhIS4ITY79hUMrBqDKCU5il1F7I4Pk1Ujm/rJIpy2Z8x4/yyEUPJdjYRed8m
         Sqvs3ZjP5J9s/e/TANYJUN+CG1GTKiz5Ztn4ebl0cK17rd0RUFQn+yVCoQ+1VsPWq4TF
         xTSyLSSDh5Y/fBF0xILsRTyUSGqcRKQSqEri/WYnhcOZ4BFGViDL44G9SAoGOCmdYcsp
         mq0nxabDR/cdAGMIgE79uDUtyiJRR+c2t6QsWml+LE8d3Ox4mtss7eDwPnRR3UBXMNUK
         vrCg==
X-Gm-Message-State: AOAM532lz+1RdDuULEU+rQGKrANfuoItTUFA0Uw5IOxN3YvindDOraYC
        nI2OKxqPBClyfLz3tZ2HMbxS112x7ZM=
X-Google-Smtp-Source: ABdhPJxa8CeqiCvxiqu5b90Ic62dXlyrC45wmfbXhus56XbsUomJZKaBwHAJONU+Gs1YWMiGUQeEwQ==
X-Received: by 2002:a1c:1b8f:: with SMTP id b137mr5221054wmb.151.1598046113661;
        Fri, 21 Aug 2020 14:41:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y142sm8205274wmd.3.2020.08.21.14.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:41:52 -0700 (PDT)
Message-Id: <c508c96eb88f7e11b0ac6303c30fa78dd7585ec0.1598046110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
References: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:41:44 +0000
Subject: [PATCH v4 2/8] ref-filter: refactor `grab_objectname()`
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

