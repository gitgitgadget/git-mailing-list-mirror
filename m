Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FA4C433E9
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95CF23884
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbhAHOh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbhAHOh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 09:37:57 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99BC06129C
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 06:36:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d13so9175091wrc.13
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IplanKWoNuYpePttOBjIqsk7GiwWzSbEGRv5in1w3Ao=;
        b=keA51QhwrwkrGZYUWkiywztlEoTsIrWDZwQxHStXqUe4byGKw4Zn2kHkHn3K976tQM
         PVofQJ0DQte8SJ3gU3nR5/l7E61xdE8YGYS31zqeKQk/vWnHetw72Y5EhrsRT/sng03G
         i15HyCH9Stb78NOIdPNEdyB/O5avqQYkSOqWLnk+bVjHRagTlAnBr1vtrB90Hhczn3A2
         PenNYPsDdHhMaJw6leZaiIWkjOsqxy5U2ODWRkdObvRY/eqBaEC9Tg7xDaUpkykJm11t
         iJiQwqqzwY6dHMZhdqwxj0CoZRorl2zc//iu3rrhrk3d5zzFKTUBUUzX5ygc53ep99hC
         /uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IplanKWoNuYpePttOBjIqsk7GiwWzSbEGRv5in1w3Ao=;
        b=Dn0l0PXFF803aw4G3E4P4wYy8QKf1GDrgBAJq7cZIml2Odh2YjEdX/uFnAXempC6cM
         HuSmSazCizXUXwGh5ByUREgydzRcmKhbNemjU//j1ppaXx6dVLHTa+hO+drTLuMysOpX
         6zXheQCCJ9tPBcM3RDfxw01fqmA+dIqEABOS5iy3r3s6h4ttv21zRwZ/kuOQONJ2zvNi
         IoKqb1d6btqPhWeTROY3Yv+5G7qFJ/4h0AbJSoGN3z9R21NbbPePBoVo1HCl5+MfVUvx
         jddHLr14/5DYcordeUCFRuznhe2AsPxeTFgVSEevg+M1BkWh/Sc42HYY+tPxtprXBHui
         9AOA==
X-Gm-Message-State: AOAM530JTrjJoaWPrGQg6nUn2rRQ1n2O/jb0zFu6RBm/1RgBD5frrWmQ
        1e/0mIwZjnx4CqGxyTUOo0lcKXoKhZE=
X-Google-Smtp-Source: ABdhPJwvvROeSloFfbtnrIN4v9+29JY9RZM35ruI2oDFrFEBbc2miV1BQ40bnYdwmtxMOBqVm9CIZQ==
X-Received: by 2002:a5d:6884:: with SMTP id h4mr3975256wru.174.1610116601240;
        Fri, 08 Jan 2021 06:36:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm12073490wme.4.2021.01.08.06.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:36:40 -0800 (PST)
Message-Id: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.git.1609923182451.gitgitgadget@gmail.com>
References: <pull.832.git.1609923182451.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 14:36:37 +0000
Subject: [PATCH v2 0/2] builtin/ls-files.c:add git ls-file --dedup option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am reading the source code of git ls-files and learned that git ls -files
may have duplicate entries when conflict occurs in a branch merge or when
different options are used at the same time. Users may fell confuse when
they see these duplicate entries.

As Junio C Hamano said ,it have odd behaviour.

Therefore, we can provide an additional option to git ls-files to delete
those repeated information.

This fixes https://github.com/gitgitgadget/git/issues/198

Thanks!

ZheNing Hu (2):
  builtin/ls-files.c:add git ls-file --dedup option
  builtin:ls-files.c:add git ls-file --dedup option

 Documentation/git-ls-files.txt |  4 +++
 builtin/ls-files.c             | 41 ++++++++++++++++++++--
 t/t3012-ls-files-dedup.sh      | 63 ++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 3 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh


base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-832%2Fadlternative%2Fls-files-dedup-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-832/adlternative/ls-files-dedup-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/832

Range-diff vs v1:

 1:  0261e5d245e = 1:  0261e5d245e builtin/ls-files.c:add git ls-file --dedup option
 -:  ----------- > 2:  a09a5098aa6 builtin:ls-files.c:add git ls-file --dedup option

-- 
gitgitgadget
