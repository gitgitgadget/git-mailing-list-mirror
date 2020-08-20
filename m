Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D609CC433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 23:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AD4207DE
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 23:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="v7sgtwk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgHTXLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHTXLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 19:11:19 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB10DC061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 16:11:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1597965075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1cRCQ8hb4lWyjoNXHRActGv5B3X+x4NtPx1keojw1hY=;
        b=v7sgtwk4IFSQx9mm/EFUBXUQYOFFwwzrMqDmnxbNxCH5K5UcqH7Ei8wpWt4VMnzLcZYDQ4
        7dpIcYv5cJguc2CaWdl+Me0VX7ORbaZefF7fL4yJzzYJkKtXJhzxYQJU3WcMJ4PNeJQIJr
        wI5/XiG/keNgXoALO/efAK01ToIRqeI=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH v2] git-apply.txt: update descriptions of --cached, --index
Date:   Thu, 20 Aug 2020 19:10:51 -0400
Message-Id: <20200820231051.85134-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The blurb for "--cached" says it implies "--index", but in reality
"--cached" and "--index" are distinct modes with different behavior.

Additionally, the descriptions of "--index" and "--cached" are somewhat
unclear about what might be modified, and what "--index" looks for to
determine that the index and working copy "match".

Rewrite the blurbs for both options for clarity and accuracy.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
How's this for an updated wording?

 Documentation/git-apply.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b9aa39000f..91d9a8601c 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -61,18 +61,18 @@ OPTIONS
 	file and detects errors.  Turns off "apply".
 
 --index::
-	When `--check` is in effect, or when applying the patch
-	(which is the default when none of the options that
-	disables it is in effect), make sure the patch is
-	applicable to what the current index file records.  If
-	the file to be patched in the working tree is not
-	up to date, it is flagged as an error.  This flag also
-	causes the index file to be updated.
+	Apply the patch to both the index and the working tree (or
+	merely check that it would apply cleanly to both if `--check` is
+	in effect). Note that `--index` expects index entries and
+	working tree copies for relevant paths to be identical (their
+	contents and metadata such as file mode must match), and will
+	raise an error if they are not, even if the patch would apply
+	cleanly to both the index and the working tree in isolation.
 
 --cached::
-	Apply a patch without touching the working tree. Instead take the
-	cached data, apply the patch, and store the result in the index
-	without using the working tree. This implies `--index`.
+	Apply the patch to just the index, without touching the working
+	tree. If `--check` is in effect, merely check that it would
+	apply cleanly to the index entry.
 
 --intent-to-add::
 	When applying the patch only to the working tree, mark new
-- 
2.28.0.1.gcf60d27c7c

