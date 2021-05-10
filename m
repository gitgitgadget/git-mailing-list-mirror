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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBBDC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCB5611BE
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhEJPZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbhEJPYs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:24:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4596FC07E5E8
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:03:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s8so16988167wrw.10
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gBHcabRsxOzaTZfqoW2cX/vxixQylnxsAwx9htHPiKg=;
        b=tAaucDwWDZkr+DqEJuEwrlhB3+rRrwLZaJRNElQhlhfjyUwWli0aCI6vOzVOijiA+6
         aje54d9APLul37VM3BFPlfNslj+GW4QhAOXjAWxB7ytOvGmR8L4EAOkK4dW6Kw0l0aCC
         m/kV6ZxYUUR7q6CSG7Z83LBt85lpf6bgJu7rnTI7uE3u3A7EY8Kw8l/FPB/2vWcqQbmt
         QOTSd2Us5ujHu+jQeL5PIZSObMg6oq3zvoydNd/MChewjhGE4ZSHbLQz16ZbYiWa2c8v
         PX97hMpOqT5zkePQ6ZwOopgpJV6XtcK0hevPNxoWsHSv7+7fMsHkQL/SGpGmIxEiV7C1
         MG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gBHcabRsxOzaTZfqoW2cX/vxixQylnxsAwx9htHPiKg=;
        b=hu95u9O6o/6PR3Ju5k+gZb5yQ+INBvv9bCuOFos//K85WXM71zeNp3zlPEUR7MNyTI
         TW91LKraQtNx7Dyf1Jo0Edy0RrSddn7qeZopQMipURpaj5Dym4aiZ3KvXKzBxQmpTTd7
         bc/tahekKLXcrC4nlCFbfJtEXFlN7JM1fFldqQyo4KEeyonulC1rxIAGPW3u8QsFg1cO
         dWHNNPusd/790TqBQV6ywLKDkKk3Yjdzbl6oEvCg5t3aO2qY4V9ztxO8n0fV8y9G3pQw
         nFg+DER/lYUodRxOBMrWt6tjm1gHIqdxvn9pFEJH7GFS+sQVwzib1L7c2aes5APma1Y8
         cP4Q==
X-Gm-Message-State: AOAM532p4k89SW67FWuLTedeDgM00kc6oTiXXB4GiB9cVL0yGWXjLVsr
        D1Bh19l0dx+H/jJxgNFEEQiFIUH0Dpw=
X-Google-Smtp-Source: ABdhPJxjSv8/ffMXzLRdNKyvml8/sNydxD8emepfMcJp8RERFy2lk8DG4hdDk6it6Nxhkfqw3Ilmag==
X-Received: by 2002:a5d:59a1:: with SMTP id p1mr31294773wrr.332.1620659002013;
        Mon, 10 May 2021 08:03:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4sm24563344wrz.33.2021.05.10.08.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:03:21 -0700 (PDT)
Message-Id: <91ca57c9d04a822aa4955dbfe3962a6fb2444e81.1620659000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
        <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 May 2021 15:03:18 +0000
Subject: [PATCH v2 1/2] [GSOC] ref-filter: add objectsize to used_atom
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

