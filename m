Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292CFC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjECVsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjECVsw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:48:52 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CA05FDD
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:48:51 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so5900753276.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683150531; x=1685742531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dqgXmpQ2ObEWzWRx68j8qSafd5gmvXOgb9LmAPYNbws=;
        b=J+dynobtcEiRkRKB/FKfkfyNV2fekoHTA26jvzH7YiCVnqPQWdwUMDSn9sGK3vOti5
         o8N9E0sy8NjJc5cAsS6WqT68Ze1rvlCi6KnFsuj4KBz+3hcBmM5EV4Sdr5lbxmSs+9qf
         01MNmiG5mJh7GDdT2zacDxcERwN8Lu0LE7yz75AZAuczKwP9wpk0teWsTz1c+YNQ00Cv
         GwKCiTHEE1AYnZ5WqFAS0iguIQN9LElFRMreSBFc5kREj3+3Rj3fbRr1eYT6NkxU53Sm
         uYlTghmrpH16E/kDzTJD6GRzVRz1Rgz3ZH05htPjXuF9lBZuS59n34RwInbYHwqsSzw8
         79GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683150531; x=1685742531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqgXmpQ2ObEWzWRx68j8qSafd5gmvXOgb9LmAPYNbws=;
        b=MS0B+mw4ko5PjOr3fbwmPV5rm8e73ZpwWmhqSY4H5njpWLWyddDevbtN0Ptg/FEyGf
         Ie9tdxAPDM8XrjJqvQxAj38CGc+6UpGc/RYCMnXYYxwadZWH7bXgsABNmCWYkwA3lNfn
         MpHsr/93JEXc+dAid0hAJCMS2rXJRoLgiWfCdJIfRbs2el1CY/rCXgVG36uGYFReGHVV
         R65SN4tLdynBpCUlKPZZ3q4usSYBpxrVj9iqTyUlapesB8ahms/xAHyDjOryC8g/b13p
         DNmZLYd3QSTlRrr2BrCEe1jgPK0nLH3QKpmPjjmlvKNkly0ESnaworE42fWh6mTiOsWE
         r9UQ==
X-Gm-Message-State: AC+VfDwJP6H22pfE9JS93zzpr/Ks6bAVI00p0HlMtOMZGXWJ30qXgLQ6
        hfxewhYcQtNrSdezyjwpyzACLg==
X-Google-Smtp-Source: ACHHUZ7mXutjqQZVvPIVRV329erap+nCEPgjA/JLiFVLQtXmBhmXzpPi0jK/KEm8cf9fwZJD6LfGow==
X-Received: by 2002:a81:2553:0:b0:559:e5e3:fe76 with SMTP id l80-20020a812553000000b00559e5e3fe76mr47274ywl.8.1683150531074;
        Wed, 03 May 2023 14:48:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x6-20020a25b906000000b00b99cfb2ab6esm5477131ybj.18.2023.05.03.14.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:48:50 -0700 (PDT)
Date:   Wed, 3 May 2023 17:48:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] revision: support tracking uninteresting commits
Message-ID: <ZFLWwTAIxRnNUKDp@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <a643678c0ff7d1a910b1d6c33a839166e2a6a7b2.1682380788.git.me@ttaylorr.com>
 <0b8884ea-f37b-b7d4-6edb-825ca935a893@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b8884ea-f37b-b7d4-6edb-825ca935a893@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 02:15:49PM -0400, Derrick Stolee wrote:
> On 4/24/2023 8:00 PM, Taylor Blau wrote:
> > The boundary-based bitmap walk will want to know which commits were
> > marked UNINTERESTING in the walk used to discover the boundary.
> >
> > Track which commits are marked as such during list limitation as well as
> > the topo walk step, though the latter is not used.
>
> I was surprised to see this as an addition to revision.c, and
> only specific to limit_list() (and its iterative copy). I would
> expect this to work for non-topo-order, too. I suppose we couldn't
> completely trust that the first visit to a commit includes the
> UNINTERESTING flag if there is clock skew in the commit history.

Yeah, the distinction between limit_list() and the --topo-order code
makes things a little funky here. But I think that's OK, since
`--topo-order` is not likely to be used here, since this is all
bitmap-based traversal. IOW, I think that it would be reasonable to ban
the revision args combination of --use-bitmap-index with --topo-order.

> But could we also do this at the caller's end by passing a
> callback that checks each walked commit if it is UNINTERESTING
> and adds it to a set?

I think I remember trying this when I originally wrote this code, and
ended up discarding the idea because it walked over more commits than we
needed to consider.

Thanks,
Taylor
