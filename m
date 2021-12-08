Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAE5C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbhLHPBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbhLHPBo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A045C0617A2
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d9so4561851wrw.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JLawhKzB98kWAK0pprQ2YXV0nIvcqy4CJG8Vma3+0MU=;
        b=O6ek6qYGMCv32r1OsEFRFlcLLtJ1qxWF/6CMEJJP9ovOghXkxPjyXYSH3Yz6WU42ti
         zRbYNxBjDkBqAiDF+PCOJ8MCo3UCk2zXRNoWENwi7cZMs5GFcpAQxTt3DimsOKarLwnO
         c0NTk2jexc/nvjoqKsnvz+jYFPEr+2Y34gIkrgYQXFlFrWzkGdQQUXrn+6iyMV8ifVcA
         0O+NxjXC/WnuymQu8rAQe/LljAoFT2xaMJXBJGbpUhP0+iSJFF5fWaQ+yiJjULh0extX
         qLPhklSgVl/5yFAZKWvr8CUHxsxbUE+FNk55g5BT4YpPzQE3ljjf2DLMpfhsfDYJtceF
         F2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JLawhKzB98kWAK0pprQ2YXV0nIvcqy4CJG8Vma3+0MU=;
        b=6x2RB4lrlQngwMrdOhtGZpDamxz3nKDGjyxQz53PAXXHf0k6oBONPFC4aBas1aAHQD
         Z9VvoBpYX55WpHTAkuwbYnLpRq0aQNc3yfiC6ubU0GMjhbZXRu1TzuvdPsG3vWc0B1Yk
         M8s44O/W/z2BcgVjvoNMpEHtEsKkuzcsxTJPHdJ6RbHxSfdLHD1kYKKj5VVNnCtqkE+K
         44hs2PyQT0y4EIyF45+kVWghFt/i+qw5RuGHfUgV8MTYWbL0fAEgKNyvlwVXLhg/3/I1
         eWDpIL78oxvVUswTToiJOIy7faxQLCLYCBeBZzGqWbgbJ69xdfYjPHa/4+ouV+RUZyvO
         RNoQ==
X-Gm-Message-State: AOAM531k+xK9OxU1OmkRQX+Wwc2cqF6bvh1RQBhWDe99ob4sfXn1X1y3
        RW4HIj2bo8we4a/vTtjfHO5fxAKLIGg=
X-Google-Smtp-Source: ABdhPJxQkfqe1aMotCGlaKuRyKUThQvgjw6EnisxtcGHLRp0k0KnXCT/PF+Wd4812AgKdjuIagIrYw==
X-Received: by 2002:adf:f9d2:: with SMTP id w18mr59168356wrr.501.1638975490666;
        Wed, 08 Dec 2021 06:58:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm7598740wmp.26.2021.12.08.06.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:10 -0800 (PST)
Message-Id: <5ea636009e7858e50357f0f6f8d8fa42e056db60.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:57 +0000
Subject: [PATCH v2 10/14] rebase: cleanup reset_head() calls
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If ORIG_HEAD is not set by passing RESET_ORIG_HEAD then there is no
need to pass anything for reflog_orig_head. In addition to the callers
fixed in this commit move_to_original_branch() also passes
reflog_orig_head without setting ORIG_HEAD. That caller is mistakenly
passing the message it wants to put in the branch reflog which is not
currently possible so we delay fixing that caller until we can pass
the message as the branch reflog.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3d78b5c8bef..fdd822c470f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -675,7 +675,7 @@ static int run_am(struct rebase_options *opts)
 
 		reset_head(the_repository, &opts->orig_head,
 			   opts->head_name, 0,
-			   "HEAD", NULL, DEFAULT_REFLOG_ACTION);
+			   NULL, NULL, DEFAULT_REFLOG_ACTION);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
 			"these revisions:\n"
@@ -1777,7 +1777,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
 		reset_head(the_repository, NULL, options.head_name,
-			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf, NULL);
+			   RESET_HEAD_REFS_ONLY, NULL, msg.buf, NULL);
 		strbuf_release(&msg);
 		ret = finish_rebase(&options);
 		goto cleanup;
-- 
gitgitgadget

