Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F9C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC31E206D7
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU5DQ9p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDXPXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726717AbgDXPXL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:23:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CAEC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:23:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d24so3845856pll.8
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p6r2Ftz30AXLuDIc/bc8dSjnaPNWlCfgXWJU4bXsUtQ=;
        b=HU5DQ9p4rxAdmXLiDwwj835/UDuiPb51YlevVxCkmAj7fmSxLkUorzGxgM6pO7ajwk
         MBWjeSrDfI4tygK1Wy1ashKTshC+kBghzsvhZWR0/RyG6POpnDy5i1Khl6FbffBAB66C
         4qZF3PZXtoJc++/E4ZRd3349Wk8YSPvjdrEIytlgPtLbmminuvmhLgfMIOB0KHlftihj
         yHQseI7ccf6hSufWPK/qEcFF987tTySf+X1HBCiA2DWgDGhYJdOqfkuNrc6Ru5dcKEk8
         YA2AODLmCNfALDRRZA0jPSclb2n72R4z1ZwyOkhMgDzXWCnDJpGkEfanxr7YgnDtwvXJ
         N5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p6r2Ftz30AXLuDIc/bc8dSjnaPNWlCfgXWJU4bXsUtQ=;
        b=EsrupDXeY/iFGNEN3SEUQ5Q/W751wFo+L66L3HEVMHmSbGwEZSu1MecgpbTbskQqPq
         YmLAzjCv/X9GsSsxTDlxMyFtxYFg4KbW6GE2sGDR9xmuKoHLHbdRP+3fp8pysdnrIktu
         VqPWwwqjWlDU/SQ8/EtUeLf8FC6/aD9qPra1jErbp7FPIUd+WFnjoFPDVKHLGJjOpz+j
         sY7FG+QlTcNzHzkqRxeyIINnTgjxdgmkY6OXIgCjoadTgjUG5HUwZEJ+lPt9CHh/B+f8
         HRspz69LXlUocyz/Te2HhCl/XXuw90rq2IZRoVBj5ZqnBnaGp8fv78pEUjxtHlhnqL52
         P4Ag==
X-Gm-Message-State: AGi0PuaSmeQMdfRa2t0LZ2aCH9Svj/R3VC+d7ocHFkx4O/yUDYuEjV/d
        4p3DhnELs7amz59RSTJw4LU=
X-Google-Smtp-Source: APiQypIplCe+i+2FWMclfO2e3TL5e22+FbqxmoPMf5T83xJLNHacUEVE99UeCLOXh0jJH30jZINqdw==
X-Received: by 2002:a17:902:a418:: with SMTP id p24mr10180898plq.55.1587741790071;
        Fri, 24 Apr 2020 08:23:10 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id o11sm5119334pgb.71.2020.04.24.08.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 08:23:09 -0700 (PDT)
Date:   Fri, 24 Apr 2020 08:23:07 -0700
From:   Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/3] credential: handle
 `credential.<partial-URL>.<key>` again
Message-ID: <20200424152307.GA85188@Carlos-MBP>
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
 <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
 <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 11:49:52AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/credential.c b/credential.c
> index 7dbbf26f174..c1a9ca4e485 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -35,6 +35,10 @@ int credential_match(const struct credential *want,
>  #undef CHECK
>  }
>  
> +
> +static int credential_from_potentially_partial_url(struct credential *c,
> +						   const char *url);
> +
>  static int credential_config_callback(const char *var, const char *value,
>  				      void *data)
>  {

something like credential_from_url_partial might had been more grep friendly
but this would work as well.

> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index efed3ea2955..f796bbfd48b 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -448,4 +448,43 @@ test_expect_success 'credential system refuses to work with missing protocol' '
>  	test_i18ncmp expect stderr
>  '
>  
> +test_expect_success 'credential config with partial URLs' '
> +	echo "echo password=yep" | write_script git-credential-yep &&
> +	test_write_lines url=https://user@example.com/repo.git >stdin &&
> +	for partial in \
> +		example.com \
> +		user@example.com \

even if it works, configurations with a username might not be worth the
trouble to support IMHO

maybe better not to include them in the tests then either?

other than that, like the previous version (which is functionally equivalent)
should be IMHO good to go.

Carlo
