Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E61C207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 18:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162958AbcIZSRy (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 14:17:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60246 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1162426AbcIZSRx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 14:17:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 659C741719;
        Mon, 26 Sep 2016 14:17:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5a4/fOC+yG3WgYeCtbyjVGTtU78=; b=qE1Txi
        CSAFW74NBbfN+VxkWei6Vy9V9CeqWOIw5+NmlUCBhxhpj458sHv5Y4JI9OEsNBVV
        /mcML4kpkmzcXIG7l9synuRiUj7ZHEfa8WAp3ibovWdL97UNaWW7PViEBJja6hRh
        5vrTFSO3TM2DPR/LVBkWl85OiZOUyBf//A1hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cjxs/O3gWPNyjppqB8uyE5Eyp3etsQRw
        SqGfkq1Vvi5PKMsdap9we1mHKj6DjDyXIkJPCC6qqs6O2a+/V7xK8m62OPvKd8gI
        9aCcsLliuNt4SlqpzbSon/CEoRHG0gYngHjueDTjNZoCd6BcQWj03e2AQ4mmXIbW
        BtwZrsJBkGI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57B7241718;
        Mon, 26 Sep 2016 14:17:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C454841717;
        Mon, 26 Sep 2016 14:17:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] recursive support for ls-files
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <20160925071744.2qcz7cntc7xxpjqv@sigill.intra.peff.net>
        <20160925163244.GB66080@google.com>
        <xmqqzimvygdt.fsf@gitster.mtv.corp.google.com>
        <20160926170429.GA3624@google.com>
Date:   Mon, 26 Sep 2016 11:17:49 -0700
In-Reply-To: <20160926170429.GA3624@google.com> (Brandon Williams's message of
        "Mon, 26 Sep 2016 10:04:29 -0700")
Message-ID: <xmqqponqseya.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 898B429A-8415-11E6-9988-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> In a previous email you mentioned that this feature should be completely
> hidden from users, which is why I removed the command line option for
> this latest series.

I may have said something like that; I do not recall, though, so a
more accurate description might be "I may have said something that
can be (mis)interpreted like so".  Sorry for the confusion.

In any case, an environment is not "completely hidden from users",
so it is not fundamentallly different from a command line option
anyway ;-)

> If that isn't what you intended that I can
> definitely add the option to git.c.  And you would rather we perform the
> checking in git.c to see if a subcommand supports the prefix versus
> silently ignoring it if it hasn't?  I'm assuming this checking would
> also be done in git.c?

I actually do not care strongly _where_ the check happens.  It was
just that in the subcommand dispatcher would be the single place
that is easiest-to-implement to perform that check, that made me
suggest that.  We already have various bits like NEEDS_WORK_TREE,
RUN_SETUP, etc. so REJECT_EXTERNAL_PREFIX (or whatever its name be;
I do not offhand recall current proposal) bit would fit there
naturally, I would think.  Of course, non-built-in commands need to
protect themselves separately, if they want to.
