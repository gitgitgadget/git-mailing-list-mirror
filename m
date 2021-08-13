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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4058AC432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29646610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhHMIXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbhHMIXo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE39C0612E7
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z9so12049552wrh.10
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=bRGi4pz2Xh9luD1c5Eb25LfrkRp+oBcvgyF4Y4GisV8=;
        b=cFx+Df30eL1G4j5AZECJQAW3VfVBDx6PSQi97YjhbykMx3h41qcrVABG0MNMUUQvWq
         BfmEpGMnbULrmvUX+mY2ifmMaeVdmMrwFqT/oMpOyjZrv23e25moYFYIj61JZE7OZWSv
         N4AqZXh8yPV0uCrS9nfEUm8chso7GL0lYCsp+mXpmy6m4qEA74ci8wE6lE54Pgi4OBdA
         Y0dBY56FMbZcfgB2Efbxk4KCNp9ApYDYw9V+bzeAATsULXE6pTCgCOowDNyc98EDcepu
         qkLwZCbp+csiM/Ch8PEkFbQHI58QyqGIvfnlROw3wm9P04UfkV1MfqXitjiIor7ixGmS
         gVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=bRGi4pz2Xh9luD1c5Eb25LfrkRp+oBcvgyF4Y4GisV8=;
        b=mUzTgzP7bcb7OHvHBwI9+PzD/VCBTda7CO0zKeVSYasX1FlgKu+r3wf7LejHTqZJyg
         IhAsaIKz+TgPDWhJAU/t9gXc2oPrLU9DfXQC4BmOKJCGJyAz+ZWtY1o1XnTaIiTL62Xr
         hH1CPfHZBXAIxFU4SSTr1Xy0/U8wN9fn1n/wTvp5jqLer+EPWzIQQKQmoAQJlYY/tSyy
         WeXh+opG7L30/3ifceTF30Sh0dpwMigXKxvM8cMom2Nr1Ydd2l0KWCaJS56IdZYv2sBR
         a0s2mImiZAKz1ZDmMFIJeEZV4G7RkyW0kLq94XThe9xIHOiKM9qey8dChtJWM6Es8vrO
         M/CQ==
X-Gm-Message-State: AOAM5337SeRWDyHO6YfFn2bsCsS4qkVSwzJSpJooBQqFcQ31pxF9Qaca
        dp5vKGD4AhVN/i8O6tBvp4Pk34kYbKs=
X-Google-Smtp-Source: ABdhPJyriD1eBFOcIES5vvub87ICTXuFWInocrgGOL3QHHnWawj8nGSZBZQUfU+lx9WvimTIG2aQXQ==
X-Received: by 2002:adf:ea09:: with SMTP id q9mr1667930wrm.64.1628842995835;
        Fri, 13 Aug 2021 01:23:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm702808wmc.24.2021.08.13.01.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:15 -0700 (PDT)
Message-Id: <c82c2d7ceab00b85d90701d9fc6d2023fa7799be.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:49 +0000
Subject: [PATCH 06/27] [GSOC] ref-filter: pass get_object() return value to
 their callers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Because in the refactor of `git cat-file --batch` later,
oid_object_info_extended() in get_object() will be used to obtain
the info of an object with it's oid. When the object cannot be
obtained in the git repository, `cat-file --batch` expects to output
"<oid> missing" and continue the next oid query instead of letting
Git exit. In other error conditions, Git should exit normally. So we
can achieve this function by passing the return value of get_object().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 93ce2a6ef2e..2fd3b69f6d6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1825,6 +1825,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
 	int i;
+	int ret;
 	struct object_info empty = OBJECT_INFO_INIT;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
@@ -1981,8 +1982,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 
 	oi.oid = ref->objectname;
-	if (get_object(ref, 0, &obj, &oi, err))
-		return -1;
+	ret = get_object(ref, 0, &obj, &oi, err);
+	if (ret)
+		return ret;
 
 	/*
 	 * If there is no atom that wants to know about tagged
@@ -2014,8 +2016,10 @@ static int get_ref_atom_value(struct ref_array_item *ref, int atom,
 			      struct atom_value **v, struct strbuf *err)
 {
 	if (!ref->value) {
-		if (populate_value(ref, err))
-			return -1;
+		int ret = populate_value(ref, err);
+
+		if (ret)
+			return ret;
 		fill_missing_values(ref->value);
 	}
 	*v = &ref->value[atom];
@@ -2592,6 +2596,7 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	int ret;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
@@ -2604,10 +2609,10 @@ int format_ref_array_item(struct ref_array_item *info,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
-		if (pos < 0 || get_ref_atom_value(info, pos, &atomv, error_buf) ||
+		if (pos < 0 || (ret = get_ref_atom_value(info, pos, &atomv, error_buf)) ||
 		    atomv->handler(atomv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
-			return -1;
+			return ret ? ret : -1;
 		}
 	}
 	if (*cp) {
-- 
gitgitgadget

