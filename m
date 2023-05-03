Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F13EC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjECVnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjECVnt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:43:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D89124
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:43:48 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-55a64f0053fso55616577b3.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683150227; x=1685742227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sVnqxAimgmPfjjTlD0WdIU3WFUUSFQ07RXLaVWbUVNY=;
        b=rDNpNgic+5nV//Y5llrhXD7YQASUs5Spx1LSLz6yE+956fQPyx2DvgqrhW/2o+QPpC
         SuRZG5qTL46oz+LU/lM5o7f8Fh5HAIi+Uy6zvH8GhWt9Up6CP03/1Gv/J/jIc03fWO6t
         FZKcR43nouXoNEQprHjolTC26o+G6dgoaNvM1tdgKEqoR1x7lJCGB9pzlSmZQgI7JL3V
         8V40XhCWPo0QMoi+lwzYGjeengcsynfTvaUNMNFnj+48I8chbEEDprOMAsb/w90BNB7i
         A5CX9CAJ6omf+arFDdIJsUGjN/Ol4vDrHEg7nm5RR4+jsQ6X9eteSmez/MvclIsHGUbD
         PvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683150227; x=1685742227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVnqxAimgmPfjjTlD0WdIU3WFUUSFQ07RXLaVWbUVNY=;
        b=CfBAEvL4ugSo84A4PvRqjTRSNlDL+AUgs+BMJZJRqL7AFI5jauzmQ6TzN72gHAp6eK
         6K6FL985+Bk4tEDyn07OcZNCvRwAwGbxAssD8RBTE7H0D2b066sjEg1aQAYTVgpIkQRL
         vIJDDPZOACggNcw6NFwFul43RyHU/wyxYRVe8RxPPtrTVJFc3F27ILvYym81XaPZja79
         UjFktEsXPMruyJUlUs1V5rDSo4nz5444Kay9dc/R4GCgiOtd0lmWQtKspfYADBYoZWek
         YytVYXcaeCPdKtHyBpdLVrJQmovQv0TeiMPc1YLBQh3NjyjOpEHh9VXJBACAGq7jfRag
         TSxg==
X-Gm-Message-State: AC+VfDw0NrhV8f0KIXrH3eCNGuKc09gbwUB1AKJFBCTpEkiAOC2duQJi
        Ur0n59zdOMj/9qwGKvlVp8zNyQ==
X-Google-Smtp-Source: ACHHUZ5yQkPYDVV2cqsWVXeCu4yzO80ubJhM9rmBBvCntAXzVF+Onz9P6j3tKLAgT58NNOlk6oGQJg==
X-Received: by 2002:a81:8412:0:b0:55a:1c7b:2dc4 with SMTP id u18-20020a818412000000b0055a1c7b2dc4mr46262ywf.15.1683150227443;
        Wed, 03 May 2023 14:43:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r2-20020a815d02000000b0054f97b52934sm9008806ywb.54.2023.05.03.14.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:43:47 -0700 (PDT)
Date:   Wed, 3 May 2023 17:43:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
Message-ID: <ZFLVkrrtMXaOJCxS@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <xmqqy1mfzvpq.fsf@gitster.g>
 <1a09d246-5750-7d98-08f7-bad6d3dee3c9@github.com>
 <ZEgikbdP8M2sDMlM@nand.local>
 <5943de3d-3dad-c600-c6d6-3c10c2851071@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5943de3d-3dad-c600-c6d6-3c10c2851071@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 03:52:29PM -0400, Derrick Stolee wrote:
> It's a good opportunity to re-think if we should be using bitmaps in
> these contexts at all, or if there is a simpler thing to do by
> disabling them when 'haves' exist. I don't think that's the right
> thing to do in all cases, but the experiments you've demonstrated here
> seem to point in that direction.

Yes, I agree that it's a worthwhile direction to consider in the future.
I fear that it will be hard to come up with absolute rules here, but
that doesn't mean it isn't worth trying :-).

Thanks,
Taylor
