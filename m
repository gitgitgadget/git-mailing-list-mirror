Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8821B207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 20:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422684AbcIZU3w (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 16:29:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54965 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1422674AbcIZU3v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 16:29:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1406B40DB0;
        Mon, 26 Sep 2016 16:29:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ijmTcHku9sNE2uDyTmikMnWUo0M=; b=xiK0EE
        JJoA5JjV+ZXoaaYJJFq4KgQcTGC4khWXp2SVxqodVY/FLgdLzTjhEm+efEzB7MWr
        4atucv0dRbWap3oGrbCJ/PtEriVVuEMX4l8o3A7e+PZrikSEyTwFvCObjHVLRSRC
        LpfyDDYK8vM9W8GSeJfENQJXGn/OsECSdRtpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c07G+Vr+4o/uSk7ruiHGRyXx+vJi7TXj
        Eq5SHoT+aUCeaS2wb7VYDX2nwItMurDTKkHi6zXcRuiB7acp2aUzZEYB/sZCrnJ6
        EpcwbRjP+6aX33Q8Pft5iOW9nXNVd3SFDMuqYhlpTMEN3M8v2jHDk2jlGQFuTLB0
        VG6vGFfaPcA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B33840DAF;
        Mon, 26 Sep 2016 16:29:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8665440DAE;
        Mon, 26 Sep 2016 16:29:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de
Subject: Re: [PATCH] Documentation/fetch-options: emit recurse-submodules, jobs unconditionally
References: <20160926193553.32631-1-sbeller@google.com>
Date:   Mon, 26 Sep 2016 13:29:47 -0700
In-Reply-To: <20160926193553.32631-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 26 Sep 2016 12:35:53 -0700")
Message-ID: <xmqq7f9yqu9w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8E3F364-8427-11E6-A41A-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Currently the section about recursing into submodules is repeated in
> git-pull word for word as it is in fetch-options.
>
> Don't repeat ourselves here and include the --recurse-submodules via
> fetch options.
>
> As a bonus expose the --jobs parameter in git-pull as well as that is
> declared as a OPT_PASSTHRU for fetch internally already.

The above may not be technically wrong, but smells like an
under-researched description.

IOW, "Why did the commit that introduced the option described it
this way in the first place?  Was there a specific reason why it had
to be that way, and that reason is no longer with us now, which
makes this change safe?" is a very natural question somebody who
sees this patch, and your description does not answer it.

It seems that the option to recurse into submodules was added by
Jens's 7dce19d3 ("fetch/pull: Add the --recurse-submodules option",
2010-11-12) to both fetch and pull at the same time.  I suspected
perhaps we hid it from pull initially while describing it for fetch,
but that does not seem to be the case, and back at that version,
pull and fetch shared the description without duplicating.

So where did we go wrong?  Was there a good reason why we have two
instances of these option descriptions, and if so, are we sure that
that reason is no longer applicable to today's system that we can
safely share the description?  The proposed log message is a place
to answer these questions.

By the way, 7dce19d3 is interesting in another way and worth
studying in that it adds --submodule-prefix ;-) It may be something
we want to consider consolidating with what Brandon has been working
on.

By the way^2, the "unconditionally" on the title conveyed less
information than their bits weigh.  Unless a reader knows
fetch-options are shared between fetch and pull, s/he would not know
you meant by "unconditionally" to show these in both fetch and pull.

    Documentation: share more descriptions for options between fetch and pull

perhaps?

Thanks.
