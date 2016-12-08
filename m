Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAD91FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 00:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbcLHAUg (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 19:20:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753012AbcLHAUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 19:20:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B2B457722;
        Wed,  7 Dec 2016 19:20:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=81ZzsrlVysd3wVylIPjKOl4sp+c=; b=tOhMgS
        KzQf9uYlGPSUlqBMhYAHbO001noLJgLOWSiLD+G8rFIm5wqVfQlF7RWRXZCBkfTM
        4UN8/U30LNiaJyIZJzCQfZ8PinJvDQqKFSVsJDP30o7eVfRAy91BSHrj9t+lhvBO
        mzW15YrKInSdqVUpmbm4hyxVGwgifkDAmDUdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=clJIXo1V9mX6ffWgGTlsT9RpjtGjL8+j
        RmrYyprnwfRBX9gDCKG+mxw4kjhxMzVYMu9z+BXkCxPPccyIci9Whvy1cHV3u/oD
        ouz480skARZ9l5Z4mFwByTTtSJ0bSrY6yv5aeWOHjXN8ObvV+cezNoY+SBzG0fns
        h66VlQVaqBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01A6D57721;
        Wed,  7 Dec 2016 19:20:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D2AF57720;
        Wed,  7 Dec 2016 19:20:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] describe: add support for multiple match patterns
References: <20161207023259.29355-1-jacob.e.keller@intel.com>
        <20161207023259.29355-2-jacob.e.keller@intel.com>
        <xmqqa8c7wfxu.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrPivwMzGhzKxu30jns+YvSQGXBKUc4JDmfbenTy27tZg@mail.gmail.com>
Date:   Wed, 07 Dec 2016 16:20:32 -0800
In-Reply-To: <CA+P7+xrPivwMzGhzKxu30jns+YvSQGXBKUc4JDmfbenTy27tZg@mail.gmail.com>
        (Jacob Keller's message of "Wed, 7 Dec 2016 15:49:22 -0800")
Message-ID: <xmqq60mvuv8v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 223CC32A-BCDC-11E6-87EF-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Basically, this started as a script to try each pattern in sequence,
> but this is slow, cumbersome and easy to mess up.
>
> You're suggesting just add a single second pattern that we will do
> matches and discard any tag that matches that first?

I am not suggesting anything. I was just trying to see how well what
was designed and implemented supports the use case that motivated
the feature. Think of it as a sanity check and review of the design.

> I think I can implement that pretty easily, and it should have simpler
> semantics. We can discard first, and then match what remains easily.

I actually think "multiple" and "negative" are orthogonal and both
are good things.  If we are enhancing the filtering by refname
patterns to allow multiple patterns (i.e. your patch), that is good,
and it would be ideal if we can also have support for negative ones.
