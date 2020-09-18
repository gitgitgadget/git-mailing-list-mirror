Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0582CC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9988721734
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="AUzpZzBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIRNbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 09:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRNbo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 09:31:44 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480D4C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 06:31:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so6019706qki.6
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3AuCGZYTuqpDiWy0HX5Tq37YGQGP9U7dYVvYGVywx5E=;
        b=AUzpZzBE6zW6B5Xs+nKkckPd8C5H+eWk5GFWIL8mx7q+5361f+XZe2bHVWNPiwUaM7
         L2LiGt1LnwuIC12EH9uMFa3hYBR829wA43U3aHuW6AM6b7tu5U96Kq8Jn8songt7puDf
         UHwQbzM2SDplNKCBH8ikNYLQGoyAKflygPHD5pTIXK73YPq6LzHh/D2NhKguLczv2FI4
         XRUVXitWFxr2vD8Aa0gCirjCwpx0TcWV7zoM7PM7DF9CAuWOLAHQNci4k/FlimtPb2Jy
         IC8Gf4y4nzfQ4e7ov17EN571UvKMgwSMBhWcfj/+KBQvz7L2VLR1Lbv8xcyC7Ag0QQVW
         ZU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3AuCGZYTuqpDiWy0HX5Tq37YGQGP9U7dYVvYGVywx5E=;
        b=FeCiWclK1u0Jqjr0+CZo953Z9Ekggjiq00w1xGJd1tJ+Pxsyr28/z4ig5Ivr3bMd46
         9b0nYJxVoQZ+qWGZIZ0x273FN18eqzA9Z/EWKIHCjBFqOPI2cOdlgTPGQ8lGXtVZ9l8V
         1ctoUQ+p24C7+chJLLPLwLRG/1FlDeDoPV/dvULa9A0eizMVHXBl81g4mHChYp4oDAv3
         7Npbs6GJJsYD3BA2/phzpYFE6JB/6wZwD6oJVPaJ3TNL8CZnZRkFgKScW9+Yn9lsF2Pt
         HpUwAoiHPcbqYFgUtUOu3RcLt8pwj2M1xqsbL0tswTo84caM5mVnAqzhniInm29TvsY3
         Kx+Q==
X-Gm-Message-State: AOAM531FdybesWutvt4Hozkohw0h8c7MwJ+hN3j2FcVn8iU3N/mygvfe
        a28d9E4nNHnrRC6i0CQOTXH9qA==
X-Google-Smtp-Source: ABdhPJwT9adNvIbwnArWJpE4FWdvfVeEYvpssmHMvDHTlwCmzAYgT8daw1SQInKuueYeOTdeibHptg==
X-Received: by 2002:a05:620a:a10:: with SMTP id i16mr32803680qka.31.1600435903520;
        Fri, 18 Sep 2020 06:31:43 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id p187sm2018777qkd.129.2020.09.18.06.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:31:42 -0700 (PDT)
Date:   Fri, 18 Sep 2020 09:31:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     gister@pobox.com, git@vger.kernel.org
Cc:     dstolee@microsoft.com, peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/13] more miscellaneous Bloom filter improvements,
 redux
Message-ID: <20200918133140.GB1601745@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

Two replacements for this version, if it ends up being the one you
queue. Gàbor suggested some helpful changes on 12/13, which in turn
cause a conflict when applying 13/13.

When queueing, please take:

  - The patch in [1] instead of v3's original 12/13, and
  - The patch in [2] as a suggested resolution when applying v3's
    original 13/13 on top.

[1]: https://lore.kernel.org/git/20200918132727.GB1600256@nand.local/
[2]: https://lore.kernel.org/git/20200918132937.GA1601745@nand.local/

Thanks.
