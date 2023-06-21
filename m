Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D898CEB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 11:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjFULHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjFULGf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 07:06:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522CD10FF
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:06:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bff89873d34so340561276.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687345568; x=1689937568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jctbYp5Zt7LO6KX+iijn4S7ITSnQv7VCAAbjLqUXlcI=;
        b=obuRCAPeVKHVup/cEkIfKELqbXse7O3Ji7vbD0uT+xB/R/VeCDrJz/rEcpqtZKQQq3
         hmCXD2qyhqRAbfcnRTQItoE7bgWdDmJSCTTWqpmjjkwoU4hoJkBIlSPPeodLWFkU3bjD
         nLplYrDoUye8Y6AlwipFPjeXFihZksYLLnqeJAhVYrZKstpi+ICxao2D39QK6g3YCXeg
         XHnHr8asmgFfEzN5lA2bk/6+VOhlPKkf+1K5G1MKpKiUE3N8UNj3sisdmUe0lMJ9YU9H
         xALP9xCGddYos2xA7R3y9Sw3FLCiWE7MYDciQmzOaj/LdADasNYOYk0nSvBz+sXDCHA6
         NGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687345568; x=1689937568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jctbYp5Zt7LO6KX+iijn4S7ITSnQv7VCAAbjLqUXlcI=;
        b=KqlNQ4Wx5kIM7bDCn2YScm0VBNRCyil4Ub6uHvdBzygHP7KSCjP9HbYIl1LKJaJfCD
         PZ3ry5JWL1Yeb2GTw7Ur/jN+5996ropF1JpjvBK4nvqSZmeOcQdzpkQYDdTNyZE8t0Df
         T726kdCIWYlhVOOil+K1LKezM9HU/Do94LhTK/Wa+o5zNcFggA69wSAze2jpQlCcY8Pf
         dCax/6Qbmj0bxf8fWYKPOKDEx93JF1jR/G/w6K4YGpnBBvWIMSnKBIhrXiIrkFjUwYxN
         1LJG3RIPXBFNR2uOxAWA121lJLA9CbRJTHdIMWPJKVY1omWNnLZp13dcyO3q/dobn+z+
         qaKA==
X-Gm-Message-State: AC+VfDx0V5gOVcz7Ivg+HIG/cyFwKzZu5M3EwGSRjr8QDuZz2DFH/JFv
        1krc+T7Z5myz5VAmO7BJIFTYkQ==
X-Google-Smtp-Source: ACHHUZ6gdX60Vy9uvi4tqJmLC5pKwcesFZTz4mCmx3EqKjNXUCUCeSdeVg7olHxI4udKGG0QO512GA==
X-Received: by 2002:a5b:d0d:0:b0:bfe:720e:ba68 with SMTP id y13-20020a5b0d0d000000b00bfe720eba68mr1857952ybp.43.1687345568496;
        Wed, 21 Jun 2023 04:06:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c22-20020a25c016000000b00bb144da7d68sm883489ybf.13.2023.06.21.04.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:06:08 -0700 (PDT)
Date:   Wed, 21 Jun 2023 07:06:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 5/9] repack: refactor finishing pack-objects command
Message-ID: <ZJLZnS1olivaQ+GH@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-6-christian.couder@gmail.com>
 <xmqqilbotgbp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilbotgbp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2023 at 05:13:14PM -0700, Junio C Hamano wrote:
> Computing "is it local?" based on the value of "destination" feels
> it belongs to the caller (one of the callers that do need the
> computation), not to this function, especially given that the full
> value of "destination" is not even used in any other way in this
> function.  And the "is_local?" bit can instead be passesd into this
> helper function as a parameter.

Hah. I had the same suggestion down-thread, but hadn't read your reply
yet. There are either a couple of changes we could make to
skip_prefix(), or foist the responsibility onto the caller (I tend to
prefer the latter).

Thanks,
Taylor
