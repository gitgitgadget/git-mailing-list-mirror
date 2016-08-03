Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6111F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 17:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757786AbcHCRAC (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:00:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756585AbcHCQ7u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:59:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3492B2FCEF;
	Wed,  3 Aug 2016 12:53:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vFJI9yCbTO5pwkwUWXrWyCE768o=; b=dCKjfm
	O0Pjt+0yy851DalHRFkQBnFI84jypxjPABt6EKnOBK4gF1nZ/G5opkidkGUc+XOQ
	DYGaE0RqQboWsaP1S8KscQcgX3VwR8HtLRb2KzX/ZcKDi/2HcQWhVK6gmEZ0+waP
	KgaeBxYLn1SEyn9BGOnOmgntDVYR5BzysCsCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PbBDjO9eNWMg+in2qjiwlzkK+nvTXDeh
	Gu3bQ4Yh8Z6Mtkxxs7+Iy7Ujo6sLAUPgYj0APztMfAitFVW+bYxL0/StXPhPSE2b
	kOH03xkmvTq59obOaPH44FMkW9XbalKVFynwalS3jjoox65WHcGMXs0qXNWxvtxq
	ZdGPegVaYyc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B8EE2FCEE;
	Wed,  3 Aug 2016 12:53:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3C2E2FCED;
	Wed,  3 Aug 2016 12:53:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
	<xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608021004080.79248@virtualbox>
	<xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608031021050.79248@virtualbox>
	<CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
	<20160803163449.iwjv4youmsf6okme@sigill.intra.peff.net>
Date:	Wed, 03 Aug 2016 09:53:18 -0700
In-Reply-To: <20160803163449.iwjv4youmsf6okme@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 12:34:49 -0400")
Message-ID: <xmqqbn19aj5t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8A53EEA-599A-11E6-AF64-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 03, 2016 at 08:33:12AM -0700, Junio C Hamano wrote:
>
>> On Wed, Aug 3, 2016 at 4:59 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > I disagree, however, with the suggestion to sift through your `pu` branch
>> > and to somehow replace local branches with the commits found there.
>> 
>> To be more in line with the "e-mailed patch" workflow, I think what I should
>> do is to send the version I queued with fixups back to the list as follow-up.
>> Just like reviewers review, the maintainer reviews and queues, the original
>> author should be able to work in the same workflow, i.e. reading and applying
>> an improved version of the patch from her mailbox.
>
> Leaving aside Dscho's questions of whether pulling patches from email is
> convenient for most submitters (it certainly is for me, but I recognize
> that it is not for many), I would much rather see incremental fixup
> patches from you than whole "here's what I queued" responses.

Ah, yes, I misspoke.  It should be either an incremental diff or
in-line comment to spell out what got changed as a response to the
patch.

I find myself fixing the title the most often, which is part of the
"log message" you pointed out that would not convey well with the
"incremental diff" approach.
