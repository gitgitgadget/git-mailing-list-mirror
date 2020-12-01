Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38757C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C144521741
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RVywcyDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392208AbgLASam (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:30:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58757 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391895AbgLASaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 13:30:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72C229F9FF;
        Tue,  1 Dec 2020 13:29:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+CA4VEz1tSvDA/enKyhiTEn3FbM=; b=RVywcy
        DdKi4dt81Dipotv0bpKzL98sjozcTNBZWbiE3AjOk4voagB7qCwJUYvKYGs8uqt3
        Y88gIx0lzmvhX7u1FwnyBak8cMlfYlx1CBoNxHtvWP42iq0IEsnpPcdNh3Uue3CG
        Zy/Q7hhHiIRhCjx1BVVVEDegAMBmMy/Gis4hI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YMAHHG00cLGtd8EVlJVGyCz1STCfF0Sv
        a73KWVuMiXobSCDL1FSQgkuYbMkvgKKp/3C6KYK1XeQkw+6Fd+TqnC7jCa+K4mBo
        WdF/Rc/EEHmouVH9MD9mdV5ENrs1N5HyZFJGJhfJAFXOLgHLCh9Muy1NMIHTK0wp
        bdJD3NKu48w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6822F9F9FE;
        Tue,  1 Dec 2020 13:29:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9EC99F9FD;
        Tue,  1 Dec 2020 13:29:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] refspec: trivial cleanup
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
        <20201201004649.57548-2-felipe.contreras@gmail.com>
        <X8YsXjN7MQrLnytw@coredump.intra.peff.net>
Date:   Tue, 01 Dec 2020 10:29:42 -0800
In-Reply-To: <X8YsXjN7MQrLnytw@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 1 Dec 2020 06:43:26 -0500")
Message-ID: <xmqqh7p5qt0p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E219830-3403-11EB-9608-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 30, 2020 at 06:46:46PM -0600, Felipe Contreras wrote:
>
>> We can remove one level of indentation and make the code clearer. So why
>> not do so?
>
> I know your question was rhetorical, but a good reason not to do so in
> general is that the existing pattern reveals some intent. E.g., it
> sometimes is the case that with the _current_ code we can return early
> from a function or loop, but that is not inherent to what the code is
> doing, and the early return or continue makes it harder to understand
> that.
>
> I don't think that is the case here, though. The continue actually
> expresses the intent more clearly than the existing code.
>
> So the patch looks good to me (as do the others in the series).

Yup, the patch text (eh, the source with the patch applied) looks
good.  I'd agree with your hintand would take rhetorical question
out of the log message while queuing.

Thanks.
