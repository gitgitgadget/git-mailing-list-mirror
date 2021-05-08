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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52054C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 15:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2470A61155
	for <git@archiver.kernel.org>; Sat,  8 May 2021 15:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhEHP1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhEHP1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 11:27:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D8C061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 08:26:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d11so12145874wrw.8
        for <git@vger.kernel.org>; Sat, 08 May 2021 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Apv+QFpDw2twvPQtPZkFIR/cBXR9MbqMiAYRnLikNXM=;
        b=fI/s7Ecx//pi2RgOJoCIcrmZhwR28cgPJ2LTwsq8szr2WkoEOlRjrKj/Mioca2uECC
         VIPMHviIqvtGcduiOjNtHEYUFXO0qBfwSML+QojObCzBX62AmICIWNxu/msmGpgjXgkX
         xxYMU4+mILKZ/J/iVqJ99xQ9xOA9VTephA4P+pHS818pSFR/E0UYR7l0yVUakvrXd2cd
         uArRKj7rRzZPWCoP9HOYNuhwmOX58SERpkODIXnbz3A5x1K/09+J24WP81nz2vvyMHUW
         daxZ5Wk6Z3GtOxH+Dgqgwe6bAz3Rxie/yn6zjR37FnPbeY2fErl9DXB1IjZf1zz0DCEF
         sg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Apv+QFpDw2twvPQtPZkFIR/cBXR9MbqMiAYRnLikNXM=;
        b=hxRQuInUg5VqBAbdY6lJJATZWOkrONUl2lAncTYVFCKWiij9EA3B8MMgYdqhCgXzEe
         npcQT1QjFvmHIesxWYn78v7U3zITV5kWZfkLi3wplhMtLCfAu7J9t2DuYv2R21ydQxbA
         K2EoU0BTyzSOk1QlvWccvzZdSMxe1dmr1vntH9JamOU7fru9rtKT98dgp60J3fvTCe8r
         iKW+5IY4UN0z75+jgnU75MlH3lvRA+Bmlf+vA553HoT95NyWB7AqkoBuRFNFlXY7MW+p
         pFwg6WYTZXASImHFj0Bm4nHlpV2mOgDCNAVYbyONoAgGoHvv5PlmIDcAGajFU8ny7gQT
         1aMQ==
X-Gm-Message-State: AOAM5320uRJMTal6ciL11ywQ8CuHq1zaywxwA4BgsGmPRaol6Oii+DBE
        sHHdYJ6cGCV09KS+aqjH2qLMusRCQS0=
X-Google-Smtp-Source: ABdhPJy87g4E9ZF0+x6SR8GCNmLi1a3xnNfJdDvskQuBJY+XgJkO5X9GuULB03NE01qp9oiiSj8GCw==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr19481857wrm.392.1620487572905;
        Sat, 08 May 2021 08:26:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10sm14920247wre.84.2021.05.08.08.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 08:26:12 -0700 (PDT)
Message-Id: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
In-Reply-To: <pull.949.v2.git.1620318676776.gitgitgadget@gmail.com>
References: <pull.949.v2.git.1620318676776.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 15:26:11 +0000
Subject: [PATCH v3] [GSOC] ref-filter: fix read invalid union member bug
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

used_atom.u is an union, and it has different members depending on
what atom the auxiliary data the union part of the "struct
used_atom" wants to record. At most only one of the members can be
valid at any one time. Since the code checks u.remote_ref without
even making sure if the atom is "push" or "push:" (which are only
two cases that u.remote_ref.push becomes valid), but u.remote_ref
shares the same storage for other members of the union, the check
was reading from an invalid member, which was the bug.

Modify the condition here to check whether the atom name
equals to "push" or starts with "push:", to avoid reading the
value of invalid member of the union.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] ref-filter: fix read invalid union member bug
    
    Change from last version:
    Modify the processing method of the condition: check whether the name of
    the atom equals to "push" or starts with "pushs", which can enhanced
    security, although it may bring string match overhead.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-949%2Fadlternative%2Fref-filter-enum-bug-fix-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-949/adlternative/ref-filter-enum-bug-fix-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/949

Range-diff vs v2:

 1:  0e1923c9d722 ! 1:  21cf7a44e168 [GSOC] ref-filter: fix read invalid union member bug
     @@ Commit message
      
          used_atom.u is an union, and it has different members depending on
          what atom the auxiliary data the union part of the "struct
     -    used_atom" wants to record.  At most only one of the members can be
     -    valid at any one time.  Since the code checks u.remote_ref without
     +    used_atom" wants to record. At most only one of the members can be
     +    valid at any one time. Since the code checks u.remote_ref without
          even making sure if the atom is "push" or "push:" (which are only
          two cases that u.remote_ref.push becomes valid), but u.remote_ref
          shares the same storage for other members of the union, the check
          was reading from an invalid member, which was the bug.
      
     -    Modify the condition here to first check whether the atom name
     -    starts with "push", and then check u.remote_ref, to avoid reading
     -    the value of invalid member of the union.
     +    Modify the condition here to check whether the atom name
     +    equals to "push" or starts with "push:", to avoid reading the
     +    value of invalid member of the union.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbu
       				v->s = xstrdup("");
       			continue;
      -		} else if (atom->u.remote_ref.push) {
     -+		} else if (starts_with(name, "push") && atom->u.remote_ref.push) {
     ++		} else if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:")) {
       			const char *branch_name;
       			v->s = xstrdup("");
       			if (!skip_prefix(ref->refname, "refs/heads/",


 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index a0adb4551d87..213d3773ada3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1730,7 +1730,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup("");
 			continue;
-		} else if (atom->u.remote_ref.push) {
+		} else if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:")) {
 			const char *branch_name;
 			v->s = xstrdup("");
 			if (!skip_prefix(ref->refname, "refs/heads/",

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget
