Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCF72098B
	for <e@80x24.org>; Wed, 19 Oct 2016 17:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942231AbcJSRcR (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 13:32:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62210 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938814AbcJSRcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 13:32:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78CA8457BE;
        Wed, 19 Oct 2016 13:32:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b+YO3n9HtPBiqvtHlnqmVeo5nAM=; b=c2lZRY
        wbL9OLiQvKmBuwuyzZYLHNc36GWLMsdmzDno5cJyKpy6ajYmnSZxfD0Tq34k6WTs
        PSdb01bp0n9JPi6/4ccuuvMfS9Qi88jLUw5Uyg4nRhRx3pP2uKHGEoovHlfw6GMX
        1mNpNvOgyA2r4MNLV8XO9uXIXTPi1p9kSeUHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j1MAmmTIG9VZzV35PvQTk/qcbNxtEF8T
        /i4XiVbr8oYCt7xPho7VxqcCvbYSZrwp86mZH08ShoAB0FHgWxUPs0jrU8O+Qb9b
        8nbuNYE6QmNV096y4waZDbsxHuLD9+/VsZyjzpReHK991HEkwT2NzFuHjq1Fto2B
        +EWyd77C5FM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70880457BD;
        Wed, 19 Oct 2016 13:32:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1C88457BC;
        Wed, 19 Oct 2016 13:32:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Drastic jump in the time required for the test suite
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
Date:   Wed, 19 Oct 2016 10:32:12 -0700
In-Reply-To: <alpine.DEB.2.20.1610191049040.3847@virtualbox> (Johannes
        Schindelin's message of "Wed, 19 Oct 2016 11:18:19 +0200 (CEST)")
Message-ID: <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9BD590E-9621-11E6-BB9F-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> What I can also say for certain is that the version from yesterday (commit
> 4ef44ce) was the first one in a week that built successfully and hence
> reached the test phase, and it was the first version of `pu` ever to time
> out after running for 3h.

I am sympathetic, but I'd be lying if I said I can feel your pain.

Admittedly I do not run _all_ the tests (I certainly know that I
exclude the ones behind EXPENSIVE prerequisite), but after every
rebuilding of 'jch' and 'pu', I run the testsuite (and also rebuild
docs) before pushing them out, and "make test && make doc && make
install install-doc" run sequentially for the four integration
branches finishes within 15 minutes, even when I run them after
"make clean".

Perhaps the recent change to run the tests in parallel from slower
to faster under prove may be helping my case.

> Maybe we should start optimizing the tests...

Yup, two things that come to mind are to identify long ones and see
if each of them can be split into two halves that can be run in
parallel, and to go through the tests with fine toothed comb and
remove the ones that test exactly the same thing as another test.
The latter would be very time consuming, though.
