Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A7ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 17:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiIIR6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 13:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiIIR5q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 13:57:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E0144976
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 10:56:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o23so935169pji.4
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=THzkfRTwQe4gzaO5q8d7iwNDxF/Q2IbdGP6ViGKUTzM=;
        b=LFWWY2SizuJNoG9SIXoCXdVjQEzt+ZFTN9ndCrQGjdTreCk9X0cPtw0+ny5dTcp/Ep
         sI+D7q81suCYtMUuV6t/ZL4T38S8/Pi+7chsNmE9mmSjzrLo46v1Qdi+c102uA7V27rZ
         DlpTaCpqbjCpJBvhkElK3d5mMGELy23zoykw1NEUA7cMXNYtIe4ro97g4FbFAIpqXwBq
         7vjv1oYk/Gzkzkmnw0BMmEqcSP4LG+3pGMWdA9UORY3RQGanyYCBAyA9/wq246MtSWux
         j/Ormz29boZpG4BSQAjRMbI8LhCDvYSVtMdPH9ms0MVC/fczSeh9ZtEcpNQ3JA8TsiUj
         fyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=THzkfRTwQe4gzaO5q8d7iwNDxF/Q2IbdGP6ViGKUTzM=;
        b=Z+VMovUcaF3H4RUOkCgDRtYcAitIjzn44ZgGvFTwPzKg+JahZohBQf6B1N2SzbHRCJ
         LBL16LhqaZ2k71PioumVhzlMdteLAwmZewm0ZC/TLOIygVbzaNiGJksz1yHNhqHj0Uwl
         Brx1DXTAbYVpR1tKjgaY76AnVwOR/6l9MngZsnwzMA7EFpCCmW45fmgLt3OuGWdbzU4g
         0Q3t0tgJw+Vs4huckPNrk0FS1S4aD4pXFY//xOMQlGF+O9uk6IKW/2cblLrKVLciFFK1
         tDfXFUkR4MZ7TmoMVc/uI5QBt+VcwPTNFB/hDjJ6z3v+gyxP6wtWC8LLoNOMj46v4FDQ
         o2SQ==
X-Gm-Message-State: ACgBeo2kTCkh6m6pdQYtSszioqy+6NnDs90DgzEhuLNlHGRZpLRloRR1
        +asQwxepJD7TOYqHE7T8pCY=
X-Google-Smtp-Source: AA6agR6DxuR+xYQ8HmaIA0gDxbwwe4waUuQBfIDwYEaT0mOMDR7o26RvcoFErAIGYbEbhUfxWzKRVA==
X-Received: by 2002:a17:90a:df13:b0:200:ae8c:700c with SMTP id gp19-20020a17090adf1300b00200ae8c700cmr11141441pjb.203.1662746186607;
        Fri, 09 Sep 2022 10:56:26 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b0016ed20eacd2sm755781plb.150.2022.09.09.10.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 10:56:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/9] bundle-uri: use plain string in
 find_temp_filename()
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
        <ee6c4b824c276364b77de0b85b54f428c236de00.1662734015.git.gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 10:56:25 -0700
In-Reply-To: <ee6c4b824c276364b77de0b85b54f428c236de00.1662734015.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 09 Sep 2022
        14:33:28 +0000")
Message-ID: <xmqqczc4l9di.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The find_temp_filename() method was created in 53a50892be2 (bundle-uri:
> create basic file-copy logic, 2022-08-09) and uses odb_mkstemp() to
> create a temporary filename. The odb_mkstemp() method uses a strbuf in
> its interface, but we do not need to continue carrying a strbuf
> throughout the bundle URI code.

What the patch does is not wrong per-se, but it is unfortunate that,
even though we accepted a known-to-be-racy approach for expediency
earlier, the first update to that is not to replace it with a
non-racy and safe approach, but make it easier to use, encouraging
use of the racy approach and give it an appearance of a clean code
X-<.

