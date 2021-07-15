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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB07C47E48
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3854C613CC
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhGOAsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 20:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhGOAsV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 20:48:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9076C061764
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:45:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id w13so2641805wmc.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=thJkGMSlxD1uro5AfAd0fExT4AlbO8y7OSCImnrUsNc=;
        b=URbgCDtxZt2+HdWLFPpFJFSq+B3S4j0KHm+qG2HjRyCmF9SnfkL5mT5nJ4JGF6Di68
         eamhgxdB7iEBVdBwsAaT+bKI1MjLcLh5+lC/zmrz4aGmsugUwaqiu2dYmPFl/J1VJGhI
         7ACnND4bzmTN2/on2PdiG9xsGVDPh4D77KlxZ9HTgGSFu+8WFH5GZM7ck6EEvRxLKF2i
         OSItJd3x4ZfVGIXaIMq8rMMkfYfgexXHDJ0zKVobab0P+uD79OYWGYTB/zJMX8McWUJv
         Gvw4raLC6inbdgGaH0SMeBujVpeleozeTIBd66c29Sua4X1T9X33SeR+4PJmTwRTegng
         BeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=thJkGMSlxD1uro5AfAd0fExT4AlbO8y7OSCImnrUsNc=;
        b=cacNMkkv8yhGAxxxNzCdM0nzlZq8S2JTnuvjplHc0olsZmtXRP15eJkwaRpV25vOa2
         V4yTSp7cj/uebo0AjmpT14TENcs6RMJtZlfDvYwRSTle/JqtzhKpedOBAPd1foDGx6Nl
         HbYaZXQk8EkiB+xxz1i1FNsnnXRJspv3gUd3YdfCMq8nq7yLvjLn8v0qNILWW3vhx0nD
         rwth2QfZOGMQa0Ls2Nxa7PNn+3ayeN2F1Pzi5mP/2uC4WchXOTHhKAWLSSQodcw/I/W4
         aQm9EnjzqLhal+nOFTlVwQtZKFgOL2PDOTL3379rEapXU5q5GWAjjlp0SqgxoqEeRsf4
         rJmg==
X-Gm-Message-State: AOAM533tvSvoewPLXeje1VjQWZkErCU9tEGDjOX/BRU3mvYwP7UNB8wb
        A3QDA9Z+vn9R3pjgZc/OaIjdzH8FZu8=
X-Google-Smtp-Source: ABdhPJw9nM02NSmdWYdV1qvEysK55+4d+qapT5ZAw8PNjbbbDPBkdtmm2xRAw0PngQgV6ZtLSvuqoA==
X-Received: by 2002:a1c:63d6:: with SMTP id x205mr826453wmb.42.1626309927476;
        Wed, 14 Jul 2021 17:45:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm4400027wrt.61.2021.07.14.17.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 17:45:27 -0700 (PDT)
Message-Id: <00a2072baea435060b525b3907121bdf980461e9.1626309924.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
References: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
        <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 00:45:23 +0000
Subject: [PATCH v3 3/4] diffcore-rename: treat a rename_limit of 0 as
 unlimited
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 89973554b52c (diffcore-rename: make diff-tree -l0 mean
-l<large>, 2017-11-29), -l0 was given a special magical "large" value,
but one which was not large enough for some uses (as can be seen from
commit 9f7e4bfa3b6d (diff: remove silent clamp of renameLimit,
2017-11-13).  Make 0 (or a negative value) be treated as unlimited
instead and update the documentation to mention this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/diff-options.txt | 1 +
 diffcore-rename.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 58acfff9289..0aebe832057 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -598,6 +598,7 @@ of a delete/create pair.
 	prevents the exhaustive portion of rename/copy detection from
 	running if the number of source/destination files involved
 	exceeds the specified number.  Defaults to diff.renameLimit.
+	Note that a value of 0 is treated as unlimited.
 
 ifndef::git-format-patch[]
 --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3375e24659e..513ba7b05f1 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1021,7 +1021,7 @@ static int too_many_rename_candidates(int num_destinations, int num_sources,
 	 * memory for the matrix anyway.
 	 */
 	if (rename_limit <= 0)
-		rename_limit = 32767;
+		return 0; /* treat as unlimited */
 	if (st_mult(num_destinations, num_sources)
 	    <= st_mult(rename_limit, rename_limit))
 		return 0;
-- 
gitgitgadget

