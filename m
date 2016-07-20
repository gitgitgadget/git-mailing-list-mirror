Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F9E2034E
	for <e@80x24.org>; Wed, 20 Jul 2016 22:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbcGTWHy (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 18:07:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754665AbcGTWHx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 18:07:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B90252E030;
	Wed, 20 Jul 2016 18:07:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X8Z1S882uvvN3LB1WBrnQF9hJt4=; b=jmPAex
	CeAuoDqjF8a3VkjDMX4gS+h5p0ixf7rfjw14z4unCC+dJ1qsSM6MqXjx8AmK/I+U
	iPoe+M0QTQyZ7PzyveCBZLvr4idRiQbiWIPllfA9XtJvqGwdJZ+ruI7t/zHesXHv
	Uww2u1q23vQTsLVAK6JFgMTVSUr2dBE4JG8Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CVCWiS7SAaTggK6h8vFh6S/+DM9mwYhr
	WmM7RrEiTLl6FVg/oriOUhx8GaBYNZ9iEi4jANcMIFac+3z8UT7OkKp9M7dNmnj6
	J5y4S+0TkE8GlXZ8CT/6/KnVcyqDnmuIo5ntub29sjJhExK1a21UzZdwD3at2dy9
	e2x1PMgsavQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF6C32E02E;
	Wed, 20 Jul 2016 18:07:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 202B92E02D;
	Wed, 20 Jul 2016 18:07:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] config: add conditional include
References: <20160712164216.24072-1-pclouds@gmail.com>
	<20160714153311.2166-1-pclouds@gmail.com>
	<alpine.DEB.2.20.1607141750190.6426@virtualbox>
	<CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com>
	<alpine.DEB.2.20.1607161507250.28832@virtualbox>
	<20160716150835.GA24374@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607161834420.28832@virtualbox>
	<20160716164747.GA24933@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607171003010.28832@virtualbox>
	<20160720133130.GA19122@sigill.intra.peff.net>
Date:	Wed, 20 Jul 2016 15:07:49 -0700
In-Reply-To: <20160720133130.GA19122@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 20 Jul 2016 07:31:31 -0600")
Message-ID: <xmqq8twwc6a2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66885000-4EC6-11E6-90CF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Jul 17, 2016 at 10:15:55AM +0200, Johannes Schindelin wrote:
>
>> FWIW I am slightly less worried about the conditional includes (it is
>> already a horrible mess to figure out too-long include chains now, before
>> having conditional includes, for example). I am slightly more worried
>> about eventually needing to introduce support for something like
>> 
>> 	[if-gitdir(...):section]
>> 		thisSettingIsConditional = ...
>> 
>> or even
>> 
>> 	[if (worktree==...):section]
>> 		anotherConditional = ...
>> 
>> and then having two incompatible conditional constructs, one generic, the
>> other one specific to [include].
>> 
>> In other words, if we already introduce a conditional construct, I'd
>> rather have one that could easily be used for other conditions/sections
>> when (and if) needed.
>
> I had assumed we would resist introducing anything like that, simply
> because of backwards compatibility issues with the syntax. But I admit
> that was just an assumption in my head; future compatibility with
> reality is not guaranteed. :)

I actually read that assumption between lines and almost wrote the
same response that begins with "I think the untold assumption ever
since the inclusion mechanism was introduced is..." ;-)

A config file with "[include] path=..." in it would not include from
the named path by ancient verison of Git, but at least it won't
cause its parser to barf, and the assumption has been that it is a
good property to keep when we introduce new and incompatible
features.

I can however understand it if somebody thinks it actually is better
to actively break older Git implementations by forcing them to stop
parsing when we introduce constructs that will lead them to do wrong
things (e.g. missing some configuration defintions by not reading
from the file that the user wanted to be read from), rather than
making them silently ignore.
