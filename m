Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F505C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8A760FDC
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhETViC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhETViB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:38:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6FC061761
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:36:40 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d16so13341548pfn.12
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oEezTJI7K6K39XDsNUrqXiIvyJAqRWwuHJKvObvVLkA=;
        b=YkCT5MUi6wdCkR+M0nMTCj0/0ePS9WRn5wIsgy7iI78QwMcP8UdCY72vbmHnE6zakb
         T8A+LRnJTo8TVcrtW4WRHZkOwVB/2Jd+O4cARt6wIzHCl58pI4OTKGYnb14hHAG3jJEe
         VsiGoLwWhQGM8152Boz9Vp8LrgHwXjB4mKSVteYaw7LLhNouFw3gtRswnOQuncGsFPF3
         eDoaIud/wD1erwU+VEzo4U1j1PbV3yix1Uw7HccOdLT5xcio08nQp6WyVUUWQpTh5SYI
         RAf9ZBIkcE3wr6lVs/MOHryzi4NcWGIpsqPUlit77JnJRRYkzavljzCjYh0qpqlqtvZS
         Mepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oEezTJI7K6K39XDsNUrqXiIvyJAqRWwuHJKvObvVLkA=;
        b=PndQwNDP1vyEL+7DxZQXDqhtMA6AfTEMJv37w0H7e52DgYUjFqcykItMJ8EZigwRph
         K8TcUTnQkXI3Fb8ARQgfFN99xPEXsXEgNEW5r9dLogmCnFiViRUy52yl+g7m43oiR09u
         fbYLeYBhn+0Uhu/ukucX5HJ9jFQGpAibhF39lPRBRQ00AGEOCAmaWbn9a6t3aH9Bavxk
         fj7aNb/YSgKCGyzKR86LFkPvoHKPIe5LNOzbfPrHa+hhbJewkLeeWX/lqKiFwMcyPUQO
         sn0E08WZcke8IT/D+jn2KrrcVkFjaSU+HAvyIGDJYK5IMzfKK4vc0OGT3Hh+vQcBtHB1
         KJvQ==
X-Gm-Message-State: AOAM530+iNus5R0PM7oke3YzKgIKs4u33aDIBb6IwgLnqBpMNwzuAhs8
        IYyzbNqZPK62tXVfOGKqesDuh994e+4=
X-Google-Smtp-Source: ABdhPJwqEwaR3XI8F2wf2akQ+cbnnt/pX+sYHy0AyZnIHwvlUD4Z3rflFtkWSyQ/wd5rN4bFqfbqkw==
X-Received: by 2002:a63:d30e:: with SMTP id b14mr6515580pgg.237.1621546599665;
        Thu, 20 May 2021 14:36:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ec75:d356:9cf2:6ea1])
        by smtp.gmail.com with ESMTPSA id h4sm8428713pjc.12.2021.05.20.14.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:36:39 -0700 (PDT)
Date:   Thu, 20 May 2021 14:36:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: fix small typo in error message
Message-ID: <YKbWZMTW2Evux1VR@google.com>
References: <20210520074214.40903-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520074214.40903-1-jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc: pks)
Jean-Noël Avila wrote:

> Classic string concatenation while forgetting a space character.
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
[...]
> -			strbuf_addf(errbuf, _("'%s' for 'object:type=<type>' is"
> +			strbuf_addf(errbuf, _("'%s' for 'object:type=<type>' is "
>  					      "not a valid object type"), v0);

Good catch!

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
