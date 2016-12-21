Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC1A1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 20:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756463AbcLUUo3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 15:44:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54726 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753780AbcLUUo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 15:44:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F5D459159;
        Wed, 21 Dec 2016 15:44:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V6NL0bdCQOqgmm4vRiQPxrDj+Lg=; b=Z3Uk3O
        jE66N4d6noeiKzczyCb65CU6+okugOuOrW7ENpHnHXcDnKpAa5zauXaBUsa3Yv1X
        v4wuUAY2QQUwo3YSasNNun6Sa45kfyBaKstQnZPQhf8P0Kedw75j/g15wnaSUDOi
        3KZETvUrH44tyKDw0o+DwlmposqlLKGf+22z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jn6UBBSplFU2Y1D/i+l55xe8grpwOT0a
        3MckKW84Cv6jrNJmtnJqffdgWuWvh53Bshj6VV0pMnwKuq4kBv/6UE0mf5Xkn6km
        f0L2PeHguyATTZyBV2hcF3HDufxAVpNJoknBMf7ojw1odRDCCxRR6SbrU6V1+4cp
        EgAMeRPTe20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5785759158;
        Wed, 21 Dec 2016 15:44:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC60859154;
        Wed, 21 Dec 2016 15:44:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
        <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
        <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
        <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
        <16b115e0-3a7e-a5c2-1526-44bbcfc97db8@kdbg.org>
        <xmqq60melazp.fsf@gitster.mtv.corp.google.com>
        <xmqq1sx2lara.fsf@gitster.mtv.corp.google.com>
        <xmqqvauejvnr.fsf@gitster.mtv.corp.google.com>
        <20161221032221.s7jmgnfrr6tyuyuk@sigill.intra.peff.net>
Date:   Wed, 21 Dec 2016 12:44:25 -0800
In-Reply-To: <20161221032221.s7jmgnfrr6tyuyuk@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 20 Dec 2016 22:22:21 -0500")
Message-ID: <xmqqh95xhv12.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4347B2AE-C7BE-11E6-A8D2-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do wonder if in general it should be the responsibility of skippable
> tests to make sure we end up with the same state whether they are run or
> not. That might manage the complexity more. But I certainly don't mind
> tests being defensive like you have here.

If we speak "in general", I would say that any test should be
prepared to be turned into a skippable one, and they should all make
sure they leave the same state whether they are skipped, they
succeed, or they fail in the middle.

That can theoretically be achievable (e.g. you assume you would
always start from an empty repository, do your thing and arrange to
leave an empty repository by doing test_when_finished), and the
cognitive cost of developers to do so can be reduced by teaching
test_expect_{success/failure} helpers to be responsible for the
"arrange to leave an empty repository" part.  But it is quite a big
departure from the way our tests are currently done, i.e. prepare
the environment once and then each of multiple tests observes one
thing in that environment (e.g. "does it work well with --dry-run?
how about without?").

Also it will make the runtime cost of the tests a lot larger, as
setup and teardown need to happen for each individual test.  So I do
not think it is a good goal in practice.

Perhaps what you suggest may be a good middle-ground.  When you add
prerequisite to an existing test, it will become your responsibility
to make sure the test will leave the same state.  That way, you
would know that tests that come later will not be affected by your
change.

