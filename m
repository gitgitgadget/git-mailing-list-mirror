Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25DBC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5784822B42
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EaMrkNbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgHDV2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:28:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63174 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgHDV2F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:28:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DAC6D68DB;
        Tue,  4 Aug 2020 17:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ig5/rg0TJ3HPHukE4SL7ujzqwf4=; b=EaMrkN
        bExwhaDgoimX6IZbzPPIA0ORyEJcx5PoVSgX+H+3Rdhzez2HK5H5SV+nUQNJdh2e
        6jtoqgKllPdTxVEbezfFOZB3gpSooDww7aGuCh9yWbXqfD6D+D34Z4kwivzjReIM
        zCAKIXTIyRRBD4YzB7waPJM+f/Dd6XKPCIHIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WlS5QxB+kkuP4Aaq/kEOI8QZeuHyppQR
        dWwC/s3cjrgxD6IhVtderUHAsg2CgTHPHWMPA78CLITttBtZxu+2ihiU95vO1FgW
        wWG8DC3gNfgBQKyF6uVTMc93Bm70/kaMtP5kVW7sFV0VlCKS603BIYHCA9sA5uuC
        HjbRolzWkxQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35ABDD68DA;
        Tue,  4 Aug 2020 17:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 74266D68D7;
        Tue,  4 Aug 2020 17:28:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
        <873652166e.fsf@osv.gnss.ru>
Date:   Tue, 04 Aug 2020 14:27:58 -0700
In-Reply-To: <873652166e.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        04 Aug 2020 23:56:25 +0300")
Message-ID: <xmqq7duerti9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F454F6E-D699-11EA-A398-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> +	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
>>>  		revs->ignore_merges = 0;
>>> +		if (!strcmp(optarg, "off")) {
>>> +			revs->ignore_merges = 1;
>>> +		} else if (!strcmp(optarg, "all")) {
>>> +			revs->diff = 0;
>>
>> Should this be revs->ignore_merges = 0?
>
> It's 4 lines above, as it's in fact common for all the cases but the
> first one.

I may be mistaken, but I thought Peff was asking about turning
revs->diff off.  I somehow thought that the equivalence planned for
the short term is:

            (new)               (peff's)         (master)
	diff-merges=none == --no-diff-merges == ! -m
	diff-merges=all  == --diff-merges    == -m

and future extension would add equivalents to --cc and -c, in
addition to <parentNum>, which is not something we can do with the
current UI and machinery.

So, shouldn't the body of that else if clause for "all" be a no-op?
i.e.

		} else if (!strcmp(optarg, "all")) {
			; /* nothing */
		}


