Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36E7C2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0212076C
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D96xqi/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgDXEud (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgDXEud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 00:50:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ED6C09B045
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:50:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a7so3481864pju.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d4SxryQVaDQVGakcwEGNz3QA1zuvNgbxEvP1OglUNT8=;
        b=D96xqi/7j83mdmr9ELUsigCDfOz8gy0bFqmbKNl94nVxns6/veTH6vAqEcNQt/pQ3c
         hQQFN1128vehriL9Xt0vVUFg7ZGY6d0eZaL590lVouqgV6qk0gwN3KWEVixe71Zrzt7S
         hlkpEWD5eMEL10BzIKCgXHhqLAT0inx6oOFOh2HOyMYCmsY1mXubEg7wLRJOqQn+dw/X
         FnKVRX+5OHx8Zv0gEsh0PO1C9Cuhi7TrYF7IZ+GMXVcF25t3xP8goJFv8fcAy+SWQrQS
         oju+mDQQ1HR6555ZYIkpG/3JRD/RiHCSEZPKskYS2nvp4OoMEyxW6mYZvEtvuKAFcAYg
         xuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d4SxryQVaDQVGakcwEGNz3QA1zuvNgbxEvP1OglUNT8=;
        b=c0uGo+dk0AIMQG4TNHqgy13O1IlCpeQ/oSOxaIK4UOJD2GRFcWhILQs+EexHS3mMrM
         O2pWCx2+POcHw1SpvMUrNZuxxUhufbDeWLNaHGNTk3TUoNGnj73U3bMZxzA8MRjB8b8f
         UDURbUhjxHU8udh0iI0UOzuQ5xris0frxOEcUVMrbTr2kX91xvl9uWCctZ3eWlcS2EYH
         cRNQ3OIdW8p3NttBvZP6WcC4VQaVmiPaSLM9Sk/AU3qN9Hj8RRLUqFrPYUuYSLOh5vJ4
         o9JBZNJz+foWn7STMq5SSBGHC7mSehJuzWU2Jk06J8lRPa0HvFhfc5Wlx/7Wo5JfvrLN
         4DMg==
X-Gm-Message-State: AGi0PubkVTKzyU9EskQuOyGnkKzwafANLEet/tWICnnqpGKJL6mw9kvP
        kroMt/wOMiZvpe1G7NVv8GRvDFT0
X-Google-Smtp-Source: APiQypIgC60EFjj1CQCh4T5ADKuuRrOOcHsK9mTAUz17dQ7Su7lPuujH1RMHvMiLmHEaLjl2sQE+NA==
X-Received: by 2002:a17:90a:37a3:: with SMTP id v32mr4610301pjb.2.1587703832444;
        Thu, 23 Apr 2020 21:50:32 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id p19sm4205031pfn.19.2020.04.23.21.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 21:50:32 -0700 (PDT)
Date:   Thu, 23 Apr 2020 21:50:30 -0700
From:   Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH v2] credential: fix matching URLs with multiple levels in
 path
Message-ID: <20200424045030.GA44448@Carlos-MBP>
References: <20200421225837.GB3515235@coredump.intra.peff.net>
 <20200422195109.2224035-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422195109.2224035-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 07:51:09PM +0000, brian m. carlson wrote:
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -378,11 +378,15 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb,
>   */
>  void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
>  
> +#define STRBUF_PERCENTENCODE_PATH 1
> +
>  /**
>   * Append the contents of a string to a strbuf, percent-encoding any characters
>   * that are needed to be encoded for a URL.
> + *
> + * If STRBUF_PERCENTENCODE_PATH is set in flags, don't percent-encode slashes.
>   */

wouldn't it be better to call this STRBUF_PERCENTENCODE_SLASH instead?, since
it is actually not applied to path?

Carlo
