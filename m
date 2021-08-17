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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9171DC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B9460F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbhHQIm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbhHQImU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:42:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1872FC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso1270164wmc.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jcYu+aw6K++rHfhWMN4DQ874DwNUGIEgwUWYMEqbzcI=;
        b=gLGynOM41ZRt4KMdugBVem1HtBM9FehqoSMwiqQbviZveeKjgfrzVfm34lmDOiDOq0
         CzBGO5GEqEfklnAulJMnumtqfenPMFV1J7/mvocjqMllmwlOf2jFQclqHGZ2v/l5BUGZ
         EwoXjFfEnbXP9ltEjs7DNAX4IKxW1qwo/rIsAOwhMH9qWyjipbZPbr21VD3gAJrkRikn
         2DwP0RthjaUK8m87MDyLhr/S0zkNoXNfF7s1RUqAPpEh+URpeusVSwgQHSZOqhWDRk5v
         nyJ2wZRWS18pdRVBjxN/yUsDm+3+T0n5KYguLvssubY59K/KtBttYs+FL1pgjbGrbNtV
         2aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jcYu+aw6K++rHfhWMN4DQ874DwNUGIEgwUWYMEqbzcI=;
        b=qGu7tWA5fK02HEql3jtusxyHZOsKT41l2tzZ3ZYA3j87bQXB+LGOOygFi+T3nqHxMC
         I46OthlnIE61r80dgvdYiM/sj/YOsxbfgx1wvlfoQCdsk99edgJeu9/xwSgIsACqQONH
         fX92boVDCPhTk7kV2pVG3Vm+n4cQeGPL6TvGY+5Pnct7HVZ4M0CU6qytnmdk8uDl1G3r
         X6F2o8+g1x1EbpCC4bp1E34zTnVpcJddMll8CYD/QVhCB77g12pjt21mo/6RcAQ2vBtX
         jCfoZ8AWYm0926TGkjzlD6wP1VerOc+29b1105iaCxmccdofAgFJIKyj6WbPhIEt6w9N
         PAnQ==
X-Gm-Message-State: AOAM531vPlCYxDMUHHcaQNc6/RCjvLaux8lciQgkrWbBc3hIbcghSAMw
        VDtG5v/QdMtBLV/y78AcGtASfNiTe9s=
X-Google-Smtp-Source: ABdhPJy9kEo7XCqg254imJVE9F929s1aIq+dl2dmobLZkXALHHyn676aAh1cLYPAgDl6i/xKsdZVOw==
X-Received: by 2002:a1c:7506:: with SMTP id o6mr2265435wmc.112.1629189706793;
        Tue, 17 Aug 2021 01:41:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm1572619wrt.13.2021.08.17.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:41:46 -0700 (PDT)
Message-Id: <61d452a6278abfe84680a11c28cde9d3a48d0848.1629189701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
References: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 08:41:40 +0000
Subject: [PATCH 7/8] [GSOC] ref-filter: introduce symref_atom_parser()
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

parse_ref_filter_atom() sets need_symref by checking
whether the atom type is ATOM_SYMREF. When we are operating
other atoms here, this step of checking is not necessary.

So add the symref_atom_parser() specifically to parse the
%(symref) atom, and set need_symref in it.

This can make the program logic more concise.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 5abcbbf10ac..f1c82e20e3d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -503,6 +503,13 @@ static int person_email_atom_parser(struct ref_format *format, struct used_atom
 	return 0;
 }
 
+static int symref_atom_parser(struct ref_format *format, struct used_atom *atom,
+			       const char *arg, struct strbuf *err)
+{
+	need_symref = 1;
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name, err);
+}
+
 static int refname_atom_parser(struct ref_format *format, struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
@@ -642,7 +649,7 @@ static struct {
 	[ATOM_RAW] = { "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
 	[ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	[ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
-	[ATOM_SYMREF] = { "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
+	[ATOM_SYMREF] = { "symref", SOURCE_NONE, FIELD_STR, symref_atom_parser },
 	[ATOM_FLAG] = { "flag", SOURCE_NONE },
 	[ATOM_HEAD] = { "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
 	[ATOM_COLOR] = { "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
@@ -770,8 +777,6 @@ static int parse_ref_filter_atom(struct ref_format *format,
 		return -1;
 	if (deref)
 		need_tagged = 1;
-	if (i == ATOM_SYMREF)
-		need_symref = 1;
 	return at;
 }
 
-- 
gitgitgadget

