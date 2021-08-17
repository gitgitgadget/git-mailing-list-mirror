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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A92CC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4665F60FBF
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbhHQHPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 03:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhHQHP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 03:15:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15876C0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w24so5280828wmi.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zzi6SFtaqQoN+uOiLVvAeRODXFeKD5NWEZX6kME8IyI=;
        b=pHYQgE6PxARnv9lUB3S5faPn5Wa8KU5/ldFbFqLULx+P1eN6QkNMjim/RU8MZvaM6L
         htTjhmaTHKed5wHGBEhcDV5bkJ7N7CvivbG0G8AQFozv4Dt5yEvdoFCdQYMW0hZX/eiU
         Gfc8dhEhzSTCrFmKH73kjQFimJwzhplok9cQ71p6REl4Kp8SXr9Pj2VkcaWEkqytTejr
         hyf0MXFcyWMcKgiAGXENf+EOM3n5A+o1I9GKXv4Se0zQP8Jyo3PlyLD8Pr44ikuqyehj
         x4g0ux8p1NnqjiureggPqys9zatJXdkJ1pm1rcn3rwx6f0j2Ba9+chykFmlHGhnX9LL0
         xqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zzi6SFtaqQoN+uOiLVvAeRODXFeKD5NWEZX6kME8IyI=;
        b=azPuj4zlnFXCADT//uedcmHexKzCGDTeZHZGrijLMG0Da7xxaTUgSanfNFZVAUhk24
         ZCWed1tVYblxYzwYJ3grhQqJZ+rUvld8QjsRvfE1xBzACeFePvxoEOcmcQXVlL47YBSO
         fRfvjZVQ7sut3xYdR6xizGwsuMnuG6slEeEHZgos+zWSAB8Jvz7o1hHlYOPzocfJeFlV
         zxVx/FWSAt1n7ecip1EnbbGd1oyR9hZYsO6OssiiBERSlIQD/ggzD4YI3zsdK6PAUZjE
         fjkeqtM5xaAS3wRnr5XZn/50Ri1nC7VPgmGJL9JlPAlpesHg6OWw0AliDuKiMLD7gsSt
         AxaA==
X-Gm-Message-State: AOAM533SbE+U5MWvCnn793CZEK6WYPt6hJrHH6AdmlZvytGbVsp4A0ax
        R+oTMm0kZMjRS3yLHuUCjXpw+HYc3Zg=
X-Google-Smtp-Source: ABdhPJxQ4DIwypSAfGTGShVIdZE31Ljam7Lp/1ekXjrrq7Ik7uT3d6s6I8u5fThbhQHDKstmIIpahw==
X-Received: by 2002:a05:600c:2281:: with SMTP id 1mr1832830wmf.9.1629184493700;
        Tue, 17 Aug 2021 00:14:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm1352363wrv.96.2021.08.17.00.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 00:14:53 -0700 (PDT)
Message-Id: <3476e548338623f954abd73192360bcba7df3d89.1629184489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
References: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 07:14:49 +0000
Subject: [PATCH 5/5] [GSOC]: ref-filter: instead CALLOC_ARRAY to ALLOC_ARRAY
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

populate_value() uses CALLOC_ARRAY() to allocate dynamic memory for
ref->value. But after that, we immediately assign values to its
members in the for loop. This shows that it is not necessary to
use CALLOC_ARRAY() for ref->value to clear the memory.

Therefore, use ALLOC_ARRAY() instead of CALLOC_ARRAY() to reduce the
overhead caused by clearing the memory. This can bring performance
optimizations.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 35e221e7ec8..fe2df82067f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1884,7 +1884,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	struct object *obj;
 	int i;
 
-	CALLOC_ARRAY(ref->value, used_atom_cnt);
+	ALLOC_ARRAY(ref->value, used_atom_cnt);
 
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
@@ -1903,6 +1903,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		const char *refname;
 		struct branch *branch = NULL;
 
+		v->s = NULL;
 		v->s_size = ATOM_SIZE_UNSPECIFIED;
 		v->handler = append_atom;
 		v->atom = atom;
-- 
gitgitgadget
