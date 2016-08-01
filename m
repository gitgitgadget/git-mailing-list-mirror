Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDC81F855
	for <e@80x24.org>; Mon,  1 Aug 2016 22:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbcHAWfF (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 18:35:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51534 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbcHAWfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 18:35:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CED1F855;
	Mon,  1 Aug 2016 22:34:47 +0000 (UTC)
Date:	Mon, 1 Aug 2016 22:34:47 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 1/4] patch-ids: stop using a hand-rolled hashmap
 implementation
Message-ID: <20160801223447.GA10924@whir>
References: <20160729161920.3792-1-kcwillford@gmail.com>
 <20160729161920.3792-2-kcwillford@gmail.com>
 <xmqqoa5gmas6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607301056120.11824@virtualbox>
 <xmqqy44gi7bp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy44gi7bp.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It would be a serious bug if hashmap_entry_init() played games with
> > references, given its signature (that this function does not have any
> > access to the hashmap structure, only to the entry itself):
> >
> > 	void hashmap_entry_init(void *entry, unsigned int hash)

<snip>

> I have a slight preference to avoid the lazy "void *", but that is
> an unrelated tangent.

Me too.  I noticed this while working on the http-walker
speedups and my self-rejected last patch:

  https://public-inbox.org/git/20160711210243.GA1604%40whir/

Extracting list_entry from list.h (currently in next[1]) and
exposing that generically as "container_of" for use with
hashmap_* would make it safer-to-use and allow structs to belong
to multiple hashmaps.

list_entry is also an alias for container_of in the Linux
kernel, but we don't have enough code using list_* to
warrant two names for the same macro.

[1] https://public-inbox.org/git/20160711205131.1291-4-e%4080x24.org/
