Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9AAC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 06:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhLJGZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 01:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhLJGZq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 01:25:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEBDC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 22:22:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d24so13355527wra.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 22:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=i/fghHjCiIadjUueQ17N41If+D3+LOUkEuqsEDtW9G4=;
        b=mU1ESjNN3C2/BD1LpczgE619B22fNY+Nj8D0tE2eXk8TNyseM2NIKsisO/OQWya08f
         OOqDC0YXOgZKlCfTSuOd3gQxpAM0DFRoaj4D4O5U8zOOpyO2ODkh8jR+Foc3tEJ9aaoC
         E6GVNljUIBJyUDo4/Yp5wBYDOfvfFmdC9rn3UUtZec0Cp/4/sgNpd0UeqoJLI6qO6Gk3
         YWV6p0xocwLk0OfF6k0q+zZ5In0mqnQzp2uuP4quqKZgQoYG5wggJJaRXunegf+Ik7v3
         ATOEwfT0tDC54y84L2SidwEhb/eVA80KYME4iKAw5keFrvBlZ5LgY08pr8GcDrY9R10/
         EXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i/fghHjCiIadjUueQ17N41If+D3+LOUkEuqsEDtW9G4=;
        b=AxdzkEGIFVkj9rz2Hw9CXLnbo2G9YPWGf2gYCaekxcQDHwXIt3XutsnYbf/YTJxhTY
         fojgDa7e+E0LVQPW7f++afQE1DFd0uFFBvknb6RqVB2xc+4X1y/PL9760rZ+WcHF94XH
         ZIaa4ppPy0whCxVygI14+dvfByW56DbqooMwVuEZ3MDHRSRICOAVeNhbE4KE1+IfPrr4
         YTzOTZYzvC5lp+Tud30AzZM1aAxnGA4paNuWUSctzngMiS1RmFuvQf7WieF9AlWBogtH
         KcsfyXDYlg4ZBFdozNyAUhbBkaIL+tqoIE0cf7ECunF82HLAR5MzKLdTbqvPkEXxUEqj
         jZkg==
X-Gm-Message-State: AOAM531I7rp0YKH+i8Y6uo61MWkJxsvFSWLwX5BY7Ok0eEHEBEP7U8t1
        TbuNuLRP7WcPppbaMaOV7JzH4MDiqAo=
X-Google-Smtp-Source: ABdhPJyIvBJNLwMZZF4hJWAIru5MipxcJkLiNgxvyUZ6PDHnqntWy98JZlXP31h+GS7ZR8bYy4NXLg==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr11759937wrp.209.1639117330788;
        Thu, 09 Dec 2021 22:22:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm2212654wmq.20.2021.12.09.22.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 22:22:10 -0800 (PST)
Message-Id: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 06:22:07 +0000
Subject: [PATCH 0/2] checkout: introduce "--to-branch" option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes people expect to checkout to a commit (or a commit which tag
reference to) and develop on its corresponding branch. This may take some
steps:

$ git checkout v1.1
$ git log  # search for the branch dev1
$ git checkout dev1


collapse the above steps into one step:

$ git checkout --to-branch v1.1
Switched to branch 'refs/heads/dev1'


This will help users switch to the unqiue branch quickly.

Thanks.

ZheNing Hu (2):
  checkout: handling branch_info memory leak
  checkout: introduce "--to-branch" option

 Documentation/git-checkout.txt |  8 +++-
 builtin/checkout.c             | 49 +++++++++++++++++++-
 t/t2018-checkout-branch.sh     | 85 ++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh          |  1 +
 4 files changed, 140 insertions(+), 3 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1095%2Fadlternative%2Fcheckout-w-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1095/adlternative/checkout-w-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1095
-- 
gitgitgadget
