Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6604C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 00:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiFNAFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiFNAFh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 20:05:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D59326F1
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:05:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x62so9336156ede.10
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ToHV1tu+HrwFdJg3HvTKYFQa7jlT6HaRhNJFyD9V4K4=;
        b=WuzJSwKihkC4m86TaY0To8rRzCnYebrRtJWk3A0jeDLD31MYr46bV5aakYPDPqXeIH
         r2eN5K/WQIV2b1CyaLuZrXRulbU6SZtyDekd6EgTjg0L8Zz/fvTsyEpFmtSoFH/gU6kC
         wqOFlkM0OImD26cEP3sxaHZ1of4qTNbaH+50ExEAofCqxT9bX5MLKYktPOcUCFQdRlgn
         vk2nalaLwBvpu/j/7SzJlGstMmqvfWHoN+0RiKPHf8Dll9KFSFGYX21+74PGZczjI+o1
         Um04+pcrfJ381YIvJR1judCPHWRAvr2oVwzAK0+fRCmDsTlore9V1Xkmf0A1+9+O7BRF
         SKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ToHV1tu+HrwFdJg3HvTKYFQa7jlT6HaRhNJFyD9V4K4=;
        b=Ifxz9lu1ZIyNFQ/p46Z2iW5n2MtS0Xbu4SfceKnOZ83+DJr92iDn6XQgVCMBT9wyU3
         tQyLWs5Z92JCZbsvbqVzUm7SX72mLlp61IeLH6dQ+JhAvGRosxjCOr0E66/KnF2SZi7f
         MEzO+irgBVfr4GxCFeEZT9hjwvDA9+3Kq98ikMwYJHsufoOHOeynDdGU8e2jpMIrkifw
         +RdqZMqCw1x6nLmH1JYI1GgQ0IbQ9B1rLsG3RwWAzhOVp09TY/zOPyDRSG+5BmZ0pY4L
         sRbblLodT1Bu1hwhmCat9kf4v5Ebxu+Tq4zxbibmOBfc/n1Wh+zshN1OvbydwMAhHlHD
         pr5w==
X-Gm-Message-State: AOAM530gHgdkSJqDaAlyxfD1Z2x2/6mlWBQu718NOxWt21xj+be3CVFG
        UtUhHxOhN1/ur7bKpvjKLoz0pE/0ixYBdA==
X-Google-Smtp-Source: ABdhPJwDMwCfwAqK+OCRh991h2h3lN1+8Thf7qUWMaTjsbjSoFMuXG8O4N3C1/ekmJt8k6M2RoaB4A==
X-Received: by 2002:a05:6402:100c:b0:42d:f407:b050 with SMTP id c12-20020a056402100c00b0042df407b050mr2619321edu.39.1655165133049;
        Mon, 13 Jun 2022 17:05:33 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s22-20020a056402521600b0042aaaf3f41csm6059578edd.4.2022.06.13.17.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 17:05:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o0u3n-000IAQ-NL;
        Tue, 14 Jun 2022 02:05:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        me@ttaylorr.com, Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/4] branch: add branch_checked_out() helper
Date:   Tue, 14 Jun 2022 01:59:32 +0200
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <dbb7eae390c90d4b710f48d8875bd7db0409aea3.1654718942.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <dbb7eae390c90d4b710f48d8875bd7db0409aea3.1654718942.git.gitgitgadget@gmail.com>
Message-ID: <220614.86leu0yur8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 08 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> +	path_in_set = strmap_get(&current_checked_out_branches, refname);
> +	if (path_in_set && path)
> +		*path = xstrdup(path_in_set);

Looking at the end state of this series there is nothing that passes a
null "path" to this function, i.e. it's all &some_variable.

So just dropping that && seems better from a code understanding &
analysis perspective.

More generally, can't we just expose an API that gives us the strmap
itself, so that callers don't need to keep any special-behavior in mind?
I.e. just "make me a strmap of checked out branches".

Then you can just use strmap_get(), or xstrdup(strmap_get()), and if the
pattern of "get me the item but duped" is found elsewhere maybe we
should eventually have a strmap_get_dup() or whatever.

I.e. just making it: xstrdup(strmap_get(checked_out_branches_strmap(), refname)).
