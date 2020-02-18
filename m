Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1F3C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 23:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F142822B48
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 23:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YQt84YfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBRX2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:28:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55296 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgBRX23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 18:28:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C315BEA1B;
        Tue, 18 Feb 2020 18:28:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=phBLnRB4LyCkYMU99rS3QWyXQT8=; b=YQt84Y
        fDaY8LRdIstKuSakI9a/iNIoRDGjd7YdljNDT+LcubE87wlpSL1kAbZutiEBhtxj
        GritoBMJb9P8w1topZ1X0ukayxDZwlH4VFFCOMktnKDgc1wPs4UsbFC+Ii/YkwT0
        vjzTfZhVCk+OhDTJwxtY6IrqLh9Kp+5R6mRQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kFOMMTPCsEywE9TV5PJgTL1Y5A56nqU5
        p3W2Cs1TPmvDdN5h/SuK5YnHtussPQfqt+emaNCH2YtMd3CShkT0cW0R8+w+aFUz
        2QmxQegobSXNi9i6cIO6fNTTJkSeac0cReATnhKQkqLe0BHnLeP3fIJszyN9wiKu
        HwCH+qnhwn4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53FB8BEA1A;
        Tue, 18 Feb 2020 18:28:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 839D5BEA19;
        Tue, 18 Feb 2020 18:28:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
References: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
        <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
        <20200216065101.GA2937208@coredump.intra.peff.net>
        <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
        <20200218195402.GA21586@coredump.intra.peff.net>
        <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 18 Feb 2020 15:28:24 -0800
In-Reply-To: <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 18 Feb 2020 15:05:21 -0800")
Message-ID: <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CF0DCB4-52A6-11EA-9200-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Coming back to the original topic, ...
>
>> If a tag describes a commit, we currently output not the tag's ref but
>> its embedded name. This means that when the tag is locally stored under
>> a different name, the output given cannot be used to access the tag in
>> any way. A warning is also emitted in this case, but the message is not
>> very enlightening:
>
> None of the above is wrong per-se, but the reason why we chose to
> use the real name of the tag in the tag object, while issuing a
> warning, was so that people can correct the mistake of storing an
> annotated tag A to a wrong refname Q.  If "describe" gave a name
> based on refname Q, there is no incentive to correct the situation
> to use the right refname.  The name that describes the commits
> relative to the real name of the A is *not* usable by design, until
> the refname is corrected (i.e. the tag is stored in the right
> place).
>
> So I am not 100% confident that the original patch is a good idea.

FWIW, this design came from 212945d4 ("Teach git-describe to verify
annotated tag names before output", 2008-02-28).  Shawn was quite
explicit that use of the real name was deliberate:

    If an annotated tag describes a commit we want to favor the name
    listed in the body of the tag, rather than whatever name it has
    been stored under locally.  By doing so it is easier to converse
    about tags with others, even if the tags happen to be fetched to
    a different name than it was given by its creator.

and I tend to agree with the original rationale.
