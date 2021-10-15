Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82752C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631A461222
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 18:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhJOSFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 14:05:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57962 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhJOSFu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 14:05:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63D4916536A;
        Fri, 15 Oct 2021 14:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PV74/dLkqfTcYI8TvSPV26y/MxfK98ZMSNr8lf
        GjQl8=; b=qVtMLgr7XsslIkOHehNSXiCeCu8YO3Lz3CHhoxiXNjfAeQJmRluwwR
        U5uqASMhLVTM88eYHONCSoTmG8uKV9I0skmZpLlVNJB4SVdGRaVusZtdKt/OaRhp
        DWPWGZE8PX7D3TRFpFEjpcnvdIilKy+gvJUG6DjyG1eWYdxGCE6WY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A0E9165369;
        Fri, 15 Oct 2021 14:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 67C9B165368;
        Fri, 15 Oct 2021 14:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     milan hauth <milahu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: force deterministic trees on git push - exact sort-order of
 filenames
References: <CAGiEHCtdjA+cVXjN43NPbSZfrDtr-kDtPMN4x_VTGSJuPZ8bcg@mail.gmail.com>
Date:   Fri, 15 Oct 2021 11:03:39 -0700
In-Reply-To: <CAGiEHCtdjA+cVXjN43NPbSZfrDtr-kDtPMN4x_VTGSJuPZ8bcg@mail.gmail.com>
        (milan hauth's message of "Fri, 15 Oct 2021 18:04:57 +0200")
Message-ID: <xmqq1r4m6u84.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A3A7A68-2DE2-11EC-A9F0-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

milan hauth <milahu@gmail.com> writes:

> fact: the sort-order of filenames in a tree is not strictly regulated

Untrue, sorry.

The rule is "a tree entry that describes a tree object sorts as if
its pathname component has a trailing slash '/'".  All your sample
trees should satisify that rule (or the implementation of Git that
created such a tree is broken).

In hindsight, if we used the collation order that puts '/' before
all other bytes when sorting the index entries and the tree entries,
it would have made a lot of implemenentation details clean and easier
to work with, but that would have been feasible in early 2005, and
not now.

