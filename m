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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B38BC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685C760F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbhHQImU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbhHQImS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:42:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD53C0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1291117wmb.2
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tNAa1sosZtO+JcxNmdcFZZbGrGnVZjLto8/IC2MAMQg=;
        b=jCh5Px79d5hklSrO41yTTwj1DmiSVdB7Yn3K7c5mjmQJeLeoM20L/wzjHVIhaxrqFA
         qN09BQdE3jCOBxbb2IkkgGOnXBw/We1YlCqsi4m08FvxA4SF45GjZ0D8SfrhEfbJ3INr
         9cDzDCiMg/EnSkk6WBW10jkTSWrDJ+hGqOoawNToHja4EG7zGDxdOVxU99V/1NXo5Z7l
         8JOoN5tC65ZsakJH99l3Vd5AHPS075bLW45WSLi51GjvbkAVWTDOx/mm4v5iPlDNMLFO
         /oytOcbyIRro/aJBARBNZ7Fpn57W4syrnE4Ch19VFbEK4ijpgB3Oanc/58ghsA4z53nM
         BI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tNAa1sosZtO+JcxNmdcFZZbGrGnVZjLto8/IC2MAMQg=;
        b=KLQt5HoIrgAx6UFlsDcRLXhc0rvXxtWtziQ2BWONM4NCvxCR05C1yz9A3RmOI0JAa5
         HIjDz4eEA5a5/akr3/NIRAjDxBdjOmGkc8bGN8yUrT1A204bJIM86RCYqbZjt42/2LjU
         as78KrfO9Ot8Lmt/OXrl+gthdleCO4rPidR2HRXiyHpqP8g9+GSc3B+SOcn9cFL8IOPC
         QtcSm5vf/Edf8+1MD01prk8U8FKCsZRSIM4zUNvu5huFIJeKl4YpFRN7Jh62S52XR8kQ
         35C37ZWTuXc256xf+W65Ipwdus6VqFXK+EHkEgVGt9XNHrDlSXWwG57iqtvdf7l4iBlH
         NnYQ==
X-Gm-Message-State: AOAM530SoEnqa2jo/L47d0YSkdsprnXDi4FYnIe2HCcUs/X4JovP0TAs
        BwB0EvKAB32LnVeMNQB5P1tsJJpP3HU=
X-Google-Smtp-Source: ABdhPJxUxRlFBqBSaj2U8BG5hLH/5qtcE2TJTscFPq/TFcOGNwgtzGLvz0oyZgQyplXC/LYmtRvHiw==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr2119363wmj.72.1629189704060;
        Tue, 17 Aug 2021 01:41:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm1618946wrz.61.2021.08.17.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:41:43 -0700 (PDT)
Message-Id: <c3a4c858df0d246e06c3e770c5eb2956eeb96538.1629189701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
References: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 08:41:36 +0000
Subject: [PATCH 3/8] [GSOC] ref-filter: remove strlen from find_subpos
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

find_subpos() use strlen() to get the length of the object
content, but in the caller of find_subpos(), grab_sub_body_contents(),
we already get the length of the object content through data->size.
So add a `size_t buf_size` in find_subpos(), and pass data->size to
it. This can avoid unnecessary strlen() overhead.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 592b8d9bd0a..875c2e4c39c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1314,7 +1314,7 @@ static void grab_person(enum atom_type type, struct atom_value *val, int deref,
 	}
 }
 
-static void find_subpos(const char *buf,
+static void find_subpos(const char *buf, size_t buf_size,
 			const char **sub, size_t *sublen,
 			const char **body, size_t *bodylen,
 			size_t *nonsiglen,
@@ -1322,12 +1322,12 @@ static void find_subpos(const char *buf,
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
@@ -1340,7 +1340,7 @@ static void find_subpos(const char *buf,
 	while (*buf == '\n')
 		buf++;
 	*sig = strbuf_detach(&signature, siglen);
-	sigstart = buf + parse_signed_buffer(buf, strlen(buf));
+	sigstart = buf + parse_signed_buffer(buf, buf_size - (buf - begin));
 
 	/* subject is first non-empty line */
 	*sub = buf;
@@ -1363,7 +1363,7 @@ static void find_subpos(const char *buf,
 	while (*buf == '\n' || *buf == '\r')
 		buf++;
 	*body = buf;
-	*bodylen = strlen(buf);
+	*bodylen = buf_size - (buf - begin);
 	*nonsiglen = sigstart - buf;
 }
 
@@ -1430,7 +1430,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
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

