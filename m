Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD1DC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjCHJRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjCHJRS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:17:18 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7077497CF
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:16:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ec29so32073692edb.6
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678267017;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LcwCbBSlzmIJ5n3BKaYtZUyi5/9wrmHFu/PnFFN1vK4=;
        b=TytqrEhwII7WfK2oxRgwxw/ZHLGpry1xsvftm+svGILB5ZZHZQrr7bJVstYTY+zK4O
         X9jLMFnoGpLt1SCoQb8RXWg++Nmwv9cDRTLKceKNdBPkDoZAz65lntWTK8KJcHz0dSTV
         0+jE8c4LIhflCqFXsmVkfFm4Y9I01uuh2OGAqqXCYNwbaWr/AoaX+yEdxVGANnj21U2x
         MKMcI1t7u9XaXEvWd1U9FhB4dZYayPDmvATnoQED8xjrDm81VL7ARsA5gbBy8ho94Ht/
         9xsM6hbVbGIQ7IcgpGo/Atpa4TSju0hipwXBTJdFP4ZsuOuoPYRss/SvpONo5q466TLe
         MRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678267017;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcwCbBSlzmIJ5n3BKaYtZUyi5/9wrmHFu/PnFFN1vK4=;
        b=qgNkY0DVPvEEdAl+CbeZsVvZoT+86QU+gA+YlQdMN0pXMPzEz2bHG9sWYiO41dkZA2
         X0S7mL42DSWFMz8BDFjs/xjrDLhAmzSquHPbrIhoGkXJOWYnM3nQaFxVtGsPNOWFEJ/6
         AoqQRTx15uYdibHzePuAI4Gzpdx56IoggW2kGOxQyTNL3NbMIQ+2nMH3iO7NJ1qeIk//
         RDdWq+wVIWO2vh5FH/oPb3rcF9YhY2UL85SrPy3mBngB/eZrIRLE6UeRy22uPHBEpz6P
         rdMg8Jj7LK8naKIkAgbO2ediImu4YDMwuLOEmUWrzjqJ5TocZugvclqD9jNMhrwae66q
         SAnA==
X-Gm-Message-State: AO0yUKW+lA/zKXmE1IJszH9sEBmLtzmUBfuU0Gkwr9zueeNOG9PaRzHH
        itb1aqsHMwmcEDnv3mF1x7lknepoldHzDA==
X-Google-Smtp-Source: AK7set9KGbuK/TgqMfu0kUloKlAQOrq4AjMQXIcr670toLgqNtMkfbeShWrrwAEYD4ThSMVl1kf0ow==
X-Received: by 2002:a17:907:20ef:b0:8ab:b03d:a34f with SMTP id rh15-20020a17090720ef00b008abb03da34fmr21222337ejb.12.1678267016848;
        Wed, 08 Mar 2023 01:16:56 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b008ba9e67ea4asm7266823eja.133.2023.03.08.01.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:16:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZpuq-000sA3-09;
        Wed, 08 Mar 2023 10:16:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] test: simplify counts aggregation
Date:   Wed, 08 Mar 2023 10:12:43 +0100
References: <20230308090536.2562917-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230308090536.2562917-1-felipe.contreras@gmail.com>
Message-ID: <230308.86bkl3zjp3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 08 2023, Felipe Contreras wrote:

> When the list of files as input was implemented in 6508eedf67
> (t/aggregate-results: accomodate systems with small max argument list
> length, 2010-06-01), a much simpler solution wasn't considered.
>
> Let's just pass the pattern as an argument.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/Makefile             | 4 +---
>  t/aggregate-results.sh | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/t/Makefile b/t/Makefile
> index 2c2b252240..6bc878558f 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -140,9 +140,7 @@ aggregate-results-and-cleanup: $(T)
>  	$(MAKE) clean
>  
>  aggregate-results:
> -	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
> -		echo "$$f"; \
> -	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
> +	'$(SHELL_PATH_SQ)' ./aggregate-results.sh '$(TEST_RESULTS_DIRECTORY_SQ)/t*-*.counts'
>  
>  valgrind:
>  	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
> diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
> index 7f2b83bdc8..2efc2c37cd 100755
> --- a/t/aggregate-results.sh
> +++ b/t/aggregate-results.sh
> @@ -8,7 +8,7 @@ broken=0
>  total=0
>  missing_prereq=
>  
> -while read file
> +for file in $1
>  do
>  	while read type value
>  	do

This leaves this code in contrib presumably broken:
	
	contrib/subtree/t/Makefile-aggregate-results:
	contrib/subtree/t/Makefile-     for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
	contrib/subtree/t/Makefile-             echo "$$f"; \
	contrib/subtree/t/Makefile:     done | '$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh

But overall I like this direction, if we can just change that contrib
Makefile as well to use the new mode the script excepts.

I think we can go even further here, and just pass the
$(TEST_RESULTS_DIRECTORY_SQ) as an argument to the script, then have it
do something like (untested):

	results_dir=$1
	for file in "$results_dir"/t*-*.counts

Which I think is a bit more obvious, and since the only task of the
script is to do exactly this, there's no reason not to have it do that
search by itself.

