Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C68C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 19:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 363BF206D8
	for <git@archiver.kernel.org>; Thu, 14 May 2020 19:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTla+EH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgENTx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 15:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727815AbgENTx2 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 15:53:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E8C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 12:53:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h17so205912wrc.8
        for <git@vger.kernel.org>; Thu, 14 May 2020 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6DqoDlifF1LX9xj9jnP13sXE8xfQ8TFax0IlVs92p2E=;
        b=cTla+EH9Y7ly9iq9gNbJoWjUCk9gdcs7GjedtMbSuGjFB+EUBMoZNywdXcSqRGWQ3V
         7K5ucyKWA0UNFtOWLfqeccPMbRN3hQx+xUZqncRZzLWGg+qPY4aAizUzGe6kC3IvEcIR
         P94QQ+YUM7R42jfZdTllnh0eDnyDVtCqOTB1bNfSyeVen6aOFuwZsPfX7vhFjeK7yiUt
         zbqyx02AnMsUBH1fPwZiTUxq6JaZcB7DphzqiOZubwvXHHsQAwhZQhWVd5ZPE6tEECcd
         2YYFFbQERDM5WODfdqsLCeGxX/nVCzRv3ZP8zj7ZtFhEScgys27sD6b8xIvoxoZRkgiW
         ucHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6DqoDlifF1LX9xj9jnP13sXE8xfQ8TFax0IlVs92p2E=;
        b=l1JJ/ubiAa6syKRPBDAmx0/BSc5yLNmZLJIaEFo4/XCgebARTfb7R0mLpLS5Yga7iG
         AF3dUPA3bazPQ+WlmR/NcFyM3GNUkQq0wFH+vdOSkTbofkHiexWqpcxgXnboVXUB1IRk
         BcZiT0YKxiVPf2n4JtV69gYXpo2crt7WUcjtG7UvW0AwX3CyMgglZAd6NnhxwNMxL+SV
         ZBA/5wZ12nvQL/j2b1tNvG/n5y5XhgWVOKTs731ttHicZ4B4Sk3Qt0RVQdkGrHuwEmUL
         6fvNspHFW9Rj5yo2Qfb4tsbe2z7q6jSj6kLgbhwaGZEtNCufSwSPTyrc2FxpUy+rRoNT
         dTCg==
X-Gm-Message-State: AOAM531rPp6/Ps4fcfNxHbj1fMtkociSBsNTXmefYv6S+25N4iNT3wn/
        BMK7OpeLJIHaI8HWJf7Aq6nXrI0V
X-Google-Smtp-Source: ABdhPJzqwq11D2Fq8sZS16yDM90rf/VVbNDoh8/j5vuMNtTtXy2D5EdC8gucrfP5aeexuWOhhV7aVA==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr90615wrq.374.1589486004873;
        Thu, 14 May 2020 12:53:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm5393952wrt.87.2020.05.14.12.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:53:23 -0700 (PDT)
Message-Id: <pull.785.git.git.1589486002453.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 May 2020 19:53:22 +0000
Subject: [PATCH] unpack-trees: also allow get_progress() to work on a
 different index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

commit b0a5a12a60 ("unpack-trees: allow check_updates() to work on a
different index", 2020-03-27) allowed check_updates() to work on a
different index, but it called get_progress() which was hardcoded to
work on o->result much like check_updates() had been.  Update it to also
accept an index parameter and have check_updates() pass that parameter
along so that both are working on the same index.

Noticed-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    unpack-trees: also allow get_progress() to work on a different index
    
    This is a fix to a minor 2.27 regression, from the en/sparse-checkout
    series.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-785%2Fnewren%2Frecent-sparse-checkout-bugfix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-785/newren/recent-sparse-checkout-bugfix-v1
Pull-Request: https://github.com/git/git/pull/785

 unpack-trees.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1fe3764f2b2..2e6e9d5eeb8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -333,10 +333,10 @@ static void load_gitmodules_file(struct index_state *index,
 	}
 }
 
-static struct progress *get_progress(struct unpack_trees_options *o)
+static struct progress *get_progress(struct unpack_trees_options *o,
+				     struct index_state *index)
 {
 	unsigned cnt = 0, total = 0;
-	struct index_state *index = &o->result;
 
 	if (!o->update || !o->verbose_update)
 		return NULL;
@@ -415,7 +415,7 @@ static int check_updates(struct unpack_trees_options *o,
 	if (o->clone)
 		setup_collided_checkout_detection(&state, index);
 
-	progress = get_progress(o);
+	progress = get_progress(o, index);
 
 	git_attr_set_direction(GIT_ATTR_CHECKOUT);
 

base-commit: b994622632154fc3b17fb40a38819ad954a5fb88
-- 
gitgitgadget
