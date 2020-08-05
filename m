Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBFDC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342D52064B
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TngxwqfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgHETGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgHETFt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 15:05:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04723C061756
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 12:05:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so38142484wrm.12
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 12:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6S+PdLUOfIR15iYUghOaFay92qW9JUqXCMzHAihWRT4=;
        b=TngxwqfHI4NlXb9UoMVINV+x4lDJK/VZGkaaP/DTcL/CRa33J0rTHyyUkjHftu4Pun
         ZlulIP2lzRQMzQLCAOOqxcE07qUKxBksyLuVOGvbCo7XXnaudCJzTs4A1zv5JsRsQYA4
         d3AjQ/FkSHHNqWhXAxUADHUkQqNP/RY+r/Lsp14Qwqh9is7qAh44OD9pnEvCDDTdQhoV
         E2Z9LpCSObvGkI6xn21Sf2MzkhBlTChzqo5CLmiJ8Ii6wjP88EorgZEzhZdx8WXEpEO2
         XewhAVQGAwNrf4zomkhYxOACQpXMr5qVx6DadV9QWAXPskaHQKrb2PtcYF+GBwgXBbbY
         ZUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6S+PdLUOfIR15iYUghOaFay92qW9JUqXCMzHAihWRT4=;
        b=R0GqlsWmdsg5K/W6ICY3bSLu9+IZwG3J1tzzOpbrXM25vfsgfl7pk9w3E2Nn7TYLSL
         PbcoYFHRbsj2fVnS2xGiuoQIs7iB+5L1vkKVZ32ZPOKPXbLxOHBQXm7jDU8Nr3Cuccgl
         m+OIPlpzPjHeCN00kmFB//o6Wzv22mDLEAw9sr0tFQ/0Zz7mFpdnY8+hUQ8uV9QUJv/F
         5z0/yLsvZylnOcUoM8I/SblZWN/0f3gSQjp3RIxdG4cBJeKNbWK7UUUIvuZHwUNA23Mg
         2uwQaj/+Dn0fLwa0HXWjXcngWbHZjT3bz79GUJWeaQJI0heUcgcpEjT9lS/HQmhTY6Y5
         Vo3w==
X-Gm-Message-State: AOAM532rz2w4yDoUnoHbnuXCH0aDLkkFgGjr7snapR7hml7ZCArG4Ons
        pDFq6Fr8cyVAJkiStzgriZVJ4qKw
X-Google-Smtp-Source: ABdhPJw7Z+9E3FioWlxmPujhi96yWknhkPgJDn6LJlBD2g5IM2Jt4TIyVFkxfg/OiUsq98LGTB5mag==
X-Received: by 2002:adf:f207:: with SMTP id p7mr4022008wro.292.1596654347435;
        Wed, 05 Aug 2020 12:05:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3sm3854611wro.1.2020.08.05.12.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 12:05:46 -0700 (PDT)
Message-Id: <pull.828.git.git.1596654345718.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 19:05:45 +0000
Subject: [PATCH] sequencer: avoid garbled merge machinery messages due to
 commit labels
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

sequencer's get_message() exists to provide good labels on conflict
hunks; see commits
  d68565402a ("revert: clarify label on conflict hunks", 2010-03-20)
  bf975d379d ("cherry-pick, revert: add a label for ancestor", 2010-03-20)
  043a4492b3 ("sequencer: factor code out of revert builtin", 2012-01-11).
for background on this function.  These labels are of the form
  <commitID>... <commit summary>
or
  parent of <commitID>... <commit summary>
These labels are then passed as branch names to the merge machinery.
However, these labels, as formatted, often also serve to confuse.  For
example, if we have a rename involved in a content merge, then it
results in text such as the following:

    <<<<<<<< HEAD:foo.c
      int j;
    ========
      int counter;
    >>>>>>>> b01dface... Removed unnecessary stuff:bar.c

