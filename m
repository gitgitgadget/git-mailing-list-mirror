Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07798C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9716207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MKEiq+ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgHDVzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:55:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50238 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgHDVzm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:55:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 334C46E3E8;
        Tue,  4 Aug 2020 17:55:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KTed02Ppt4dTjiPJY3rC41O+YtY=; b=MKEiq+
        ma575Q95CSPDDCeoqzeNvIlmYCWLYothr6oTh9nWXlPbScQDgyEBKQD2Dfhqtx9e
        aCYQ9wCmlfGQXxj/55B7zkw0HlmyIMcPaiK7nbzzxWI6aORf4fPB8qvAvAJSW31j
        S+k+YL3zZ45rY9loLrzn+B5YT/QMdHRRhEYho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kgRoKvAQ3WfZgf6XkAxjkwmMclJsgM2N
        m7M2FcOeUJ8Ro4MXzCiq6EErAUUeAP7nbgodhyvNA3xzg1AeQ7WeaQZBgkBp/9tv
        hYGheM1mGNE99nleVU9lwsxYuxZ/eCY10olmPqNZu/WMw91cKVA+bFJ3rEoL+lSy
        8H7wrKxeKiA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A4586E3E7;
        Tue,  4 Aug 2020 17:55:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A89FB6E3E6;
        Tue,  4 Aug 2020 17:55:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
Date:   Tue, 04 Aug 2020 14:55:39 -0700
In-Reply-To: <20200804212201.GA2020725@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 17:22:01 -0400")
Message-ID: <xmqq3652rs84.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C3D42E8-D69D-11EA-86DF-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 04, 2020 at 11:55:19PM +0300, Sergey Organov wrote:
>
>> I only don't like --diff-merges=none (even though it sounds great for
>> --diff-parents=none) and used --diff-merges=off instead. It's not a
>> strong feeling though, and I'm fine with whatever we decide.
>
> I think that is fine. I took "none" to be "diff against none of the
> parents", which is the opposite of "all". But "off" conveys that, too.

For now, "off" is OK, but then we'll regret when "all" comes,
because "off" would not exactly sit opposite to "all".  On the other
hand, "none" would: Compare with all parents?  Compare with none of
the parents?

Thanks.

