Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B20C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924A9207F9
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk0cx1GD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgEQSwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgEQSwo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:52:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322FDC061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h188so6106426lfd.7
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BcnMfFsie4+0a9z8QgeBFHu3FahSzZ79Vc+CfMx5ITs=;
        b=Mk0cx1GDvjIwtYhRuk2WRvI4MC2BB97V9JRWO64PHlqSzowHu2kyXfFNEbMo5HEWZl
         Slk+RTxSIy5pchl+2LNyHXqIBtufaBsJqyqBb+HuCZNO+PvFjxds5KrX8BA82//TLmld
         vIwGlBCuewsbMJcPyjY/wvLPF88VLCJK2gQnskt37cVY9Y0h6QirwTxYIaNJQrqDjrX7
         gpJBu3KyPBtCfvMd0DloUFnFBXrT8OgNGl3xp8tddycT4eLGWxay9+FnTNmFnSwlSgdO
         AFvtDKOzlENrP4d9H4yVGWmQHqrwMldLVjM12CSMvANCXrExtg/kZGFaZZMJk6TQt1Kz
         g6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BcnMfFsie4+0a9z8QgeBFHu3FahSzZ79Vc+CfMx5ITs=;
        b=JR1QCIVvnGjS12/np+yIfPLKXcSRAngGa3oq1NwIQR5phi7r2ZYi2JpAFEccpHm39e
         753L8itQ6nZE03AGPCNgmmHKy1D7ogJ+bxswvcBZgdq2xcpzp5uwnZjV6MvmPswn1kFa
         lV8EAAV0nQRLL14Wx310bigHqxybwbxXDTIL8TUeYQ7UWtNhjs+rd1Wy4RomKNhIOEaR
         q4btwkKS+aHp723jxfiBA9pguGIuS8NZkOWI04QmL6eOXonTSDAACdAl0YOG/Io4z2cX
         nrW3r1B8pYM6kLDKUnU4Ykd8a78PjMHbjK0Ae8D6eFk0AT9gwMtYWvdXZZrKPvT/RYbv
         Xuug==
X-Gm-Message-State: AOAM5329MWIdWNHiQDkY0Awb+XyLvooCrQFTg4p8hIIWTuXLDPJWBk/x
        1cn5NjUeemEa2/Hf1wyKyRzxxYlj
X-Google-Smtp-Source: ABdhPJxXmyFo31oPnDfO+pV3Ne4nOjNU2cN1kOH7xRwFM4XnaT2RjKA+QTh6+3OmN+gaci4cNyNIzw==
X-Received: by 2002:a19:c895:: with SMTP id y143mr8723212lff.199.1589741562207;
        Sun, 17 May 2020 11:52:42 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a12sm4513938ljj.64.2020.05.17.11.52.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 11:52:41 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 7/7] rev-list-options.txt
Date:   Sun, 17 May 2020 20:52:22 +0200
Message-Id: <acfca5465e822eaa6f0ddf85a01f7855d3dfb7d1.1589739920.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <cover.1589739920.git.martin.agren@gmail.com>
References: <cover.1589739920.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The explanation of the `--show-pulls` option added in commit 8d049e182e
("revision: --show-pulls adds helpful merges", 2020-04-10) consists of
several paragraphs and we use "+" throughout to tie them together in one
long chain of list continuations. Only thing is, we're not in any kind
of list, so these pluses end up being rendered literally.

The preceding few paragraphs describe `--ancestry-path` and there we
*do* have a list, since we've started one with `--ancestry-path::`. But
we don't have a similar list running here. We could tie all our
paragraphs from 8d049e182e to that list, but that doesn't make much
sense: We aim to describe another option entirely.

We could start a new list item:

 --show-pulls:
    Before discussing another option, `--show-pulls`, we need to
    create a new example history.
 +
    ...

That reads somewhat awkwardly to me. Not to mention that the chain of
paragraphs that follows is fairly long, introducing a new example
history and discussing it in quite some detail. Let's make this run
along without any kind of indentation. It effectively means that we're
treating "Before discussing..." as a paragraph on the same level as
"There is another simplification mode available:" which precedes the
`--ancestry-path::` list.

If we really want a `--show-pulls::` list somewhere, we could perhaps
let it begin around "The `--show-pulls` option helps with both of these
issues ..." further down. But for now, let's just focus on getting rid
of those literal pluses.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/rev-list-options.txt | 38 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 04ad7dd36e..48e37e2456 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -581,12 +581,12 @@ option does. Applied to the 'D..M' range, it results in:
 
 Before discussing another option, `--show-pulls`, we need to
 create a new example history.
-+
+
 A common problem users face when looking at simplified history is that a
 commit they know changed a file somehow does not appear in the file's
 simplified history. Let's demonstrate a new example and show how options
 such as `--full-history` and `--simplify-merges` works in that case:
