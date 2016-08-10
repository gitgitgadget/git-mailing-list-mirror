Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081631FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbcHJSPq (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:15:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933503AbcHJSOv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:14:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F33935981;
	Wed, 10 Aug 2016 13:17:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hvS7AwsMgCGnoE12OrKtrLiPm6g=; b=jObNEH
	0uUNhOdF3TINTiLU//rFlWsFK5+GyiYJiDVhtqp1Gugdfi/AqOuipzSeRkXjEQ3N
	iwJ3YHLAAOYPmZvgtvpUs5ooHVmALhzTQvh49LiBkTW6BTujOeI5QKgbHOskpUEN
	lZr/WKxjrRl91CxrQT3UqmJX1AMZBV7V91VZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a/WHe3gZmpzgUymoP0ig2ZYxwysYqvM9
	CyFLH2SeHpGWWiHX1jjYt7ojq6gt+cprMp/Izn2lhjfkbePVt6SzVb4pC0mHDZyM
	fvfnGtXuBNqY7PEFT93DbH977ZfgWAKKIvMSS2Kie4qvf9cSBc1lTzyjOROyydGH
	fXKhY1O9hFk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56A1F3597F;
	Wed, 10 Aug 2016 13:17:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1AE13597E;
	Wed, 10 Aug 2016 13:17:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
	jnareb@gmail.com, mlbright@gmail.com, e@80x24.org,
	Johannes.Schindelin@gmx.de, ben@wijen.net
Subject: Re: [PATCH v5 04/15] pkt-line: add packet_write_gently()
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
	<20160810130411.12419-1-larsxschneider@gmail.com>
	<20160810130411.12419-5-larsxschneider@gmail.com>
	<20160810132814.gqnipsdwyzjmuqjy@sigill.intra.peff.net>
	<434CB5D7-3FC0-4398-9028-135701121E55@gmail.com>
	<20160810134003.q6mzgkcrwmkxv5fw@sigill.intra.peff.net>
Date:	Wed, 10 Aug 2016 10:17:24 -0700
In-Reply-To: <20160810134003.q6mzgkcrwmkxv5fw@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 10 Aug 2016 09:40:04 -0400")
Message-ID: <xmqqtwes5ysb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F7DED62-5F1E-11E6-BD42-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 10, 2016 at 03:36:45PM +0200, Lars Schneider wrote:
>
>> > So now we have packet_write() and packet_write_gently(), but they differ
>> > in more than just whether they are gentle. That seems like a weird
>> > interface.
>> > 
>> > Should we either be picking a new name (e.g., packet_write_mem() or
>> > something), or migrating packet_write() to packet_write_fmt()?
>> 
>> Done in "[PATCH v5 08/15] pkt-line: rename packet_write() to packet_write_fmt()"
>
> Ah, OK. Generally I'd suggest to reorder things so that each patch looks
> like a step forward (and so the early patches become preparatory steps,
> and the justification in them is something like "we're going to add more
> write functions, so let's give this a more descriptive name").

I am guilty for saying "packet_write() should have been similar to
write(2)".  We may want to have a time-period during which there is
no "packet_write()" in the codebase, before we get to that stage.
I.e. rename it to packet_write_fmt() to vacate the name and add
packet_write_mem(), and then later rename packet_write_mem() to its
final name packet_write(), or something like that.  The two-step
process would reduce the chance of misconversion.
