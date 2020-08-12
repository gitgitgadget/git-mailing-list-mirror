Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52500C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2138720781
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS1EvuNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHLWaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHLWae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 18:30:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB3CC061385
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 15:30:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so3354959wmi.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TDpi4+EmjZU+UR4kquq0spvU3bAYMq//ZPJFahjdxCA=;
        b=iS1EvuNgBVl+zB8bu8SHz8qX7JFqi7uk8L/PBz+3YvDyaAtJSE7AY6xZJIX7vC+Yqg
         AeRPStec0Cyh3fXZGJ4qYoXhTLCVpPLRTW3xyWqDxXyqaVKb8G4a0K54fe2pEFA+SUmE
         QL5ayrfXg5vNHapdoK6wylh+lOmsqPmyLVLskVulfNiDmSFOVLyuBRdOv941Ui/Jr1MX
         7XRNwC/xxm3esadbs4Z7fnSY2T+8+cfvTWO5DoQx14TnnJJLSWfTr8wA3EchaFK97/Eq
         coomg1Ap9LAy/TntMBQzgulv5wCmGqRBO71dmfLPTO9rLdwOrYe54OOPf6m7xGqczSvp
         veDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TDpi4+EmjZU+UR4kquq0spvU3bAYMq//ZPJFahjdxCA=;
        b=isQDlJvBlSFNB2ndOsDpBZG96tN1CxFy2R5qB4CZNRBJOD+2ELzhqrlzCTfkXwFEOl
         sjHpx1oibZVkNPAW3LGy9mnE/5xx7bMIb/4b70Diza6d94UBBSDjNvjrwLWA4szfQkWn
         G1IFguMyOs7jBl+2jvQ7V0h/M67F67LKIAYhfc7xesRaoKIFR9Q0UjlY0UT9cs4byjcY
         VWLEfOgn3F0Vyp/fY3K9miVkCW2pK2NaAkglQfqe/x5sPxfuLiVaVRFGHwZ/t6kenOQ/
         R7zgl97j98+A+lyDxNsfr3WwCTrZASVv7ySmU80QQ4g+dp5XG4lKZPuuvEudhVRZbgRu
         X/ug==
X-Gm-Message-State: AOAM533O4XHXmE4Rspk6Buccokg+3QEC4ypfQABV+7l0FERyXlLPzF3r
        8Hn2T7mtlsvkG04we4aphjhS69vP
X-Google-Smtp-Source: ABdhPJwht+AELPOBitD8GMKNDOP1RxVN3M1whWXowRycOvfl63m6JiySt6Nq1KeZbxnHjUbLK4yR1Q==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr1528942wml.186.1597271432618;
        Wed, 12 Aug 2020 15:30:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4sm6653061wru.55.2020.08.12.15.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 15:30:32 -0700 (PDT)
Message-Id: <69fe977b66f9744c914cfdfa2da4b9be5e720e4f.1597271429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.git.1597271429.gitgitgadget@gmail.com>
References: <pull.700.git.1597271429.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Aug 2020 22:30:29 +0000
Subject: [PATCH 2/2] userdiff: improve Fortran xfuncname regex
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Brandon Casey <drafnel@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The third part of the Fortran xfuncname regex wants to match the
beginning of a subroutine or function, so it allows for all characters
except `'`, `"` or whitespace before the keyword 'function' or
'subroutine'. This is meant to match the 'recursive', 'elemental' or
'pure' keywords, as well as function return types, and to prevent
matches inside strings.

However, the negated set does not contain the `!` comment character,
so a line with an end-of-line comment containing the keyword 'function' or
'subroutine' followed by another word is mistakenly chosen as a hunk header.

Improve the regex by adding `!` to the negated set.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t4018/fortran-comment-keyword | 1 -
 userdiff.c                      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t4018/fortran-comment-keyword b/t/t4018/fortran-comment-keyword
index c5dbdb4c61..e9206a5379 100644
--- a/t/t4018/fortran-comment-keyword
+++ b/t/t4018/fortran-comment-keyword
@@ -8,7 +8,6 @@
       real funcB  ! grid function b
 
       real ChangeMe
-      integer broken
 
       end subroutine RIGHT
 
diff --git a/userdiff.c b/userdiff.c
index 707d82435a..fde02f225b 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -53,7 +53,7 @@ IPATTERN("fortran",
 	 /* Program, module, block data */
 	 "^[ \t]*((END[ \t]+)?(PROGRAM|MODULE|BLOCK[ \t]+DATA"
 		/* Subroutines and functions */
-		"|([^'\" \t]+[ \t]+)*(SUBROUTINE|FUNCTION))[ \t]+[A-Z].*)$",
+		"|([^!'\" \t]+[ \t]+)*(SUBROUTINE|FUNCTION))[ \t]+[A-Z].*)$",
 	 /* -- */
 	 "[a-zA-Z][a-zA-Z0-9_]*"
 	 "|\\.([Ee][Qq]|[Nn][Ee]|[Gg][TtEe]|[Ll][TtEe]|[Tt][Rr][Uu][Ee]|[Ff][Aa][Ll][Ss][Ee]|[Aa][Nn][Dd]|[Oo][Rr]|[Nn]?[Ee][Qq][Vv]|[Nn][Oo][Tt])\\."
-- 
gitgitgadget
