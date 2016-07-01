Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6D42018A
	for <e@80x24.org>; Fri,  1 Jul 2016 15:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbcGAPnT (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 11:43:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752922AbcGAPnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 11:43:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A16B273E6;
	Fri,  1 Jul 2016 11:43:10 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uYhxc6BQ37HJSTRX2gj8IrIG8Vg=; b=OMNAJJ
	g15j0byQvTgdnPu63FoUmTlpcco2g7cKTAApNvssD3R5wSevZYzG5HYYu0TksSUx
	bOZcQZnIJJFnMdUzFeIHfVXV+eozyIMpp5jDzHHv5Pr7LbBefsv8TieZUCV5wrAF
	/tDZFvOVJmC/deCdWv6lnfnUImZqLLEzohqpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DI6CG65Kp1APGcGL+78Mgusf1j4qgBBn
	HTEXFfAp+QEA6Y5Ox8Hdp4ZZaHY4x7DM5moZ+kBcLWI5f6CDIO7DnojzzlV3Iblb
	KjFKTBMCtR3wJI4Dz8y5QXs+7yN2AdZTIghDWdqSHRuNHeS5eqT3MQkFa61llaFe
	O7kNDE/vFco=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B2D5273E5;
	Fri,  1 Jul 2016 11:43:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFF2C273E1;
	Fri,  1 Jul 2016 11:43:09 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 3/9] Prepare the builtins for a libified merge_recursive()
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<753eabc5193c148c67e64ed5d070b6ff08f51d82.1467199553.git.johannes.schindelin@gmx.de>
	<xmqqziq33ju2.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607011123550.12947@virtualbox>
Date:	Fri, 01 Jul 2016 08:43:07 -0700
In-Reply-To: <alpine.DEB.2.20.1607011123550.12947@virtualbox> (Johannes
	Schindelin's message of "Fri, 1 Jul 2016 12:14:10 +0200 (CEST)")
Message-ID: <xmqq37nt1i0k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83351874-3FA2-11E6-9FF8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > A truly libified function does not die() just for fun.
>> 
>> The sentence is wasting bits.  After all, a helper function in
>> run-once-and-exit program does not die() just for fun, either.
>
> This sentence does not so much target *you* personally as audience, but
> the occasional reader of the log who wonders: "Why don't we just call
> die()? We would not have to worry about passing back the return value
> through all those long call chains..."

I was (and I am still) reacting mostly to "just for fun".

> Even more natural is it to guess that the code will call error(), just
> like we do almost everywhere else.
> ...
>> But that does not mesh very well with the stated objective of the
>> patch.
> ...
> I could imagine that you wanted even more fine-grained control, where we
> have a range of return values indicating different error conditions.

I personally don't.  I was pointing out the discrepancy between what
the introduction says, i.e. "this way is way more flexible for the
callers when they want to do their own error handling", and what the
code actually does.  If the explanation said "This series does not
give the full flexibility potential callers may desire yet, but at
least gives enough flexibility to do 'I do not want the called
function to die, but append my own error message before I die
myself'.", that is certainly an understandable stance to take, I
would say.
