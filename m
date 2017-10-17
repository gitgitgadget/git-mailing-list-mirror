Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEEE7202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 01:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754334AbdJQBWe (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 21:22:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63150 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752573AbdJQBWd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 21:22:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7ADC6B6513;
        Mon, 16 Oct 2017 21:22:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V/UtyhfpR0ua7U2lV5pO/isfuPw=; b=Vj090q
        wdQsSNNj1rBpYYq/mDkR8mSvV24A0bgkaxabuSvuuWxNR2E9CnzFOlhdGTR+lbGm
        X9XkUYQmtvj87zhZK37NG5mNRgDWSEVqTjwJx1dsezhri3qUMBIuJ3xYfUx4O6Zt
        heDja+X331UqG5EgTo4cfy3r9MzNZynU+89Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ei/usWbacJ35cr74brglsEiwqlmgN0U0
        skYU8rb1gUdnaTcShg1eXdq7H3P/CWcAJYMLZxHQG/ORatA1ClM3+dzLEvaow0mF
        PZhMqIwh5QLeN+LB9k4XH6bAVesGh4czgp4i+uDRf1uffWPbYNJDQmCVaMDYIpSP
        lsxufXkbdsI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73D9BB6512;
        Mon, 16 Oct 2017 21:22:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E790BB6511;
        Mon, 16 Oct 2017 21:22:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
        <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
        <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
        <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
        <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
        <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
        <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
Date:   Tue, 17 Oct 2017 10:22:31 +0900
In-Reply-To: <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Oct 2017 18:45:13 -0400")
Message-ID: <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A688AEAC-B2D9-11E7-AEF3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 16, 2017 at 07:45:46PM +0900, Junio C Hamano wrote:
>
>> > So I think the right endgame in the longer term is:
>> > ...
>> 
>> Here is to illustrate what I mean in a patch form.  It resurrects
>> the gentle setup, and uses a purely textual format check when we are
>> outside the repository, while bypassing the @{magic} interpolation
>> codepath that requires us to be in a repository.  When we are in a
>> repository, we operate the same way as before.
>
> I like the state this puts us in, but there's one catch: we're
> completely changing the meaning of "check-ref-format --branch", aren't
> we?
>
> It is going from "this is how you resolve @{-1}" to "this is how you
> check the validity of a potential branch name". Do we need to pick a
> different name, and/or have a deprecation period?

That was not my intention.  When used in a repository, it behaves
exactly the same as before, including @{-1} resolution part.  And by
using strbuf_check_branch_ref(), it has always been checking the
validity of a potential branch name, even though it wasn't
advertised as such.  The documentation needs to be updated, I would
think.

When used outside a repository, @{-1} would not have worked anyway,
and @{-1} continues not to work, but the part that checks the
validity should continue to work.

At least that is what I wanted to happen in the patch.
