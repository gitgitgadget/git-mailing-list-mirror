Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEFCC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 07:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiATHrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 02:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiATHrT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 02:47:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6EDC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 23:47:18 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r132-20020a1c448a000000b0034e043aaac7so3397743wma.5
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 23:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=cYKBxaw3FQhlol8rd6NwYL9c5qSIT5hxOyYVatR0UjM=;
        b=Zd/DfdCjT2OjSS0kPcBaVkHAoJgGrgCr2bI4nIyd3j8yLit41ti7vJ+px8uZArTvZ/
         JCIcUCEY8MT1ZovYkc02O2ahYnj+nI08HyYyjZisuFlQxXQOAtRr0lQzMsVofHskeYG2
         cgtSmVMrEtC3np0OOdhQAouZV2iuot11MZ1fnPVYeEmTc36Lfhb/chZ5R6zYquqYTX9F
         Oc1TW9HdZT+1NPVuphgYMhNMEYondlTaRXluSKOpVhhwAzU4gk66/8a7X9ZyEEBEhVRW
         Rx8E7ElBlmfst+B2Ey5978XvfXnDHLeqvqPuwlIXfTlpJqmZQljm9piCsqyNIcAdiKxk
         35ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=cYKBxaw3FQhlol8rd6NwYL9c5qSIT5hxOyYVatR0UjM=;
        b=R6s/C1YI9+9jhMCQH1PsQh5y78gGcdnoJROLsJR0ec65IRIE0T4iH9nbsMAaJRYdho
         TpTCVMGyU1oeE3AnETSHzDRnkEBxv8d/XNaAKVUxCiuE3p8hyLW9XENwmMaImlb9E0BC
         wQJwuZs3YjeqtLgl+c0ZSCArpXaX8bS20+LtpacAwllaR1hiruCnDdABXx1aS87PH6nQ
         CSyqI/5yFBWCiIx8LmIC6QE+DwgETn6owKKaUiSU/RLPc3+Etxat+4bcT4ZidyffxVu6
         nhyYWhX8ycA+Ia1kquD+fZXfge5+u1lnpxkkZjRMH0l4+mW0tk16YdFNOreuiyxw5NQq
         98Cw==
X-Gm-Message-State: AOAM530uIRlFdGYVjskANVOni4zAmsHpvMGGrvR2cYvBxYzUMEvY6FMq
        muOd7NCdeoGfxf2ZI807UiSMwqEilzM=
X-Google-Smtp-Source: ABdhPJxYdJuuzIMbSQlfUoksxVwR8rQdJ7fBVON6xurFDmitxl19gmEZu576bgEXmoE0oLy5t3DdxQ==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr7548109wmc.0.1642664836882;
        Wed, 19 Jan 2022 23:47:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm3101478wry.45.2022.01.19.23.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 23:47:16 -0800 (PST)
Message-Id: <pull.1200.git.git.1642664835.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 07:47:13 +0000
Subject: [PATCH 0/2] Fix some old memory leaks in merge-ort and builtin/merge
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes three memory leaks.

The first comes from a report at [1]. It's a leak in merge-ort that
pre-dates the remerge-diff topic (technically traceable back 15.5 years ago
across merge-recursive.c history) and is triggerable from a variety of
testcases. I think I may have overlooked it previously just because there's
other leaks in revision walking and this looks like one of those.

The next two leaks were ones in builtin/merge.c found while fixing the above
leak; they are fixed together in the second patch.

[1] https://lore.kernel.org/git/220119.86pmonn2mb.gmgdl@evledraar.gmail.com/

Elijah Newren (2):
  merge-ort: fix memory leak in merge_ort_internal()
  merge: fix memory leaks in cmd_merge()

 builtin/merge.c |  6 +++++-
 merge-ort.c     | 10 +++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)


base-commit: af4e5f569bc89f356eb34a9373d7f82aca6faa8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1200%2Fnewren%2Fmerge-leaks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1200/newren/merge-leaks-v1
Pull-Request: https://github.com/git/git/pull/1200
-- 
gitgitgadget
