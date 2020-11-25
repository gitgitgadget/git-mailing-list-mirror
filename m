Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254B7C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D312075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OzeSI36P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgKYVWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 16:22:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63429 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbgKYVWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 16:22:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53E3F103A4E;
        Wed, 25 Nov 2020 16:22:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zM84WSOZnvWYg06BmWI1vsDLiOU=; b=OzeSI3
        6P+ZiI/aUKk28GOezqBbAjkZ0Noz5FbBvqmoe8FdWp11osYTRbVSD/eo96+efPMb
        Mbs7KGnSLnwPbUK/14NwymVezQD04asrutFdfmptKQZk9sbxXDstVBvvgXYbMpfs
        fFlCJ2So6Yi6Mkiw5KLeHYTH47R8Sgg0IfGh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H9VkSM5v+gb8oB3LypBMk7niThzfZqvd
        CdWDjBPM2wwAzy8ahz7q9ygZRexb+hETvg3uzGyUclKy2zy/PIWpBK1DaRC2kvxi
        C6T7y4c7UqDWpBXK+vQNjZIns1ReyBakAwURfTlR1MPRj5zGh22wqNFIcoRUl+t9
        d7PR1Qf1xHI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C360103A4A;
        Wed, 25 Nov 2020 16:22:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94C6F103A49;
        Wed, 25 Nov 2020 16:22:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 2/2] midx.c: protect against disappearing packs
References: <cover.1606324509.git.me@ttaylorr.com>
        <e1806d1bdc0da8061c78608e56138424ad24bed0.1606324509.git.me@ttaylorr.com>
Date:   Wed, 25 Nov 2020 13:22:03 -0800
In-Reply-To: <e1806d1bdc0da8061c78608e56138424ad24bed0.1606324509.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 25 Nov 2020 12:17:33 -0500")
Message-ID: <xmqq360xdtdw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 446E6FBC-2F64-11EB-9859-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When a packed object is stored in a multi-pack index, but that pack has
> racily gone away, the MIDX code simply calls die(), when it could be
> returning an error to the caller, which would in turn lead to
> re-scanning the pack directory.

Makes sense.  Will queue.

Thanks.
