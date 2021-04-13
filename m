Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2D7C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F9661176
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345805AbhDMVDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:03:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54958 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245671AbhDMVDh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 17:03:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0D17CED68;
        Tue, 13 Apr 2021 17:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZhOCi1SL2fjJ4vAyY+Rz1pAQks8=; b=a/EWPd
        f6altoYIW9BE/TExNSz19zK60BByRb6DxxJEngVsy5VHi4VqUXYqWsRvfUP6ffCb
        MBWrVRl9l+EFF2ZZM52vcpdPqYOFEU6iaoEoW58NfkOwZztym5E6SX17Qp9XYUFt
        RpTKBMtyZjUBo/2+6hgMyq5m3Gr53mPc3XSiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=du9WPvq5jLRt34PpeaX+ToDsQ77tOFgC
        v2EnLiDmURQzDrDhrtGI4nG82hcctXOMGdbGlLen0IJgjrzsmlgfALABYIy48yRz
        YPDZmzUDd9MUJ1Zh0NVw1/aVXcHSvwGTKR0mttwEwLXRDE7HgTbspargcjU2z+lL
        sCR6ZtXlYtw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C84C9CED67;
        Tue, 13 Apr 2021 17:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C9ACCED66;
        Tue, 13 Apr 2021 17:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
References: <cover.1617967252.git.ps@pks.im> <cover.1618234575.git.ps@pks.im>
        <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
Date:   Tue, 13 Apr 2021 14:03:12 -0700
In-Reply-To: <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 13 Apr 2021 03:45:21 -0400")
Message-ID: <xmqqfsztlwxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8F315A6-9C9B-11EB-936A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks. I have no more nits to pick. The only question left for me is
> the big one of "do we like this with --filter, or should it be some kind
> of rev-list option", as discussed in:
>
>   https://lore.kernel.org/git/YHB7R8hVRt+V+i2W@coredump.intra.peff.net/

I do agree that adding "--blobs", "--trees", and "--tags" options to
the "--objects" (and implicit --commits) to rev-list parameters is a
lot more in line with the original design by Linus when we added
"--objects" (vs not giving it).  We even internally have had the "do
we show trees?" "do we show blobs?" separate bits from the very
beginning of the "--objects" feature at 9de48752 (git-rev-list: add
option to list all objects (not just commits), 2005-06-24), which
was extended to cover tags at 3c90f03d (Prepare git-rev-list for
tracking tag objects too, 2005-06-29).  The basic design principle
hasn't changed when the code was reorganized to be closer to the
current shape at ae563542 (First cut at libifying revlist
generation, 2006-02-25).

But back then, we didn't have mechanisms to filter rev-list output
using other criteria, which brought us the umbrella notation to use
"--filter=...", so as a notation, it might be OK, provided if

	git rev-list \
	    --filter=object:type=tag \
	    --filter=object:type=commit \
	    --filter=object:type=tree \
	    --filter=object:type=blob "$@ther args"

is an equivalent to existing

	git rev-list --objects "$@ther args"

I however have to wonder why this need so much code (in other words,
why do we need more than just adding something similar to this block
in the revision.c machinery:

	} else if (!strcmp(arg, "--objects")) {
		revs->tag_objects = 1;
		revs->tree_objects = 1;
		revs->blob_objects = 1;

that flips <type>_objects member bits?) though.
