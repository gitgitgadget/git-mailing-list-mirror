Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097B5C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC1F24649
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oJlZ9jVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBMSet (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:34:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53310 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSes (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:34:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C752753EA5;
        Thu, 13 Feb 2020 13:34:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=evdfp7i0p6SL8eXx+2x7WPCXFxo=; b=oJlZ9j
        VRGL5GCbibemqpmWhlBOiN7G2fKoFlHci4Ulr+2FrvyjdzgjFWKuKDr1xZT5fz89
        ZdpasVBltolzkAzDr6vnJQt245Jfj44dzlm08J1RogZX0rO8scTvh263NNwlN1IJ
        yjfm0sODvHzl5XNqPMlfh5RvPPsx0Hd+pyziQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xoHpJ76ZUQ++GyxyffK7R2Dq8eEWbBYy
        jKVU51vYIzY4lMKWjs0+axAgg854lO0oHILPmGvM10Ho/bQr7+cmBQi0xX4lVLlV
        V2HqO3sWe6+p3GxfwpOcW4fdsztbJoNR9s9CtfkvyWcgN602QPnIv0Zo+pTI7esb
        C6qEbSnypX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF3DA53EA4;
        Thu, 13 Feb 2020 13:34:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E38253EA2;
        Thu, 13 Feb 2020 13:34:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 05/13] rev-list: factor out bitmap-optimized routines
References: <20200213021506.GA1124607@coredump.intra.peff.net>
        <20200213021820.GE1126038@coredump.intra.peff.net>
Date:   Thu, 13 Feb 2020 10:34:45 -0800
In-Reply-To: <20200213021820.GE1126038@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 12 Feb 2020 21:18:20 -0500")
Message-ID: <xmqq4kvus5dm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82EC8992-4E8F-11EA-819C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There are a few operations in rev-list that are optimized for bitmaps.
> Rather than having the code inline in cmd_rev_list(), let's move them
> into helpers. This not only makes the flow of the main function simpler,
> but it lets us replace the complex "can we do the optimization?"
> conditionals with a series of early returns from the functions. That
> also makes it easy to add comments explaining those conditions.

... and these new comments makes the resulting code much easier to
follow.  Nicely done.

