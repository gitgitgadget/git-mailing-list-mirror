Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C80C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 12:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJ1M6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 08:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJ1M6b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 08:58:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CF91CD68C
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 05:58:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y14so12721042ejd.9
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lkJAa4gTCo+HObNyl3O+CaubycAnbMYe0YkUPpOChOs=;
        b=lexOBFnlTYaDs55Wgsha3n4nS3E+MF/WJLdC6/OJhsW+Y3W6Vz/67eAg8NGbQ0rScJ
         Q+5/qkYkQ3XNxBEaZZBg5w844k7nF46CeM1YrRH+Ccb/ALZDW8XmJnZperbbz1hGxQfe
         XEpign96H94xiZrqH2JlgdwL68Ahf7CxMCumfGKBj9HLl9Pnv77xAEetTNt06CbKzhAP
         7hqucXsVU1kMlyEtCjgP2VhcD50Oq/J3MijpXaxifXtGYReDJOl07/ZR9wAnFXOqUaoi
         p61xqkY0ssggDULxY7rBY+S9MGrL3EIcXE6D2x8trOWLC+VKqEHNVEuGsjHQTMaHhTlZ
         QLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkJAa4gTCo+HObNyl3O+CaubycAnbMYe0YkUPpOChOs=;
        b=34by2NBffO5RyQtUgr/gTnxuOmBaXWeckCUh0wmUe+AL0EEHhCqwiCwNFpmmVFn584
         oEqJbT/fMv9+Kn3bi39NfpBhqkHPn5yjejrKXte81eFMlpyDNMTVIjmtlDcQCYT88azc
         aY9bkblkRHE3pAL/M2+0xiHKqqNQ8Znb7/QnIgFTQKpt7w2c37e5BAZJKOQ+eMEaB+ZF
         oezWn+RK+Gj+naTU34QnXW3l+0voEhmkT6Z50eH8kQT9lDHVcIbcrcqwZyyhMt5ME7Oc
         5A5tS76K9ODl11j29XLOHLDm1av0ivox1xCaSTGkC5YgOClGXaGfxhIMK4vbft9H6zlq
         cL4w==
X-Gm-Message-State: ACrzQf1/a6TrYvgMmeAn+8QqppTalFQ3KbpVKaHyWD4QdggYRz9cjaH6
        y+Em1HSQnQJyIQrm+Ww9pCc=
X-Google-Smtp-Source: AMsMyM5nxlvRZSWemg9KQnMRWXhRA11MiH2r3T4uA2BnFxjzYff766djTeJke07QI/5P2oaJXJJhLg==
X-Received: by 2002:a17:907:b1c:b0:797:983a:7d97 with SMTP id h28-20020a1709070b1c00b00797983a7d97mr39654382ejl.267.1666961909576;
        Fri, 28 Oct 2022 05:58:29 -0700 (PDT)
Received: from localhost (94-21-58-15.pool.digikabel.hu. [94.21.58.15])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906319100b00730df07629fsm2186799ejy.174.2022.10.28.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 05:58:28 -0700 (PDT)
Date:   Fri, 28 Oct 2022 14:58:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 11/12] cocci: run against a generated ALL.cocci
Message-ID: <20221028125827.GA1682@szeder.dev>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
 <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
 <patch-v4-11.12-a848d09527f-20221026T141005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-11.12-a848d09527f-20221026T141005Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 04:20:38PM +0200, Ævar Arnfjörð Bjarmason wrote:
> The preceding commits to make the "coccicheck" target incremental made
> it slower in some cases. As an optimization let's not have the
> many=many mapping of <*.cocci>=<*.[ch]>, but instead concat the
> <*.cocci> into an ALL.cocci, and then run one-to-many
> ALL.cocci=<*.[ch]>.


> @@ -3252,7 +3281,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
>  coccicheck-test: $(COCCI_TEST_RES_GEN)
>  
>  coccicheck: coccicheck-test
> +ifdef SPATCH_CONCAT_COCCI
> +coccicheck: contrib/coccinelle/ALL.cocci.patch
> +else
>  coccicheck: $(COCCICHECK_PATCHES)
> +endif
>  
>  # See contrib/coccinelle/README
>  coccicheck-pending: coccicheck-test
> @@ -3527,6 +3560,7 @@ cocciclean:
>  	$(RM) -r .build/contrib/coccinelle
>  	$(RM) $(COCCICHECK_PATCHES)
>  	$(RM) $(COCCICHECK_PATCHES_PENDING)
> +	$(RM) $(COCCI_GEN_ALL)

This should also remove 'contrib/coccinelle/ALL.cocci.patch'.

