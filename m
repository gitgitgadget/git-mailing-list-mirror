Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95482C433E1
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6181C20792
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j8mMI/1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgHCRVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:21:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53332 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgHCRVM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 13:21:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCA94D2815;
        Mon,  3 Aug 2020 13:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5w0mEWo0Gc4CfPGMD9LI1dw1+mo=; b=j8mMI/
        1oYEpJ4jQQKhflt47tPpflzpXIvgY/N2wUtrn/QiagehanaEot0IBFOfO8USlgjU
        Y4wDZkn+JnbFGyOdBlYLN8uD1RSpFl+gwY88I80vsgjomj7zjARnC2+IGlvJF8lR
        S9DFqKILyOBJExdt6oGcasyxu2SNtSNlUndTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YG/K6+DWgliGuEGB6WtDDkpwuiKalraf
        NkELwtkmPnelyQVYIX6OM6dgVNqB1rkj5ZcOLg+fTck6sazw1d2k/JdIvrfatfCa
        kQhnj4/0ONXzeJZwDCwBdkh43ZIqPVWYhqPhL26Ko6DslC3PuOQmOWhMeyM5Jdye
        FX8fEONqGD8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6B5DD2814;
        Mon,  3 Aug 2020 13:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1AB6FD2811;
        Mon,  3 Aug 2020 13:21:08 -0400 (EDT)
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
        <87o8nrybnb.fsf@osv.gnss.ru> <xmqqd047wuuh.fsf@gitster.c.googlers.com>
        <87pn87smw3.fsf@osv.gnss.ru>
Date:   Mon, 03 Aug 2020 10:21:06 -0700
In-Reply-To: <87pn87smw3.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
        03 Aug 2020 19:41:00 +0300")
Message-ID: <xmqqy2mvve65.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7FFB960-D5AD-11EA-9BA5-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Sounds great, I only hoped we can do it right now, with this new
>>> --diff-merges option, maybe as a pre-requisite to the patches in
>>> question, but Jeff said it's too late, dunno why.
>>
>> A follow-up patch or two to remove the "--diff-merges" option and
>> add the "--diff-parents=(none|<number>|c|cc|all)" option on top of
>> the jk/log-fp-implies-m topic BEFORE it graduates to 'master' is a
>> possibility.
>>
>> But is it worth the delay?  I dunno.
>
> I don't think it's worth the delay, provided yet another new
> --diff-parents is to be implemented rather that using --diff-merges for
> that.

I was responding to your "it's too late, dunno why", as you seemed
not to want to waste an option "--diff-merges" that will become
unused when "--diff-parents" come and also wanted it to happen right
now.  If you no longer want to see it happen right now, that's OK by
me.  



