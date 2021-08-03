Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28CAC432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8DA60F9C
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbhHCPfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbhHCPfj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB2AC06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso1995419wms.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6hg3eONk+4RNe7hQ+AKKd4UJZjHmb8SRriFdnCfxUyo=;
        b=TOisQHwQZBZ2RJe+GfnKgjqvRpGRod0TzBLe0G4uditflJrXNXe18lDWTzk3rkZPcU
         gsLUumVCAqqHE9TLotl8mCz27ANCa0UCstANISHyURDLxA8WYgoVfvL46L4RJc1z3wYQ
         On6jOZnVaG2zYN/fQL6hZrxO302kE2wJUpqs5AYthio2Dx+ipmDr5gq7fmywxC3htN/7
         1ZElktXDEgCBvqbe8V8XQcaFRoQSn7lh6sjzdhBhHgWkqKSYU1I9jOfA3DE4zooqURMi
         w2oG4l5J5D+rF7WWfvR6vZTvqzyUqDvDH3Djkx9VSKJbyObRtiy2vHz9Z8DTuCnT0Ihs
         CNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6hg3eONk+4RNe7hQ+AKKd4UJZjHmb8SRriFdnCfxUyo=;
        b=eY8M6IQkypTSOgSYr2z8jYLw95guFH7j6qvYhdr9Io25F31EkWkVhgpizDtlchBGob
         orEyqgohsCHO7eDPmBdPljyObKepESrlr5xQV1OCqWtZy6p/eQB1BxJ0yzyR8Mj53Agb
         X0pDPSiGwGiCLVWn7mh70cv4G/q+sb/uOtv6VTnzl1a8u/dkWC0jm4DnQ6/wX1BSb/KY
         S+7kzQtOh0hsXUV1I5kfKCnbXOJjlNnMLN6N8myUXs53FBnK4DWVZ6xheAU3kKMe0S46
         tcaRtxF8whenk6HWjaIMzJ2D1rxGSpGJulPXfFXFfiEBSdmXUoUhzdcDwW5SVKNbQKo6
         AoGg==
X-Gm-Message-State: AOAM533scUKixSypUuIMQY4fNFQYTXl6HpjPQQ0Y4xMu5GhqzaJd6zsY
        CwQnWP6m5ysPzW4t6bsjivNMCWG5zMk=
X-Google-Smtp-Source: ABdhPJzkbmH1ojc3C19UIlDaLm5UcdD3WYvl70saqo7KMPvkv7zmhikGlalyJcsqrG0Cloc7l1zfSQ==
X-Received: by 2002:a05:600c:2942:: with SMTP id n2mr22639207wmd.161.1628004926449;
        Tue, 03 Aug 2021 08:35:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j140sm13941158wmj.37.2021.08.03.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:25 -0700 (PDT)
Message-Id: <3989f194ba91e64852285064b652979861445c03.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:14 +0000
Subject: [PATCH 04/10] merge-strategies.txt: update wording for the resolve
 strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The resolve merge strategy was given prominent positioning in this
document, being listed first since it was the default at the time the
document was written.  It hasn't been the default since before Git v1.0
was released, though.  Move it later in the document, near `octopus` and
`ours`.

Further, the wording for "resolve" claimed that it was "considered
generally safe and fast", which implies that the other strategies are
not.  While such an implication may have been true in 2005 when written,
it may well be that `ort` is faster today (since it does not need to
recurse into all directories).  Also, since `resolve` was the default
for less than a year while `recursive` has been the default for a decade
and a half, I think `recursive` is more battle-tested than `resolve` is.
Just strike this extraneous phrase.

Also, provide some quick historical context that may help users
understand its purpose and place in the list of merge strategies.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 5d707e952aa..6b6017e1cc8 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -6,13 +6,6 @@ backend 'merge strategies' to be chosen with `-s` option.  Some strategies
 can also take their own options, which can be passed by giving `-X<option>`
 arguments to `git merge` and/or `git pull`.
 
-resolve::
-	This can only resolve two heads (i.e. the current branch
-	and another branch you pulled from) using a 3-way merge
-	algorithm.  It tries to carefully detect criss-cross
-	merge ambiguities and is considered generally safe and
-	fast.
-
 recursive::
 	This can only resolve two heads using a 3-way merge
 	algorithm.  When there is more than one common
@@ -106,6 +99,13 @@ subtree[=<path>];;
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
+resolve::
+	This can only resolve two heads (i.e. the current branch
+	and another branch you pulled from) using a 3-way merge
+	algorithm.  It tries to carefully detect criss-cross
+	merge ambiguities.  It cannot handle renames.  This was
+	the default merge algorithm prior to November 2005.
+
 octopus::
 	This resolves cases with more than two heads, but refuses to do
 	a complex merge that needs manual resolution.  It is
-- 
gitgitgadget

