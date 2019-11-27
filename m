Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE9BC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9132071E
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JlmRLWwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfK0Maq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:30:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63743 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfK0Maq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 07:30:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A19E4A1618;
        Wed, 27 Nov 2019 07:30:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=MMIOWGqA93COhoFCCVzjShOByrA=; b=JlmRLWwYy2DRyPzRzcHf
        iHZQqtroqEiX4qUdIJ6C6Scp9zuIRGvrQQ9OxDYPRcReN/O1p1rZ73Dpj4lehZ4W
        UDw2mncpg0UVZPY0sUQYd94wLXvw8zadh1DfUd0TtxChe2TDVUq1RV470zifNsIQ
        6Cm00xE6nJQCMLTrF6gfN/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=NHaYv3xQUBBLsJ+pMFX6nBMHFgJsR/Tt/VInspQeKG+6+C
        lxfUVWWmPTdSOvwNG/osNhl2CRHsLB2lb0u2jT4FTWnK3canyOhyG08X7H5CTx51
        Bt4lbd5oMJHYlOuXSuFPSIAxCTqb9dYXEz6oMiQBWPO4aA7keqqFSoDJimXII=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99616A1617;
        Wed, 27 Nov 2019 07:30:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3C64A1616;
        Wed, 27 Nov 2019 07:30:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] Doc: explain submodule.alternateErrorStrategy
References: <cover.1574731649.git.jonathantanmy@google.com>
        <a8125b946227d918865fde0dcbec516474b42386.1574731649.git.jonathantanmy@google.com>
Date:   Wed, 27 Nov 2019 21:30:39 +0900
Message-ID: <xmqqo8wxv6vk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9D5E81A-1111-11EA-8830-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Commit 31224cbdc7 ("clone: recursive and reference option triggers
> submodule alternates", 2016-08-17) taught Git to support the
> configuration options "submodule.alternateLocation" and
> "submodule.alternateErrorStrategy" on a superproject.
> ...
> The "submodule.alternateErrorStrategy" option determines what happens
> if that alternate cannot be referenced. However, it is not clear that
> the clone proceeds as if no alternate was specified when that option is
> not set to "die" (as can be seen in the tests in 31224cbdc7). Therefore,
> document it accordingly.

Given that for everyday use (cf. sha1-file.c::link_alt_odb_entry())
of an alternate is best-effort basis, I have a feeling that it was a
design mistake to have the "error strategy" configuration option in
the first place, and "clone --reference-if-able" was the result of
the same design mistake.  We would have been better off if we made
these the best-effort features as well.

But the ship has sailed long ago---so I think these two are the best
we can do at this point.  Perhaps flipping the default to warn may
be a longer term improvement, too.
