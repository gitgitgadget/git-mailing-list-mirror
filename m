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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF25C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E303660249
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhEFQcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhEFQcR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:32:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5AC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:31:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so6294877wrr.2
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Eb0uUaUL3BVUM3P/Lo7dNbUW2G9ibmNkCeaqQ8wfuSU=;
        b=ui9DUht1NYI1pYVEnG2zsaGT+s7ZrbqHxSQN/O+78FVGZVOZ9Lxjapc5ObuOPlSAeW
         f7mr8UjwlHyAFOiOaSb3YtxcwV7aXrHhfvZl5uneCRV7TlmfBDEQa9CUkfGQ8yTEVZeG
         /rF/giYahbrdY4Lt8qoHsdTY1yDM9Dvo9fK0KgFB6CYGq5wp30LDeG23KiT5OqE+TJu5
         W5DrefKpRKCZSwOHxrbm323Uaop0F6vVqWxmGiu5ZWJz04jaEFPMlThhmPxsl+teYHEk
         jOUtHarg6VGusktVTsligHzhDABPNuk8HZgcnE8vs7JsPlNFzpiUiIKzmqKDRUqQOlMh
         ZkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Eb0uUaUL3BVUM3P/Lo7dNbUW2G9ibmNkCeaqQ8wfuSU=;
        b=o2pQzlZlD6EXCGoxAJEJqLEKt4pNICNMNvChi9mdJS0xpjfrcM2u/XaTHT6k5387Gk
         qbw2MmGCWWIWKa1KdDWZj1iY1tLY9iTcd5evWeKf83JQOAzkPrechZDsaCp+m/VMA1yR
         YtihxFpKubYLRXzDOM3KNFqeVR8ghyeLj/u5tibjmsi/rAdPNebxPRCDjLx1paEMoL92
         m/jlqHo5l/sn32kdqr/z/xXodi5lFOD4JcSZ0t/jDi2hgv/epldnwxV/gDJv6NzRQ4UA
         VrN8eacToxLfcZ7ehRgFdevnVHhgCI+8U39yoBheAa0xGPw6n7mxOACHt3+EYsw+H/V0
         nfaA==
X-Gm-Message-State: AOAM531SuD+0YnRw8gqdzMNNwVyclGf5Dsx1S0XbKZ8X1Wnfsb55mpd9
        y+jQzzuLn5IsbsCk9pUv8qpTgZz/WSg=
X-Google-Smtp-Source: ABdhPJyZUsfJb+nzVaLyhue4X5KL3p3wNKsdhPJr0tPOETRbcI2d3lKtErL7YMJFaxQ9wayspdV6JA==
X-Received: by 2002:a5d:6809:: with SMTP id w9mr6414730wru.295.1620318677940;
        Thu, 06 May 2021 09:31:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g19sm3833546wme.48.2021.05.06.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:31:17 -0700 (PDT)
Message-Id: <pull.949.v2.git.1620318676776.gitgitgadget@gmail.com>
In-Reply-To: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 May 2021 16:31:16 +0000
Subject: [PATCH v2] [GSOC] ref-filter: fix read invalid union member bug
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
used_atom" wants to record.  At most only one of the members can be
valid at any one time.  Since the code checks u.remote_ref without
even making sure if the atom is "push" or "push:" (which are only
two cases that u.remote_ref.push becomes valid), but u.remote_ref
shares the same storage for other members of the union, the check
was reading from an invalid member, which was the bug.

Modify the condition here to first check whether the atom name
starts with "push", and then check u.remote_ref, to avoid reading
the value of invalid member of the union.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] ref-filter: fix read invalid union member bug
    
    Change from last version: Modified the documentation description with
    the help of Junio. And modify the processing method of the condition:
    check whether the name of the atom starts with "push" and whether
    u.remote_ref is non-zero.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-949%2Fadlternative%2Fref-filter-enum-bug-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-949/adlternative/ref-filter-enum-bug-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/949

Range-diff vs v1:

 1:  e51ca176f76b ! 1:  0e1923c9d722 [GSOC] ref-filter: solve bugs caused by enumeration
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] ref-filter: solve bugs caused by enumeration
     +    [GSOC] ref-filter: fix read invalid union member bug
      
     -    Johannes Schindelin seems to have introduced a bug in
     -    cc72385f(for-each-ref: let upstream/push optionally
     -    report the remote name), it use `atom->u.remote_ref.option`
     -    which is a member of enumeration in the judgment statement.
     -    When we use other members in the enumeration `used_atom.u`,
     -    and it happened to fill in `remote_ref.push`, this judgment
     -    may still be established and produces errors. So replace the
     -    judgment statement with `starts_with(name, "push")` to fix
     -    the error.
     +    used_atom.u is an union, and it has different members depending on
     +    what atom the auxiliary data the union part of the "struct
     +    used_atom" wants to record.  At most only one of the members can be
     +    valid at any one time.  Since the code checks u.remote_ref without
     +    even making sure if the atom is "push" or "push:" (which are only
     +    two cases that u.remote_ref.push becomes valid), but u.remote_ref
     +    shares the same storage for other members of the union, the check
     +    was reading from an invalid member, which was the bug.
      
     +    Modify the condition here to first check whether the atom name
     +    starts with "push", and then check u.remote_ref, to avoid reading
     +    the value of invalid member of the union.
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## ref-filter.c ##
     @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbu
       				v->s = xstrdup("");
       			continue;
      -		} else if (atom->u.remote_ref.push) {
     -+		} else if (starts_with(name, "push")) {
     ++		} else if (starts_with(name, "push") && atom->u.remote_ref.push) {
       			const char *branch_name;
       			v->s = xstrdup("");
       			if (!skip_prefix(ref->refname, "refs/heads/",


 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index a0adb4551d87..750b25914b82 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1730,7 +1730,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup("");
 			continue;
-		} else if (atom->u.remote_ref.push) {
+		} else if (starts_with(name, "push") && atom->u.remote_ref.push) {
 			const char *branch_name;
 			v->s = xstrdup("");
 			if (!skip_prefix(ref->refname, "refs/heads/",

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget
