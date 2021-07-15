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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D39C47E48
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205EC613E0
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbhGOPna (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbhGOPn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5427AC061764
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f9so8339355wrq.11
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=W8ooZCt6Qfgnwu0vRHhx5yRmsci71JFTX9Sq2mPY6j0=;
        b=PZBtrSTGUpQ+RW4ex3S6q7CyP7kvt8x9dAYau80gARBGuskHptz4HYOkWAEdNjmpRp
         oxtCYVlFqNDKGuF+eweVX25uUlP3zGZX/mhqfO4GGZ3rIpTHHr8TVY/BreE3IxMU73GI
         vIqLNrJ4XOeAwJpslAeNZT+6tVLz+Wh1dQYzpF+TXzT8uRc1SjEAgVODUTd8qNlEL+AF
         MYsIS2bXg5rODSDWOZGX5vaG1etTxlsuocvBE6r4WYQIweeD+xYEmb+q9Fs76jdVfC2c
         kNpSJasYZ9cq3iVQ50gs6m3NkU5ZkReV0vRGH3EUpO6ysFjcpIrvp5Gw1/IwaNXMYrf7
         lyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=W8ooZCt6Qfgnwu0vRHhx5yRmsci71JFTX9Sq2mPY6j0=;
        b=EjyO2sAx4lihuSAa1TaYsXGjeJLLBGGUEcd+zFGO9jfZ5nZLd79Ol4B7GKhQls/A4Q
         6OOxgncK4UmcWbP1XmOp/AE03fAUxdejuqiTrW3rs0RhKSEF1U55MVh+8Z72feTdF/6w
         zJ6daAGM3EXSLkWh3s2/O1YhNTAtlFZAQ0/nJkrVzYAXMXMiuh0VNM3Pb7S2Efs+AqmO
         HPvHVj7ADkeEwSCcgLOf+/ipSa+VUG90//ib4p/nt438HzR8n5EHLyOL8p0lt4kRsJdw
         92uaiCx3DPbzeCmxhUdgNlorpIUp6Q/MbPvttX3byr/BxwU0C/rQd/mGvKbDsTkmWrRC
         wfzA==
X-Gm-Message-State: AOAM530/k1Ax8JayWZovKnNZQ6RolqxpkWvivQ//EEbp/zyBTqUD9HGC
        FA82wONXTdRYQo0Czwfr579wKJPzJLg=
X-Google-Smtp-Source: ABdhPJxZH5pn0mZvnfDMffNoQ1ddpTIOXaHb4M7vQVAOkGL7SeEmKhJKScqOU3JDR8ogEjxELXsphA==
X-Received: by 2002:a5d:53c5:: with SMTP id a5mr6508228wrw.15.1626363631983;
        Thu, 15 Jul 2021 08:40:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm6777792wrm.13.2021.07.15.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:31 -0700 (PDT)
Message-Id: <c3378dbfaed6b8d62ef46d8528770efa8365fb1a.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:14 +0000
Subject: [PATCH v2 06/17] [GSOC] ref-filter: pass get_object() return value to
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
index af8216dcd5b..cfcea0e507e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1821,6 +1821,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
 	int i;
+	int ret;
 	struct object_info empty = OBJECT_INFO_INIT;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
@@ -1977,8 +1978,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 
 	oi.oid = ref->objectname;
-	if (get_object(ref, 0, &obj, &oi, err))
-		return -1;
+	ret = get_object(ref, 0, &obj, &oi, err);
+	if (ret)
+		return ret;
 
 	/*
 	 * If there is no atom that wants to know about tagged
@@ -2010,8 +2012,10 @@ static int get_ref_atom_value(struct ref_array_item *ref, int atom,
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
@@ -2585,6 +2589,7 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	int ret;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
@@ -2597,10 +2602,10 @@ int format_ref_array_item(struct ref_array_item *info,
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