Or in various conflict messages, it can make it very difficult to read:

    CONFLICT (rename/delete): foo.c deleted in b01dface... Removed
    unnecessary stuff and renamed in HEAD.  Version HEAD of foo.c left
    in tree.

    CONFLICT (file location): dir1/foo.c added in b01dface... Removed
    unnecessary stuff inside a directory that was renamed in HEAD,
    suggesting it should perhaps be moved to dir2/foo.c.

Make a minor change to remove the ellipses and add parentheses around
the commit summary; this makes all three examples much easier to read:

    <<<<<<<< HEAD:foo.c
      int j;
    ========
      int counter;
    >>>>>>>> b01dface (Removed unnecessary stuff):bar.c

    CONFLICT (rename/delete): foo.c deleted in b01dface (Removed
    unnecessary stuff) and renamed in HEAD.  Version HEAD of foo.c left
    in tree.

    CONFLICT (file location): dir1/foo.c added in b01dface (Removed
    unnecessary stuff) inside a directory that was renamed in HEAD,
    suggesting it should perhaps be moved to dir2/foo.c.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sequencer: avoid garbled merge machinery messages due to commit labels

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-828%2Fnewren%2Fsequencer-merge-messages-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-828/newren/sequencer-merge-messages-v1
Pull-Request: https://github.com/git/git/pull/828

 sequencer.c                     |  2 +-
 t/t3404-rebase-interactive.sh   |  2 +-
 t/t3507-cherry-pick-conflict.sh | 20 ++++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fd7701c88a..e988c12ad2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -355,7 +355,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
 	subject_len = find_commit_subject(out->message, &subject);
 
 	out->subject = xmemdupz(subject, subject_len);
-	out->label = xstrfmt("%s... %s", abbrev, out->subject);
+	out->label = xstrfmt("%s (%s)", abbrev, out->subject);
 	out->parent_label = xstrfmt("parent of %s", out->label);
 
 	return 0;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4a7d21f898..1d0a656ebd 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -256,7 +256,7 @@ test_expect_success 'stop on conflicting pick' '
 	D
 	=======
 	G
-	>>>>>>> $commit... G
+	>>>>>>> $commit (G)
 	EOF
 	git tag new-branch1 &&
 	test_must_fail git rebase -i master &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 752bc43487..152ea11dc9 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -283,12 +283,12 @@ test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	a
 	=======
 	c
-	>>>>>>> objid picked
+	>>>>>>> objid (picked)
 	EOF
 
 	test_must_fail git cherry-pick picked &&
 
-	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
+	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
 	test_cmp expected actual
 '
 
@@ -298,16 +298,16 @@ test_expect_success 'diff3 -m style' '
 	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
-	||||||| parent of objid picked
+	||||||| parent of objid (picked)
 	b
 	=======
 	c
-	>>>>>>> objid picked
+	>>>>>>> objid (picked)
 	EOF
 
 	test_must_fail git cherry-pick picked &&
 
-	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
+	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
 	test_cmp expected actual
 '
 
@@ -319,7 +319,7 @@ test_expect_success 'revert also handles conflicts sanely' '
 	a
 	=======
 	b
-	>>>>>>> parent of objid picked
+	>>>>>>> parent of objid (picked)
 	EOF
 	{
 		git checkout picked -- foo &&
@@ -345,7 +345,7 @@ test_expect_success 'revert also handles conflicts sanely' '
 	test_must_fail git update-index --refresh -q &&
 	test_must_fail git diff-index --exit-code HEAD &&
 	test_cmp expected-stages actual-stages &&
-	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
+	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
 	test_cmp expected actual
 '
 
@@ -429,16 +429,16 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
-	||||||| objid picked
+	||||||| objid (picked)
 	c
 	=======
 	b
-	>>>>>>> parent of objid picked
+	>>>>>>> parent of objid (picked)
 	EOF
 
 	test_must_fail git revert picked &&
 
-	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
+	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
 	test_cmp expected actual
 '
 

base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
-- 
gitgitgadget
