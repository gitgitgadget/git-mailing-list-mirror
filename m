Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A211220179
	for <e@80x24.org>; Fri, 17 Jun 2016 18:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbcFQSYl (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 14:24:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753481AbcFQSYk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 14:24:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60CA523525;
	Fri, 17 Jun 2016 14:24:39 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cY8JipBxfr/VmE6dLi+p8TqMRts=; b=uJievc
	XzKKtj2sW/LOufXAJSuVWiXblIsJeOvf3xHPFG4IGGuTCARyIyFD+xIjUSnwtcjh
	gxct9Tsruq1+VHdudRyA5swjmc5KLQFjgo6Cy5DYiAcUjZA8KW8XV56d9OtUZCuk
	AJ1Lap4oXgG0aLloRE0KigAeUrfN2WIpPZiw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ovK89zr0JeWzGYrX5ZAJp+T5O36qDvKq
	nVqGf+3fee4aK8UMYxpBYXw8Je00tzEOGAuRb8eULFQdVmi3P755Z6QXJTky6Qm1
	oDwiv2C4XGUVFxZcaHZK9JUOwrwbi5kagSFeKEoXdZU92xqVAcHqnEK3CuI/Gw0A
	lor59OeEni0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58DE623524;
	Fri, 17 Jun 2016 14:24:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C84E023523;
	Fri, 17 Jun 2016 14:24:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <id@joeyh.name>
Cc:	Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] add smudge-to-file and clean-from-file filter configuration
References: <20160616203259.5886-1-joeyh@joeyh.name>
	<20160616203259.5886-3-joeyh@joeyh.name>
	<3c7349e7-34a1-ed7f-721e-e7a7b191bb3d@drmicha.warpmail.net>
	<20160617124707.GB24025@kitenet.net>
	<xmqq60t73igm.fsf@gitster.mtv.corp.google.com>
	<20160617180650.GA16404@kitenet.net>
Date:	Fri, 17 Jun 2016 11:24:37 -0700
In-Reply-To: <20160617180650.GA16404@kitenet.net> (Joey Hess's message of
	"Fri, 17 Jun 2016 14:06:50 -0400")
Message-ID: <xmqqa8ij1xne.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C06CB638-34B8-11E6-9066-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <id@joeyh.name> writes:

> Or we could pick one of the two methods of appending the file
> (I prefer not including a space before it as more flexible), and
> anything using this interface would need to design its command line
> parsing with this interface in mind, and would probably choose to use
> --to-file=foo rather than --to-file foo.

When I gave the example in the message you are responding to, I
chose to assume that we will always have a space there, and this was
to to avoid a problem that will become common if we did otherwise,
namely:

    [filter "foo"] cleanFromFile = command

which must be spelled as

    [filter "foo"] cleanFromFile = "command "

to separate the command name with it argument if we didn't add the
space there.

I tend to agree with what you said in the other response, i.e.
"Probably anything using this interface is gonna be implemented with
the interface in mind from the beginning", so they will not have an
issue if the interface always added a space there, and there is the
"sh -c" thing if they really want to do something unusual.
