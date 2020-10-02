Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB47C4363C
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037D320758
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WikWeOOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbgJBQWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 12:22:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58871 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQWx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 12:22:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B58FE9903;
        Fri,  2 Oct 2020 12:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8JAyFkMwu/8EVGJu+L+Np7NLECU=; b=WikWeO
        OCikx12lJvTcl0Cx2xMbCc2cajlfiDmZqds9F4iwbfIuOJyWqcIr7EI5ZscQGOaC
        0U/eJVPMz9VjZlDPYh9AIczwUX6rPspyFwZxJ4xi8+HJvADUJZ/+8E+nMt7/lsN6
        tAV1kfN56HUwDzPJmhkyxduCATr3UH2dCLkmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eHoL27cqxhUa47vAxOTZbbn+0mf3L6a6
        V1W3+6rmFhfKmaKjxsJABNerLLU1iI2sXHCsvo9fgg+i7jV61Hvlv2UEjlfzGnl0
        aC1ryOR0LoAh0G/MxhO4/TlVk1GZ8YPY96/dF9QZu1GufLF+8g2CLgvtkRwhUj90
        lTMNqOEvftQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93C4CE9902;
        Fri,  2 Oct 2020 12:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D6F15E98FD;
        Fri,  2 Oct 2020 12:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 1/3] push: add reflog check for "--force-if-includes"
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-2-shrinidhi.kaushik@gmail.com>
        <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2010021642210.50@tvgsbejvaqbjf.bet>
Date:   Fri, 02 Oct 2020 09:22:46 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010021642210.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 2 Oct 2020 16:50:01 +0200 (CEST)")
Message-ID: <xmqqy2koa97t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 827BA310-04CB-11EB-8FFB-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Having said that, the change I suggested (to use `get_reachable_subset()`
> instead of repeated `in_merge_bases_many()`) is _still_ the right thing to
> do: we are not actually interested in the merge bases at all, but in
> reachability, and in the future there might be more efficient ways to
> determine that than painting down all the way to merge bases.

I agree with you that the age-old implementation has an obvious room
for optimization.  I think I already pointed out a #leftoverbit that
we can invent a version of paint_down_to_common() that can
short-circuit and return immediately after one side (the "commit"
side) gets painted, so that in_merge_bases_many() can stop
immediately after finding out that the answer is "true".

The function is *not* about computing the merge base across the
commits on the "reference" side but finding out if "commit" is
reachable from any in the "reference" side, so (1) it has a wrong
name and more importantly (2) it wants to do something quite similar
to get_reachable_subset(), but it is much less ambitious.

get_reachable_subset() is capable of doing a lot more.  Unlike the
older in_merge_bases_many() that allowed only one commit on the
candidate for an ancestor side, it can throw a set and ask "which
ones among these are reachable from the other set".

So from the "semantics" point of view, get_reachable_subset() is
overkill and less suitable than in_merge_bases_many() for this
particular application.  We know we have only one candidate, and we
want to ask "is this reachable, or not?" a single bit question.  In
any case, they should yield the right answer from correctness point
of view ;-)

Having said that.

I do not think in the longer term we should keep both.  Clearly the
get_reachable_subset() function can handle more general cases, so it
would make a lot of sense to make in_merge_bases_many() into a thin
wrapper that feeds just a single commit array on one side to be
filtered while feeding the "reference" commits to the other side, as
long as we can demonstrate that the result is just as correct as,
and it is not slower than, the current implementation.  That may be
a bit larger than a typical #leftoverbit but would be a good clean-up
project.

