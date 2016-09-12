Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD3B20985
	for <e@80x24.org>; Mon, 12 Sep 2016 20:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbcILUpD (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 16:45:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64048 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752736AbcILUpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 16:45:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 810703E195;
        Mon, 12 Sep 2016 16:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mt6FCTh2WlQVs7Z3m/RAGCZZDLo=; b=gVJtEi
        1SbOKQ92QsArl14RTfMdwvlJ/tUOdrwQo8UNLa0gWVPJqA8zWnC15S2v9RYHd7vB
        Woei2YuNBLUbjP+XVJYO2yIji55Xb+PYpjw8sb2mrF825DsSXsdgXkrE7oBKCCWa
        4Bu0tFM18vVrOubGDyclfKbXKRY9t8weNFbrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l2LNDyM286JPs1xzOGcsGH4OyGH/v6/X
        vxDOA832XWiO/tqo6AbBRnRcklnXo9uT4rhwkJQuOsIuokoS5TV2FKmgTyQ4chGF
        UEbsQ1fXa84WaDCNUpqA/XL0XctjZIykOl4bP7IE7LcsPbM/s6xbEvb6xBS68+BX
        R9peFsYBWWg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 781623E194;
        Mon, 12 Sep 2016 16:44:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00E4A3E193;
        Mon, 12 Sep 2016 16:44:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3 0/2] patch-id for merges
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
        <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
        <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net>
        <xmqqfup8aiud.fsf@gitster.mtv.corp.google.com>
        <20160912155930.2acw4265nfjq3uyj@sigill.intra.peff.net>
        <xmqq37l53ul2.fsf@gitster.mtv.corp.google.com>
        <20160912175641.nj4h6oupbwaedwbx@sigill.intra.peff.net>
Date:   Mon, 12 Sep 2016 13:44:57 -0700
In-Reply-To: <20160912175641.nj4h6oupbwaedwbx@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 12 Sep 2016 13:56:41 -0400")
Message-ID: <xmqqpoo8zw3a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C538048C-7929-11E6-9521-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Sep 12, 2016 at 10:18:33AM -0700, Junio C Hamano wrote:
>
>> > +static int patch_id_defined(struct commit *commit)
>> > +{
>> > +	/* must be 0 or 1 parents */
>> > +	return !commit->parents || !commit->parents->next;
>> > +}
>> 
>> If we make the first hunk begin like so:
>> 
>> > +	if (commit->parents) {
>> > +		if (!patch_id_defined(commit))
>> > +			return -1;
>> 
>> I wonder if the compiler gives us the same code.
>
> Good idea. I actually put the "patch_id_defined" check outside the "if"
> block you've quoted (otherwise we're making assumptions about the
> contents of patch_id_defined).

Facepalm.  I was mis-reading the condition in the helper function.
Of course, guarding up-front makes more sense.