-+
+
 -----------------------------------------------------------------------
 	  .-A---M-----C--N---O---P
 	 /     / \  \  \/   /   /
@@ -595,7 +595,7 @@ such as `--full-history` and `--simplify-merges` works in that case:
 	  \ /      /\        /
 	   `---X--'  `---Y--'
 -----------------------------------------------------------------------
-+
+
 For this example, suppose `I` created `file.txt` which was modified by
 `A`, `B`, and `X` in different ways. The single-parent commits `C`, `Z`,
 and `Y` do not change `file.txt`. The merge commit `M` was created by
@@ -607,19 +607,19 @@ the contents of `file.txt` at `X`. Hence, `R` is TREESAME to `X` but not
 contents of `file.txt` at `R`, so `N` is TREESAME to `R` but not `C`.
 The merge commits `O` and `P` are TREESAME to their first parents, but
 not to their second parents, `Z` and `Y` respectively.
-+
+
 When using the default mode, `N` and `R` both have a TREESAME parent, so
 those edges are walked and the others are ignored. The resulting history
 graph is:
-+
+
 -----------------------------------------------------------------------
 	I---X
 -----------------------------------------------------------------------
-+
+
 When using `--full-history`, Git walks every edge. This will discover
 the commits `A` and `B` and the merge `M`, but also will reveal the
 merge commits `O` and `P`. With parent rewriting, the resulting graph is:
-+
+
 -----------------------------------------------------------------------
 	  .-A---M--------N---O---P
 	 /     / \  \  \/   /   /
@@ -628,21 +628,21 @@ merge commits `O` and `P`. With parent rewriting, the resulting graph is:
 	  \ /      /\        /
 	   `---X--'  `------'
 -----------------------------------------------------------------------
-+
+
 Here, the merge commits `O` and `P` contribute extra noise, as they did
 not actually contribute a change to `file.txt`. They only merged a topic
 that was based on an older version of `file.txt`. This is a common
 issue in repositories using a workflow where many contributors work in
 parallel and merge their topic branches along a single trunk: manu
 unrelated merges appear in the `--full-history` results.
-+
+
 When using the `--simplify-merges` option, the commits `O` and `P`
 disappear from the results. This is because the rewritten second parents
 of `O` and `P` are reachable from their first parents. Those edges are
 removed and then the commits look like single-parent commits that are
 TREESAME to their parent. This also happens to the commit `N`, resulting
 in a history view as follows:
-+
+
 -----------------------------------------------------------------------
 	  .-A---M--.
 	 /     /    \
@@ -651,18 +651,18 @@ in a history view as follows:
 	  \ /      /
 	   `---X--'
 -----------------------------------------------------------------------
-+
+
 In this view, we see all of the important single-parent changes from
 `A`, `B`, and `X`. We also see the carefully-resolved merge `M` and the
 not-so-carefully-resolved merge `R`. This is usually enough information
 to determine why the commits `A` and `B` "disappeared" from history in
 the default view. However, there are a few issues with this approach.
-+
+
 The first issue is performance. Unlike any previous option, the
 `--simplify-merges` option requires walking the entire commit history
 before returning a single result. This can make the option difficult to
 use for very large repositories.
-+
+
 The second issue is one of auditing. When many contributors are working
 on the same repository, it is important which merge commits introduced
 a change into an important branch. The problematic merge `R` above is
@@ -671,26 +671,26 @@ important branch. Instead, the merge `N` was used to merge `R` and `X`
 into the important branch. This commit may have information about why
 the change `X` came to override the changes from `A` and `B` in its
 commit message.
-+
+
 The `--show-pulls` option helps with both of these issues by adding more
 merge commits to the history results. If a merge is not TREESAME to its
 first parent but is TREESAME to a later parent, then that merge is
 treated as if it "pulled" the change from another branch. When using
 `--show-pulls` on this example (and no other options) the resulting
 graph is:
-+
+
 -----------------------------------------------------------------------
 	I---X---R---N
 -----------------------------------------------------------------------
-+
+
 Here, the merge commits `R` and `N` are included because they pulled
 the commits `X` and `R` into the base branch, respectively. These
 merges are the reason the commits `A` and `B` do not appear in the
 default history.
-+
+
 When `--show-pulls` is paired with `--simplify-merges`, the
 graph includes all of the necessary information:
-+
+
 -----------------------------------------------------------------------
 	  .-A---M--.   N
 	 /     /    \ /
@@ -699,7 +699,7 @@ graph includes all of the necessary information:
 	  \ /      /
 	   `---X--'
 -----------------------------------------------------------------------
-+
+
 Notice that since `M` is reachable from `R`, the edge from `N` to `M`
 was simplified away. However, `N` still appears in the history as an
 important commit because it "pulled" the change `R` into the main
-- 
2.27.0.rc0

