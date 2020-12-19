Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3118C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 21:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77D623A9D
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgLSV7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 16:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgLSV7U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 16:59:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD6EC0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 13:58:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y23so6936034wmi.1
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hptE/PUPHQ+ZxCjMmilPt0nbYnbFDMdk67+5E2pka+Q=;
        b=TsAN5XIuIsyoRydvFLFms8soKdIveTOxpmx/aW9M3d04IpUF6OYyf+eoeiLGquxH/X
         jvhmg+Rk+ik+nLC8B0WAF39pJdjtfeseGe0sjGGNn5hEjoxB7Nu0VGufpunPk3jEzjT0
         nXrMYvoVy3rx7HFELkflaeBPHpClRsRppiR3Q3m+xNYwj13KabiE8gYKKDZo7hFd0dKa
         NEN85Y78GgzeuYzJdjRH3PC1UVOfRCv/eDGcVRPwMjMjJ3pBAM7BoBArh9xzyLQ3TCf/
         a5itn7JYTqYulFoO2f5gK68Wbp4Q0UP0nKuzV6hpkTSqa549IAIg2FoxhoUUJ+SvQb8g
         ewDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hptE/PUPHQ+ZxCjMmilPt0nbYnbFDMdk67+5E2pka+Q=;
        b=RhzmFFRjz0BG2g31GhV19UzS/gu8hmnnp5+VSy0htZTEe0MFY0nIRMNyVK6t+IRRmU
         n7JISlyIek+r4WBEWV4crkT2brdm0kgdTx6POMkDkJKxy6eA9aUlgv2ujRZ6GliwjDAn
         Pixj6GzaK/Dzt6Uy18qH93O+kdtlq2AO3CRUC2pRGXILQoejx9nBFScUpNl14WDBvcMj
         rXHEghn9uzNRIbYQlmYUT+oqwVV1RUKmlYM7xfS4Dgl6mSW5lg77btw7OUHAf0vgAmE2
         +GGBQaVqF94SNSNG7x+yexVMyBTCzq9a+HRSjMsxlUxRdv00EWuDmwYJ2OsHIOOfgJOm
         Ry7A==
X-Gm-Message-State: AOAM532FbuTkLIXCRfW617vQ2zn6WIQsvr5E3EaCp4b+jObt5z3SJBho
        81uO77fU8bk11odnNVZcdF1sbcqvIIQ=
X-Google-Smtp-Source: ABdhPJz8Z7OvT9ZghevZ3iJjCCHUvqoxW4GtVCuB0O61uhoarYJCcXO4qUzOk2HcUiifswBl44o99A==
X-Received: by 2002:a1c:67c5:: with SMTP id b188mr9750146wmc.147.1608415118790;
        Sat, 19 Dec 2020 13:58:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r82sm16904650wma.18.2020.12.19.13.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 13:58:38 -0800 (PST)
Message-Id: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.git.1608398598893.gitgitgadget@gmail.com>
References: <pull.820.git.1608398598893.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Dec 2020 21:58:35 +0000
Subject: [PATCH v2 0/2] negative-refspec: fix segfault on : refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, if remote.origin.push was set to ":", git would segfault during
a push operation, due to bad parsing logic in
query_matches_negative_refspec. Per bisect, the bug was introduced in:
c0192df630 (refspec: add support for negative refspecs, 2020-09-30)

We found this issue when rolling out git 2.29 at Dropbox - as several folks
had "push = :" in their configuration. I based my diff off the master
branch, but also confirmed that it patches cleanly onto maint - if the
maintainers would like to also fix the segfault on 2.29

Update since Patch series V1:

 * Handled matching refspec explicitly
 * Added testing for "+:" case
 * Added comment explaining how the two loops work together

It may be wise to add additional testing for a case with a matching refspec
+ negative refspec with expected behavior

Nipunn Koorapati (2):
  negative-refspec: fix segfault on : refspec
  negative-refspec: improve comment on query_matches_negative_refspec

 remote.c                          | 16 +++++++++++++---
 t/t5582-fetch-negative-refspec.sh | 15 +++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)


base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-820%2Fnipunn1313%2Fnk%2Fpush-refspec-segfault-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-820/nipunn1313/nk/push-refspec-segfault-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/820

Range-diff vs v1:

 1:  743e848653f ! 1:  e42200b644a negative-refspec: fix segfault on : refspec
     @@ Metadata
       ## Commit message ##
          negative-refspec: fix segfault on : refspec
      
     -    Previously, if remote.origin.push was set to ":",
     -    git would segfault during a push operation, due to bad
     -    parsing logic in query_matches_negative_refspec. Per
     -    bisect, the bug was introduced in:
     -    c0192df630 (refspec: add support for negative refspecs, 2020-09-30)
     +    The logic added to check for negative pathspec match by c0192df630
     +    (refspec: add support for negative refspecs, 2020-09-30) looks at
     +    refspec->src assuming it is never NULL, however when
     +    remote.origin.push is set to ":", then refspec->src is NULL,
     +    causing a segfault within strcmp
      
          Added testing for this case in fetch-negative-refspec
      
     @@ remote.c: static int query_matches_negative_refspec(struct refspec *rs, struct r
      -		} else {
      -			if (!strcmp(needle, refspec->src))
      -				string_list_append(&reversed, refspec->src);
     -+		} else if (refspec->src != NULL && !strcmp(needle, refspec->src)) {
     ++		} else if (refspec->matching) {
     ++			/* For the special matching refspec, any query should match */
     ++			string_list_append(&reversed, needle);
     ++		} else if (refspec->src == NULL) {
     ++			BUG("refspec->src should not be null here");
     ++		} else if (!strcmp(needle, refspec->src)) {
      +			string_list_append(&reversed, refspec->src);
       		}
       	}
     @@ t/t5582-fetch-negative-refspec.sh: test_expect_success "fetch --prune with negat
       	)
       '
       
     -+test_expect_success "push with empty refspec" '
     ++test_expect_success "push with matching ':' refspec" '
      +	(
      +		cd two &&
      +		git config remote.one.push : &&
      +		# Fails w/ tip behind counterpart - but should not segfault
      +		test_must_fail git push one master &&
     ++
     ++		git config remote.one.push +: &&
     ++		# Fails w/ tip behind counterpart - but should not segfault
     ++		test_must_fail git push one master &&
     ++
      +		git config --unset remote.one.push
      +	)
      +'
 -:  ----------- > 2:  8da8d9cd1c5 negative-refspec: improve comment on query_matches_negative_refspec

-- 
gitgitgadget
