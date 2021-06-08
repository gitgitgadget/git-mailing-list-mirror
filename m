Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B0C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92D4610A1
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhFHTLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:11:37 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:44780 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbhFHTJW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 15:09:22 -0400
Received: by mail-pf1-f169.google.com with SMTP id u18so16436768pfk.11
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqeXepsDgXO7lu0gX+qr6B1yVAzgqbvZokt7hW9WWoc=;
        b=Cgql+Qs4Vf6sq9xi3OiMp9IU/ewWpV50K8ebCojralTr2Z7MfkmPcae0VMZ6I1Cn6W
         f0qSh57605yXY1JOD9GiKZvvNfYQTB9bHWKfKsprE9394GvZ8R7D0NB1hAvJHIE1+Ub0
         zborNgbW9W88iNB0X1qBx+t+p1ZXot2YuSNDX/K5uAsGjRSZ9+lJ14Rhjgvaje8qI0Cf
         bJRDTulId8PyHLkA4KylQ/qS5OtuF39u2EiT8KMX01DZlz+Q+iSEJt6KA0ognUZuYxGS
         pBM4f/tsc/os5L1fVG4Xr/ScAUgSrp8WAQwN3nE+aWI1Wo6IfK80CxAP/QzOFtaecwAX
         A2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqeXepsDgXO7lu0gX+qr6B1yVAzgqbvZokt7hW9WWoc=;
        b=GN8M6OKl1qMajuDWTKLR8on6ThI3sFcTG2rXGqfC04Q3mGbSTR7xwco/ljWe5xywq4
         7qB9sE382+SU5C2gk7/LfbW8tV8/N0oEs/B8CQV7Z0SI6RqmnB4xMjRrTeRMsadd7s+6
         M/ZiXYKUzNkdD8U1sgJnV9yj9KAHpiQy/ZkTUtHzvo5uXFs4k8nsZAtjULVN2AenzSDD
         6ug6Oqi+rsP3MruVnzL1RRY2VufqIlmo/y9rynFpeq+YDR2ti09GVCdZLMV6I55Yzt0T
         XOPJxSPef9Gl9wLpT3owFxUeWu9rxgA7IHtzn2rCLrSDs52i1JSsjemgFTwR0KL710yb
         alOg==
X-Gm-Message-State: AOAM530lBTgIBbYXMSy8yBA4/H9VS2NXZUpi0AFFi0Obq6u/ab8yP6da
        PJ8OTig4AsEAifzdDzsh6CRgsA+QGXzc1tHJJC8=
X-Google-Smtp-Source: ABdhPJykeo0j1c3QqZq7/V/XKwdn9ipqSscfyOhVwmTNhS1ngLG8AQ3fjOAQoFb9nHCLdZrzznBmpQ==
X-Received: by 2002:a65:6a52:: with SMTP id o18mr23982606pgu.177.1623179186991;
        Tue, 08 Jun 2021 12:06:26 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id q21sm11906345pfn.81.2021.06.08.12.06.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:06:26 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v3] MyFirstContribution: link #git-devel to Libera Chat
Date:   Wed,  9 Jun 2021 00:36:12 +0530
Message-Id: <20210608190612.72807-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608180624.72135-1-raykar.ath@gmail.com>
References: <20210608180624.72135-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many of the regulars on #git-devel are now on Libera Chat, to the extent
that the community page now lists it as the IRC Channel[1]. This will
help new contributors find the right place, if they choose to ask
questions on `#git-devel`.

Relevant discussion on the IRC transition:
https://lore.kernel.org/git/CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com/

[1] https://git-scm.com/community

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---

I'm sending it again as my v2 had one line crossed 80 lines in my edit,
which broke the local convention.

 Documentation/MyFirstContribution.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index af0a9da62e..015cf24631 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -47,7 +47,7 @@ Veteran contributors who are especially interested in helping mentor newcomers
 are present on the list. In order to avoid search indexers, group membership is
 required to view messages; anyone can join and no approval is required.
 
-==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
+==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
 This IRC channel is for conversations between Git contributors. If someone is
 currently online and knows the answer to your question, you can receive help
@@ -827,7 +827,7 @@ either examining recent pull requests where someone has been granted `/allow`
 (https://github.com/gitgitgadget/git/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+%22%2Fallow%22[Search:
 is:pr is:open "/allow"]), in which case both the author and the person who
 granted the `/allow` can now `/allow` you, or by inquiring on the
-https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Freenode
+https://web.libera.chat/#git-devel[#git-devel] IRC channel on Libera Chat
 linking your pull request and asking for someone to `/allow` you.
 
 If the CI fails, you can update your changes with `git rebase -i` and push your
-- 
2.31.1

