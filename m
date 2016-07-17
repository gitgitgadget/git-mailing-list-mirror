Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED,
	URI_HEX shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C7E2018F
	for <e@80x24.org>; Sun, 17 Jul 2016 23:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbcGQXHV (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 19:07:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55306 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbcGQXHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 19:07:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94EB52018F;
	Sun, 17 Jul 2016 23:07:18 +0000 (UTC)
Date:	Sun, 17 Jul 2016 23:07:18 +0000
From:	Eric Wong <e@80x24.org>
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] list: avoid incompatibility with *BSD sys/queue.h
Message-ID: <20160717230718.GA8569@starla>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
 <FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com>
 <20160716210454.GA7849@starla>
 <20160717002533.GA14200@whir>
 <CAPig+cRvhbKwr=QJAyp=sYLLGDx-B2EHovHpn8Z1701stQMi1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRvhbKwr=QJAyp=sYLLGDx-B2EHovHpn8Z1701stQMi1g@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jul 16, 2016 at 8:25 PM, Eric Wong <e@80x24.org> wrote:
> > Eric Wong <e@80x24.org> wrote:
> >> I also wonder where we use sys/queue.h, since I use
> >> LIST_HEAD from ccan/list/list.h in a different project
> >> without conflicts...
> >
> > Still wondering... Checking sys/mman.h in an old FreeBSD source
> > tree I had lying around reveals "#include <sys/queue.h>" is
> > guarded by "#if defined(_KERNEL)", so it mman.h wouldn't pull
> > it in for userspace builds...
> 
> It's pulled in like this:
> 
>     git-compat-util.h ->
>     sys/sysctl.h ->
>     sys/ucred.h ->
>     sys/queue.h

Ah, thanks (and I've been sidetracked into using FreeBSD again :>)

> Very reminiscent of [1].
> 
> [1]: http://git.661346.n2.nabble.com/PATCH-ewah-bitmap-silence-warning-about-MASK-macro-redefinition-td7632287.html

Alright.  In this case, I think "LIST_HEAD" is sufficiently
descriptive compared to more-generically named "MASK" or "BLOCK"
that it's harmless to "#undef LIST_HEAD" here without worrying
about conflicts or breaking outside code.
