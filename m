Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A15C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 17:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbhLISBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:01:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57236 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbhLISBh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 13:01:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BAB37F38EC;
        Thu,  9 Dec 2021 12:58:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GSbpiRgdxxMCphQmSUHLtNx8mwy/8AmHvhP+4+
        q812o=; b=OhK9ibnvZq0Itu31HKPPkAcvmPnUSyt+IBokWKT0xR/iUF97Kio4fy
        9MDFDXYT53Auhb7h2EC4J8a/+SwQa6PLHDB4N5JEMoEpbNajpmFQDXJc2c0pSvfd
        EKTFF4SdMEse+2OwJQpENRJr7SfUbekSkcpc85TlFxzuzj59zjTDQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A146DF38EA;
        Thu,  9 Dec 2021 12:58:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4463F38E8;
        Thu,  9 Dec 2021 12:58:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
        <YbEpE7UI+ovnNQyj@coredump.intra.peff.net>
Date:   Thu, 09 Dec 2021 09:57:59 -0800
In-Reply-To: <YbEpE7UI+ovnNQyj@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Dec 2021 16:52:19 -0500")
Message-ID: <xmqqczm5u0d4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D0B502A-5919-11EC-A1E4-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't mind the general direction, but...
>
>> +# Additional tests from places in contrib/ that are prepared to take
>> +# "make -C $there test", but expects that the primary build is done
>> +# already.
>> +test-extra: all
>> +	$(MAKE) -C contrib/diff-highlight test
>> +	$(MAKE) -C contrib/mw-to-git test
>> +	$(MAKE) -C contrib/subtree test
>
> I'm not sure of the quality of tests in some of the contrib stuff. The
> tests in diff-highlight worked for me when I added them, but it's not
> like I ever run them regularly, or that they've been tested on a wide
> variety of platforms.
>
> So I think this is as likely to cause somebody a headache due to a dumb
> portability problem or random bitrot as it is to actually find a bug. I
> guess test-extra wouldn't be run by default, but only via CI, so maybe
> that limits the blast radius sufficiently.

Yeah, that is the exact thought I had when I did it.  Anybody who is
not aware of test target other than 'test' will not be hurt, and we
explicitly make the CI aware of 'test-all' to trigger it.  But as
long as somebody bothered to write the tests, exercising them to
reveal bitrot-bugs either in the tested contrib stuff or the tests
themselves to be fixed or removed would be a good thing to do.

An updated version of the posted patch is in 'seen' that also covers
credential/netrc; https://github.com/git/git/runs/4465323829 shows
the logs from its jobs.

It is not particularly interesting that most of the jobs are marked
as failed, as t1092 was broken the same way in my local test.  What
I found interesting from my quick scan of randomly chosen jobs are
that (1) nobody seemed to have failed test-extra, and (2) nobody had
mediawiki installed to test mw-to-git.

So I am tempted to do

test-extra: all
	$(MAKE) -C contrib/credential/netrc test
	$(MAKE) -C contrib/diff-highlight test
	: $(MAKE) -C contrib/mw-to-git test
	$(MAKE) -C contrib/subtree test

in the topic itself, while adding

	$(MAKE) -C contrib/scalar test

before the subtree test (alphabetically) when it is merged to 'seen'
with the js/scalar topic.
