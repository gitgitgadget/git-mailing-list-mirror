Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293CFC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71DA20714
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbgDATgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:36:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbgDATgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 15:36:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id c7so1488611wrx.5
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 12:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuGFjWAzueAW4jUU0UMNB7EYdc9lTDSeUolanks/mkQ=;
        b=IWnnslxLecsamGKnwFDIiQbO7KGFwQPQET7PEtC5UwOZzxov7TMXBRTDuQ9Qo1b/X+
         tZu4swTP6knmSgKH7j8LsBgQEt4CEZcYCba/x5WAhef9fH7z6BtcPQdjYFvZAxzNcd/J
         apC/pESXsVg3CjOj85PQs2vCIHPg8uoa1zgYTzssyaFVMu943MF2t6gPXukq/zzz0SKo
         lLvrr58eebBvMhwObFMTbMtA99jrUVs/ZI0FsqzPy+43X2OBZY1KydyOqNjAHzdkAvOu
         0BwNAOZonh/L1VLKLVH8BJGOB7rjFRBmeVvjEIW2L3znkposAi3QqkogC7RXkJ0I9mIT
         Eryw==
X-Gm-Message-State: ANhLgQ15LTSAuS8CSj0KP57PsnULibPg6CvMTSSdWosOZYW8bjeg9tgu
        yClsL4TR283IpelLxD4lL56HxuLw3cTZS2xghjo=
X-Google-Smtp-Source: ADFU+vtqkDk8Rqxs4Dv5N6qY6cgPyyeSlp6nwiCoh242b+qFVr8GU+XtJlSmgILskiFkNKTydUP/l4T3KiKnopy9MtE=
X-Received: by 2002:adf:decf:: with SMTP id i15mr28852149wrn.277.1585769813145;
 Wed, 01 Apr 2020 12:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com> <20200401192715.GB13599@syl.local>
In-Reply-To: <20200401192715.GB13599@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Apr 2020 15:36:42 -0400
Message-ID: <CAPig+cQc+Qr=BHKgWkQv8QrB47qG+-Y0+DQeKj5WD6VwzeAyHw@mail.gmail.com>
Subject: Re: [PATCH] commit-graph: fix buggy --expire-time option
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 1, 2020 at 3:27 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Wed, Apr 01, 2020 at 06:11:35PM +0000, Derrick Stolee via GitGitGadget wrote:
> > -             git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
> > +             touch -m -t 201801010000.00 $graphdir/extra.graph &&
> > +             git commit-graph write --reachable --split --size-multiple=10 --expire-time=2019-01-01 &&
>
> Could this be written instead as:
>
>   touch -m -t $(date -r $test_tick +"%Y%m%d%H%M.%S") $graphdir/extra.graph &&
>   test_tick &&

This won't work with GNU 'date' command which doesn't understand
"-r<number>" (it understands only "-r<reference-file>").
