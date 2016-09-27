Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D2220986
	for <e@80x24.org>; Tue, 27 Sep 2016 22:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbcI0WBG (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 18:01:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58947 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752504AbcI0WBE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 18:01:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58793406E6;
        Tue, 27 Sep 2016 18:01:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a8PU30LiKA75SfDdXhnMT2V/aYM=; b=SChM9i
        upPtbqF7c9/rQ1T4G9mXI66/G5GoKbZ7uRGYoCn6txWHrLAOyeycu1c0psaWgtiO
        R7NTfkERVHyFjX3b3bgE0L/ZDxi/xqEhqhFz4vWTf31z5o+WAypu/gs+GWBJ04nA
        JEIGhwWOY85bjoJdMbnLXtHailp5/yEfi/z6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ei8gHenKbkQD6lvfJdu75yWjZrsKytzz
        3ninPGRHmVdEea9qtEHXWuvjxwKmgrg8vAnheFQyFV6EX+HRRn0PGkjf/jhKgI+0
        PU7ECTdaNSkF/hEDs7RWLpbDtCaC/eI1601y2pNO0LzPLa969VogZ/Ds9alqQad4
        3QloGoDEDbw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50856406E5;
        Tue, 27 Sep 2016 18:01:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA615406E3;
        Tue, 27 Sep 2016 18:01:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
        <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
        <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
        <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
        <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
        <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
        <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com>
        <xmqq60phm39w.fsf@gitster.mtv.corp.google.com>
        <20160927214854.GA180705@google.com>
Date:   Tue, 27 Sep 2016 15:01:00 -0700
In-Reply-To: <20160927214854.GA180705@google.com> (Brandon Williams's message
        of "Tue, 27 Sep 2016 14:48:54 -0700")
Message-ID: <xmqqwphxknoj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1973F82-84FD-11E6-8F34-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Well maybe...I don't really know much about how the prefix interacts in
> every scenario but would what you describe still work if we are in a sub
> dir of the superproject (which contains other directorys and perhaps a
> submodule) and execute a --recurse-submodules command in the
> subdirectory?  I suspect we don't want to force users to be in the root
> directory of the project in order to use --recurse-submodules.

You need to remember "must be at the top" is relevant only to the
command that is invoked with --super-prefix, not the recursive one
that drives such a process.

Suppose your superproject is organized like so:

    - file-at-top
      a/file-in-A
      a/b (submodule)
      a/b/file-at-top-of-B
      c/  (submodule)
      c/file-at-top-of-C

If you are in a subdirectory of your superproject, say, a/,

    cd a && git ls-files --recurse-submodules -- "b*"

I would expect we would recurse into the submodule at "a/b" and find
"b/file-at-top-of-B".  What does the internal invocation to do so
would look like?  I would think "git -C b --super=b ls-files" that
is run from "a".

Your code would is already prepared to find "file-at-top-of-B" in
the index of the submodule, prepend "b/" to it and report the result
as "b/file-at-top-of-B" when such a call is made, I think.

Now, can you refer to c/ and c/file-at-top-of-C while sitting at a/?

    cd a && git ls-files --recurse-submodules -- "../c*"

would be the top-level invocation.  This would iterate over the
index of the superproject, trying to find what matches "c*" (or,
"../c*" relative to "a" i.e. where you are), find that 'c' that is a
submodule, and invoke "git -C ../c --super=../c ls-files"
internally, I would imagine.  I think your code is prepared to
accept this case as well.

In any case, the "must be at the top" does not come into the picture
at all for the end-user interaction, i.e. invocation of the command
that is told to recurse into submodules, so we'd be OK.

