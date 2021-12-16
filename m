Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC0EC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 16:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhLPQNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbhLPQNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 11:13:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B6CC06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:13:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c4so45102259wrd.9
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yqd8piQNr43peyKivGK0zeQqWRtnCbt/yIqPl9weTEQ=;
        b=I5nS4gq5qY7gzXDPG6Hx9dlQPhoGM0KkR/mqao8FxAna+22jAjshnkiBXG3bahil1r
         deg/As1zrJfSqb75u54sqBZGEftphTpRBpNfW+b4eLvVIANDxPWl8xtjKOrhgt0FsrFe
         8biHPnBVpSq1zoTGVz8xqCSqFU7JOROxZs+oGDjJnKnKyMUYUPwP1o6tJO+N6nvmutU4
         r94gtUPdaOGV9SJv2HMlrql7xQwymmcGb4wpOb0tVjOKHAr0U1nPGZFRhj32BKzIq3gL
         kiN/1N8+JdUVpd63V4o2NTiPKW7DtlAz3v78DhHt0A6tmxqdUtI7A57iUvACpUjozZSb
         dFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yqd8piQNr43peyKivGK0zeQqWRtnCbt/yIqPl9weTEQ=;
        b=3+ycPe9OElqaUlMxrMjYlOmplQ+oqoEip2Nn6dipd0xK4glUGEbdRJKrOHxVo0IbAy
         HBgdNdjzsCSpqtWAQqvdN9l6LnpcMq1ekdHzSDEL27By/roaufDhXUqGtMvmNoNtrug2
         WKPdsurQr/vxcNT846wiiLi1fKchC7rHCuq9Uw6lt6vMVae1fUFKusoRAdyhY8j8UVfJ
         MQ7D/w+OH+0nqtlTX3tK2J/Xp6zMKI7ob87JH6zpDqVuiR75wMQ2tl16St7DZDV3iknL
         dQBvGjMtw/Hp44ABQTtwhM0yeIvNAzgHj7TCtdcHFmPslf544IFNb/CJhzOATYQrtaYV
         D7MQ==
X-Gm-Message-State: AOAM530C/p/k9kvzASG5GPIaXzLRVXT0UTxAVqN/sCfJDhXRmonDvOCt
        MXrx51WUT4AvWrB3DbltZRf1bcUjzmI=
X-Google-Smtp-Source: ABdhPJyjkYgLaxMYJZTk5EP0a87c0xXNtvz/dTOrNBm791mB/6yGlgU7t40s9osLZ/py4cagrVr+YA==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr9950610wri.343.1639671224080;
        Thu, 16 Dec 2021 08:13:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p62sm4915408wmp.10.2021.12.16.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:13:43 -0800 (PST)
Message-Id: <pull.1069.v4.git.1639671222.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
References: <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 16:13:39 +0000
Subject: [PATCH v4 0/3] sparse-checkout: fix segfault on malformed patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some issues with parsing sparse-checkout patterns when
core.sparseCheckoutCone is enabled but the sparse-checkout file itself
contains patterns that don't match the cone mode format.

The first patch fixes a segfault first reported in [1]. The other two
patches are from an earlier submission [2] that never got picked up and I
lost track of. There was another patch involving 'git sparse-checkout init
--cone' that isn't necessary, especially with Elijah doing some work in that
space right now.

[1] https://github.com/git-for-windows/git/issues/3498 [2]
https://lore.kernel.org/git/pull.1043.git.1632160658.gitgitgadget@gmail.com

Thanks, -Stolee


Update in v4
============

 * For added precaution, this kind of unexpected duplicate pattern will
   disable cone mode matching.
 * Tests are updated to verify this new behavior.


Updates in v2 and v3
====================

 * I intended to fix a typo in a patch, but accidentally sent the amend!
   commit in v2
 * v3 has the typo fix properly squashed in.
 * Added Elijah's review.

Derrick Stolee (3):
  sparse-checkout: fix segfault on malformed patterns
  sparse-checkout: fix OOM error with mixed patterns
  sparse-checkout: refuse to add to bad patterns

 builtin/sparse-checkout.c          |  5 +++-
 dir.c                              |  6 ++---
 t/t1091-sparse-checkout-builtin.sh | 37 +++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 6 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1069%2Fderrickstolee%2Fsparse-checkout%2Finput-bug-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1069/derrickstolee/sparse-checkout/input-bug-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1069

Range-diff vs v3:

 1:  1744a26845f ! 1:  5353c541d9f sparse-checkout: fix segfault on malformed patterns
     @@ Commit message
          list' command because it iterates over the contents of the hashset, which is
          now invalid.
      
     -    The fix here is to stop trying to remove from the hashset. Better to leave
     -    bad data in the sparse-checkout matching logic (with a warning) than to
     -    segfault. If we are in this state, then we are already traversing into
     -    undefined behavior, so this change to keep the entry in the hashset is no
     -    worse than removing it.
     +    The fix here is to stop trying to remove from the hashset. In addition,
     +    we disable cone mode sparse-checkout because of the malformed data. This
     +    results in the pattern-matching working with a possibly-slower
     +    algorithm, but using the patterns as they are in the sparse-checkout
     +    file.
     +
     +    This also changes the behavior of commands such as 'git sparse-checkout
     +    list' because the output patterns will be the contents of the
     +    sparse-checkout file instead of the list of directories. This is an
     +    existing behavior for other types of bad patterns.
      
          Add a test that triggers the segfault without the code change.
      
     @@ dir.c: static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_
      -		hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
      -		free(data);
      -		free(translated);
     ++		goto clear_hashmaps;
       	}
       
       	return;
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'cone mode clears ignore
      +	!/foo/*/
      +	/foo/\*/
      +	EOF
     -+	cat repo/.git/info/sparse-checkout &&
     -+	git -C repo sparse-checkout list
     ++
     ++	# Listing the patterns will notice the duplicate pattern and
     ++	# emit a warning. It will list the patterns directly instead
     ++	# of using the cone-mode translation to a set of directories.
     ++	git -C repo sparse-checkout list >actual 2>err &&
     ++	test_cmp repo/.git/info/sparse-checkout actual &&
     ++	grep "warning: your sparse-checkout file may have issues: pattern .* is repeated" err &&
     ++	grep "warning: disabling cone pattern matching" err
      +'
      +
       test_done
 2:  a2fe867222e = 2:  3fd625290a3 sparse-checkout: fix OOM error with mixed patterns
 3:  a0e5a942ae0 = 3:  f5f7b8b8e04 sparse-checkout: refuse to add to bad patterns

-- 
gitgitgadget
