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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6A1C4320E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CAF6109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbhHMIYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbhHMIXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D859C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h13so12174563wrp.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R5l2xbFARzrNIJu+PtNYP7lBcR3O4QNQ1MhipoiwXSg=;
        b=QGAf29UYRrMcYQSgryi+mdmFB7OncLLAwQRIkSGA35kMvBMoLpm9gATCso06I3VF6n
         nCN82KTNUOYWnkHU1k0zGZfLInkiXVChPQavcvScCVYnOFOf7+UPLClMDKnwEC7GAtrx
         x/HpLkPIuXG2GQ+zR3c7iVY/X9n/wp4L+/EicZJtZrDYsoRoiLKbsYi69q0Grb2Dlyk/
         MY9fiM1EFag0xL9QHLyIKht52Ayl21PMCRhdBLe4K7ontiIGSzIjxhkJsmdev8yPQttL
         NpEYkjJXw3ElKVOAlxaLD8pIqzQJ+AuUaqV+UNJWjXauFBj0U/j6cU369VCSR5LmgZ2j
         4YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R5l2xbFARzrNIJu+PtNYP7lBcR3O4QNQ1MhipoiwXSg=;
        b=ccnt++69nqzW/YZvJV3Sz50UISsXt7NXVYUxTQAqljs/xU/HP9xo4KLBAvkt/4x2ZL
         /piNNBiDrRtob4MxsBLRFbEYUzfWm387A3j5D0gf7hPNpKr0oMOxFQ7HVQYs9Nh8BIiv
         w2xF4AQ/tpMRHl8H1jHAf6NZ2FGcEdvRKQJBc13X7JJsmliXkro0Fq0nuEiKCm8OUJDM
         xmgscBgUEkBXMhjKOAWAnIZmfwq13Z5ByrISBok1uEItLd0ipiTyGBpDJfWUpkcrbhJy
         dvrPI1EMxKD07gbxSxj32tqGH+lhnTmzarCRliAQuAn8o8+W2Qr63n87M+mL+Fwe7Ti/
         a91Q==
X-Gm-Message-State: AOAM531RhyBxzQodgJ6RHw/nXlNAJtxFcLZQW2+t9wm9Qkh0xoXIQIbO
        hySFnZaVq/KKSHYIokEI/lQBaLCKEwI=
X-Google-Smtp-Source: ABdhPJz9cMfvCyeV3LhtTY3zmir+nXZVbOTAjDlUvkBzpwHyF06qEwN+v0HzE5cqxHFcYjnzitZfkQ==
X-Received: by 2002:a5d:6090:: with SMTP id w16mr1694429wrt.38.1628843003742;
        Fri, 13 Aug 2021 01:23:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm741939wma.25.2021.08.13.01.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:23 -0700 (PDT)
Message-Id: <20cbc3645f14a2090195abeb880cca1541aa1206.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:23:02 +0000
Subject: [PATCH 19/27] [GSOC] ref-filter: remove strlen from find_subpos
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

find_subpos() needs to use strlen() to get the length of the object
content, but in the caller of find_subpos(): grab_sub_body_contents(),
we can already get the length of the object content through data->size.
So add a `size_t buf_size` in find_subpos(), and pass data->size to
it. This can lead to weak performance optimizations.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3ccb531e073..be4c4405b12 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1346,7 +1346,7 @@ static void grab_person(enum atom_type type, struct atom_value *val, int deref,
 	}
 }
 
-static void find_subpos(const char *buf,
+static void find_subpos(const char *buf, size_t buf_size,
 			const char **sub, size_t *sublen,
 			const char **body, size_t *bodylen,
 			size_t *nonsiglen,
@@ -1354,12 +1354,12 @@ static void find_subpos(const char *buf,
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
+	const char *begin = buf;
 	const char *eol;
-	const char *end = buf + strlen(buf);
 	const char *sigstart;
 
 	/* parse signature first; we might not even have a subject line */
-	parse_signature(buf, end - buf, &payload, &signature);
+	parse_signature(buf, buf_size, &payload, &signature);
 
 	/* skip past header until we hit empty line */
 	while (*buf && *buf != '\n') {
@@ -1372,7 +1372,7 @@ static void find_subpos(const char *buf,
 	while (*buf == '\n')
 		buf++;
 	*sig = strbuf_detach(&signature, siglen);
-	sigstart = buf + parse_signed_buffer(buf, strlen(buf));
+	sigstart = buf + parse_signed_buffer(buf, buf_size - (buf - begin));
 
 	/* subject is first non-empty line */
 	*sub = buf;
@@ -1395,7 +1395,7 @@ static void find_subpos(const char *buf,
 	while (*buf == '\n' || *buf == '\r')
 		buf++;
 	*body = buf;
-	*bodylen = strlen(buf);
+	*bodylen = buf_size - (buf - begin);
 	*nonsiglen = sigstart - buf;
 }
 
@@ -1462,7 +1462,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 		     !starts_with(name, "contents")))
 			continue;
 		if (!subpos)
-			find_subpos(buf,
+			find_subpos(buf, data->size,
 				    &subpos, &sublen,
 				    &bodypos, &bodylen, &nonsiglen,
 				    &sigpos, &siglen);
-- 
gitgitgadget

