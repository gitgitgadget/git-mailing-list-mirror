Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA3C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B286146D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343840AbhCDAWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842945AbhCCKWw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:52 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E541C0698DC
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 01:22:12 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e9so3773903pjs.2
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 01:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxby1aKrpgP43MfKf3jSXJmiVri5Qm66HsIJa8Gj7L0=;
        b=dJ9z/DzAlB+JErJqLGM7sMbvPPj7tsLOgNEiqz0fKMsUW9KIdVW9fyNxZWzEMAlwD/
         cu2vcMfOrXPdEPjNFij0ZVLECITfWJ2t8pMZduPdO2MPNVjQ8lj9v4fWtwGwQbdnigii
         SUKdGirtHHMobRTWJdtePAtPkj799Q9dlHeTat3Qzu65cOiNLqQ6sUUz0St8oCnmM42S
         K5HCzAi66GvsrWsqMM5bArMgLTzJH2qcZoVGSsBlzSyQslcyhyOfVgsGn+avr/A8/BTw
         k/Pa5YYMHdp0AYlLqYJObYg5sE5ViwcVtCvVKw+lwPB4o61tBQAyQ5baxcL2iKPHuG1l
         SHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxby1aKrpgP43MfKf3jSXJmiVri5Qm66HsIJa8Gj7L0=;
        b=t3KwoWBCuF4WHTRnEakG1QSchc3yBSBylKEa6ZJidKYc6kqs+4b0+t+bb0X/QN0T1r
         G1EeGvDd2rhnlPl0Pujh6V7FWb+WvKFYhjCQuQtV3Wz65YLGrlFpGvEjEGl7RB+9067m
         7MGUY07Qdhucs1PzNfgx/ry3uFiSLslvyZfazzCBIjPTrCdu7D8knpavbFveqLjLyCNQ
         EOm3PRhBiFUxxZo0ucV63gfshzRA7yifaZ0qTWV3zMAEjXHlk9MP8lj7OB21V+aWZAYi
         5unW6Zwf4I8SAmWXrF/+X7uhzsX+oTCF9sEi7+mA4+9RK2Xr3VWo7OhhZDUefprMPEVH
         kjDg==
X-Gm-Message-State: AOAM531ngTmdu0IozeOsS3EH3ihJDv9aRYIbq+3+LCMGrKoyl5b9SII9
        vogXDvRi+5iJf8km77h9C3XpI2+wSNI=
X-Google-Smtp-Source: ABdhPJxReE1gdtegDa5r4+7+yUgzI8z9nghNC2SpBWEvFFUmU3QtaOYfdBz1LbVaOa/0ahlf5YT5rQ==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr8926703pjv.129.1614763331381;
        Wed, 03 Mar 2021 01:22:11 -0800 (PST)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id a11sm13986861pfk.109.2021.03.03.01.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 01:22:11 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] git-cat-file.txt: remove references to "sha1"
Date:   Wed,  3 Mar 2021 01:21:56 -0800
Message-Id: <1b57fdad9767a3b63c359e1663e5a045b4964320.1614763281.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.1.823.g0a3b79fd18
In-Reply-To: <cover.1614763281.git.liu.denton@gmail.com>
References: <cover.1614062288.git.liu.denton@gmail.com> <cover.1614763281.git.liu.denton@gmail.com>
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
index a1c37a9e81..4eb0421b3f 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -200,7 +200,7 @@ object, with placeholders of the form `%(atom)` expanded, followed by a
 newline. The available atoms are:
 
 `objectname`::
-	The 40-hex object name of the object.
+	The full hex representation of the object name.
 
 `objecttype`::
 	The type of the object (the same as `cat-file -t` reports).
@@ -215,8 +215,9 @@ newline. The available atoms are:
 
 `deltabase`::
 	If the object is stored as a delta on-disk, this expands to the
-	40-hex sha1 of the delta base object. Otherwise, expands to the
-	null sha1 (40 zeroes). See `CAVEATS` below.
+	full hex representation of the delta base object name.
+	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
+	below.
 
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

