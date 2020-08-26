Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0CFC433E3
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 14:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E132177B
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 14:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkIF+Oon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHZOuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHZOt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 10:49:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB35C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 07:49:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so2691355ljj.5
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcUPiyS1TLpViGxL1gCFZ2BV9KBmrwn8ThjFAfPQzUg=;
        b=VkIF+OonRsncWDlZ25o2nvr6Kol4KyI2U9DLbL9iLDk15Zf95nCVdNw9WItZibbsCz
         vSvpJEphKrV7NVdS14uwZmDDVo9a193FH2mkec8lntCBbDq2XK37vKmxBxpyK9uP20wM
         r0dFnITQIQPZt886h6dxFZxcnQyv1/6sNjatspsLpsOFIVa1nr211iUdBJ+ZaYsGRll0
         iHzHRUBjlYTAP9H9BCnFieEqyjFbK+NmXj/MAB/UFXwTTlmswUmLSDCRIohKEt21E4ok
         fwkimrATrjFPnwcYt5DFDMebyABrNY32EdscEKf3taEAqTNAkEHuH/li0GJp5JU1DKAa
         sOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcUPiyS1TLpViGxL1gCFZ2BV9KBmrwn8ThjFAfPQzUg=;
        b=S3gzuODS9HpNYiqM3dGskUTmUSZi6+xBWMTvYy0KcvuxtDEF5gFDCFjtJLmDtY0vof
         6uywnKxyYTqOi8Jasti/W7ePPHAWKAJAUhT5WmwYPBeBMoXKX7V5OmPVdJIOSrubvKKz
         XPfczWD+jimtK1ND6oZdef/4IgtmoAanrVkUMvlrDqy9S3mTmlcVlH4LX+nVbJZekhpc
         RqMF3G/dMmKp0qL7FyENrFZw7WWCoQ47KT0qBZlFBSdkq0lUpMQe/BdpQdvHUdmO/Lkf
         339iAe0GbjgwpgbvLlZJF0p/jGx+R+Jqtqo+lcDem8IzgxaQ4uDxHyXfpA8ACH6BDHzW
         61sA==
X-Gm-Message-State: AOAM531TNu3Dil5Ls/M10Z1asRUyi+sIXsU/aKHzkJZ3eNRKAU4abG41
        UDGSM1eQUEp0VB5Kasppkjo=
X-Google-Smtp-Source: ABdhPJxF3uD9nKLAH+MG9CTf/Ajf7BnUSMjABmO6cflqc5G0awifwZyFyq4rqlq6ydP9Mr07Ycwu+w==
X-Received: by 2002:a05:651c:1103:: with SMTP id d3mr7155705ljo.99.1598453392579;
        Wed, 26 Aug 2020 07:49:52 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f24sm554822ljc.99.2020.08.26.07.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:49:51 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] pretty-options.txt: fix --no-abbrev-commit description
Date:   Wed, 26 Aug 2020 17:49:23 +0300
Message-Id: <20200826144923.16806-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Description suggested --no-abbrev-commit negates --oneline as well as any other
option that implies --abbrev-commit. Fix it to say that it's --abbrev-commit
that is negated, not the option that implies it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/pretty-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 7a6da6db780e..17c5aac4b71d 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -25,8 +25,8 @@ people using 80-column terminals.
 
 --no-abbrev-commit::
 	Show the full 40-byte hexadecimal commit object name. This negates
-	`--abbrev-commit` and those options which imply it such as
-	"--oneline". It also overrides the `log.abbrevCommit` variable.
+	`--abbrev-commit`, either explicit or implied by other options such
+	as "--oneline". It also overrides the `log.abbrevCommit` variable.
 
 --oneline::
 	This is a shorthand for "--pretty=oneline --abbrev-commit"
-- 
2.25.1

