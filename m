Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3369FC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23CE206A5
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ueqrFtzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgEDVFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:05:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53754 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEDVFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 17:05:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62B98BD02A;
        Mon,  4 May 2020 17:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AIr7Yv1KgxAq1cbKHgJ94yN5b1Q=; b=ueqrFt
        zkD/JTk4SgdD0gq4ksf4an3jp9GC4+cl0WUKKgDwfmulVxWADDuB0uFSVEUSfeIv
        sCXd8Zsx2ZnyGYB3hSATVjHc9LO5etWrpxzOf6AnRWOiF4lDRipLX/6z2Rvq9l9P
        1Dm9qQjPMZApEp1kF1Xz8g0tg/H7Z3JRKW28w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tePjL4OizyT2LxXPaVxlUyX2hysWfp/K
        0sBsmeJzofl3AUfoiEzQqwRukyfz/qMUC7UQSoTlign78TU5Y/wk06DwNpo4jQ0U
        qRhbE2TmweRFilhlA6RpUWidk/B/VZXCCLRV7kyiGhK/MCSgoWwAL3BHfOs5xaP2
        aH+Bt7+GOLE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 459A3BD029;
        Mon,  4 May 2020 17:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B16DBD026;
        Mon,  4 May 2020 17:05:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     clime <clime7@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] ref-filter: apply fallback refname sort only after all user sorts
References: <20200503090952.GA170768@coredump.intra.peff.net>
        <20200503091309.GB170902@coredump.intra.peff.net>
Date:   Mon, 04 May 2020 14:05:16 -0700
In-Reply-To: <20200503091309.GB170902@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 3 May 2020 05:13:09 -0400")
Message-ID: <xmqqd07jfm2b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F577B3F6-8E4A-11EA-90D7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit 9e468334b4 (ref-filter: fallback on alphabetical comparison,
> 2015-10-30) taught ref-filter's sort to fallback to comparing refnames.
> But it did it at the wrong level, overriding the comparison result for a
> single "--sort" key from the user, rather than after all sort keys have
> been exhausted.

Good find.  It does look like that the fallback was broken from the
very first version when it was introduced, as we did have multiple
keys support back in that version already.

The fix looks good to me.

Thanks.
