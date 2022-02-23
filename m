Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C93C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbiBWSD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243755AbiBWSD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:03:28 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D19D43EE4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:03:00 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id m185so25457547iof.10
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EgHl+bGJg8UQ3Ex+QvUU/f/PZ6j/HSr2vv9+Pi9kHe0=;
        b=UVTh0gfjOL+3po1i2iv50jsHmGu2F5kGa+TZAWXljA96vPZ66sbmbETGBL+kyJZ+SS
         T0IXF8ZZBd80ktEbKfe8417fDOQ8Lr6sEoGFrvBi8Av0eSq8k1mo3pD0LnNlh1ZzBAMS
         sgVAeSDIhsHZSW/qyv0zZ3MXidfoJ4KUViEHv+2hDf6jAAtiTkkUfkzvap8oYKjxq5PN
         0SYFw1IMf8rY7pN2m07mQh9VRUorOo5OVOPCYWgMgFvRhjTa6S0CjxNtObeEGn2itsSS
         9hLoLiot4Qc1agI09JmVzoDYjsOQSXH77DRo8ERlcnjKC18eaTP9cvrDs1+0C2rM/K9K
         YuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EgHl+bGJg8UQ3Ex+QvUU/f/PZ6j/HSr2vv9+Pi9kHe0=;
        b=gqIqzMiftDToNKX6AEhBtAvSXfNfmR8OHpk+j7DOjsezR1DXP+W+BD9fApXFMiPMuF
         hva5nrtlOQSQVVkOvUTee4K5SI5Tc3jjGBZNPnlp3iHdcKDkOISxZrzr99rJyx/T1+Nd
         XcmGI1+1QB8LZJhfjW8wFzS4PrWlc85E/tciOtu6kbRmLq4ao6R0MPBWSkDlaGKydeQy
         B4Lyb6zkWu25dtv/eqLKlWPutAeTQHnWOymqHf65ytaCkDHxw10Qf4BXgc7j0ysJIYhJ
         /92cjDFqesk23q8TJcGImHdWGCSQkIUTPMyR5D+BLWy7axzIs/z6qFyf5ygHoq6BR7sC
         +fwg==
X-Gm-Message-State: AOAM530vNz9lNqOkyBfE3LlDf31R8k2uozgsHYrWJhEJH60dQDybhX4E
        cW9F9jO84vvmEOycj3uTFrXZQQ==
X-Google-Smtp-Source: ABdhPJy9EtBOdR1yfTS5n/WQ5bwYh/CbmkbwX9a8VFcsIJmhkRxj1H0nXhyGZ+6pR7srtBUs8w0Ivw==
X-Received: by 2002:a5d:8714:0:b0:636:13bb:bc89 with SMTP id u20-20020a5d8714000000b0063613bbbc89mr469529iom.126.1645639379946;
        Wed, 23 Feb 2022 10:02:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s4sm216808iol.18.2022.02.23.10.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:02:59 -0800 (PST)
Date:   Wed, 23 Feb 2022 13:02:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/2] t0001: avoid pipes with Git on LHS
Message-ID: <YhZ207PO0jOmaD6V@nand.local>
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com>
 <20220223115347.3083-2-shivam828787@gmail.com>
 <YhZ0qOwtY1vUVTiN@nand.local>
 <CAC316V5nWB8_ctk6Wz9j_xPMogomktuDdXZkPz2TodqRVXZPhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC316V5nWB8_ctk6Wz9j_xPMogomktuDdXZkPz2TodqRVXZPhQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 11:31:41PM +0530, Shubham Mishra wrote:
> Ah, It's dumb, I'm sorry. This was unintended. The regex I used gave
> me all Git on LHS of pipe including this.

It's certainly not dumb :-). You are doing a great job on your first
contribution!

Thanks,
Taylor
