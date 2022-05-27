Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CDAC433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 12:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352487AbiE0Mbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 08:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiE0Mbe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 08:31:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF93522E7
        for <git@vger.kernel.org>; Fri, 27 May 2022 05:10:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g20so5139183edj.10
        for <git@vger.kernel.org>; Fri, 27 May 2022 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ln9aY9KPu0M/s0LrkU0Flc8FYUdtu5dMAlci696znAw=;
        b=CMC9TC1Y0Ps/7cMksiA/EAS+f0COD3TIGwJpILunkX930Jk5nXibImay6EKBL2JOey
         hp2xAG/RWBHFBMGDZIi/9vOmpswTqjrYs3Zp55Fi+oCreHftLq4b4//UjmX4sPXuwOEp
         sS1Ga0gAE5Ecnsg7Ix1Wj4Cq+4SAaXprU+SKcoYKC/mbyaeOOnOyHZ1FMhHsoHHME2KZ
         yyd+qSbqg/joaL/Pd3EkHJWY3dusJ3+4Fj0pehBcfaZnUYhza4ioi1QXelG6dQGH/4Fg
         wJtzp5qnOYCkut5BZJKJ/3b51wZTDrdvxNAkmpDTTyMp8Y/0y8rP/LqVNUe507jGaLlC
         GsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ln9aY9KPu0M/s0LrkU0Flc8FYUdtu5dMAlci696znAw=;
        b=Gs/FcWL/p9hgYRZKCwplKLA49Jxx0lY03Bf+z647W7Fus7GtiLY9Zu9/Strn2h1Byr
         yJ1smbRez0KPvEq0his6XepqWN+XzaOQju1q1M7YxWnCFrfiLYd+z9jGe3OJd97VjD0I
         6vxnCUU0TFpG2VdSQ2bK93ZcrDOW8h4FYygtUeo1QlGi5SF6i2tfFbD+qiYh6Gk6zUjQ
         /OLMoD+3c96eII8Cyk/28DWlsX2UCS+t1liwOKBbIjM9EnUFfiKKz0jrIViLDrsF4q5f
         8VpF82tJ7YLjy0lpoZqfzs6k5v5Ow2qfPn2cfOQz8RY/VbSZ96on67DNW7JQYUokPx7b
         b5AQ==
X-Gm-Message-State: AOAM530IxT4AzEJwNOFteKabqHCpi46Ps8ZyvjBDaOalfCpukSCAKHzP
        uCMr6DDBq/MMNopF5F3uT23O2G3hcKAfaQ==
X-Google-Smtp-Source: ABdhPJw8b0rpRGvDUxl4YiP0A/iSWgq0NtsXMW5zgunKXzDCe3annyDQUwv1ZlAD6tpX1lcLlS/KuQ==
X-Received: by 2002:aa7:d557:0:b0:42a:c6a0:7c28 with SMTP id u23-20020aa7d557000000b0042ac6a07c28mr45204522edr.426.1653653442952;
        Fri, 27 May 2022 05:10:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z73-20020a509e4f000000b0042aa23fa93bsm1988012ede.20.2022.05.27.05.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:10:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuYnh-000Rpv-SZ;
        Fri, 27 May 2022 14:10:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        gitster@pobox.com, newren@gmail.com
Subject: Re: [WIP v2 5/5] mv: use update_sparsity() after touching sparse
 contents
Date:   Fri, 27 May 2022 14:10:00 +0200
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-6-shaoxuan.yuan02@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220527100804.209890-6-shaoxuan.yuan02@gmail.com>
Message-ID: <220527.86sfov2n26.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 27 2022, Shaoxuan Yuan wrote:

> +	if (sparse_moved) {
> +		struct unpack_trees_options o;
> +		memset(&o, 0, sizeof(o));
> +		o.verbose_update = isatty(2);
> +		o.update = 1;
> +		o.head_idx = -1;
> +		o.src_index = &the_index;
> +		o.dst_index = &the_index;
> +		o.skip_sparse_checkout = 0;
> +		o.pl = the_index.sparse_checkout_patterns;

You can drop the memset here and use the designated init syntax
instead. I.e. "struct x o = { .verbose_update .... };"
