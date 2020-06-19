Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC3C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CDA420DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZYNdTZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbgFSN2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731738AbgFSN17 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 09:27:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF01C0613EE
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 06:27:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n9so3940369plk.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0qgNr6iP/aaJbjxdjzgkiUHZGIeJ2f7u8oAlGSik8G4=;
        b=gZYNdTZocWtHxocJnp5h63f59/KOFEgMIULA1FC27hIbaT8/IORITE1JP9RX5227Sp
         zZmC8LNsnY4opGKGWL0imxowWGCAG83t5zpu/dXSxGelcoTHrYr63Ud0oOIGEBTXM1zB
         u5vytvSxPwv4ftP4VKm7kRfNhSI/cvaQCZ/jzOIcutJ47/cgAdrQ7chAH5kaDwurnoUX
         sPmG13jB8eZvm53xPB2sGEU6o/BBARb6jjVLjJlBM5wkg72/Vuf3CeX5j9Ie6lqLLtGs
         cYJWZl9QwERCwVf6LbKuLyBt71vx7/3fB6sbabDeI0oSg25geaW4CtaZ/kHJkCKjKHcn
         RIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0qgNr6iP/aaJbjxdjzgkiUHZGIeJ2f7u8oAlGSik8G4=;
        b=lANGgtMJtUs9YEqT8HcTWU+NGUZKBliz/evryRlVkjDrbQc7LrvFAmWtuGL2IKnlen
         kBj3V6+ZDrtuy8RKChzKnzSLhmSGC/AVrjSQaMkCRBM8eCmP/88czoK91/N1oRFADqqi
         5ANOTYxkZ802yc3Bi/xQSvnxKcx9SSMzEFTiL886J3dKZW1abBzT6y0XvaPXp2Rkjcv4
         Vpsko9syb+hGgWe/zMlyJ2JzxTNZaQqYJqgdgo8RLv73k6N0cruhxsx3AhXwAvLO+f78
         oTKqgpiK+qXOc2sqO10BiDNSfYyRbhJomQcBWHkykKDMcZtgJ+IA7Rb/3Ehp78DB3QcL
         iZwg==
X-Gm-Message-State: AOAM531DANOlGnr4CyATptXxDt8Nwcgwc78DjMpT2i6+xL5gvyzzvBe8
        0OFcWiSCUoNoFdge/7EbqVjI/VSl
X-Google-Smtp-Source: ABdhPJz0lTOnhLDbeXtKnxbJwVLPWHs/lpIfpUvpj4wGkdA3fNBU93kE/P5UkU8VeTng8vBMgSTp7g==
X-Received: by 2002:a17:90a:1308:: with SMTP id h8mr3844064pja.22.1592573278295;
        Fri, 19 Jun 2020 06:27:58 -0700 (PDT)
Received: from [192.168.208.37] ([49.207.136.53])
        by smtp.gmail.com with ESMTPSA id p19sm6068583pff.116.2020.06.19.06.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 06:27:57 -0700 (PDT)
Subject: Re: [PATCH v2] tests: do not use "slave branch" nomenclature
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     git@vger.kernel.org, msuchanek@suse.de,
        Till Maas <tmaas@redhat.com>
References: <20200619093210.31289-1-pbonzini@redhat.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <8f2bf041-1a04-55cb-05fd-a3802fbfb09d@gmail.com>
Date:   Fri, 19 Jun 2020 18:57:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619093210.31289-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19-06-2020 15:02, Paolo Bonzini wrote:
> Git branches have been qualified as topic branches, integration branches,
> development branches, feature branches, release branches and so on.
> Git has a branch that is the master *for* development, but it is not
> the master *of* any "slave branch": Git does not have slave branches,
> and has never had, except for a single testcase that claims otherwise. :)
>

I wonder if "claims" is too strong a word here. "... hints otherwise"
sounds better to me.

> Independent of any future change to the naming of the "master" branch,
> removing this sole appearance of the term is a strict improvement: it
> avoids divisive language, and talking about "feature branch" clarifies
> which developer workflow the test is trying to emulate.
> 
> Reported-by: Till Maas <tmaas@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Other than that and the comment by Danh elsewhere this patch looks
good to me.

> ---
>  t/t4014-format-patch.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 575e079cc2..958c2da56e 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -81,16 +81,16 @@ test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
>  '
>  
>  test_expect_success "format-patch doesn't consider merge commits" '
> -	git checkout -b slave master &&
> +	git checkout -b feature master &&
>  	echo "Another line" >>file &&
>  	test_tick &&
> -	git commit -am "Slave change #1" &&
> +	git commit -am "Feature branch change #1" &&
>  	echo "Yet another line" >>file &&
>  	test_tick &&
> -	git commit -am "Slave change #2" &&
> +	git commit -am "Feature branch change #2" &&
>  	git checkout -b merger master &&
>  	test_tick &&
> -	git merge --no-ff slave &&
> +	git merge --no-ff feature &&
>  	git format-patch -3 --stdout >patch &&
>  	grep "^From " patch >from &&
>  	test_line_count = 3 from
> 

-- 
Sivaraam
