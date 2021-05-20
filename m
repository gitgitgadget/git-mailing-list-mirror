Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E2C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2EEA6108D
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhETPnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbhETPnv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:43:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEC1C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:42:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so19895847edt.13
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=c2WZ4aNtTEvC/xmbWbQ6mleLioLKSIOXRZEqLCWSUGo=;
        b=HBao55yzdVVui+XnJZUTOR+3HwpaujjX0Q6Y4hfDuMjRNeHA1tm6StYI36qZeNsZjR
         cVV1ZAPYK/x09Mdxsj1QP3gAURnvgoQlyhMGABfGDvepPSom8nZrpvbawMMUQ3KjihrJ
         Y3W1gUyMDjLmmh11g5l1zCZ0fQ2K7E9A9ryGlp1+8XZIG2YZP0Jf5vugBJsCQF4jPW3M
         oN9PHQAAMaYkyuJpDuYFYYLZAlIRwrIMhTqR1ZbKunbBi2AG8jOj34s4RWx11DTmelxY
         /DpIJbEgMpW7vEvR6g2/ZHITKbT7R+IiiOJq86XWRQtWqATz6s8xbcCrwamoCuFYyZCa
         9oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=c2WZ4aNtTEvC/xmbWbQ6mleLioLKSIOXRZEqLCWSUGo=;
        b=bkbK1U56nznFZOud3GZXhsjcjuvVak945kIMpMddt6ipLz/ySwV3+zd9pbUqbuQO+h
         F1j1//uX7Bj7ZJAMm2rk8qsen/+XHZcl4uUktEYBffWYx1anlgJ1HPBBHhgkXSQb4903
         Jr8Sm/qECJeUTJiOybGp714M/c3PEhMxuLOsuuRD0yIoBfPqMaaXc/FHU0p4oBSFEfVg
         qX8kIszKIwOAoipka1kGZfZ9XLhrCQ2zI5fLG61sq1oc9dVdB8r7BCPMzQ4/Fktez3X2
         SDIatwtm+Mm2ixc4i48llojunHREAt9FnKeu+QdoJvnnPWinOvep2ysWLdGYtV9ysMvJ
         JqDg==
X-Gm-Message-State: AOAM530Konm8JuUi1mUQ/da0kQR4Q5vQG4xPxsPeAZmaSTBcSO6XKEIz
        2X5X3GTQMDajhuAEUaJMqSb6/FO/t8I2OA==
X-Google-Smtp-Source: ABdhPJw7ZqY8kjmsGWCVNgz80pETIVJi2PiO2AIP3dAPWFren8nGDWbdWAgc4rf35to7zQQkXgNrbA==
X-Received: by 2002:a50:ef15:: with SMTP id m21mr5563570eds.226.1621525347721;
        Thu, 20 May 2021 08:42:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f20sm1757226edu.24.2021.05.20.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:42:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 19/21] t7003: check reflog existence only for REFFILES
Date:   Thu, 20 May 2021 17:41:52 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <24dcf05d8fa6172d04ca047a860ad5019aad17b7.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <24dcf05d8fa6172d04ca047a860ad5019aad17b7.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <87h7ixpg2l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t7003-filter-branch.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index cf30055c88dd..e18a21895238 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -396,7 +396,10 @@ test_expect_success '--prune-empty is able to prune entire branch' '
>  	git branch prune-entire B &&
>  	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
>  	test_must_fail git rev-parse refs/heads/prune-entire &&
> -	test_must_fail git reflog exists refs/heads/prune-entire
> +	if test_have_prereq REFFILES
> +	then
> +		test_must_fail git reflog exists refs/heads/prune-entire
> +	fi
>  '
>  
>  test_expect_success '--remap-to-ancestor with filename filters' '

Ditto chicken and egg, but isn't this conflating "we always write logs"
v.s. reftable just behaving differently, i.e. shouldn't this be
positively asserting that we have the log *for that branch* still after
its deletion?
