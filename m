Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FD4C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 23:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbjEKXXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 19:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjEKXXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 19:23:11 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8119C5B93
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:23:10 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so43942896276.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683847389; x=1686439389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=toiQNm6Nd52G4xzYvY+YE6YXT5E5tjM7WXQ+AJMaHEY=;
        b=Ilt0Y6IrwNt4LgSrQBea29USZj3wGCxpYXW4nl7esy9X1Ce94dNdeb9poMJNiMQbKD
         STwCn/kmVYOPC2RAIr9pUoLa9HjgW3Mu5ZfwRICmVWryKnE5SN8urot1C5n8Ep7hxZb4
         fI2RUSZUQQqde/zEBngZjXsT2o/SNU7jCHSIaGzxKsUWVLHcfXvzQeiBJVPWkDK3yex1
         yZGmgBSkfPtffh4uKj6MzSfIJZlvPaV2rlELBzh0wk4ZKMBdTitL/2YZQfBCn1Q7mO6l
         kCRb8AruIcGsX8KStb5RpnFpytyIVEJv+HPbEhB+oDPFjSAwnJsdQmkAmSCDN3KwCT76
         kZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683847389; x=1686439389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toiQNm6Nd52G4xzYvY+YE6YXT5E5tjM7WXQ+AJMaHEY=;
        b=VCRGBM2zzCkUC49PZ8maquhuUC+WlSoaWZOrg94t4cUNFVzmg4IzW1GQ7RKGBDt57G
         6+l4CyiBd1JB6CFQ8hKEw//4naNaSGv8XnJ1MHzI5uUX3WY1Lof3Iv1wjYFUn1+cw7cw
         NjbEa9l2m2+1TPindHEEMaK6v0aC4FzwGRLLkMPB9QD+16HMoT+hFLo9ZENa1cC42m8m
         s7eWg/m69aPjEVbjTvmPh+srkTjJBO2KOPk+hYGlcm+LIG+sA831Kkb24HF9Fh3HWV33
         zGFPNPKcfkeNyZICBh8+2z2kH08nKsdaoAnGXSjFav/s+dxmtxaOhA8LBG87EyLUAg/Q
         5I7A==
X-Gm-Message-State: AC+VfDxea1oyQTEuZTzB/UdxNRqxdMV19jmX0r/oaRo/TjAUt5+rFYH9
        Mnmwq3g9F9t+VLfflpzx6rPk9pYeTK+OS0L7/7btOw==
X-Google-Smtp-Source: ACHHUZ53JEnznN/YEbkOdRoWKWX15UrDG9/7MKP/D1s3Z3kdFiLLewF1ll1umOn0yUFGCsQl/Nv9Ww==
X-Received: by 2002:a25:3287:0:b0:b98:c6bb:137b with SMTP id y129-20020a253287000000b00b98c6bb137bmr24588374yby.9.1683847389583;
        Thu, 11 May 2023 16:23:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u9-20020a252e09000000b00b9d255709f9sm4641120ybu.2.2023.05.11.16.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:23:09 -0700 (PDT)
Date:   Thu, 11 May 2023 19:23:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] pack-objects: introduce
 `pack.extraRecentObjectsHook`
Message-ID: <ZF143FzAjTZJ00/O@nand.local>
References: <cover.1683847221.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683847221.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 07:20:31PM -0400, Taylor Blau wrote:
> Here is a reworked version of the patch which introduced a new
> configuration `pack.extraCruftTips` to keep additional objects from
> pruning during a cruft pack-generating GC.

I'm starting a new thread disconnected from the old one since the
approach is significantly different (but mostly because I forgot to set
`--in-reply-to` when preparing these patches ;-)).

Strictly speaking, I think this is technically "v4" of the original
topic, so v3 here is a mislabel.

Those interested in following along with the earlier round(s) of
discussion can see the original thread at [1].

Thanks,
Taylor

[1]: https://lore.kernel.org/git/8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com/

