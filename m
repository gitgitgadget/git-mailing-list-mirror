Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594D2203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 17:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbcG0RSQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:18:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752073AbcG0RSP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:18:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 689412ECD4;
	Wed, 27 Jul 2016 13:18:14 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qD2IswEaeVzqCi1RUR4o3BNxw6w=; b=JDOVmw
	nnKxI4deBOfeic7HtN+i0edQXfp9NjJablJ3NZAfH7A7N4FwTbA7MATHaaIIVJmk
	N5w+w73+UFV/bzV3YnE7W9/AD9HCMzdLrcLrCzgpXu0lXMjh+2c1+X6yvOgxPiym
	RitDMxSTv2/lXAe0NCQz1cBPzEkmBeVqDjdF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O3YBfHThHGlWWqu5WFCyFjen24ShO+AE
	14v57UL83ue5edyPB6yJPWw5WjrwNCVHpQkbVjAO3tlC24LTnM41a1cE56DR2UMz
	I0zQCb3EbQDbSagoxyT50jriCyogwc6EFO3RSCjRtMVmW6sIYzt2UH+Ab5lIiXqB
	6ijAHjVfwQU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FEA02ECD3;
	Wed, 27 Jul 2016 13:18:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C419E2ECCE;
	Wed, 27 Jul 2016 13:18:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Phil Pennock <phil@pennock-tech.com>,
	Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
References: <20160727081414.GA21451@breadbox>
	<20160727135820.GC14928@sigill.intra.peff.net>
Date:	Wed, 27 Jul 2016 10:18:11 -0700
In-Reply-To: <20160727135820.GC14928@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 27 Jul 2016 09:58:20 -0400")
Message-ID: <xmqqwpk7vw30.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19BA449C-541E-11E6-A033-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 27, 2016 at 04:14:14AM -0400, Phil Pennock wrote:
>
>> The reflog contains timestamp information, but these were not exposed to
>> `--pretty`.  Four of the six author/committer format string
>> second-letters were still available and copied, but `d`/`D` are taken
>> for reflog selector formatting.  So use `%gT` for "time" instead of
>> "date" mnemonic for using `--date=...` formatting.
>
> Hrm. Since Ted was not cc'd, it is not clear to me whether this is
> coincidental or in response to the thread over in
>
>   http://thread.gmane.org/gmane.comp.version-control.git/299201
>
> To summarize, I think the conclusion there was that we would go with at
> least the 't' and 'r' formatters in the short term. The 'i/I' ones were
> not something Ted cared about that much, I think, but they do make
> things orthogonal with the other ident dates.

I forgot about that thread after it stalled without drawing
conclusion, after Ted asked if anybody has a strong opinion
and saw only one response to it at

  https://public-inbox.org/git/20160711164317.GB3890%40thunk.org/

So, what is the next step?  Apply

  https://public-inbox.org/git/20160710055402.32684-1-tytso%40mit.edu/

but exclude %g[iI] bits out of that patch while doing so?

Thanks.

