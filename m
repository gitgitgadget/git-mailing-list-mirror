Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE9B01FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934183AbcHJSVi (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:21:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933704AbcHJSVg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:21:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4401235162;
	Wed, 10 Aug 2016 14:21:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fK9Rcr4EVAMBuq0XwkKRTvFR3dg=; b=s+0wTp
	P91LxRZsJ5bq9lwK679l5Y4UziHCz3Mq+KNNGQcQiEb4Mve6GXF26RcTClCi/0sJ
	F5Y6wg6FJZ4wVdoUZN7HNelvcpegnLhX/hljt+8GFUOVVqQyVziOhguabCd0nGk8
	AbpbuxRye4+vbXXc1m2U83vXRP9yA8Fj0zFsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xDR90JjSW3NnhV/8qZ49zsvNrtBXQZj8
	m2qtrDe8E2YTYda9UhADp4vh+1XK4mFPz9oBf9j6cYFuiBqqXk+TI2Jnr8IvhaXo
	h34/lxhegUT576H+QB8EZKpiU+FOPLS44RJVQgM7MQjtvP4h/gC6OQmHV2KZ0btL
	e2ld0jZqP94=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AF5835161;
	Wed, 10 Aug 2016 14:21:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADC2635160;
	Wed, 10 Aug 2016 14:21:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Subject: Re: [PATCH v5 04/15] pkt-line: add packet_write_gently()
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
	<20160810130411.12419-1-larsxschneider@gmail.com>
	<20160810130411.12419-5-larsxschneider@gmail.com>
	<20160810132814.gqnipsdwyzjmuqjy@sigill.intra.peff.net>
	<434CB5D7-3FC0-4398-9028-135701121E55@gmail.com>
	<20160810134003.q6mzgkcrwmkxv5fw@sigill.intra.peff.net>
	<xmqqtwes5ysb.fsf@gitster.mtv.corp.google.com>
	<13CB2673-7C7D-4982-9725-27D4091AAD84@gmail.com>
Date:	Wed, 10 Aug 2016 11:21:31 -0700
In-Reply-To: <13CB2673-7C7D-4982-9725-27D4091AAD84@gmail.com> (Lars
	Schneider's message of "Wed, 10 Aug 2016 19:49:48 +0200")
Message-ID: <xmqq8tw45vtg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45077B92-5F27-11E6-BEB1-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 10 Aug 2016, at 19:17, Junio C Hamano <gitster@pobox.com> wrote:
>> 
> OK. Does this mean I can leave the "packet_write()" to "packet_write_fmt()"
> rename as is in this series?

I didn't really check what order you are doing things to answer
that.

If the function that is introduced in this step is a version of
packet_write_fmt() that does its thing only gently, you would want
to do the rename s/packet_write/packet_write_fmt/ before this step,
and then add the new function as packet_write_fmt_gently(), I would
think.
