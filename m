Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FAECD6114
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 18:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377501AbjJISOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 14:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377093AbjJISOD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 14:14:03 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D69C
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 11:14:02 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-777252c396bso5945985a.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696875241; x=1697480041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yP3lu7W3ARHedxIIUoJwtRG/om4cSn8I6G/iPBB2Oe8=;
        b=slq6UqZEEKnZJwNdam5bbiqBNnBw3bVqF+V/fuB0GRWY6ff/IKd5+ol9OSsOjSf/Nn
         hTSUOstOg/XFUdc0U2+KgLeAm4xeggVEFIptGQ68vFf7FSllsG7C5uxpUcnL7pyu0IN6
         /Wa01d6p3B5zLXlzwz7ERF6lvrLpxefOTw/SAn+YFCeWwUUpCHYT/QgajUDmzOY07aCq
         srTd6HWEl9yNqRN+2a1AWarsMRoLoDVVdjIM1ko36lVpPyQB3yRFsgH09A7SqgkptyG/
         8M8J5wjfY3pqMnFg/BxzlGxX5C7y15xiuCjO02fbB13xXqPFYZgCanjBxEIs0aXT6TKo
         L1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875241; x=1697480041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP3lu7W3ARHedxIIUoJwtRG/om4cSn8I6G/iPBB2Oe8=;
        b=kJx6bc81PYJbZWWbm8LVZX3dhvcdhJXr2O7dSsAJapfKUApsjUrttOYvnflPSPvDzh
         Dj5YPNLUpgf4xgR+VeQYyEUgmZem4Z7HSRp0PhSFCPZkeCDh91+tebQOe9VV9CK4M9ib
         UdPTMtwGx0wSK2ykG59f0uv75rTCFAcdzjnAsd5L7umQ5cwlcuV+d1ZcwhHJ5xGZErrC
         S/3a4U4mI0Ui26MW7TihL0yIWZUpE8H/Av7aXD09ygR/UQf/umgJQTH/bI4ELRwUaNxE
         6m4FFJ4KLQTJ6y9r971gCFtLkPCvjuZUKYzazHI+mxt4T6k4vNSqWTkgHJsQpZrTX9sG
         xakQ==
X-Gm-Message-State: AOJu0YzQSB6vZl48QLLXNf90vCG7HuS2xY4INxG5I46y2mVCdPxCn3Of
        GzsDWDIbsXNF3JnfYY1g/vA2nIv/7g2+ozZqfj+UVQ==
X-Google-Smtp-Source: AGHT+IGVjeLy5AxWYpZcFfHMhrDco7sztkvFbze0V5FJNQHzqUdGjOHdr+QBxaFVpIXAOia9HlycBw==
X-Received: by 2002:a05:620a:372a:b0:774:2cba:b33e with SMTP id de42-20020a05620a372a00b007742cbab33emr18496197qkb.20.1696875241530;
        Mon, 09 Oct 2023 11:14:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a1-20020a05620a124100b00767b0c35c15sm3687973qkl.91.2023.10.09.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:14:01 -0700 (PDT)
Date:   Mon, 9 Oct 2023 14:13:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #03; Fri, 6)
Message-ID: <ZSRC5IaKoXPpTFnq@nand.local>
References: <xmqqh6n24zf1.fsf@gitster.g>
 <ZSQnVnK0k3bdk5zX@nand.local>
 <xmqqfs2j1xdo.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs2j1xdo.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 11:09:07AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Sat, Oct 07, 2023 at 01:20:02AM -0700, Junio C Hamano wrote:
> >> * tb/repack-max-cruft-size (2023-10-05) 4 commits
> >>   (merged to 'next' on 2023-10-06 at b3ca6df3b9)
> >>  + builtin/repack.c: avoid making cruft packs preferred
> >>  + builtin/repack.c: implement support for `--max-cruft-size`
> >>  + builtin/repack.c: parse `--max-pack-size` with OPT_MAGNITUDE
> >>  + t7700: split cruft-related tests to t7704
> >>
> >>  "git repack" learned "--max-cruft-size" to prevent cruft packs from
> >>  growing without bounds.
> >>
> >>  Will merge to 'master'.
> >>  source: <cover.1696293862.git.me@ttaylorr.com>
> >>  source: <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>
> >
> > Thanks. On a semi-related note, did you want to pick up my patch in
> >
> >   https://lore.kernel.org/git/035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com/
> >
> > ? That should address a performance bug that occurs when a repository
> > (incorrectly) chooses a cruft pack as its preferred pack source when
> > writing a MIDX bitmap, significantly impeding the pack-reuse mechanism.
>
> Isn't that in the above list already as b3ca6df3b9^2?

Oops, duh. I hadn't expected you to group that patch in with the rest of
tb/repack-max-cruft-size.

I'll put on my glasses the next time before suggesting you dropped one
of my patches on the floor... ;-)

Thanks,
Taylor
