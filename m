Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1BC20193
	for <e@80x24.org>; Thu,  4 Aug 2016 20:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965707AbcHDUlH (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 16:41:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965213AbcHDUlG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 16:41:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 28CB431BCD;
	Thu,  4 Aug 2016 16:41:05 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tkvPsBPLSpbKdLJ9+XI7QI0n5vc=; b=kjBNbH
	LCdz5fcrcwrh7VSdecjQRiSpFlKExYZ8cUjk+xQ83TsYFqura8pvCv5nxGvVy15O
	YhZ7EmoynEZSrg4yXP5AKy0YcwB1gpUoBasqEnAvhjIBSQqAac9v7C5Vnm2Up/7i
	ymnz8p2zcHPaF45eAW1n6B7cheSJf6HaVhScQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qzkqJF0e7n9l2RnJlrQPUuXexGlPo0e4
	bappf7vhW/3PcKw5H4bl7c3qmq0/3uh2323S8OjdD5ceZjoB287jGfl6Y4e0cO3n
	5IMMSZvKo18UHtZGvKMGGwCo3pLvsDXd1INP/vcswgm8TbVHADCgcoK1FixAYK5a
	FFiwNPMIMic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2161C31BCC;
	Thu,  4 Aug 2016 16:41:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D9A031BCA;
	Thu,  4 Aug 2016 16:41:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 3/7] trace: use warning() for printing trace errors
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
	<20160803225826.hlr273h4cy2hcfyk@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 13:41:02 -0700
In-Reply-To: <20160803225826.hlr273h4cy2hcfyk@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 18:58:26 -0400")
Message-ID: <xmqqk2fw1d41.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C361F312-5A83-11E6-BCC6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Right now we just fprintf() straight to stderr, which can
> make the output hard to distinguish. It would be helpful to
> give it one of our usual prefixes like "error:", "warning:",
> etc.
>
> It doesn't make sense to use error() here, as the trace code
> is "optional" debugging code. If something goes wrong, we
> should warn the user, but saying "error" implies the actual
> git operation had a problem. So warning() is the only sane
> choice.
>
> Note that this does end up calling warn_routine() to do the
> formatting. So in theory, somebody who tries to trace from
> their warn_routine() could cause a loop. But nobody does
> this, and in fact nobody in the history of git has ever
> replaced the default warn_builtin (there isn't even a
> set_warn_routine function!).

I think the last bit is about to change; cf. 545f13c0 (usage: add
set_warn_routine(), 2016-07-30) on cc/apply-am topic.
