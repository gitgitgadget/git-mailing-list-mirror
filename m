Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C0C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 11:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9296760249
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 11:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhKFLtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 07:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhKFLtz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 07:49:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45E6C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 04:47:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so11424346wmj.5
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=erxVfkJFfapOM95Ny/LGG3np4KFGmrCmB3lOblJLSLs=;
        b=kGnyiiAylfbZ6wacdjj/PhTrFYDDyLCbAbnviQiRirC+dtt0za8h4fKin94qPkuG1Y
         0tVF9SwjHjHYVGsaQeQgOCo4CHQaEiKFcSizbm56AcNNBr+x/tGCI4G0JcTsmOpXjWr4
         Yu8+b9ghYhCbEB7CCp73XGgE8/Q0zdDii/QIs12b1eTTcGXixEEi1pup6qiZZgOow9x8
         VaQb5EWHxH93l5ALotrH/tlDk0WTK52CBEl3HhK/WSn83M3I7WSkVHZjUKuEyrgY+fBy
         bX9WTkUg8cEPuGb8ZYV5bDt2CbKh2muHzRJ03feNFZ0Jtk2lch+ejoxVN/QXAJc5a6lo
         pqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erxVfkJFfapOM95Ny/LGG3np4KFGmrCmB3lOblJLSLs=;
        b=LEUcG53AkyU44vU+YU0xz20OldRHbVLeGPyzuc86E5tDgE74i35bNvQQCP319G7cYx
         A+ZPrmlNgi/2eFeureiiVFSDI3D2M+XwdeLCD1wA/z/qtlx4H9XxT0qWhd7+BFbObHuF
         5UYLePdh7ekBWlbjwA1fBcN4AulURAUtfBhack3djVqgW4bG318utZmp9VsSkWAeBKRO
         r09kKkmTiEVVtlsHex00LalSdxaKq24xIOLYgPAJGSmmDfFvjIXI7pg8obsnugd1+THi
         e0hmZJdmA9TD5eY8yj8BlS0VukuuQv5jEI/tm8vP9PIcXDhxCNRebTwTVPAD9uLXllHH
         wggw==
X-Gm-Message-State: AOAM531bOWNgYGkmno/Gs2E4UEKVqgjIqxtgu+kdI1v9x0t4VTxErLuf
        /enI1d8zd2cz7+D3KocNp/E=
X-Google-Smtp-Source: ABdhPJxD1ZV1otsEUOcRzgVzWaA8L8tLzgUMX9PMcySntI3ip7iB5ip6FCCJwKVIU1G5TlGenE/M7g==
X-Received: by 2002:a1c:48e:: with SMTP id 136mr38371350wme.21.1636199232534;
        Sat, 06 Nov 2021 04:47:12 -0700 (PDT)
Received: from gmail.com (62-47-8-237.adsl.highway.telekom.at. [62.47.8.237])
        by smtp.gmail.com with ESMTPSA id m20sm7558140wmq.11.2021.11.06.04.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 04:47:12 -0700 (PDT)
Date:   Sat, 6 Nov 2021 12:47:10 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rhodges@cisco.com, git@vger.kernel.org, rphodges@gmail.com
Subject: Re: [PATCH v3] apply: --intent-to-add should imply --index
Message-ID: <20211106114710.v3ew6752svuvjtk6@gmail.com>
References: <20211106112439.iw7asj4bq6uwcb3l@gmail.com>
 <20211106114202.3486969-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106114202.3486969-1-aclopte@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 06, 2021 at 12:42:02PM +0100, Johannes Altmanninger wrote:
> +test_expect_success 'apply --intent-to-add is not allowed to modify untracked file' '
> +	echo version1 >file &&
> +	! git apply --intent-to-add <<-EOF

I guess s/!/test_must_fail/
