Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BDCC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5640720723
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQAOj/5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbgEYRGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 13:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389112AbgEYRGo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 13:06:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3E8C061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 10:06:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z6so21424613ljm.13
        for <git@vger.kernel.org>; Mon, 25 May 2020 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=clpqlEu8xiPvCAJeMz/dcbxSY/4HKVlvqtPiC/Pt6bE=;
        b=iQAOj/5aK8ASwsx17/etG4FRMu7YGVGFbI2BqF+6U9IJZszAeyFlEBQxphXoKVO4GE
         i5buHFz43xuDiDlliS8UEnSG0cV20Dz+n1+S7G1wQYRGKE+3QRIPwHUepeDh41wzNHrW
         s5VbLoDkUvICtNixOF5nvpGJeatv3w0TTK2hmy2pjoEGpAJ8tv7nz07uGKEOOLDHE37+
         Zt5hn5uPljvUaqRHK9K3bCOfzMKLNSV8CdghU7RzTyO6Xcq2ygRvIDhC+41AFcMuC299
         bnWmRtfu+B+Hgw70pyC+OORTQpU1+DoyONf3oJYgvtG3sWrREDi0T/2Sucz4fMcAZnVB
         RYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clpqlEu8xiPvCAJeMz/dcbxSY/4HKVlvqtPiC/Pt6bE=;
        b=F5+/GT84b64602t6B2P7ZiofVlLL4OfKohYe+gIWfVL8NyK5EkItZv1ETEde0Jn7Gt
         ++lj1yhqwugP+Wa4Kh/Nj8Dwbb79zIg9DdJBbjFCewzIPvV8NBOe0Jd1E48pyTawxTo6
         Rxm/Re35br0R4yZ8nh1JdpBUGAWOVQziigF6ed6iN0A+R1wxeSRkp8mt8n+VCuuI/QUr
         +uEVimSwYxeABR7WVPSckWVexL4YljNbmP75BP7Z91ZW6nRq1FO/dQ3UsM+KHr2ItA6d
         M7zbJQ8uABOzudBrCM7wiFaZUD54rYEG0q35iKTpO/v/RMiiIfRDSbOeUXy49v3QtQc7
         8Oog==
X-Gm-Message-State: AOAM530/qOiXzIkOLP/YNdVD+c/Ns/PeGVKSAC7VBVZcH22YP1PPZy8b
        iMRiJJRMpzPxTKV85kakhegMYouh
X-Google-Smtp-Source: ABdhPJyRI/ujQVnbkzSjLch2o0EdGxgeZwCmz87QMQR9kREsgpzpDdBVBBpmwmnzu78mCdQwzL/ciw==
X-Received: by 2002:a2e:8191:: with SMTP id e17mr14662734ljg.68.1590426399297;
        Mon, 25 May 2020 10:06:39 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id i11sm1649585ljb.1.2020.05.25.10.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 10:06:38 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2] rev-list-options.txt: start a list for `show-pulls`
Date:   Mon, 25 May 2020 19:06:07 +0200
Message-Id: <20200525170607.8000-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <xmqqsgfx0z9k.fsf@gitster.c.googlers.com>
References: <xmqqsgfx0z9k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 18 May 2020 at 22:22, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin Ågren <martin.agren@gmail.com> writes:
>
> > I currently have the commit message below for my patch plus your fixup.
> > ...
>
> I've queued 1, 3, 4, 5, and 6 in the meantime.  Todd gave us a
> replacement for 2, which I also took.
>
> Thanks.

A long weekend offline passes and it's already a week later...

Here is my original patch 7/7 plus Stolee's fixup, with the rephrased
commit message from upthread. I've tried to test it from all angles I
can think of -- AsciiDoc/Asciidoctor, man/html, doc-diff, ... It should
be low-risk and does avoid beginning ~20 paragraphs with a literal "+"
in the rendered docs for this new option.

Martin

-- >8 --
The explanation of the `--show-pulls` option added in commit 8d049e182e
("revision: --show-pulls adds helpful merges", 2020-04-10) consists of
several paragraphs and we use "+" throughout to tie them together in one
long chain of list continuations. Only thing is, we're not in any kind
of list, so these pluses end up being rendered literally.

The preceding few paragraphs describe `--ancestry-path` and there we
*do* have a list, since we've started one with `--ancestry-path::`. In
fact, we have several such lists for all the various history-simplifying
options we're discussing earlier in this file.

Thus, we're missing a list both from a consistency point of view and
from a practical rendering standpoint.

Let's start a list for `--show-pulls` where we start actually discussing
the option, and keep the paragraphs preceding it out of that list. That
is, drop all those pluses before the new list we're adding here.

Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/rev-list-options.txt | 35 ++++++++++++++++--------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 04ad7dd36e..b01b2b6773 100644
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
@@ -671,10 +671,13 @@ important branch. Instead, the merge `N` was used to merge `R` and `X`
 into the important branch. This commit may have information about why
 the change `X` came to override the changes from `A` and `B` in its
 commit message.
+
+--show-pulls::
+	In addition to the commits shown in the default history, show
+	each merge commit that is not TREESAME to its first parent but
+	is TREESAME to a later parent.
 +
-The `--show-pulls` option helps with both of these issues by adding more
-merge commits to the history results. If a merge is not TREESAME to its
-first parent but is TREESAME to a later parent, then that merge is
+When a merge commit is included by `--show-pulls`, the merge is
 treated as if it "pulled" the change from another branch. When using
 `--show-pulls` on this example (and no other options) the resulting
 graph is:
-- 
2.27.0.rc0

