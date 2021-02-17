Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158B4C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F7664E42
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 17:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhBQRXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhBQRWx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 12:22:53 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD8C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 09:22:12 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j19so22821187lfr.12
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 09:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ryw6fMkzih/5ohfUp+piokOLJBRcOR0sTqvuOdzt0oc=;
        b=ouOIVLf5Z9Xq+u7Arb6NM+Q0uo/cpCqr1LuycmJV54scb0mvUNr1gzEl6iNJXtUjjs
         GalszDaosHIaw3nPW1WHULOl6ggQLaLS0Ux+DKWNgq6cUuip5WTYUVzrosSaR+sKg7IT
         7VoFIpVxLh/yk5cbDlaAKeFWWJq5gXYNg4Z1j0/9u9qZbcubXC9831YoyCiYYQXLIijW
         xR+XKHi0h1b/ryP/DAKg3wuT6m95lBo3SSH3c65Ov4tO1Oe/qiVCXElewp+LiIgv273u
         rxStISzD3zfiuL3++OqV2Uo7hEweflOsht6qDQ828P/P9z5lVh2KMgzsSZSEBdldzh5L
         Ymvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ryw6fMkzih/5ohfUp+piokOLJBRcOR0sTqvuOdzt0oc=;
        b=djTtX0ZrIiWx8Z+IF4pg/orsl61rdabdD2nOhhJUjtZYtqB6gPDsIpdKf/IN0q3zqg
         vRhNeRSMM8E+Yb9V7C6lfXoeHX2zlb/rxy/AuKKL44iRVsB3plhsCCHoL8YcdPu+eDQY
         j0ZLg8zoeDN6ELVPU8OurwWuaovqdi+e/bNrX6tqmTRGXuhc8TbgbKQW5zCUzDi0Jp47
         qjg1tJWGuqoKO28GLtry8v7wZiZP+EbI8VWK0wv67rVs/IgAy3j/ah1TVtOEtLs/uEV4
         v3AxuIA8cMZ8uhG+Kh5GX8yUD/ko7JmPkqnKe9pUV/c8ghyE4RefohwOZX/dG0IgIRMe
         9LHg==
X-Gm-Message-State: AOAM530DMVaBdi2HPgAlbkKaUXTwFKO964FtqByrzs4/w0Pxmd8R6sQ7
        7PNdH0hJBzeMhsKvidBbbfQ3pg2fHkZ7FvIuksHi7VdoP1lrsz24
X-Google-Smtp-Source: ABdhPJwl0f2a0IJ1OrIq+qb8CmMbaN0eFGWOMv9JegkkHsKEMXrNnWTkRqTqpMpjhur8aU+nBBMQTsgKCNRvp0fBYzY=
X-Received: by 2002:a05:6512:32a2:: with SMTP id q2mr16421803lfe.237.1613582530825;
 Wed, 17 Feb 2021 09:22:10 -0800 (PST)
MIME-Version: 1.0
From:   Alireza <rezaxm@gmail.com>
Date:   Wed, 17 Feb 2021 20:51:45 +0330
Message-ID: <CAD9n_qiN+qXqR79z_4d+_8_mxa9eTFB42sTUT8CTF8=oQArQaA@mail.gmail.com>
Subject: Considering merge --dry-run to foresee conflicts ahead of time
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a half baked alias for this and it proved to be extremely
useful even in this state.

```
check = "!f() { BRANCH=${1:-HEAD}; BASE=${2:-origin/master}; git
merge-tree $(git merge-base $BRANCH $BASE) $BRANCH $BASE | sed -n
\"/+<<<<<<< .our/,/+>>>>>>> .their/p\"; }; f"
```

Of course with large conflicts it gets less useful. Getting only file
names from the patch isn't straightforward either.

So my question is what are the downsides to introducing a `merge
--dry-run` option and what would it look like?
