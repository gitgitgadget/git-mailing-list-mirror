Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7E91F403
	for <e@80x24.org>; Thu, 14 Jun 2018 05:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbeFNFzF (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 01:55:05 -0400
Received: from mail179-28.suw41.mandrillapp.com ([198.2.179.28]:17671 "EHLO
        mail179-28.suw41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752176AbeFNFzE (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Jun 2018 01:55:04 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2018 01:55:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=bhsORCeQ3SQS8x1qXMBftbTkMogop3ubWDAUCP7o/QI=;
 b=Mj5d9j1F20pzK39Q8RrDcUW7ayW2mRF7yGx6qGr9+ZAYblnvji1V4GsnO5Mr4kk2OBQkAjYCbbi8
   lYnmqgPNgLJeZBRcV/sci6csF+CHZI5ZgdDN1CQIOVF1hPDA2VdqcmjJj6VFegsf3vUEc6DQYMu6
   vrZnbXDpEJs5pOvITDE=
Received: from pmta04.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail179-28.suw41.mandrillapp.com id h481jg22s289 for <git@vger.kernel.org>; Thu, 14 Jun 2018 05:29:42 +0000 (envelope-from <bounce-md_31050260.5b21fd46.v1-48e6a575e64644c7b3a494d34025058a@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1528954182; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=bhsORCeQ3SQS8x1qXMBftbTkMogop3ubWDAUCP7o/QI=; 
 b=IEkHp5q5o2gAqCtmQpw9HJdSWBX+wtB1vF6nLplWVkEhRATeUyqSd0CDaadnS3Y9PmZd8U
 52wFyl5iIxD/FD0aNK6nFvcfxY9oLsQwoAizSDvFzjgRtziBuKE1YE0bnFXfagsz4lkmugi1
 48SHitVmdjeFn4AFvCoxOQ6NCDuac=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH v2] fetch-pack: don't try to fetch peel values with --all
Received: from [87.98.221.171] by mandrillapp.com id 48e6a575e64644c7b3a494d34025058a; Thu, 14 Jun 2018 05:29:42 +0000
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Message-Id: <20180614052938.GB2861@deco.navytux.spb.ru>
References: <20180610143231.7131-1-kirr@nexedi.com> <20180611042016.GA31642@sigill.intra.peff.net> <20180611044710.GB31642@sigill.intra.peff.net> <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com> <20180611055357.GA16430@sigill.intra.peff.net> <20180611094255.GA15563@deco.navytux.spb.ru> <20180612094849.GB26123@sigill.intra.peff.net> <20180612185413.GA21856@deco.navytux.spb.ru> <20180613211302.GB15574@sigill.intra.peff.net>
In-Reply-To: <20180613211302.GB15574@sigill.intra.peff.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.48e6a575e64644c7b3a494d34025058a
X-Mandrill-User: md_31050260
Date:   Thu, 14 Jun 2018 05:29:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 05:13:02PM -0400, Jeff King wrote:
> On Tue, Jun 12, 2018 at 06:54:17PM +0000, Kirill Smelkov wrote:
> 
> > > If an extra connection isn't a problem, you might be better off with
> > > "git ls-remote", and then picking through the results for refs of
> > > interest, and then "git fetch-pack" to actually get the pack. That's how
> > > git-fetch worked when it was a shell script (e.g., see c3a200120d, the
> > > last shell version).
> > 
> > Yes, this is what I ended up doing:
> > 
> > https://lab.nexedi.com/kirr/git-backup/commit/899103bf
> > 
> > but for another reason - to avoid repeating for every fetched repository
> > slow (in case of my "big" destination backup repository) quickfetch()
> > checking in every spawned `git fetch`: git-backup can build index of
> > objects we already have ourselves only once at startup, and then in
> > fetch, after checking lsremote output, consult that index, and if we see
> > we already have everything for an advertised reference - just avoid
> > giving it to fetch-pack to process. It turns out for many pulled
> > repositories there is usually no references changed at all and this way
> > fetch-pack can be skipped completely:
> > 
> > https://lab.nexedi.com/kirr/git-backup/commit/3efed898
> 
> Thanks for sharing that, it's an interesting case. I'd hope that
> git-fetch is smart enough not to even bother with quickfetch() if there
> are no refs to update. But if we have even one change to fetch, then
> yeah, in the general case it makes sense to me that you could do better
> by amortizing the scan of local objects across many operations.

Thanks for feedback. For the reference in case of git-backup `git fetch`
or `git fetch-pack` would have to always do quickfetch scan or equivalent,
because in case of backup repo there is only one reference in it - its
master - and references of backed up repositories do not have anything
representing them in backup.git/refs/ .

Kirill
