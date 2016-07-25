Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383FF203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 20:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbcGYUag (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 16:30:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752814AbcGYUae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 16:30:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 08994316ED;
	Mon, 25 Jul 2016 16:30:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HLYWBWz/GPBccAyyYniYBp/Pj3Y=; b=Z9cEWI
	SEtVPGLQafNZDXf0MsVXlTSPDQeVif2M2vP9gSY1bV0LZlVqnW4s0v89dmGSLrER
	FxE3ECZijTH1hBGTpSn5jTyJnNdAKmOmRihaT33ABcDMHeHoMN6YafRQvdaL1i7H
	EJLKJtjN0v7zARIL9r0rfRTrFDr5La14x6Pkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ftdTq6OUqd0rq9y4o+dEa8PUjSwoNb8C
	eLkac2VQCtaS3Q8xNDEBZNFGWwytIBCzypoIy2XQlAu35+3S1zdMzvZA8tK2Fk45
	ozxgKiHuZKQaNg4Alix6VNNK7/Nm9QjhQp4XRlNnsQ6tj8LI5CJSv+ZQ4rU0FEKW
	pH0c6vBbSmU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F27E9316EC;
	Mon, 25 Jul 2016 16:30:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73EFC316EB;
	Mon, 25 Jul 2016 16:30:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 6/8] status: print branch info with --porcelain=v2 --branch
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
	<1469474750-49075-7-git-send-email-jeffhost@microsoft.com>
Date:	Mon, 25 Jul 2016 13:30:30 -0700
In-Reply-To: <1469474750-49075-7-git-send-email-jeffhost@microsoft.com> (Jeff
	Hostetler's message of "Mon, 25 Jul 2016 15:25:48 -0400")
Message-ID: <xmqqshux4g0p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A272E452-52A6-11E6-A08B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <jeffhost@microsoft.com> writes:

>  /*
> + * Print branch and tracking header for porcelain v2 output.
> + * This is printed when the '--branch' parameter is given.
> + *
> + *    "## branch: <commit> <head>[ <upstream>[ +<ahead> -<behind>]]<eol>"

Just FYI, the only reason why the original "short" output gives this
information on a single line with ## is because it was added as an
afterthought to then-existing short/porcelain format that used two
letter prefix and one-line-per-path format, and the expectation was
that the existing parsers for the output would ignore unknown status
letters (namely "##").  Because you are inventing a new format that
needs to be parsed by a brand new parser _anyway_, you do not have
to mimic that old convention which was a workaround, and use a
notation that mixes better with the other lines you show under
the --porcelain=v2 option.

Of course if you like "## branch:" output and think it is pleasing
to see, that is fine as well.
