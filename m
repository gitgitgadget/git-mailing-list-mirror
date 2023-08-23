Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B20C27C40
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 20:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbjHWT7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 15:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjHWT7O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 15:59:14 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4510CB
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:59:11 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d650a22abd7so5936723276.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692820751; x=1693425551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GmI3SUUooXdJf/epoPpMMkGKuOhwUhjzPOywVwsNBjw=;
        b=HxTFa2cw/omgiScB9ryXpM+rMo980VhAC072GSyjso8MiCnskMitLA3uF06XXAeQ+D
         6DH91m3R8mxy7JSP3w4mXXa/wD9t55TAT5V9vDQx3kxSXTqQA5pPm2EOcqwkv7uPdaDq
         ZwRD7G5EVkBUcm0nA5EZiMJ8jo4Pq6gKW4uTEcjHdckPvEkDm1IPi2Yu/x/Vti4OCdYP
         R7r1N+Q4GKwQ4wdo9d8W0C3GPfozL81QGwvfqKkOx21wAmrYapeWKuGS/5TlP3K0Ydeg
         KRBRy11nJV8YyDeyM4ii28vhQa6DKRa/IqlcZJXELuSlJ6k8QDn16U5II7jVFrNHJbJ1
         fAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692820751; x=1693425551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmI3SUUooXdJf/epoPpMMkGKuOhwUhjzPOywVwsNBjw=;
        b=G/wb6+ueutdTzuJQC61zdnK02CphIdJDA/itt69+knirY47PpPGzJj4jzK7ou0YKfZ
         K1WZVwy7JbbklMHvTeu7AkaIErlG86aFlTwuMVsiNMR9cRYO/PHbEpXEzizo+2I7PE9B
         6345bHSTICms7lVv3b8WQf5z8JWBjWjbgTUX7vw/xDFdV27sRmxOB/ZxWvDfLXVo4yuz
         016sGF31hAFXLOP8I93rr1IQAvloLB2Fq89TPtqFTjEXJxEen8XtmNnwZ8QlM9ZtCPzJ
         z1eu4oWenApJJgqByIZI2nHYSTcdbh7a9zOxZnCHvJ+C6sDJNE0FocwZJWH4XXB/eM+B
         Fdfg==
X-Gm-Message-State: AOJu0YxF/mJrA8I7lDxIS4cMbiOG1Nvux76AehyXS+hXRs7+BPsoMI+s
        2vqZb1stXNFQ2mb+jlDnzHdEEA==
X-Google-Smtp-Source: AGHT+IGNpF6YXd8GZTNZYbT+m7/3Yp1ntqOwH1EiIhBnQay2izJwbxBr4bAHJZGmV1ILpRpDtO4a1w==
X-Received: by 2002:a25:d257:0:b0:d12:77c7:b362 with SMTP id j84-20020a25d257000000b00d1277c7b362mr13883455ybg.26.1692820751052;
        Wed, 23 Aug 2023 12:59:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l14-20020a25bf8e000000b00d636d05d3e6sm2865633ybk.19.2023.08.23.12.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:59:10 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:59:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/4] commit-graph: fsck zero/non-zero generation
 number fixes
Message-ID: <ZOZlDS2w9n3tHbR+@nand.local>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1692653671.git.me@ttaylorr.com>
 <20230821215518.GA1811034@coredump.intra.peff.net>
 <xmqq5y58nfp0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5y58nfp0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 04:22:51PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > The end result looks good to me. I probably would have squashed at least
> > 2+4 into one, and probably just squashed 3 into that as well. But I am
> > OK with it as-is, too, and it is definitely diminishing returns to keep
> > polishing it.
>
> I had the same impression.  The endgame after applying all four
> looks very sensible but the changes necessary to fix things while
> keeping ZERO_EXISTS and NUMBER_EXISTS looked more or less like
> unnecessary detour.

I had a hard time picking between the two alternatives when assembling
these patches myself. I ended up going with the approach here because I
figured that the intermediate stages of the refactoring were
sufficiently complicated that breaking them up made it easier for
readers to digest the changes as a whole.

> > Thanks for assembling it into a usable form.
>
> Yup.  Will queue almost as-is (except for dropping the repeated
> "commit-graph" on the title of the last step).

Thank you!

Thanks,
Taylor
