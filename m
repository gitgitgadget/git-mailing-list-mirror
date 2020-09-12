Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928FEC433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 03:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F125221E7
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 03:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0yZ+koke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgILDYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 23:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgILDYx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 23:24:53 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E532C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 20:24:53 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cv8so6224505qvb.12
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 20:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uQ2hSnxy22qN0vRAAL4GJeqOSw2NjPbP2027dA/ntVc=;
        b=0yZ+kokeNggLOxwTT0255oJZSi5Il3lrEBe1gez6uCeai1+dM98oAXujudMzbmsc48
         NZ3kTLACm3j8H7gI0ByHfkHdB1SjesNyi0iQXOnKtOsflctDSYDfFF3P4V3YxrWs//sA
         K52K3g2/LcXtJdyBR8aXArQUiPd5a+D9fuNZ7zCB7rHzceOTuuwbQ9Nnp4YmQ6pbG7Ft
         unNf4oTY2BhYNetdZtV67LrKy6udgwyUwj+yIeKbM4UK0UmtjwK6y+XyR1ZY4qWHDUHC
         p1PtQ9b04oAzfQy1nFqZJN0zxBfT2FUwblvS+wZvf7t5HdIPxUQKmewGI9oU5ks38c8h
         waRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uQ2hSnxy22qN0vRAAL4GJeqOSw2NjPbP2027dA/ntVc=;
        b=uc2wL1UuStyT8rOVUFwLeWQlRl7tRjbHESc++KC5AhhLcx4Ssz6Gmyj+gJphGObx30
         1v9l8CYuOY0lexkOIT8jSoGSrO3qKT7nW7xjOgMOZKhMUwThWV/Bbe+ukrfje+UgQHQk
         vc78uyY4hsdMyzpvdXRuuD90NTSvLtOn16J3PXFNnP7MidBXVSbX6NBxlA2QVThfPi1k
         0pas7/4IQEgKy0PHb6WHHqc+b2ULvVy1EJiawZuR3szgC45nIRY86ij2QnZH3NjTD+MP
         U1+/eVXWog/F5FHka+zbCd84/wTZ51kBJ5tmXHmWM/eHchrC8oCRu+1RxIgPs2QOtfJB
         OOGA==
X-Gm-Message-State: AOAM530I0KpKiBGQG2d3gKK0Hewi3Mkb3bV6cQEshcV3mZBjY83foLNG
        eJK8XrCtFWstcx8LyfaIHcoTAg==
X-Google-Smtp-Source: ABdhPJxLfoQxZj85vicMxNVYAIu9/7dRY7hqZGsmvBcMEF1F6sICn08F9jWpuVtSprIVzrDixAKwuw==
X-Received: by 2002:a0c:99c8:: with SMTP id y8mr4931937qve.53.1599881090891;
        Fri, 11 Sep 2020 20:24:50 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:14f0:d4d0:9608:fa48])
        by smtp.gmail.com with ESMTPSA id i66sm5577256qkc.63.2020.09.11.20.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 20:24:50 -0700 (PDT)
Date:   Fri, 11 Sep 2020 23:24:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH] builtin/clone: avoid failure with GIT_DEFAULT_HASH
Message-ID: <20200912032448.GB1988@nand.local>
References: <20200911151717.43475-1-matheus.bernardino@usp.br>
 <20200911233815.2808426-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 11:38:15PM +0000, brian m. carlson wrote:
> Neither of those are appealing, so let's tell the repository
> initialization code if we're doing a reinit like this, and if so, to
> clear the extension if we're using SHA-1.  This makes sure we produce a
> valid and functional repository and doesn't break any of our other use
> cases.

Your explanation makes sense, and what you're proposing here seems like
a very reasonable path forward. I can't think of anything that would
cause it not to work as expected.

> -void initialize_repository_version(int hash_algo);
> +void initialize_repository_version(int hash_algo, int reinit);

I'm not a huge fan of adding a 'reinit' parameter to a function that
itself begins with the word 'initialize' (why wouldn't you call
'reinitialize_repository_version()' instead?), but seeing as there are
only a couple of callers, maybe it is OK.

Alternatively, I certainly wouldn't complain if you did introduce a new
function and updated the call-site that passes reinit as 1.

> +test_expect_success 'clone with GIT_DEFAULT_HASH' '
> +	(
> +		sane_unset GIT_DEFAULT_HASH &&
> +		git init test
> +	) &&
> +	test_commit -C test foo &&
> +	git clone test test-clone &&
> +	git -C test-clone status
> +'
> +

This test looks very reasonable, and certainly demonstrates the bug and
fix. Thanks.

With or without my nitpick:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
