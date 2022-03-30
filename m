Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7F4C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 02:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbiC3C2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiC3C2e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 22:28:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A0A59A5F
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:26:49 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9so13667505ilu.9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lHonjIbhiXpAgCQKfsvFKeXhpE46mCXIFc8qZ9dF8Hk=;
        b=rUG93ijrqStApYiqepzB6z510x4+W0SBA4XgtrrDcxxneUfyUveoeBM1u07EecYPYm
         IM6u/6s5tO/YY+le60PjKUL9G62S3JxDLAbQjFF2rP7D6dqpxOcMhfRST4IwQ3t1Bdhl
         gi5lnqY64TzYjL9lcQvlXaii2nmJAfHpP50wlRy6tLYZQ4pnBOoElynIHPZ8xGCW56NN
         nCnPwxMCfjbF/Yz2sMHgOGlT2tmg40MJ/WqWKdZzc24y97tW8+kSCbrQrwV2nhe2FKj3
         WBP9VoWx9YPgQM0C4/ebNX4pzN0cM7TVnvPDZ7/DnvRqvyugLBnfqJ4Ebc7X5EQAzh8C
         GSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lHonjIbhiXpAgCQKfsvFKeXhpE46mCXIFc8qZ9dF8Hk=;
        b=Y9jCNPeV90wA01AjgQE8qXXb+/p6J+eW138+wsQYOM9CLaDANTDd0k2Lt/jM/vpFVe
         InVRlyA+T+CZnPTrTKy6VaEL7XoRAMfnF0EbiE2YkMOmNGL1T4t/OqW2RyeZ/ojJHRL3
         cIXMMw9iyiC0aEWPraialiqnJjhAxqOZIfdrIa7wqVzBaSZi5B7GK0aivfTZ6XVB7ouC
         25tawdd3fZchqCjScqXJJfle7CpmdcVhhJacHGfhiUp/CamwDUCiGVcAmVWuqbPY7S1r
         ajUeYUWowb97/QK1EVEMWEnKtAIyRnQqsfTe/hlvH433oqGrIPq5AHVpjNHUt7kPIv5x
         KUlA==
X-Gm-Message-State: AOAM5303pUOki3DrVFxtyY15Zw6W5Ql+9W+PnChMIlgeKMFW42PoD5tu
        3oUTJdVPT3fXgiDS1wpzPoEytg==
X-Google-Smtp-Source: ABdhPJw5uvdibfkvTaxpNL2/KHCURin5EwK7cKGzD+cP2Wqk/MzPhIG4wGj8EmBQCYXZ7S6ReMpAxA==
X-Received: by 2002:a92:c9cd:0:b0:2c9:ced4:c490 with SMTP id k13-20020a92c9cd000000b002c9ced4c490mr3844648ilq.57.1648607208686;
        Tue, 29 Mar 2022 19:26:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e15-20020a92194f000000b002c25e778042sm9604032ilm.73.2022.03.29.19.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 19:26:48 -0700 (PDT)
Date:   Tue, 29 Mar 2022 22:26:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Message-ID: <YkO/5/TVQvqyVQly@nand.local>
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
 <Yjt6mLIfw0V3aVTO@nand.local>
 <220329.86lewt2kqp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220329.86lewt2kqp.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 11:03:14AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Mar 23 2022, Taylor Blau wrote:
>
> >  	/* Boolean config or default, does not cascade (simple)  */
> >  	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
> > +	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
>
> If this ends up being kept let's add it to its own commented "section",
> the comment 2-lines above it is now incorrect.

Thanks for pointing it out; indeed that comment is definitely stale with
respect to the newer code. This patch was just a sketch of an
alternative approach for Josh to consider, so I can't guarantee that it
isn't immune to nit-picks ;).

I think that Josh is planning on picking this up, so hopefully he
doesn't mind applying these and any other touch-ups locally before
resubmitting.

(Josh, if you do: thank you very much in advance!)

Thanks,
Taylor
