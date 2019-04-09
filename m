Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1E320248
	for <e@80x24.org>; Tue,  9 Apr 2019 03:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDID2d (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 23:28:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44473 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfDID2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 23:28:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so3201173wrn.11
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 20:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yg9TSXIqZ6R4IMfD1Ahy1Dc1J8bQdBS0E8aRFt7zsrE=;
        b=jbCN2IH+CoFs53wI0u4lm+K6wn7+3mSR22mY6T4bkTn6tT1ELoLJeFRH82adTNAe2h
         33uqD7x3vlOO1GcupjQDirmsdeUNLcK2WMSI9O0+sdO/2AODrGHlhSS9fD8BPzVdpG80
         Xd4MlI4CsAergFH6zC0tT4crVPHfKELyGbLstC+yk9WNEWpFglWVkS6NpnkpczI0PBF4
         Pq4X5Cajw/8uxN4oK3snPGGsmJh5ZVxl0z9XI6TjpALPnUHVkeSAWfYD19r6HFocgpQ7
         qet/g7sHzHI6VnkXpgFQjG1twNowSrshFcvTqLo8mT2COhNtquv/Gy1XwboxaxGWT+oJ
         8H7Q==
X-Gm-Message-State: APjAAAUCPt0rNgjKsxQGn05GCKCsibk3gcUgmulYwKJyqd05B+YAI+b2
        vffxT9NwBhS6ZkZXYuqK5tfyEt+ZawIkiVoMRPU=
X-Google-Smtp-Source: APXvYqw7VQ9rO16UgVatpgYfQ+dhqN56NOgKpdWd2b7AseTR6+Y8gUgy10ElHo8FMXnRNiYhOmox75KCRZdnAfBYABU=
X-Received: by 2002:adf:db05:: with SMTP id s5mr21841549wri.247.1554780510970;
 Mon, 08 Apr 2019 20:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554435033.git.me@ttaylorr.com> <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev> <20190405182412.GC2284@sigill.intra.peff.net>
 <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
 <xmqqbm1h9et2.fsf@gitster-ct.c.googlers.com> <20190409023055.GF81620@Taylors-MBP.hsd1.wa.comcast.net>
In-Reply-To: <20190409023055.GF81620@Taylors-MBP.hsd1.wa.comcast.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 Apr 2019 23:28:19 -0400
Message-ID: <CAPig+cS+4tTAAWsp+KX2-__kcvgDABQQCmz63d6pQUa6Qu3LKw@mail.gmail.com>
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 10:31 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Mon, Apr 08, 2019 at 03:44:25PM +0900, Junio C Hamano wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > >> > > +   git cat-file commit $commit |
> > >> > > +           perl -lpe "/^author/ && print q(parent $blob)" \
> > >> > > +           >broken-commit &&
> > >
> > > Trivial and portable 'sed' equivalent:
> > >
> > > git cat-file commit $commit | sed "/^author/ { h; s/.*/parent $blob/; G; }"
> >
> > Looks good.  I had a bit of head scratching moment when I saw that
> > "perl -lpe" one-liner; this sed expression may not be crystal clear
> > to those who are not used to, but it is not so bad, either.
>
> Should I take this as your endorsement of putting 'git' on the left-hand
> side of a pipe? ;-).

I suspect that Junio's "Looks good" was referring to the 'sed expression.

With all the recent work of moving away from having Git upstream of a
pipe, let's not intentionally introduce a new instance. I wrote the
example 'sed' expression that way merely to mirror how the original
'perl' version was written to make it easier to see the equivalence
(not because it was intended as an endorsement of having Git upstream
of a pipe).
