Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAC6C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 15:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DD5613BA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 15:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhEEPcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhEEPcD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 11:32:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1273CC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 08:31:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 4-20020a05600c26c4b0290146e1feccd8so1388365wmv.1
        for <git@vger.kernel.org>; Wed, 05 May 2021 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hL5MXJfBdnIBXXjlxEpJFMMX/kh7ij8zR4wRHSJ8vTs=;
        b=So78l6kVT3N4XgnEHUmlWv/4G6mSauw0iTYZBavoiRfhBOKkYQwgcv7MxmO2fjcZqk
         5fRl4AsDMRNnPxDvcNkFBcqb8tJ0pvc5ukteqfL0BjdZRDb3v17PUvbcMgdfE0lym+8Z
         Ref/792sE7EzAst4GrHTPpTRREhkunWNRnY2cZMyPSVYpvIZ6llO29+Fr+XMmRJFeXEq
         o12Q44wf0Z530Zn9IIKgOkNOxDtley6iveJ6I8v1JYePv8dXv8d28Bi0IeTysP5EkiuS
         OyJaTp1XccPY1875d3SJUiKayCb1uRSlW/js3Mg0um8gsUC/27iTMtaBPULsMcpeEhbO
         9q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hL5MXJfBdnIBXXjlxEpJFMMX/kh7ij8zR4wRHSJ8vTs=;
        b=bkOmcxnE6qs6mnjmRnBPitn3GaW9N1BUZ2bqZAnBwCnSgZl4RVTcW7bhYLCKenYcxt
         l0BE4D5SwVM5eFo4QADWmx9Fc31uQnWeVX8KrBzBVCIsH13DkWWadlyr2Uc1EugH2rvK
         LZBKGwxZuySwanPwJ3Wh0whrOl1rRpmOIIhTj7aBUWVJuMYG9UBVtYOM8DYoFHhHi/Cp
         MnW33HF+Yl3yDHAHDgQgzU+WPuPM9Ef/26hmn38wTKkRBSNrOCKQWTj156Orpb14jfHD
         btpAHeT+CDf57hrXRhQ+4T7sae0mGj+ceP4t8aP7qV/jYk2JteZb+pS9KTR2vrt0L3EI
         T9TQ==
X-Gm-Message-State: AOAM5321whTuVmsURGfa63kbQbAgiE5pjccZuU/o55ASA/a8akFGRPr+
        ktp0jfX9MoOPuOi/dingRjvh5KuUWD0=
X-Google-Smtp-Source: ABdhPJyM3D0yeVxnIg8OAfHcH6ZYlwuUsjuxaE8u11Lyh1vbh+g5IOQWi36W9JQC1U9icvzIM4t0Yw==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr33498588wmh.151.1620228665828;
        Wed, 05 May 2021 08:31:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm20111056wru.70.2021.05.05.08.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 08:31:05 -0700 (PDT)
Message-Id: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 May 2021 15:31:04 +0000
Subject: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Johannes Schindelin seems to have introduced a bug in
cc72385f(for-each-ref: let upstream/push optionally
report the remote name), it use `atom->u.remote_ref.option`
which is a member of enumeration in the judgment statement.
When we use other members in the enumeration `used_atom.u`,
and it happened to fill in `remote_ref.push`, this judgment
may still be established and produces errors. So replace the
judgment statement with `starts_with(name, "push")` to fix
the error.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] ref-filter: solve bugs caused by enumeration
    
    This is the problem I found in the implementation of git for-each-ref
    --format="%(notes)".
    
    I added a new option to the enum used_atom.u , but the program seems to
    output the value of "%(push)".
    
    After research, it should be the problem of incorrect use of enumeration
    values here.
    
    Thanks, may the force be with you!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-949%2Fadlternative%2Fref-filter-enum-bug-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-949/adlternative/ref-filter-enum-bug-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/949

 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index a0adb4551d87..f467f2fbbb73 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1730,7 +1730,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup("");
 			continue;
-		} else if (atom->u.remote_ref.push) {
+		} else if (starts_with(name, "push")) {
 			const char *branch_name;
 			v->s = xstrdup("");
 			if (!skip_prefix(ref->refname, "refs/heads/",

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget
