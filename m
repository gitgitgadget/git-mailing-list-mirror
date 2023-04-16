Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B56BC77B61
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 07:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjDPHmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 03:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjDPHmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 03:42:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE41E64
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 00:42:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u3so4346571ejj.12
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 00:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681630934; x=1684222934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRbrFOMrm31F8xIEbtfKPkT2PnZBkMnW214f0/SzlSg=;
        b=GWcHe8S9KuQ87X49CytDYfEtbYOuZZHAIBj1vmRhhb7IjzjRSxxBhD6XvooJxGiXsQ
         TAQDcxZ7tqv2E3tYfkS1FHG7flI3QDgHLjlu9Zap7h73slDJyZvUsbJxdcISOoE0WDfr
         reyOw8XHzE/RVXY3Gv05jF97cWp0JHN7gaJZkzxE894TNC8MINZZIy+DQWKe9E3afDjO
         4NhTotY6z84Bt8LobM7H1eckkrzocLuFBWK6YBz91MXs4rv673ZPd8GxFTrcBiqunJhZ
         psWUKopLjFN74pU8Wye/ZHhSPsxUvjGnFivVdomR6D1EqjhC5tun1xhd02T/jbBTYM25
         ASaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681630934; x=1684222934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRbrFOMrm31F8xIEbtfKPkT2PnZBkMnW214f0/SzlSg=;
        b=aVb3Fr6kLS2CFt1sIlmpUXH/6ziHHCCB4VDiCBB5dojsU+SXkAMHNN1e+9ROfEE8ZS
         QjXuPZ/4gdQZhPjEDedW3Ju52fXmb4OxHAmEYb0nUAfl70w8s7moOOlL02HgZAzKkdnS
         kln0suDHoBuJNyznrBva9D7SdydcipFrNTwkYCiw+UvD4dNlhsS7yCjVeiMNAgVM3Cbj
         Pfz1blQKBDDqA4Ydut1UjY31hblEG70aYoV8rfOd2U8nEJOsFfE7dt/97QiOZ77hQiCI
         L64lnMpG7+ASG3k0rZ93rRfy4RCeiziUNKTgelTkR4QYbRE8V11lZo6cCr0ARrsRKpYy
         O5uw==
X-Gm-Message-State: AAQBX9djT/0temc4hJUpjpXjABziYfmNTVE9n9i1+F6x/Mi6/6RQjaoz
        kL1aiM36NC8kHsGpBwlkqrY=
X-Google-Smtp-Source: AKy350Y1KdlnJNBJ/AG5brftTO1etDfh8N879DDkyNBl+ktYLq0xitxQ66M6C4i1F0JX6u5e4y/Lwg==
X-Received: by 2002:a17:906:d7b3:b0:94e:8d63:9319 with SMTP id pk19-20020a170906d7b300b0094e8d639319mr4042095ejb.45.1681630934051;
        Sun, 16 Apr 2023 00:42:14 -0700 (PDT)
Received: from localhost (92-249-246-116.pool.digikabel.hu. [92.249.246.116])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090603c100b00882f9130eafsm4677616eja.26.2023.04.16.00.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:42:13 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:42:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 2/2] cocci: codify authoring and reviewing practices
Message-ID: <20230416074212.GB3271@szeder.dev>
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
 <75feb18dfd8af03f5e7ba02403a16a0ed4c2edaa.1681329955.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75feb18dfd8af03f5e7ba02403a16a0ed4c2edaa.1681329955.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 08:05:55PM +0000, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
> 
> This isn't set in stone; we expect this to be updated as the project
> evolves.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  contrib/coccinelle/README | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
> index 9b28ba1c57a..055e3622e5c 100644
> --- a/contrib/coccinelle/README
> +++ b/contrib/coccinelle/README
> @@ -92,3 +92,26 @@ that might be useful to developers.
>  
>     The absolute times will differ for you, but the relative speedup
>     from caching should be on that order.
> +
> +== Authoring and reviewing coccinelle changes
> +
> +* When introducing and applying a new .cocci file, both the Git changes and
> +  .cocci file should be reviewed.
> +
> +* Reviewers do not need to be coccinelle experts. To give a Reviewed-By, it is
> +  enough for the reviewer to get a rough understanding of the proposed rules by
> +  comparing the .cocci and Git changes, then checking that understanding
> +  with the author.
> +
> +* Conversely, authors should consider that reviewers may not be coccinelle
> +  experts. The primary aim should be to make .cocci files easy to understand,
> +  e.g. by adding comments or by using rules that are easier to understand even
> +  if they are less elegant.
> +
> +* .cocci rules should target only the problem it is trying to solve; "collateral
> +  damage" is not allowed.
> +
> +* .cocci files used for refactoring should be temporarily kept in-tree to aid

How should such semantic patches be kept in-tree?
As .pending.cocci?  Then I think it would be better to point this out
here.  Or as a "regular" semantic patch?  Then I'm not sure I agree
with this recommendation, but perhaps a commit message explaining the
reasoning behind this would help me make up my mind :)

It might also be worth mentioning that before submitting a new
semantic patch developers should consider its cost-benefit ratio, in
particular its effect on the runtime of 'make coccicheck', in the hope
that we can avoid another 'unused.cocci' fiasco.

> +  the refactoring of out-of-tree code (e.g. in-flight topics). They should be
> +  removed when enough time has been given for others to refactor their code,
> +  i.e. ~1 release cycle.
> -- 
> gitgitgadget
