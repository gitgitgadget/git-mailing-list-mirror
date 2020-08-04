Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59548C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 19:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF10207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 19:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AMH8HwdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgHDTmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:42:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62310 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHDTmu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 15:42:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D85A76D47E;
        Tue,  4 Aug 2020 15:42:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0w0efGvQVn2IrKd49WlLdknJUHI=; b=AMH8Hw
        dAQlHLZixiv5NVLiNWSSmdIW9EtZUYoFL7vV890Z7/JH0ytmp6uDOJfO1Fj5u8B8
        ewNc1grwsZX/xPBgnBwqOL9d4caQnJaGFZsBh4bW9ToCAO6vt3kO+Mxa4rhdrYvs
        gW+pCi/s84/DlOTSp22K9DwIQ8DFKym5b8hH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kWpMNco+0Si0bdhKk7X2sO27PSHaMhee
        s5pDzLaCAESfHSG49399vSg7beURXsbEXCmDl3fE8lJ6ix6WhH2+RpUjkqT0kED3
        5cHJ7+2n0IBNRRvhXa+yqJauc6yChyAVQFRFn9RMIXJ9iBbGw6z2zOMfzNr6ksYO
        8Z+adLBkTzU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF0426D47D;
        Tue,  4 Aug 2020 15:42:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AC5B6D47C;
        Tue,  4 Aug 2020 15:42:46 -0400 (EDT)
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
Date:   Tue, 04 Aug 2020 12:42:45 -0700
In-Reply-To: <874kpi47xj.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        04 Aug 2020 20:50:16 +0300")
Message-ID: <xmqqbljqrydm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABC50F96-D68A-11EA-AF86-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> It's too late for "-m" to change semantics (we could do a long
>> deprecation, but I don't see much point in doing so). But --diff-merges
>> is definitely still changeable until we release v2.29. My resistance was
>> mostly that I didn't want to complicate my series by adding new
>> elements. But we could do something on top.
>
> Attached is rather minimal incompatible change to --diff-merges that'd
> allow extensions in the future, to get out of urge for the discussed
> changes. I'm going to follow-up with actual improvements and I'm aware
> it lacks documentation changes.

The overall direction is probably OK, but I wouldn't call it minimal.

> What do you think, is it OK to have something like this before v2.29?
> And, by the way, what's approximate timeline to v2.29?

tinyurl.com/gitCal

> As for me, I'm not sure 'combined-all-paths' should be included and if
> it should, is it a good enough name.

As a user, I do not think I can guess, from the option name, what
that option is trying to do.

As a minimum patch, I think it is OK to have just 'all' and 'none'
(not even c or cc, let alone the one with ultra-long name whose
effect is mystery) before we let the result graduate to 'master'.
Others can be added on top, as the primary focus of Peff's series is
to make sure "-m" can be countermanded, for which being able to say
"no" is sufficient, and the primary reason why we are further
futzing with the series with this addition is to leave the door open
for later additions of different "modes" in which how
"--diff-merges" option can operate (iow, Peff's was merely on/off,
but you are making sure others such as <num> can be added over
time).

Thanks.
