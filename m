Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A3EC43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiF2Ulr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiF2Ulg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:41:36 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463943EF24
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:41:35 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id q4so26661653qvq.8
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=REliv1KLGe0JrkFCPoDFJg4evkxm/+GCiFJXuoHUTpg=;
        b=gxA+q4AK/ymGx90p36TWnlfIFnGBNadK7lqnp+3jyCRRYPasEaA8+BXrMD5QQlRUGG
         5eoIdpqslZzetlTxf8ZQkcoYNFeVv8KusC/r9IoNvP05DmOwNHXi1s2mx92JygDy7KoX
         7vb5fw0/bMvsi68dmaaNjI7jVpPkEUAtFhqc/459mTq6W3ldfcTUr6m9ksKR/uPv9y8B
         6QlW8thn4HRBYH9symHTd9VeAgezB6S/Zt+PL/P3mK7EiR/QGrmbm4u6pyMiFD3blU2J
         VAgslJjPy/qUL++1JaW5CNdLHSfaU4v2KSCAemdVqfnQcUHnX+mn0n35YG8bMXOpLmIt
         YLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=REliv1KLGe0JrkFCPoDFJg4evkxm/+GCiFJXuoHUTpg=;
        b=3+PXlCn71KqouCqHzEMcoFxVbtCVW/lcg1JriYY/JplwMSzFrJCDZrWCLo6qsSz2H3
         rp6Bi9jwVghlqA2cg3FgoKyr/cssKXZ98tjjxLCa9zZQX8cE3nzEHZJknSCmIDqC1VbU
         FJSTAhOZs3sB5r3Yn43Ff00jdnoKwJLgWEcKSDp+0wkJiho5UIAo0TXvU3vNgESKeh3d
         IoNFFGGPvMMO0Wn+KvIcldcLJ1GmhjVx2LE96nFqHv9lh69GmzCxxAQzSzeJ+l3VFUYN
         LlztSULp1wTBvEeGUu1STLFhzwOWRQ4s4EmUmWQSI0kwrv5APxi0h1nO4FjDjBKPJ206
         qb2Q==
X-Gm-Message-State: AJIora/SudTSjkHYqrKcXW5E2KGaNuRca6FFceJR7Zy+YJ63HzN7tijC
        8GKfEdz3SE5Uq2gM3yb8ThZuMA==
X-Google-Smtp-Source: AGRyM1smGYvRKmjL/PNQoG854vgyMycHlvMtGNzYYXqyEXYuoY7J0tKb0T/yMp8+3p0z0vr/LxzLvw==
X-Received: by 2002:ad4:5c68:0:b0:470:52b5:c85c with SMTP id i8-20020ad45c68000000b0047052b5c85cmr9535514qvh.3.1656535294414;
        Wed, 29 Jun 2022 13:41:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f30-20020ac840de000000b00315110b47bcsm11401036qtm.22.2022.06.29.13.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:41:34 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:41:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table
 extension
Message-ID: <Yry4/W6ENxnljI60@nand.local>
References: <YrojV5aYCzxXlV3c@nand.local>
 <20220628192555.23565-1-chakrabortyabhradeep79@gmail.com>
 <Yry4ElVFQEsVbqse@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yry4ElVFQEsVbqse@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 04:37:38PM -0400, Taylor Blau wrote:
> +				return error("could not find commit at "
> +					     "position %"PRIu32, commit_pos);

Oops. Pretend that I marked this string for translation ;-).

Thanks,
Taylor
