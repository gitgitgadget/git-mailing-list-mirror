Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A7020401
	for <e@80x24.org>; Wed, 21 Jun 2017 22:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbdFUWUP (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 18:20:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46014 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752188AbdFUWUN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 18:20:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 43A0720D0C;
        Wed, 21 Jun 2017 22:20:13 +0000 (UTC)
Date:   Wed, 21 Jun 2017 22:20:13 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Tim Hutt <tdhutt@gmail.com>, git@vger.kernel.org
Subject: Re: Monitoring a repository for changes
Message-ID: <20170621222013.GA24176@dcvr>
References: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com>
 <87efud8jrn.fsf@gmail.com>
 <20170621195252.GA31582@starla>
 <87a85180om.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a85180om.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Wed, Jun 21 2017, Eric Wong jotted:
> > I've long wanted to do something better to allow others to keep
> > public-inbox mirrors up-to-date.  Having only 64-128 bytes of
> > overhead per userspace per-connection should be totally doable
> > based on my experience working on cmogstored; at which point
> > port exhaustion will become the limiting factor (or TLS overhead
> > for HTTPS).
> 
> Come to think of it I should probably have asked you about this, but I
> have a one-liner running that polls every 5 minutes, but will stop if I
> haven't changed my git.git in a day:
> 
>     while true; do if test $(find ~/g/git -type f -mmin -1440 | wc -l) -gt 0; then git pull; else echo too old; fi ; date ; sleep 300; done

Polling https://public-inbox.org/git ?  no need to stop it,
every 5 seconds is fine if you're not worried about power
consumption on your end :)

> > But perhaps a cheaper option might be the traditional email/IRC
> > notification and having a client-side process watch for that
> > before fetching.
> 
> If there was a IRC channel with this info I could/would use that,
> getting it via E-Mail would just get me into the same problem
> public-inbox is currently solving for me, i.e. I might as well keep the
> git ML up-to-date on that machine if I'm going to otherwise need to
> subscribe to a "hey there's a new message on the git ML" list :)

The IRC server would have the same scalability problems faced by
maintaining persistent connections to git-daemon or HTTP
servers, however.  And, yes, email does seem redundant, and
modern header sizes (with DKIM, etc) are gigantic; but
connection lifetime and concurrency is manageable to the server
even if not instantaneous.

I also considered having clients setup a listener of some sort,
(possibly using UDP) but that would have all the problems with
git:// + firewalls.
