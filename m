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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B5C433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F6E64DAF
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhBWGkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 01:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhBWGj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 01:39:58 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1479CC06178A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:39:18 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w18so8167942pfu.9
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nfzwLVVGaWzIAYaEV0582VuQxPc9XUCipKlQUZz3uEA=;
        b=OuvvhGBGvvLVEu4XrCxELvZGTM31t24dSeqp+jPZFh/G1+6zxuCqTw5oVp/f2pShnS
         GhbYuxxw9JHLL/Go2Ri/opfO4rvNp+P4g178V9Mb9uD0cJZ9xuyfBZsbIZjHGLP2mDkN
         t7bS/+PhoPRid2dg6vNyScbKFgkD9GEopwJMgRg3G7n/pscSP1CnjRvtpdzmpEDKQBrk
         0flQtV+jpIvWnH20CjgooO6sVKZeLT6/S1G+puIoSnr8C6Y9D3YIGaNmqAHJ3Du5u6CA
         ZKFoW26azrYj99p9PgB9WyLo2/orimxYGvTQKr930ZIIuRKNZ9/W/iOL+57N/aBMtnAd
         2k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfzwLVVGaWzIAYaEV0582VuQxPc9XUCipKlQUZz3uEA=;
        b=QiwUY2h899YWnw2yWIQsPA/PmllW4iqxUWn+ZlI8Sdy5dZ8PyEnmJoUBDiBXQiUreG
         8NkIXBGfgufUFBsr165koY2I4aAW1OVNIEnPORyzDfq6+uPiQvJHaqF7EHnO8ZykMjHq
         6LNM9PgozUzVfb3UlL3ZiimmZ5T0n1IwfbTCiaj5VVL1SQt1DTGJvQjiFr/1LNWIZtrl
         yrSVvhucwjsp/a3E4wmIp3Pc2U8irXz619FFIXAM10TfMlggNSmV6oVz/We3Ub7U5BSR
         5nGIWtABLOsD/HQ6KyBe+tsqWLA6E+7d1f+kcPTL09GQe9ZnuTNvk7xb4qJFreesFB2h
         S1zg==
X-Gm-Message-State: AOAM532aGz7YhUtuy87p56zGYmHeINga2LjTwqb78HH5brPLznG+Eb1q
        9PTBJLnojv0RuAMLnWzOR7xw+s4QbgE=
X-Google-Smtp-Source: ABdhPJygDB5oZGTdSf/s8No1UWz5BTUcB0EoQM94HJzcLRwZE37OEugkU5CiT9XzMt76P3ZYPEAfJg==
X-Received: by 2002:a63:e343:: with SMTP id o3mr22538333pgj.317.1614062357447;
        Mon, 22 Feb 2021 22:39:17 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j1sm21355055pfr.78.2021.02.22.22.39.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:39:17 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] git-cat-file.txt: remove references to "sha1"
Date:   Mon, 22 Feb 2021 22:39:08 -0800
Message-Id: <a24cbbe955f45072ffa88ca16f84e2443720a38f.1614062288.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1614062288.git.liu.denton@gmail.com>
References: <cover.1614062288.git.liu.denton@gmail.com>
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
 Documentation/git-cat-file.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 987d170506..ff89c7bfab 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -200,7 +200,7 @@ object, with placeholders of the form `%(atom)` expanded, followed by a
 newline. The available atoms are:
 
 `objectname`::
-	The 40-hex object name of the object.
+	The full hex representation of the object.
 
 `objecttype`::
 	The type of the object (the same as `cat-file -t` reports).
@@ -215,8 +215,8 @@ newline. The available atoms are:
 
 `deltabase`::
 	If the object is stored as a delta on-disk, this expands to the
-	40-hex sha1 of the delta base object. Otherwise, expands to the
-	null sha1 (40 zeroes). See `CAVEATS` below.
+	full hex representation of the delta base object. Otherwise, expands to the
+	null OID (all zeroes). See `CAVEATS` below.
 
 `rest`::
 	If this atom is used in the output string, input lines are split
@@ -235,14 +235,14 @@ newline.
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
2.30.0.478.g8a0d178c01

