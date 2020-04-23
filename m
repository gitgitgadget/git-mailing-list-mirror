Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A35C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72EB12074F
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="FcJ9uVRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgDWVnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgDWVnI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:43:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEFAC09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:43:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s18so865839pgl.12
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zMt2n5LRi9tTajgO7FIGKUxl6Cy8mUMMjrBpuwG+uuA=;
        b=FcJ9uVRy6NZ9YxVgflIJDeJidV0zX5Nyo6Cu154/LM5PZHXdPLHtKtACmqrKcGHKwv
         3VJQOOACTnkCT47uv38y0MPJ4UTwsBckaje6+vqd/ZvnZcQMhcTX5qWWPUTlD/8YTeP9
         z4tlMTHwSJAeFWweUJtk1vBuAerQ515eKZM/kONIb0Yw1HB3hq+YVxNgBieVdh4abwEY
         8ytgK2ArRMgS8orXF+Wvy5EElGp6fNwGLQ70A/1vsqm06asnPVP7gC0W6iqcXcUTljRK
         zfx0mmCq+WQlMmH0bWslzp1hQtrq9ipiXLKPPkcVdjf4lZWAxwcHB9DbFZ7EpUf/9shB
         WeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zMt2n5LRi9tTajgO7FIGKUxl6Cy8mUMMjrBpuwG+uuA=;
        b=gV94UKXMtB8Z5KUbG3CSreSPKc19C5yuNy7ejfRSiUwm3jGWDx2RlrboI54y0DF/o6
         6i/MgDEZfgNAnLSZRafUzsw8G8llwJIjmmBBY9L6dhfVV8FfTTd+ZR85xQ95EFrIjoO3
         oTQJziEbbz7ywKDcDBiMl2B8WQA2zcF2IXZb+YPhYhbVagGCH4KxXnH6gVD2avdv8f1O
         I5S3d/0kxZqAv/KmeDa/X4t4b/Z7xa+u0/cPpQPA11ijWP+Pr9FSI4ST0w49HHZF29NQ
         OGn5dAfBgH4UIt4uvWLpOj2D/CK1YGH9zlBIxm0IA4a41fYyKDz3fPZ1GIJDkzJLyVFZ
         1CAQ==
X-Gm-Message-State: AGi0PubBuj93eQoXD6ifWRe6+o9crnY8obNfH/57f2pUM6T7p48931DX
        UMPf7PKjkU9She8ETOvv/qhttQ==
X-Google-Smtp-Source: APiQypLKzuvFLi98NohVOI0PiKpMjtxW8o6Yz/n1lyWukM8tX9uFbPOVSHhfvO4vE8EoAIfUOVS6xg==
X-Received: by 2002:a62:f908:: with SMTP id o8mr5809867pfh.170.1587678187467;
        Thu, 23 Apr 2020 14:43:07 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id e66sm3526027pfa.69.2020.04.23.14.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:43:06 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:43:05 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 0/4] commit-graph: handle file descriptor exhaustion
Message-ID: <20200423214305.GA48325@syl.local>
References: <cover.1587677671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587677671.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

...I should mention that this is based on my series in [1], since it's
much easier to express the new test in t5324 with '--split=no-merge'.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1586836700.git.me@ttaylorr.com/
