Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C6EC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6103264E25
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhBWHS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhBWHSW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 02:18:22 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAFCC061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 23:17:41 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t25so11838408pga.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 23:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+laI71WJmk4Fh4PoJclq3fhdc53/lUk0rjCM+GYlu4=;
        b=Ua5DC2NR3dp9l2jOYzrektbhIcjRG9NcANmlMk4bORLGB2lwPeDbRstn1w2WPBiGRq
         GSlmQiL6OY0MtY5d5kyvpzSQh1nHRf6g2Kspdc2t/PUmmA0gCfLnIUFFUChz/LSYMIDX
         I/Dx3egaIXPKikzn4iIIeRKw04OpGCdDl4X1+BRaIzed4kt8e1C0A7W/hscow/nb60Qm
         q2NUnYzPaUVD+FfOqVBmCo/n+GbDVLkzI3miJcm3bxzwZMPMTjFac9NY/CYP/eygdsvn
         Ui/EixNYdyOpgk48Lh10y+RzdZRSCHBkEH5d9N1/ywkV1mEsQAeH9e5+vyRg5bll6kSW
         FRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+laI71WJmk4Fh4PoJclq3fhdc53/lUk0rjCM+GYlu4=;
        b=cRjSezcHQFJsGrEWav7ffoUQCcP5HwLkf1BMxiTV9fDpi+xzjh18fjNPBlDo9D2+xf
         SV+rF8h+VjbHu8/UZSekDiu8Mx229rOoKMoJ3352VnLl/fERzzswbovndIqzygT9IhP6
         4OD7wy0PXjLzKZTlyQLp/d4RK/WabrZtsen0eJFnoptZkvZFKHoKVMLUmkgN+1JgnNFQ
         gBF4GeADuhCn5LgxnCNAtcGxjycel/x0Jp6sFoXFt4p+jSXfLGGczcYtRV5kz5UpX+L7
         4X7VWPMc6sKgfmc0bhOrbo7RmCyB8b0FbDWvhP/P3fOEixYIT5J+fNcA05Yqdn6dDrBx
         0dAQ==
X-Gm-Message-State: AOAM530kqN2zwu/xUJYBSGmPwIaNWmIqryi+lklAqAy763VkINVy/gBo
        Sxg5DaVBSPJXztlIrtWUWiIWEX9F19U=
X-Google-Smtp-Source: ABdhPJxXRKdhDRB6EvMKmmoeKKoM9/+1ZGfMpDFIumRAZEePL3M47ll+chDasgGmyPrRHt3WCwAPoA==
X-Received: by 2002:a62:1997:0:b029:1ed:5de5:5f1c with SMTP id 145-20020a6219970000b02901ed5de55f1cmr15786035pfz.14.1614064661263;
        Mon, 22 Feb 2021 23:17:41 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j73sm22505365pfd.170.2021.02.22.23.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:17:40 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] git-cat-file.txt: remove references to "sha1"
Date:   Mon, 22 Feb 2021 23:17:33 -0800
Message-Id: <4030a678b923ca6a49b4e5bc6f0cdf4cf6ae7037.1614064618.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.1.823.g0a3b79fd18
In-Reply-To: <a24cbbe955f45072ffa88ca16f84e2443720a38f.1614062288.git.liu.denton@gmail.com>
References: <a24cbbe955f45072ffa88ca16f84e2443720a38f.1614062288.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the hash-transition, git can operate on more than just SHA-1
repositories. Replace "sha1"-specific documentation with hash-agnostic
terminology.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-cat-file.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index a1c37a9e81..c404a9aae8 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -200,7 +200,7 @@ object, with placeholders of the form `%(atom)` expanded, followed by a
 newline. The available atoms are:
 
 `objectname`::
-	The 40-hex object name of the object.
+	The full hex representation of the object ID of the object.
 
 `objecttype`::
 	The type of the object (the same as `cat-file -t` reports).
@@ -215,8 +215,9 @@ newline. The available atoms are:
 
 `deltabase`::
 	If the object is stored as a delta on-disk, this expands to the
-	40-hex sha1 of the delta base object. Otherwise, expands to the
-	null sha1 (40 zeroes). See `CAVEATS` below.
+	full hex representation of the object ID of the delta base
+	object. Otherwise, expands to the null OID (all zeroes). See
+	`CAVEATS` below.
 
 `rest`::
 	If this atom is used in the output string, input lines are split
@@ -235,14 +236,14 @@ newline.
 For example, `--batch` without a custom format would produce:
 
 ------------
-<sha1> SP <type> SP <size> LF
+<oid> SP <type> SP <size> LF
 <contents> LF
 ------------
 
 Whereas `--batch-check='%(objectname) %(objecttype)'` would produce:
 
 ------------
-<sha1> SP <type> LF
+<oid> SP <type> LF
 ------------
 
 If a name is specified on stdin that cannot be resolved to an object in
-- 
2.30.1.823.g0a3b79fd18

