Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8082FC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 14:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4115320838
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 14:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rP+mLHcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHLOkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgHLOkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 10:40:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8398C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 07:40:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 184so2199596wmb.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vvpg0iEWwAT7oexm9ZgDO/DiAKc+/riPpwBiWMe4MfY=;
        b=rP+mLHcqZl9sO+JrKIFXizDzQDOTxW+9osTYXaBCUx/lHnOMDQWopT54bLfJdPqlkp
         vqXzo67Jt1jzaLHwTSKXLL6io3x/u50FGiDZ2ra4vNUrFCmsyRYCaqkRaw3NfxWceMMF
         mruQIPWMj+K/H8UNemk8z0TVYBNxfBScpqGUOJp7M3YeR+cE6mAdYh1sXmxZwBsyIHTc
         FKRf59Lze+vglnLauxhn8ycwWgthu0sePnRQ+E55fWLKckI0EOIpJBFAsXOK+YB4v9R6
         cwLxHSoqbv2+4IiVm2mD8IHrqnpBYFgwBOZ/BEbLr8cNuO9vPzEO3XHcaBOu52/3RllS
         P2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vvpg0iEWwAT7oexm9ZgDO/DiAKc+/riPpwBiWMe4MfY=;
        b=s+jYer9+B7KmoADJCLj4zSozGU0L5BZfvzd17kMrAPSTQ0gcA6dJ183MyIiAhYjoio
         IUQ8z+6y0MIXY1vBFeKRRaTXLfbuyucsG/QYc6Texe+p1GNGlm1ev9VSP2lIp+NRR2My
         Q7wPKMBB1zbk3vNWv/oG36iYWT82MOSWloAZfAh0y4FMnw5/5ok2Px3KT3tdhXxYOmIQ
         Q3ZHMqGD5nAR7tjKXwTpDBAKNVnseyaeJoZsrfu0FhVVXjOLN0WmJSBckYmfdGZgxFdJ
         YEgJ8qH5HFk62bpVKkc4bpZYlEYEbO2/khXGRa0w2LM93hF57y4aqsh0A+qxZbvuYxox
         IyLQ==
X-Gm-Message-State: AOAM5324ia6A0KUBr/n1gGaHpND2vmkATaHpwdassGx3o4w1BZOK6fNe
        bF9BWF/AD0WwUD1/Ph6gPprudron
X-Google-Smtp-Source: ABdhPJykcoy2h1+jaZG1QZf7Gj//eMYNx8/ZPhiPt8fOwuapkgQr0QFMYQ3BtTzjAdmWW5XOjF+YHA==
X-Received: by 2002:a05:600c:258e:: with SMTP id 14mr56858wmh.141.1597243206438;
        Wed, 12 Aug 2020 07:40:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm4401467wrv.50.2020.08.12.07.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 07:40:05 -0700 (PDT)
Message-Id: <pull.828.v2.git.git.1597243205137.gitgitgadget@gmail.com>
In-Reply-To: <pull.828.git.git.1596654345718.gitgitgadget@gmail.com>
References: <pull.828.git.git.1596654345718.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Aug 2020 14:40:04 +0000
Subject: [PATCH v2] sequencer: avoid garbled merge machinery messages due to
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
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Acked-by: Junio C Hamano <gitster@pobox.com>
---
    sequencer: avoid garbled merge machinery messages due to commit labels
    
    Changes since v1:
    
     * Added Taylor's Reviewed-by, and Junio's Acked-by (I assume that's a
       fair translation of "Looks good", anyway; feel free to adjust when
       you apply otherwise).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-828%2Fnewren%2Fsequencer-merge-messages-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-828/newren/sequencer-merge-messages-v2
Pull-Request: https://github.com/git/git/pull/828

Range-diff vs v1:

 1:  da49e2eb58 ! 1:  762eb962cc sequencer: avoid garbled merge machinery messages due to commit labels
     @@ Commit message
              suggesting it should perhaps be moved to dir2/foo.c.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Reviewed-by: Taylor Blau <me@ttaylorr.com>
     +    Acked-by: Junio C Hamano <gitster@pobox.com>
      
       ## sequencer.c ##
      @@ sequencer.c: static int get_message(struct commit *commit, struct commit_message *out)


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
