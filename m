Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4BAC4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 09:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D4B61373
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 09:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhHWJsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhHWJsX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 05:48:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17D1C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 02:47:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id q3so25320233edt.5
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 02:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NhNa0cCneTwbazpiYe+0PpWU2RvCiaYuIgQ5DFifFnA=;
        b=luo3pA346YljwHFbXcZPUmaoE8uBqeYgWbVIErdtT6Fci64bMuhI8bmp6Wot+ZFKBe
         LC+tarr5QL2k96es39kKroWFmdfUbOfTCEPXOI7FkONEgWiIvMe0RWpuodG/iFYob0L5
         lptrszYHCqF/OCV8hwZESnuyGQsUggMF45VQLs7Iw5ULIe/dv2Av89zE4NB/biRogN8J
         O2lYh2RZc7M+HAEnVc+0nBX532p+qD6vbSOfRyLfPldtREiUEMUMCL6llUG3gWtEzqHd
         EjAvlLsT2N2dJkcf7khgvZvmNRdbnVzPdgXUmzHbnbj+ZyhYrm9JykLIe47NHxaUHPFq
         DrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NhNa0cCneTwbazpiYe+0PpWU2RvCiaYuIgQ5DFifFnA=;
        b=CFa4cDUKm1bCRVAlZDou9eICGsngrqlOz/f7brh4Q6pbMBfYJb+tnDKDfhg6fSv6/e
         D6EkItv73w+9BsJl7htzlzmHMLT9/LzDZ2a2o7aOGuGoicUbzEmKl4bAJK952F5EqoG/
         PhtZxMK/t7xAaa9DQn69ttzGVNpuBWbjBhAyzNiXuGgnXvy/MCvYZsyS2AG0KwpsRZ2W
         stIvk3KsQViZufbPsKLvD94L1MBSfnotqLN0DLoFTgj+Z7FIEaTcpE6HvvyOgArhtzcU
         Q14fhAtkySPWqnu9jrBaF409Wk77wypCl6T80sCEx9odkfNITOSo0X8yghdIEGTYtTC6
         THyw==
X-Gm-Message-State: AOAM532p7mUXhSzIkGTycvbzsMLPFK0SCGc96cblBIuppLxFFMx6qx65
        JZJhI95n8NMf5buLGz5kD90e5BqUAx/TJQ==
X-Google-Smtp-Source: ABdhPJz7rxmbinOEyQVcKB5qSm2TGc5IqF40YXT1ah3gBQ9+2y/dfhBZj4+J+QdECCmfdJZ0p6MfXw==
X-Received: by 2002:a05:6402:520f:: with SMTP id s15mr29960206edd.139.1629712059403;
        Mon, 23 Aug 2021 02:47:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b18sm913216ejl.90.2021.08.23.02.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 02:47:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 01/25] hash.h: provide constants for the hash IDs
Date:   Mon, 23 Aug 2021 11:47:19 +0200
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
 <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <cad3c4835a2945cfecc66da161fefa53d9c19574.1629207607.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <cad3c4835a2945cfecc66da161fefa53d9c19574.1629207607.git.gitgitgadget@gmail.com>
Message-ID: <874kbgh4qt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 17 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> @@ -164,7 +164,6 @@ static void git_hash_unknown_final_oid(struct object_id *oid, git_hash_ctx *ctx)
>  	BUG("trying to finalize unknown hash");
>  }
>  
> -
>  const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
>  	{
>  		NULL,

Nit: stray whitespace change that snuck in?
