Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63094C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26275611C1
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhDGXXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGXXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 19:23:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0F3C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 16:23:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id n38so456724pfv.2
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=29UtF+uMZ0D8BK7qLDMxPDZp6ehVSjVXn8qG+UAQRgE=;
        b=ptl4TqhaVhL3CD4Zvv+zNayguHMtTisw1UQp2d/fARQLzuk91Re2Z2LZt+13GVkhtb
         pwvoAYx6kcrslbQ0bm0np+S3vFb7gGk92vjR2xw/xX0QTYEkAgBV7d41HqlANA5vtJxw
         iMB24PQQK+n9DJcKwaAnhtyG/67IVx0JYGjI4zl2UVT5hfk1iQmx5676a3fsRGuFrMMf
         3r1jm7XjH7C+R5tbfZsxLpN2blmZTHZr1K3HCQ7zYogF9oRN2KGkfmlshkYDvYN0NF86
         06mHFV1gNdJFn11zdpXZLs3LCyQj3qy76KW5banC9FPPaylJH3aMu0yNfTU2uN6kjTg4
         +e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=29UtF+uMZ0D8BK7qLDMxPDZp6ehVSjVXn8qG+UAQRgE=;
        b=OAIHoLZgV5Vlf2Ta3wv7t9YgRdKWt49Vc9iD8CYud7uRgb5tgnR07BLpnjpEOKO9St
         kjE6OXz7VkuonMLKeN/a/sn5uogH1Fj0lU/7SOOCo5/GeYF0JVbMSUza8kTS5DOLD2cp
         iM508fc6Bm+L1cLBXncVHCPNQuIy+mQNaR9x+4Bf0B1EgU8avz1VWJI1Z69Odyd3BbPT
         Umq9JsGDUfVvdz76tLCyrqK4qWAVDLwAzOPksgeMia8BpysQp4+p0G689aC78HMxU7q4
         1G32qTVnRn4Ugov6wvNZl/jnBpJocYTi2LPDM0YgZY/5lVeMUuqhAfsyHgSc7HJu3rLA
         Mkrw==
X-Gm-Message-State: AOAM530HKdpCjxsb7K8DKW+i23fJ6MuSNCD/MuxXWVHHjRcdjfMqeCvS
        Stjtrmd9nzH6jmUbYrNNLvGODg==
X-Google-Smtp-Source: ABdhPJw48WLk/7GB4qk/6hoDZEyditUw0EJUL51pwhLWsEH16VI16l+w4QpUJ7PmI4dM/FjevfP4Bw==
X-Received: by 2002:a63:6683:: with SMTP id a125mr5290578pgc.382.1617837810550;
        Wed, 07 Apr 2021 16:23:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:8cb6:cbee:2f8c:7584])
        by smtp.gmail.com with ESMTPSA id f135sm22270870pfa.102.2021.04.07.16.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:23:29 -0700 (PDT)
Date:   Wed, 7 Apr 2021 16:23:23 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/5] maintenance: simplify prefetch logic
Message-ID: <YG4+67oe39IRnUzb@google.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <5aa0cb06c3f2e31a51bb6747fa84de69c0c1212f.1617734870.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aa0cb06c3f2e31a51bb6747fa84de69c0c1212f.1617734870.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overall, the series looks pretty solid to me - which is why I've got a
handful of small nits to relay. :)

On Tue, Apr 06, 2021 at 06:47:46PM +0000, Derrick Stolee via GitGitGadget wrote:
> -static int fetch_remote(const char *remote, struct maintenance_run_opts *opts)
> +static int fetch_remote(struct remote *remote, void *cbdata)
>  {
> +	struct maintenance_run_opts *opts = cbdata;
[snip]
>  	if (opts->quiet)
I worry about the lack of null-checking here.

 - Emily
