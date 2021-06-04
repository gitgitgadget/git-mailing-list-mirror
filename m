Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFCAC47083
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 12:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BF06141A
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 12:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFDMOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhFDMOU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 08:14:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5FFC061761
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 05:12:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so7793513wmk.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=ItCUOvj0L2Ib1sB5GV2zx9xLxLhlsZYy+t85P5IK74cuZaRzInvLjJcgQHzRG+dpSf
         09AzjsgmcR2QSTkgYpTOCCZ1iXnSo2yj/xN/oNvaUdSfhHhQLbpWc0h5feHOdNsYlt/G
         5jPNnXAj57m4tLd3VBo9ig1B+9Po/3TGiu2Bo4R1Z4ZEY46SlxuNvea5uVnyGybVWS0P
         vHIiZM7eDc+/FWe9bJHpPc7ycCu3IH5jCwkJg9kYcIW2wVTglmms9Ma/2zhXwic224jf
         dcA/IgSdYQs72HE8l26+yXiUkA+NSym3i6QUoDxvzaIu47fRCX12W5GhQs/N+S5Ye734
         btdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=kCLzt45HNQ487et1/trSd51T+GqvOse2k44w0GlRS8gL2ikP5OZmvjwke7yDWpi4cw
         5SV7vQDTD2p2snPtPKYqxUg6I7QSahXJ8x1qd/u2WhSX+6pJRtquiS0ZLQLRGxuImEV3
         NcaKNtGls4EWm/s2iXxxG2jAz4/eKuPeM+bvRxkmTJ9nPP4hT50rnGFxoDzZtHWq9cCU
         Jw6uv7fvR6bZ/NMi6AZWxpyh+Bq8NQnLKO6kFaCSsIfOrI5662bQ4+j86OhMhtqUBo37
         /gYi7Um3+jXF71PWN8xmMQwDFld6Vu7kybgMqbGWqBHA6u7MHuP/GGrMh4rSHxN9lnFB
         pKnA==
X-Gm-Message-State: AOAM533VJX7liekXGTaI8JZfI6OmrvkE6cQsZk0x3fuJb+VQlRRgUSGu
        n8luc63Fl6hgG2mUoo+EqFJ37UFRL5o=
X-Google-Smtp-Source: ABdhPJy8AMbaM5GfVdm3lVEpCl2mPFazRXJs+ifKtI4wOojCVKizU03CsPzbMTs6WOUJ6N2fwo8JcQ==
X-Received: by 2002:a05:600c:47c4:: with SMTP id l4mr3298742wmo.145.1622808752650;
        Fri, 04 Jun 2021 05:12:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm7936826wme.43.2021.06.04.05.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 05:12:32 -0700 (PDT)
Message-Id: <48d256db5c349c1fa0615bb60d74039c78a831fd.1622808751.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.966.v2.git.1622808751.gitgitgadget@gmail.com>
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
        <pull.966.v2.git.1622808751.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 12:12:29 +0000
Subject: [PATCH v2 1/2] [GSOC] ref-filter: add obj-type check in grab contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Only tag and commit objects use `grab_sub_body_contents()` to grab
object contents in the current codebase.  We want to teach the
function to also handle blobs and trees to get their raw data,
without parsing a blob (whose contents looks like a commit or a tag)
incorrectly as a commit or a tag.

Skip the block of code that is specific to handling commits and tags
early when the given object is of a wrong type to help later
addition to handle other types of objects in this function.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4db0e40ff4c6..5cee6512fbaf 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1356,11 +1356,12 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
+static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
 	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
+	void *buf = data->content;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
@@ -1371,10 +1372,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			continue;
 		if (deref)
 			name++;
-		if (strcmp(name, "body") &&
-		    !starts_with(name, "subject") &&
-		    !starts_with(name, "trailers") &&
-		    !starts_with(name, "contents"))
+
+		if ((data->type != OBJ_TAG &&
+		     data->type != OBJ_COMMIT) ||
+		    (strcmp(name, "body") &&
+		     !starts_with(name, "subject") &&
+		     !starts_with(name, "trailers") &&
+		     !starts_with(name, "contents")))
 			continue;
 		if (!subpos)
 			find_subpos(buf,
@@ -1438,17 +1442,19 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
+static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
 {
+	void *buf = data->content;
+
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		break;
@@ -1678,7 +1684,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi->content);
+		grab_values(ref->value, deref, *obj, oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
-- 
gitgitgadget

