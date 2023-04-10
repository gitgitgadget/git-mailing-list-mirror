Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A06BC77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 16:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDJQli (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 12:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjDJQlg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 12:41:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B281BCE
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 09:41:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a2104d8b00so335545ad.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681144887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XhMeQx3joRhJ7u/XOkyBki5x9v+hcJCkytScTCPfWQA=;
        b=OLf+1UmncmYb5cZwg7M4oZ//X9SNOo6Zsn3qAzcBXNjRRgKIqC54BBsvDpSsO//uHH
         A5vkKPWGqUtuyDknD3hGNygAp7Cnn+gt8LDpKKCEDIwZ76NzSOjk8z6lJruB4YhfaEcH
         W/lsJaBJ+GDBOJq/YHW6rHHUUA/LYQzNZEXJ12cYvLXUWd/fmaUNgB1VLPZkh9s3kssN
         sAJTjA4TbJaP6qwLHkBhTRgc8zAZ+qWuIAkPzzqZhzEXRHxWc7ZosTVH0K7lt4+TD0y7
         spH3xMyZq4IgM/jjLYrAjf6aRtOUPh3ckPNX6BjJhloMTvEEj0oA/E2UTxZgSIpw4u33
         MKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681144887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhMeQx3joRhJ7u/XOkyBki5x9v+hcJCkytScTCPfWQA=;
        b=4NfdLpTkAGx041tKo9LwtstmEJ8ijuz+7FoL84PezWZwm8/dfLhp/qXydYYZ9IrIi5
         /T2N5r5x6fksznjgqGmTEh8ZEdKzRJbN2LizH5lhSwch/lkYTEvxWkesXq9SHNJQLIJ2
         SKrLxCMhI4rgQQKb9jktVBuQ38N+jQ8M6ioZfEZMlydI/XDcG5SFRJZxLMKKf+2D4NGY
         xkCYS2DkhQxLMyGmxMDXXSA6BgxGv8Cplt93RT4RtEERdetAEN0UQPTOQ2J4KgKWJdKb
         YBZOXusGCdDNs9j56fyeW6fzyS8yH5O1CxPtUK77/rQ08MN7BQx75csyl73JZvdCF5Dg
         g7Zw==
X-Gm-Message-State: AAQBX9dlY4xImMQ9xuuAkzLHGUiTYRbYVKJlSRtLoWykvMNtma/5ZAh9
        dxCUYaWE6A7fmWMP2jBwoKr7Kw==
X-Google-Smtp-Source: AKy350YLmjoOxbOgB6EGGJ++A+9CuY8CzVxSXnzZKesFy8n1GcTcSyeCPPc3bZP5cwnMJug4tgBmBA==
X-Received: by 2002:a17:902:c151:b0:1a1:854b:99d3 with SMTP id 17-20020a170902c15100b001a1854b99d3mr458405plj.19.1681144887188;
        Mon, 10 Apr 2023 09:41:27 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:e06e:1db:d0a:7a9])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b006328ee1e56csm4555489pfw.2.2023.04.10.09.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:41:26 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:41:21 -0700
From:   Emily Shaffer <nasamuffin@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] usage: clarify --recurse-submodules as a boolean
Message-ID: <ZDQ8MdTPhCleBNeJ@google.com>
References: <ZDCWrl4GhgYKYFYG@google.com>
 <xmqqcz4fi7bd.fsf@gitster.g>
 <xmqqy1n3gryw.fsf@gitster.g>
 <ZDCztVHuZoCstNar@google.com>
 <xmqqy1n3fat2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy1n3fat2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2023 at 05:59:53PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <nasamuffin@google.com> writes:
> 
> > I think we do because config_update_recurse_submodules is static to
> > submodule.c - that is, builtin/checkout.c and friends don't have access
> > to set it manually with OPT_BOOL. Using the callback just to set static
> > state we don't naturally have access to is pretty awful, though, so I'd
> > be in favor of plumbing it through like other options we might be
> > passing to the submodule machinery.
> 
> Yes, the cleanest way to interface into that part of the submodule
> machinery that wants to use a hidden static state would be to
> 
>  (1) implement a setter interface in the submodule machinery for
>      that hidden static state, and
> 
>  (2) use the bog-standard OPT_BOOL() on an on-stack variable of
>      cmd_checkout() and friends, and use that setter interface after
>      parse_options() returns.
> 
> Then you can avoid the "pretty awful" arrangement today's code has.
> 
> Note that such a clean-up can be done independent of how an option
> that yields a Boolean value can be spelled, i.e. whether we'd accept
> --frotz=yes or only take --[no-]frotz.

Oh, totally. Yes, this sounds quite easy, I'll send a reroll today.

 - Emily
