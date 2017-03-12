Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53EE8202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 18:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935130AbdCLSOc (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 14:14:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51622 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935111AbdCLSOU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 14:14:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 088226573E;
        Sun, 12 Mar 2017 14:14:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WDRdlgdsTA2JsL627PhmA7KuNP8=; b=eYfahh
        MSp/ToaJVqqlN2mpiljmBM8ixHSZgd/Jdmly0yZG74qQ8poY0XfuWYwaYvC5Gp68
        korh2yfAJXKKMArshEuXKkp/kBEsiESjGfDue+u4CME9fPYbRjdrZwf6j2yzCYuN
        I664lOXxZiOGZ1wLgAHIQ9NPAvAtZv+90uc5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M3hCbK+ABiHXE4rQpRoMk9OfVSw8ztt3
        TxXxcacHUyr4+wkDZvrzC9MqDYDsy6yzr6qKJupb6YFckqe69cdRaF4ISuV+n2OE
        BH+lbMykrs4TcqOh1jGSjIwXxLPBoJTIb/3CmtvC5ATEQQKM93xSxNVn5QmCUo+A
        rwWl9+Elz3g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00C4A6573D;
        Sun, 12 Mar 2017 14:14:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AF566573C;
        Sun, 12 Mar 2017 14:14:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
        <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
        <CACBZZX5fGU9C-z94KbMAs_AegOSGtq8nbrkRe-NxBCHYsDswkA@mail.gmail.com>
        <20170312123212.3rnqyx3dvi5yppk5@sigill.intra.peff.net>
Date:   Sun, 12 Mar 2017 11:14:17 -0700
In-Reply-To: <20170312123212.3rnqyx3dvi5yppk5@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 12 Mar 2017 08:32:12 -0400")
Message-ID: <xmqq7f3uuzuu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5508382-074F-11E7-9CFD-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One further devil's advocate:
>
> If people really _do_ care about coverage, arguably the AFL tests are a
> pollution of that concept. Because they are running the code, but doing
> a very perfunctory job of testing it. IOW, our coverage of "code that
> doesn't segfault or trigger ASAN" is improved, but our coverage of "code
> that has been tested to be correct" is not (and since the tests are
> lumped together, it's hard to get anything but one number).
>
> So I dunno. I remain on the fence about the patch.

Yeah, I have been disturbed by your earlier remark "binary test
cases that nobody, not even the author, understands", and the above
summarizes it more clearly.

Continuously running fuzzer tests on the codebase would have value,
but how exactly are these fuzzballs generated?  Don't they depend on
the code being tested?  IOW, how effective is a set of fuzzballs
that forces the code to take more branches in the current codepath
for the purpose of testing new code that updates the codepath,
changing the structure of the codeflow?  Unless a new set of
fuzzballs to match the updated codeflow is generated, wouldn't the
test coverage with these fuzzballs erode over time, making them less
and less useful baggage we carry around, without nobody noticing that
they no longer are effective to help test coverage?
