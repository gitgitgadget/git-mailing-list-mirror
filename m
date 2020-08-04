Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808BCC433E1
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9C02073E
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvesEjNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgHDA4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbgHDA4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:56:30 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F4DC061757
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:56:29 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g14so3010692iom.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtHL16NuO3rHOYVCaFPifAV7SolL0YUrShrXhwAZ2YQ=;
        b=MvesEjNcC6LdT3v60j/8VxAcCH+tWR9zkzxowDEpDhXVd/Rf85K8k8UGrRawu7hAm7
         3WZa7r0ByAfOP/Cb9iYZc8CpV2uRAjpCGf04THRZJgPpxm5FLra7x4CTj0P/x+cmWlYh
         PaV8IAOZorRyzMYzb25IRMnbI+Uz7SaS5Ih/oLQjP0HbdX78Ac/QJOYeNQlECGJ1rs5E
         q7n8ROr983o5KpJ6Ixezcoc+/roZsrJsKCdTQe320sc86agEaZDakA636vVhvDal6OVd
         YoJS1i5S/QrkNZgA6p2J2edRa8er0pNBZicSBZSzRdYuF/T/FHryVWqPod3d5vD0W2zs
         wEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UtHL16NuO3rHOYVCaFPifAV7SolL0YUrShrXhwAZ2YQ=;
        b=Jje2DbWcfmIa7hNmV5ce3QKQ4H9xM99yCHDAvCaipBwGh4W2EW58+/l6/RfBVkPhfc
         drMBT3UWnOgYtQmKBiKtbJnnwCiRxFvw2lTgX1Krt0iWRxLmpIWO9FZ5/0+3mWjQ0VSH
         Rhv+EVPb8goGZ1ToedT0uErj5okHYt30tBeLpCBHwGUwrbNHJHHgHoqlVnSkQOQLUuYJ
         bMbB7cxyfS/Qg+dbR+Eh2uiPWObQiLmpo9G1gI9ekltmiIacIiDabsHVJjVTSngX7mA8
         O6H9CXQIwcvHbdppaYwlN1vLVqxmcJiEcbYz7DWBoV05B8bfp8BGEq17DHXu7QW9gxYe
         CRPQ==
X-Gm-Message-State: AOAM533b/eZKg6fSkOHogqR0lenNOLC2HOJln0d884vTgBRMyaD23Qfx
        VRf8IalXDGOt5qIf7OzwGPCNLIqKNEY=
X-Google-Smtp-Source: ABdhPJzozE71fHwJ5trVJ6Bt6TYxYor/imRyJ5IgrqbZoJkBQvsg5JNuLQ9xSwr4rLZ9hSXtn48o+g==
X-Received: by 2002:a02:c9d5:: with SMTP id c21mr2741445jap.72.1596502588851;
        Mon, 03 Aug 2020 17:56:28 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e84sm11878453ill.60.2020.08.03.17.56.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2020 17:56:28 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/5] git-worktree.txt: fix minor grammatical issues
Date:   Mon,  3 Aug 2020 20:55:33 -0400
Message-Id: <20200804005535.5126-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966
In-Reply-To: <20200804005535.5126-1-sunshine@sunshineco.com>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
 <20200804005535.5126-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a few grammatical problems to improve the reading experience.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 926f4662ee..ce2d40ee4c 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -82,7 +82,7 @@ list::
 
 List details of each working tree.  The main working tree is listed first,
 followed by each of the linked working trees.  The output details include
-if the working tree is bare, the revision currently checked out, and the
+whether the working tree is bare, the revision currently checked out, and the
 branch currently checked out (or "detached HEAD" if none).
 
 lock::
@@ -171,7 +171,7 @@ This can also be set up as the default behaviour by using the
 --lock::
 	Keep the working tree locked after creation. This is the
 	equivalent of `git worktree lock` after `git worktree add`,
-	but without race condition.
+	but without a race condition.
 
 -n::
 --dry-run::
@@ -202,21 +202,21 @@ This can also be set up as the default behaviour by using the
 	absolute.
 +
 If the last path components in the working tree's path is unique among
-working trees, it can be used to identify working trees. For example if
+working trees, it can be used to identify a working tree. For example if
 you only have two working trees, at `/abc/def/ghi` and `/abc/def/ggg`,
 then `ghi` or `def/ghi` is enough to point to the former working tree.
 
 REFS
 ----
 In multiple working trees, some refs may be shared between all working
-trees, some refs are local. One example is `HEAD` is different for all
-working trees. This section is about the sharing rules and how to access
+trees and some refs are local. One example is `HEAD` which is different for each
+working tree. This section is about the sharing rules and how to access
 refs of one working tree from another.
 
 In general, all pseudo refs are per working tree and all refs starting
 with `refs/` are shared. Pseudo refs are ones like `HEAD` which are
-directly under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There is one
-exception to this: refs inside `refs/bisect` and `refs/worktree` is not
+directly under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are
+exceptions, however: refs inside `refs/bisect` and `refs/worktree` are not
 shared.
 
 Refs that are per working tree can still be accessed from another
@@ -243,7 +243,7 @@ already present in the config file, they will be applied to the main
 working trees only.
 
 In order to have configuration specific to working trees, you can turn
-on `worktreeConfig` extension, e.g.:
+on the `worktreeConfig` extension, e.g.:
 
 ------------
 $ git config extensions.worktreeConfig true
@@ -255,7 +255,7 @@ configuration in this file with `git config --worktree`. Older Git
 versions will refuse to access repositories with this extension.
 
 Note that in this file, the exception for `core.bare` and `core.worktree`
-is gone. If you have them in `$GIT_DIR/config` before, you must move
+is gone. If they exist in `$GIT_DIR/config`, you must move
 them to the `config.worktree` of the main working tree. You may also
 take this opportunity to review and move other configuration that you
 do not want to share to all working trees:
@@ -334,7 +334,7 @@ Porcelain Format
 ~~~~~~~~~~~~~~~~
 The porcelain format has a line per attribute.  Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `bare`
-and `detached`) are listed as a label only, and are only present if and only
+and `detached`) are listed as a label only, and are present only
 if the value is true.  The first attribute of a working tree is always
 `worktree`, an empty line indicates the end of the record.  For example:
 
-- 
2.28.0.236.gb10cc79966

