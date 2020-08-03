Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A31AC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5082086A
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cY4l6XIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgHCUk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:40:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54845 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgHCUk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 16:40:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D7247926C;
        Mon,  3 Aug 2020 16:40:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AGXWV51AlSTVYKJUE2AH5/k/3LQ=; b=cY4l6X
        IMgpu4VqRGwM8XTXEiKGLrbHpBxD4tDCvbMXeGbdqw3wSn2hLkvIltmTj9IlhZ0T
        uqjXIIuF4JbesU3yIcUG7TnDeA/AqPSm+VuSB216HAwR5G+D6PuI1Uh4X4zKsq5X
        o2AKhd8GtaLV5PAzR+QiyuoRq3RAzDfQ8yuek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MSWm5kHMVjNwEI4asD2IFQO2wjClEgj8
        dS5BAUjchIFcEfPB79uACQWnoUibVSGAzckpCP4yB/vNXLJtpLg7nGMSl+Ub7MR1
        mBVkettn9vKE02oJ2nvtsTQn5JIJbwUxZlAlJFzkcUBFlJg4IOlv8T/viFcHYdPB
        XK0aYPneZtg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 161C17926B;
        Mon,  3 Aug 2020 16:40:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A9347926A;
        Mon,  3 Aug 2020 16:40:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
        <20200803160051.GA50799@syl.lan>
        <20200803194006.GA2715275@coredump.intra.peff.net>
Date:   Mon, 03 Aug 2020 13:40:54 -0700
In-Reply-To: <20200803194006.GA2715275@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Aug 2020 15:40:06 -0400")
Message-ID: <xmqq8sevv4x5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A08613DA-D5C9-11EA-B957-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The real trick is that you can't create or update symbolic refs on the
> server side using a client. So this would have to be something that
> hosting providers allow (and there might be some security implications;
> I'm not sure what happens if you create a loop in the symref
> resolution).

Another is that the old name must be declared forever banned if we
use symbolic refs for this.  The mechanism would have fell far short
of helping transitioning from 'pu' to 'seen' for example X-<.

