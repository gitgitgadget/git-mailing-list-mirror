Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1B2EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 15:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjFZPLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjFZPKr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 11:10:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9556E1729
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 08:10:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f865f0e16cso4416195e87.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687792199; x=1690384199;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=98UGvHNn3iQDevVZoKUviNSdCjgIzo6thGjuHplJVdc=;
        b=LgEi1qJKPf4FFVkFwOoEf9lnhMG3udazavZizqBkw+GvTvYJkGWfa0+JQfj5qDBOob
         qAOEkNZ3guC6YSZBJQ/4TAi2iI41QedrwhAI6GxRWFRVq7F9q3reRuO7hUCr/yXfOfxx
         Iqt8D9FhG+6y0BRlSOJ5TqUkgzUrhtOy376o30i98B5V5kx4TuDNvu3V0rRcGh+nGTgc
         jV5YPjZLe7GQ2p2HQjc0cB+6ql5MuJE24NEr/QuPaEn7CduYjs8QRpP3pwvhWmiGu4jc
         hNbuuwSv2ycFizh9PJL1gtJ0VZjaA9AtWmRVuU9ArmmczGXbni78KeuXnrR9/z+I98tt
         XRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792199; x=1690384199;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98UGvHNn3iQDevVZoKUviNSdCjgIzo6thGjuHplJVdc=;
        b=M9PV6b9JaVa6aFuOWtULbispXqUkVIRqcHckro9mKzygi8TSq6tkiLd42mXQGy/65u
         ZeMsWUqToG5QpILf2XIpO2vUEcEW9qko9y+qFGnB9KUwk0e5sTnDcA7YJNMc56lvOll8
         dZu5YQw4FTJZP9T4/FuxcTFal8W2DRTlsatqzclqL3svIcqTGT5349iuJv9xwKhnTDN5
         zMKMMiPdfr9zRRWwWqaD4gDMhDRwW5ml2XGiDdAWG20Mg6m3FeQ42BdsbyEHmk09vYAA
         6QzheSsBeOTHbu/+CHsiMAYlMEKB6oTnzD+aKXKM94eu+0Y6LDDVZAcEnAp8STIxIBCx
         4epg==
X-Gm-Message-State: AC+VfDxL1Vt/yjmkDG/gqAHySXFi00DTrWODxJQdXgn4+yuiKOtaU/c6
        07YnhodGyvjcp59KCQJfU0pmQj9UVKo=
X-Google-Smtp-Source: ACHHUZ5Pu5sufO99eNJPam0cjnnj9/IIXY7pD2cRAObGKpiWOTljkkFGnGQ/y6DMENJRN/HVKF4RDA==
X-Received: by 2002:a05:6512:44a:b0:4f8:5b97:c74c with SMTP id y10-20020a056512044a00b004f85b97c74cmr14572084lfk.16.1687792198401;
        Mon, 26 Jun 2023 08:09:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c205600b003f8044b3436sm10858616wmg.23.2023.06.26.08.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:09:58 -0700 (PDT)
Message-Id: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 15:09:55 +0000
Subject: [PATCH 0/2] [RFC] for-each-ref: add --count-matches mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com, me@ttaylorr.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm leaving this as an RFC for now because I can't decide if this new option
in git for-each-ref is good or if this needs an entirely new builtin. I'm
open to whatever people think is best, I'd just like a way to count matches
based on refspecs.

Thanks, -Stolee

Derrick Stolee (2):
  for-each-ref: extract ref output loop
  for-each-ref: add --count-matches option

 Documentation/git-for-each-ref.txt |  5 ++
 builtin/for-each-ref.c             | 80 +++++++++++++++++++++---------
 ref-filter.c                       | 47 ++++++++++++++++++
 ref-filter.h                       |  7 +++
 t/perf/p1501-ref-iteration.sh      | 35 +++++++++++++
 t/t6300-for-each-ref.sh            | 28 +++++++++++
 6 files changed, 179 insertions(+), 23 deletions(-)
 create mode 100755 t/perf/p1501-ref-iteration.sh


base-commit: d7d8841f67f29e6ecbad85a11805c907d0f00d5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1548%2Fderrickstolee%2Ffor-each-ref-count-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1548/derrickstolee/for-each-ref-count-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1548
-- 
gitgitgadget
