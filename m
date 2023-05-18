Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28673C7EE2A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjERUuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjERUue (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:50:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86B2170B
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:50:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae4e49727eso25382535ad.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684443008; x=1687035008;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI3ib59ZZO22MUyKoYPEt/vDuDsanf0hQfzpOwJut6k=;
        b=UXha9Dzmki+8APLjBCI+XiuCngnPe0uXH4C0tc5EkcIBXUNV5bRaBTpigCwj6PjJf4
         s/3KDH/xA4GHzkM/rehKBzrP5427VclyutIoQODBUm+ZUvb4uDiyAGmaqU7K9ZG+k3sv
         G9rC0+bm5zWhs+/FdXFKZenkSNBo6WF/i+BBKeWNi0eLwWzxj6thLM31/D/nkpe2ZFKD
         NMUnZw1+j4LOfWt1zOD9aU0Bp7UzdnyTxNU6UW1GiI0lxbJgJHADasW4wWvvYG5fDe+3
         qvpXe0zCCYSvBVyGcUBREYHIC6O42o0VpQ+X3ND18q5AbUSIH4nNskL1ghRCwG6YTzeK
         QuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684443008; x=1687035008;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UI3ib59ZZO22MUyKoYPEt/vDuDsanf0hQfzpOwJut6k=;
        b=HT9z8b7Cvb+MWRODy5pFqOccnH5TdXt3z0bD1B2pLf3Wic6GCfkyt7c1YVyRd8dAHM
         SMjseTvINL5KxkB5rGVx2QM06zD7x59nJrnRhN1U8wyC+DVD1tq3EGPe1D5FJOde8wu6
         PhP6OlJ+/VAybLzd7EUEIp9NHMVztHw+0ORE5SVu3hmZNV++WE+lrP8Wq9d6LbVD4dyk
         0S1n3uJcO69ZKyNFD/vaZS0rUcNC3k/dBpznqtvV3nZ8lbdjOzD4m/1dxJ8kW8pwluXC
         Yme1k54TYyCKobwtd+H+ReJk6iaq1KAJTLs6vmvvWh5MRe+by3k3TxYHfLFQ7V39+Z8h
         j+/Q==
X-Gm-Message-State: AC+VfDx48vsiwve2FOJBVv1U6mZDOE1XsfjL8zM64VWZLBu/mQYFk2h6
        EnTqZ+g5kWtUyYLfwMmeDWZE+A==
X-Google-Smtp-Source: ACHHUZ6sqDNUWQFq/SnUTh4pAJGMVZ1rkRYAraUxLIDJ+jHmAqvjYdKRFy4g5tOEx/i9uhanbTK8Rw==
X-Received: by 2002:a17:902:ebd2:b0:1ad:c627:87de with SMTP id p18-20020a170902ebd200b001adc62787demr324863plg.32.1684443007852;
        Thu, 18 May 2023 13:50:07 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:3344:75d5:a3ff:a602])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902b10400b001aad4be4503sm1924547plr.2.2023.05.18.13.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:50:07 -0700 (PDT)
Date:   Thu, 18 May 2023 13:50:02 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, calvinwan@gmail.com, szeder.dev@gmail.com,
        chooglen@google.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH RFC v2 3/4] Add C TAP harness
Message-ID: <ZGaPeqBSkDEQLmGw@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        calvinwan@gmail.com, szeder.dev@gmail.com, chooglen@google.com,
        avarab@gmail.com, gitster@pobox.com, sandals@crustytoothpaste.net,
        Calvin Wan <calvinwan@google.com>
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <20230517-unit-tests-v2-v2-3-21b5b60f4b32@google.com>
 <c891c417-2859-b4c2-2838-e336ff72173f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c891c417-2859-b4c2-2838-e336ff72173f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.05.18 14:15, Phillip Wood wrote:
> On 18/05/2023 00:56, steadmon@google.com wrote:
> > From: Calvin Wan <calvinwan@google.com>
> > 
> > Introduces the C TAP harness from https://github.com/rra/c-tap-harness/
> > 
> > There is also more complete documentation at
> > https://www.eyrie.org/~eagle/software/c-tap-harness/
> > 
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Is that a mistake? I don't think I've contributed anything to this patch
> (unless you count complaining about it :-/)

Yes, sorry. I was experimenting with b4[1] for my mailing list workflow,
I think it got confused by your patch in [2]. I'll try to make sure it
doesn't reoccur for v3.

[1]: https://github.com/mricon/b4
[2]: https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/
