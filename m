Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EA6C678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 10:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCGKXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 05:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCGKXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 05:23:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935A360B5
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 02:23:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i34so50189547eda.7
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 02:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678184596;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76rbOh4eY6HDpQsB7c8eAzROChnYF3pnfSIQN7Em3Pc=;
        b=SIoPf3Wc6JfcoGyyT8BDuovZOqOr7v0zO1oEL2z/jie9LmLOP9PaC4f91JWWeYOpQK
         oE5u47oS1zENdE7xucquWJreVh+yQee1XQsdq4X3GDRpTOiP2hkL0W+VGY2tBiQbJfP0
         BVG/UUEiBoFrJLkNhPz2M8X1RRALxr+2+cNb3me5oJZtvECd+FE5dacXgBdY9UJQDqbC
         jMjN4vKqQ64b28Ucf+TdqGFFaR5Kcd+rk4a1mFNZLt+6oDmr3nBvwO+n1OGIIySdFmdz
         ajenJx2kvtB5SpiOfe4G0EOSYsvWLAfYZQdI2vTuSptMSf1waXq8zKwdejzgZyAzVfR7
         MAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184596;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76rbOh4eY6HDpQsB7c8eAzROChnYF3pnfSIQN7Em3Pc=;
        b=JlAv8keBT5uC3yPBRl1fn+4Ch2/Md7AoyoFgqPhGMIXCfOzaZ9fs+s+0yK+yFNCmfh
         yynia/xqd0Ncu2LplZ1gA/Op/y3au2NYGK4g31XXUUYcGaQaA4Wca5iFY2iMojWHGzcp
         1/Aff177dZuejf+DtcnNlTRicbxt5yCwL0Cw2Wjwb6TFbPpQeifqmJ/BO0fv2saQ4dUX
         ES4N1zJxH7NjA1pU0nwm6Z6gRFFnKywhALcM5yA+i3ZBcPFL9fKGXgseHojoVMLavBGP
         hl3RRGQWeXAAOSUPge6KgO8FgfxKwPRnrJmLBBhqA/PFzZEDIgiJCHSDNZGYJCymqGlI
         ARgw==
X-Gm-Message-State: AO0yUKWFfnYblRTw4zOoYR3VqB/DTIMNH/7nEFEhMTtHb1VBiCkXpfKN
        /+Rx0WSvJZd4/yYoTCcOpPzGblCnCUw=
X-Google-Smtp-Source: AK7set/baPKqgHEEQzEFCEkxwBRrJmcnysKoAyyTDFK+GtGK5KKIGABniNn+I2sg2Mm0f1nwlY49AA==
X-Received: by 2002:a17:906:af18:b0:8b1:2dd3:cb45 with SMTP id lx24-20020a170906af1800b008b12dd3cb45mr13414417ejb.42.1678184596387;
        Tue, 07 Mar 2023 02:23:16 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090611c600b008b17eb06282sm5866718eja.213.2023.03.07.02.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 02:23:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZUTT-000bG8-1j;
        Tue, 07 Mar 2023 11:23:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v9 6/6] diff-lib: parallelize run_diff_files for submodules
Date:   Tue, 07 Mar 2023 11:21:10 +0100
References: <20230209000212.1892457-1-calvinwan@google.com>
 <20230302215237.1473444-1-calvinwan@google.com>
 <20230302220251.1474923-6-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230302220251.1474923-6-calvinwan@google.com>
Message-ID: <230307.865ybc273g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 02 2023, Calvin Wan wrote:

> +		if (git_config_get_ulong("submodule.diffjobs", &parallel_jobs))
> +			parallel_jobs = 1;

Something I missed when eyeballing this in my just-sent review, here we
have a "revs->repo" already, so let's not fall back on "the_repository",
but use it. I think you want this as a fix-up:
	
	diff --git a/diff-lib.c b/diff-lib.c
	index 925d64ff58c..ec8a0f98085 100644
	--- a/diff-lib.c
	+++ b/diff-lib.c
	@@ -312,7 +312,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
	 		unsigned long parallel_jobs;
	 		struct string_list_item *item;
	 
	-		if (git_config_get_ulong("submodule.diffjobs", &parallel_jobs))
	+		if (repo_config_get_ulong(revs->repo, "submodule.diffjobs",
	+					  &parallel_jobs))
	 			parallel_jobs = 1;
	 		else if (!parallel_jobs)
	 			parallel_jobs = online_cpus();
