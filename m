Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5765BC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 07:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1139A238EC
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 07:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbhANHlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbhANHll (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 02:41:41 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA23C061786
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 23:41:01 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x126so2846906pfc.7
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 23:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zofHzHtY8tu/bECwd1MBoP7+Yq6MIC+NypNENv/sh3s=;
        b=eS6A3++icRqN4x6aGiKfFjuDcpFDeGRPMF2798TmT00i73USgPD9e00RUzihZAjw1S
         Fno8ired6hhxy5mUw9CA06oyq3ovlYkOIw18C1OblplrpVL0kg8c681ohHRs3rPIs7cz
         2tZ1qfPAIo/KcgbezkxoGT/H5Ad3DDkfz8fQ1vBdxZ2R594J3XSEhKU6HKDXSIUD0DTz
         JfaTQkgUPUvUcDXtEbwLGdUZ3CbTlQOvoiwzxI6yQkH0K7JF5yJ7+//R7rwMmx7E8Zhm
         i3axv7v9EvMZ33yfICcHSq0itil776DRqyd7SRmRa4bqa9pip/dp6rKbCbkUC8rtQJw0
         rLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zofHzHtY8tu/bECwd1MBoP7+Yq6MIC+NypNENv/sh3s=;
        b=DqkJ7Q6ewPSawyjFjLImBPurbLn5RMky5kZLvIaLbqSH0A5o1zS00mszQq4KHMhxMJ
         P9kKPwj8Q95jQV8BIKEcJzFvoB5Dr1nACcMruxT/AwO0q/AF/ZmwJZd7iDCZOPAEc1RG
         6HLczZ/+UoDqUFG1wCwqmQKwQR0mx1w/oaO4ZibT5injYqEA0++6ZtqKT1h9+fycCfZ0
         BtLsZzRaiv+pw5jlmTYnInMP0iEXdyIgD59WPfYExhrx31kXkEhcgQ6p/0pLxh7Vuw74
         jvU59WaPj4qWQVXJhAMn4LKQ5KJ2nwLrtxlJfnj1+w5PT9B096uyalAsN6jkjlK5VevE
         sH5w==
X-Gm-Message-State: AOAM531c/NIDkM/dbEIFww7bjZs3uelYeQRQYYqTAGTTqaE0Hn9Q3Nb9
        JP+TPendP+4MxO2vuh6KAbnp3t/7STY=
X-Google-Smtp-Source: ABdhPJyF+OhxXKp+qEwiZ7CYYmPIWI3q+6L8wgUMrugasqcXuhecNBLor15NQaRWp/wr6sm+LQZZZA==
X-Received: by 2002:a63:dc4c:: with SMTP id f12mr6238721pgj.167.1610610060587;
        Wed, 13 Jan 2021 23:41:00 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id b1sm4573682pjh.54.2021.01.13.23.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 23:40:59 -0800 (PST)
Date:   Wed, 13 Jan 2021 23:40:57 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 14/22] test-lib functions: add --author support to
 test_commit
Message-ID: <X//1iV92dlzGEoJI@generichostname>
References: <20210105130359.21139-1-avarab@gmail.com>
 <20210112201806.13284-15-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112201806.13284-15-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Tue, Jan 12, 2021 at 09:17:58PM +0100, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 194b601bc0..529f6264fe 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -185,6 +185,8 @@ debug () {
>  #	Do not call test_tick before making a commit
>  #   --signoff
>  #	Invoke "git commit" with --signoff
> +#   --author=<author>

The usage shows that you have to specify the author argument with an
equal sign...

> +#	Invoke "git commit" with --author=<author>
>  #
>  # This will commit a file with the given contents and the given commit
>  # message, and tag the resulting commit with the given tag name.
> @@ -193,6 +195,7 @@ debug () {
>  
>  test_commit () {
>  	notick= &&
> +	author= &&
>  	signoff= &&
>  	indir= &&
>  	while test $# != 0
> @@ -201,6 +204,10 @@ test_commit () {
>  		--notick)
>  			notick=yes
>  			;;
> +		--author)
> +			author="$2"

but over here, it's only parsed if they're presented as two separate
tokens. We should correct the usage text accordingly.

Thanks,
Denton

> +			shift
> +			;;
>  		--signoff)
>  			signoff="$1"
>  			;;
