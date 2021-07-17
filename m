Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A0C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409E061154
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhGQSZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhGQSZg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 14:25:36 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3284DC061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:22:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so13475709otl.3
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ol6EWq+evwTOndn3pEDtI7FxUOcNaVaur9mPSpr8i2U=;
        b=TD0imX6IzFgSbRiNSwr4hKMizEfNSAlRfxmiZYh6cOJnBhHA1ipj9HkVCHEHlAtduM
         aYRhTioKqc5dblnfM3yNKaQRMpu+pICG0+Q12mpWC/rh/vVqyLOJ/OK9VTBsw0InMIl7
         donFJ4GZnV4sZP8B9XAX58JeuupoKI1C4VjkQy94z3OH2hyJjXrWFEFFIomJddRNwPa8
         2sclD5Xx+zLIm2dKXXtSBqm5fg7CJElE8HF0WfuWm8lVwVBFTgJiEkcKnYiJsNUTzJw8
         LsO8cIE6EO/f9lkQGTVtH3D7avSad/nGIOdenbj+v71ocM5JvlCi8A1BqViDLYc09S+e
         sssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ol6EWq+evwTOndn3pEDtI7FxUOcNaVaur9mPSpr8i2U=;
        b=F5v5uYcKo3Y7uMKtuyKUEqKyqWk7yuSrQnWT4p1kcSdDrM1HAgyOwbcl2EbcMyLEyy
         onOTHOxaI5TdxnuvGHdw/kW6q3JDd5XUZ/OicZx2jK3dn1QBVe38YS/VpVueJyAFA4pQ
         rhNkQlIXNw3upDVvUQZx3w7Z/Te02S3K0zOsD3OMlBqvS7QdOIUZiNK2MVW8TuI3vM4q
         37xSbzu6qbzsBdjCFZd0NaOTIyX5k/K9aDqJFerZhZgq0rKV8b6/FcQAlPw0q0zOJBhW
         nEJMzaWMbs9rloOk+7D3/TX/KKpoc3g0YLoiXeqzKb5sDFucn1ep70GUKcpkoFTcA+wB
         NyzA==
X-Gm-Message-State: AOAM533GViVSok8IlCHQQcDDDXqvN7VRCwKa/dc10A669MGbMDMypPey
        h/4EvvCkenbcul4Fd7hFltg=
X-Google-Smtp-Source: ABdhPJytuaJU9+phZFRqDtzyG0ylgirkemgzHlxtKj63dCAzzPSi/AmBc92zakhHvVFEJGtYP+Qhvw==
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr12689795ots.246.1626546159430;
        Sat, 17 Jul 2021 11:22:39 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id x73sm2454292oif.44.2021.07.17.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:22:38 -0700 (PDT)
Date:   Sat, 17 Jul 2021 13:22:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f31fedbbd67_25f2208d@natae.notmuch>
In-Reply-To: <de4b460b09d3a3b6848f9f9eaa5520b31a3b453a.1626536508.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <de4b460b09d3a3b6848f9f9eaa5520b31a3b453a.1626536508.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 4/9] pull: since --ff-only overrides, handle it first
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> There are both merge and rebase branches in the logic, and previously
> both had to handle fast-forwarding.  Merge handled that implicitly
> (because git merge handles it directly), while in rebase it was
> explicit.  Given that the --ff-only flag is meant to override any
> --rebase or --no-rebase, make the code reflect that by handling
> --ff-only before the merge-vs-rebase logic.
> 
> No functional changes, just making it easier to verify that the codeflow
> matches our precedence rules.

But it does have a functional changes. Now you are calling run_merge()
without update_submodules().

-- 
Felipe Contreras
