Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B80B2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 16:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbcGMQFd (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 12:05:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750963AbcGMQFb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 12:05:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 69FFF29157;
	Wed, 13 Jul 2016 12:05:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yk3tFp6fOGFyEL6T0Xk7hzsRU5A=; b=ho1djq
	j9szNpU2nH5QVSp1EVqtF57+oOOeCrleoNPkFkZrIzl5zqcDnpu9lw/UJevRAEAG
	xcv4WrQ4HkS25n/SKDETc3ZNpSHizcuFREQVKIh1PtU7zvKfC0g0sHbDf86rE43d
	+qyJXRMn/NAPO3AnG7rk0PL+pVMUynrQZNVcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iEvipwg8ClgejgUYYS1OtEyOPt7Wos4e
	tdcgpKh3lCM7JDQv9aIjjaekZxfuHoZD8hKAmn/6g3zP72563inU0rUtD/9/YGUS
	zo8nQzHgtK/qLOGQwRl0AX0ictWbZcJIn9ru36LCm7FCXqAJ3JDwhInFZ+XNTR3E
	S4ZOGZBWU7c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6206729156;
	Wed, 13 Jul 2016 12:05:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E11AE29154;
	Wed, 13 Jul 2016 12:05:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607120927410.6426@virtualbox>
	<20160712073912.GA26431@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607121257450.6426@virtualbox>
	<xmqqbn2267zq.fsf@gitster.mtv.corp.google.com>
	<20160713020132.GA13918@sigill.intra.peff.net>
Date:	Wed, 13 Jul 2016 09:05:22 -0700
In-Reply-To: <20160713020132.GA13918@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Jul 2016 22:01:33 -0400")
Message-ID: <xmqqh9bt34n1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BD9E006-4913-11E6-8F00-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Definitely keep that paragraph. I am quite familiar with the test
> helper and it was not the outcome I initially expected.
>
>> +test_lazy_prereq 64BIT_TIME '
>> +	case "$(test-date show:iso 9999999999)" in
>> +	*" -> 2038-"*)
>> +		# on this platform, unsigned long is 32-bit, i.e. not large enough
>> +		false
>
> I see you tightened up the match a little. TBH, I think we could
> probably just match the whole output string, but I doubt there's much
> chance of a false positive either way.

Ah, it wasn't meant to be a tightening; rather the above is for
documentation value, i.e. make it stand out what 2038 we are
matching---its answer being "the year portion of the result of the
conversion".

