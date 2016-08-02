Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFEE920220
	for <e@80x24.org>; Tue,  2 Aug 2016 21:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbcHBVP5 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 17:15:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753537AbcHBVP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 17:15:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3426031A37;
	Tue,  2 Aug 2016 17:15:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YMKD0K9+aybqr0409y1BU3bbK0g=; b=lIm522
	47PeIIUB4dY/iVM70o/6/X7NmVnDOOX2NHOw/syQtf4J+Lvt5x6BkJcRi5r3DdPk
	g55ITJpVRDDhHLhJvynJA2vpWHeetVMFNKdx78VYy4exWa50hkQkKQ/BT4UKTYNR
	IDTQL3wLf8N+mSXKitKhuN440MD3bBGoKEqrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RMg9VPC/X4kdWpKxeCMuD2tfQTyyA9JM
	b8ZvbfFGg/LlBy6R8aTtsmWi5K20YFzES7CJ4a54PiJR89xSJBQU7E7wD0e6qUq0
	sIrsaH46vdbgLmNPDugdF7DeX1pMZdE8bBfcLdDFf2Ru02ivT7ty3vCmEbiDntNT
	X58790LUxC4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BE4531A36;
	Tue,  2 Aug 2016 17:15:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A871B31A35;
	Tue,  2 Aug 2016 17:15:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/1 v2] pager: move pager-specific setup into the build
References: <20160801214937.4752-1-e@80x24.org>
	<20160801214937.4752-2-e@80x24.org>
	<xmqq1t28gkhf.fsf@gitster.mtv.corp.google.com>
	<20160801235651.GA7140@starla>
Date:	Tue, 02 Aug 2016 14:15:52 -0700
In-Reply-To: <20160801235651.GA7140@starla> (Eric Wong's message of "Mon, 1
	Aug 2016 23:56:51 +0000")
Message-ID: <xmqqa8gudg8n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C5BC47A-58F6-11E6-B462-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> So v3 will be MORE=FRX, as less was added:
>
>     commit 98170c0c3ba86eb1cc975e7848d075bf2abc1ed0
>     Author: ps <ps@FreeBSD.org>
>     Date:   Mon May 22 10:00:00 2000 +0000
>
> 	bmake glue for less.
>
> and more was nuked:
>
>     commit cde9059fa3e4dc7e259c3864d7536252a5c580a0
>     Author: ps <ps@FreeBSD.org>
>     Date:   Mon May 29 13:31:51 2000 +0000
>
> 	Nuke more from the repository.
>
> And "git branch -r --contains" on both of those commits says
> they showed up in the 5.0 release.  However, further
> investigation says more was even gone by the 4.1.0 release
>
>   git show origin/release/4.1.0:usr.bin/more # non-existent tree
>   git show origin/release/4.0.0:usr.bin/more # tree still exists
>
> But, "git show origin/release/4.0.0:usr.bin/more/option.c"
> reveals more from those days wouldn't handle -R anyways,
> and hopefully nobody is still running 4.0.0...

OK.  And they can always set $MORE on their own to work it around,
or we can do a release-dependent tweak when somebody screams.

