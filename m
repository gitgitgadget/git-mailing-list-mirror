Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2E6C433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 00:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CC865077
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 00:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhCFAwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 19:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCFAvj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 19:51:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5362EC06175F
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 16:51:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w11so4012927wrr.10
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 16:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xdMK+ecLk6KFyQF3X2MxYu8lwk/NeBRXKdpONZmH6Fw=;
        b=r39HRZmFcVASFgCQ2Yz1if/60zs3L+mLex6/wo1nLAtsJVzcovGqpKR1b99Um+nJBL
         cAP65A3B6JPi9sJBbzCjbcMpJKc060Yogvb7fhpn0irwuQ9Ycsn4gQaLYOFe/oULCtPv
         GjXCkdGZAeJB+MWDgOhwBBMv5bR7X9iCL0sGc+hoZBmuZk+VsIGgzKOl8gnIgHKWarq+
         dA96IAO0izlCT2hhu0DV4bD3rtOgkRQJgPPeQicfOcZT1ZNo9hm+GY08m0uuKSjlKaOO
         6KSWqQFqPhD0/PVXvQBIV6QG6l2+YJ7KwMkJ8u4n4cPnP/GWw2mQ8ISW5VuqJLgacr/l
         /Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xdMK+ecLk6KFyQF3X2MxYu8lwk/NeBRXKdpONZmH6Fw=;
        b=i7OzxxXd1/IGS5TeyWwmNH+AcWIxtpTY+LI+gWtyhR3ooSxYQEUAiEAMYCrJ2FT9Gz
         lN2G04pxGD0u12osYO99jd/N6AKpDdvNA69ZB3im+a8/1D4qmm0PFBK5sIm8XLjmRNml
         pfui9aaBsy9vT/rfk0UczR9mTfzkJMLyNZKKFNX9RtJ6D5l+SbmDBJAbg/ZoayGYCHdn
         8hEI+rFXFNcKCQ37GPYJkR1Lgb+Ms6BGnza/dG0kiGWpnRjoon9sANUswiaUUrKkn757
         EJtP2zvG2SaaEZ2l1dYNQw/svUgxNe6gx48RXAayCXTdNjiyGe03G20n0TvrCUPwOfQd
         eWXg==
X-Gm-Message-State: AOAM533FRCrPCvL7sLmF//0MyeU5iMNgO8cOz/COT0zIUe0VTikE/guQ
        e48GbXIzjWgSD4ZeDypoJUHNroNducc=
X-Google-Smtp-Source: ABdhPJyNJ1CACHwSvVyoxEdzYhasxjTNH+Pu7beIcq7q4IUal7Z7O8qY2ciZShkTkB4ky+0KToR04g==
X-Received: by 2002:a5d:52c2:: with SMTP id r2mr12285864wrv.40.1614991897981;
        Fri, 05 Mar 2021 16:51:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x25sm6811742wmj.14.2021.03.05.16.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 16:51:37 -0800 (PST)
Message-Id: <pull.896.git.1614991897210.gitgitgadget@gmail.com>
From:   "HG King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Mar 2021 00:51:36 +0000
Subject: [PATCH] fix: added new BANNED_EXPL macro for better error messages,
 new parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     HG King <hgmaxwellking@gmail.com>,
        HGimself <hgmaxwellking@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: HGimself <hgmaxwellking@gmail.com>

Signed-off-by: HGimself <hgmaxwellking@gmail.com>
---
    fix: added new BANNED_EXPL macro for better error messages, has a par…
    
    
    Extend Banned Function Error Messages
    =====================================
    
    AS A NEWER USER, I WANT TO BE ABLE TO UNDERSTAND WHY CERTAIN FUNCTIONS
    ARE BANNED AS WELL AS KNOW WHAT FUNCTIONS TO USE INSTEAD.
    
    
    Changes
    =======
    
     * Added new macro named BANNED_EXPL(func, expl) which added the expl
       onto the error message
     * Used strcpy as an example

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-896%2FHGHimself%2Ffix%2Fadd-new-ban-macro-with-explanation-parameter-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-896/HGHimself/fix/add-new-ban-macro-with-explanation-parameter-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/896

 banned.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/banned.h b/banned.h
index 7ab4f2e49219..a19f0afeda79 100644
--- a/banned.h
+++ b/banned.h
@@ -9,9 +9,10 @@
  */
 
 #define BANNED(func) sorry_##func##_is_a_banned_function
+#define BANNED_EXPL(func, expl) sorry_##func##_is_a_banned_funcion_because_##expl##.
 
 #undef strcpy
-#define strcpy(x,y) BANNED(strcpy)
+#define strcpy(x,y) BANNED_EXPL(strcpy, buffer_overflow_risk)
 #undef strcat
 #define strcat(x,y) BANNED(strcat)
 #undef strncpy

base-commit: be7935ed8bff19f481b033d0d242c5d5f239ed50
-- 
gitgitgadget
