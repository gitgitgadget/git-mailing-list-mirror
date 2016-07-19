Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14282018B
	for <e@80x24.org>; Tue, 19 Jul 2016 00:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbcGSARs (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 20:17:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751457AbcGSARr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 20:17:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 986A02E532;
	Mon, 18 Jul 2016 20:17:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+zXwvJuxU1y//A+kOr4K2QsQ6wQ=; b=EH3z8s
	nD3YNdO00d/b9cWAkE4TpNXN5JLhXHK/4ino2nJ7RZXV/mAZGIhuqmjiqHYVWTpx
	/KuAx4Z7oHKDFl6pTel/O2dexzwk8pOTDzbVGAF7OJKa6JLB2hYb/l4amPIDxhWf
	VbcX4PtmJo0rjpR4PY3x1hu/eGzFVCqHOA758=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VETMR0ktpFMGcBEmG0wZiIxOXiNXOpxe
	sFXjE303L0MmfhImdNYls0Z0kPAALlY2ttRARME5mx9wnWaFC0Ga508FviGrmfUF
	V85BEmVSSGJnvqqta4H1KqXesE+4dRNKOKpVjNokvtmPxrbuK6vD+PVKLoZmdWp9
	PnsMTawcbV4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FCA22E531;
	Mon, 18 Jul 2016 20:17:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C4412E530;
	Mon, 18 Jul 2016 20:17:45 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH v3 00/16] Use merge_recursive() directly in the builtin am
References: <cover.1467717729.git.johannes.schindelin@gmx.de>
	<cover.1467902082.git.johannes.schindelin@gmx.de>
	<xmqqpoqi35u3.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607141414180.6426@virtualbox>
	<xmqq1t2wqaa3.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 18 Jul 2016 17:17:43 -0700
In-Reply-To: <xmqq1t2wqaa3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 14 Jul 2016 12:39:32 -0700")
Message-ID: <xmqqshv6h460.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 373ECF58-4D46-11E6-A394-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> The two topics that are in 'pu' and conflict with this series are
>> 'jh/clean-smudge-annex' and 'bc/cocci'.
>>
>> It also conflicted with 'va/i18n-even-more', but that one was merged to
>> 'master'.
>>
>> Now, I think it would be okay to wait for 'bc/cocci' to go to 'master'
>> before integrating the 'am-3-merge-recursive-direct' branch, but I would
>> want to avoid waiting for 'jh/clean-smudge-annex'.

Nothing seems to be happening on jh/clean-smudge-annex front, so
unless we hear otherwise from Joey in the coming couple of days,
let's get js/am-3-merge-recursive-direct untangled from its
dependencies and get it into a shape to hit 'next'.  You can assume
that I'll merge bc/cocci and js/am-call-theirs-theirs-in-fallback-3way
to 'master' during that time, so an appropriate base to use would be
the result of

    git checkout master^0
    git merge bc/cocci
    git merge js/am-call-theirs-theirs-in-fallback-3way
    git merge cc/apply-am

if you want a semi-solid base to rebuild am-3-merge-recursive-direct
on.  I am not 100% sure about the doneness of cc/apply-am yet,
though but it could be that am-3-merge-recursive-direct does not
have to depend on it at all.  You'd know better than I do ;-)

After that, I'll see if the conflict resolution is manageable when
remerging jh/clean-smudge-annex to 'pu', and if it is not, I'll
worry about it at that point.

Thanks.

