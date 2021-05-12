Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BED8C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C33861413
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhELMMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 08:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhELMMR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 08:12:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EE8C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 05:11:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d11so23366227wrw.8
        for <git@vger.kernel.org>; Wed, 12 May 2021 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gBHcabRsxOzaTZfqoW2cX/vxixQylnxsAwx9htHPiKg=;
        b=ThqVZtHYhy6BgQr8guhncNqt/Y/N8SJL/vwrIhM7m2FnY6LCp7Bv+ZPLc8azaGarbp
         +cRpcfM4+3bNqMSNdUQIjzr/5zdso2ZC71lM7x1/m6HaOGyRgraubr7WI/dlPGVOSAij
         2h/G8RBwDlaYtdIW8VBPAHxEUz43DxM2xgW0TYr9GMSo8zdIbOnHWbpJ7x1hyIK7XvqS
         /mUZcuwYar37wrqW4Y7kW2Wtk82ZV5kmxjppiq8kD160fOoLTKBNcUqlP4HonROPuceC
         dbXozUZaBkJYJbYeW/0oIGjXx0IS9rMjG+aSpBWC4WtUhuzzez5cyYKE3jMCTOLMHrYP
         dWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gBHcabRsxOzaTZfqoW2cX/vxixQylnxsAwx9htHPiKg=;
        b=lHho3apE+vcxVeKGpHFXdUdM5rYAHiI6f+jmU+Ej8QzltXrWDVGJrvXdGLd4MDzPd7
         tmiMRAlGjqcXjSn3EPjoOkmKFiw6shMX8dhtuyKbk7aH0dsl/awktdE9BMrEX00rGhSJ
         UL742KI7S+a64toZuvPTLkdfW6sIaBnLTxDtelYm+N14wsipiVnMgWZMp36Vc5eQKNMh
         28mvo6LEH7TOqtu7yu4HdkrQ3XEtcLx9/5UX6Y8Q1VWKtHjXqFugPzpit2FLWv6uqMFJ
         zhL6Mv63ri2L9FBshDRfrIaFSiVRET4LeSn/QSSN24Y3s1o4g9IcTdIYpt/nPMfDL7VA
         81fA==
X-Gm-Message-State: AOAM533+Et9srhlV8+xEdBW8iw9FZoPNA2eilE9a+xp720aQPHfbnud0
        CyUaaS88e1gI26b0TMsrAkcPAzni5PY=
X-Google-Smtp-Source: ABdhPJziYX97A6ooAD5uxirjcWQBALVGh+vghPulVZHezUtre7uylGnVaDN0EoN9xIjD/F6i+pbxyw==
X-Received: by 2002:a05:6000:1863:: with SMTP id d3mr45080425wri.126.1620821467164;
        Wed, 12 May 2021 05:11:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c187sm6124066wmf.23.2021.05.12.05.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:11:06 -0700 (PDT)
Message-Id: <91ca57c9d04a822aa4955dbfe3962a6fb2444e81.1620821464.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.951.v3.git.1620821464.gitgitgadget@gmail.com>
References: <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
        <pull.951.v3.git.1620821464.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 12:11:03 +0000
Subject: [PATCH v3 1/2] [GSOC] ref-filter: add objectsize to used_atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Since "objectsize:size" is composed of two parts,
"type:attribute". However, the original implementation
did not decouple the two parts "type" and "attribute" well,
we still need to judge separately whether the atom is
"objectsize" or "objectsize:disk" in `grab_common_values()`.

Add a new member `objectsize` to the union `used_atom.u`,
so that we can separate the judgment of atom type from the
judgment of atom attribute, This will bring scalability to
atom `%(objectsize)`.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index a0adb4551d87..f420bae6e5ba 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -146,6 +146,9 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} oid;
+		struct {
+			enum { O_SIZE, O_SIZE_DISK } option;
+		} objectsize;
 		struct email_option {
 			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
 		} email_option;
@@ -269,11 +272,13 @@ static int objectsize_atom_parser(const struct ref_format *format, struct used_a
 				  const char *arg, struct strbuf *err)
 {
 	if (!arg) {
+		atom->u.objectsize.option = O_SIZE;
 		if (*atom->name == '*')
 			oi_deref.info.sizep = &oi_deref.size;
 		else
 			oi.info.sizep = &oi.size;
 	} else if (!strcmp(arg, "disk")) {
+		atom->u.objectsize.option = O_SIZE_DISK;
 		if (*atom->name == '*')
 			oi_deref.info.disk_sizep = &oi_deref.disk_size;
 		else
@@ -967,12 +972,14 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			name++;
 		if (!strcmp(name, "objecttype"))
 			v->s = xstrdup(type_name(oi->type));
-		else if (!strcmp(name, "objectsize:disk")) {
-			v->value = oi->disk_size;
-			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)oi->disk_size);
-		} else if (!strcmp(name, "objectsize")) {
-			v->value = oi->size;
-			v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
+		else if (starts_with(name, "objectsize")) {
+			if (used_atom[i].u.objectsize.option == O_SIZE_DISK) {
+				v->value = oi->disk_size;
+				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)oi->disk_size);
+			} else if (used_atom[i].u.objectsize.option == O_SIZE) {
+				v->value = oi->size;
+				v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
+			}
 		} else if (!strcmp(name, "deltabase"))
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
 		else if (deref)
-- 
gitgitgadget

