Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0686CC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 00:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbiAFARe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 19:17:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55922 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiAFARd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 19:17:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 450C417CB2E;
        Wed,  5 Jan 2022 19:17:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QlI6pKqO0VLmEieMtR5FSSAMmSnn+dHqmf6q2E
        1vh5o=; b=RPktnEsf6yyDWCp1YqZ7j+6hdkL9byBKm+zJGzqu7mXus/emlUPpNM
        81q51gA6E+m2TqYwGi4WmjNeMZItoqWzqMftzLt5SGuSjwk+xR2Kh2UYFKD4EsJw
        KBx/zpBCARY0jPXMwoCAN35pxJjYthZdpimB6blnNCh/+4SRVtBHk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C14A17CB2D;
        Wed,  5 Jan 2022 19:17:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 894A317CB2C;
        Wed,  5 Jan 2022 19:17:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Bug report - sparse-checkout ignores prefix when run in
 subdirectories
References: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com>
        <xmqqsfu1g64s.fsf@gitster.g>
        <CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcPFkOAvn_A@mail.gmail.com>
        <xmqqbl0pg3s7.fsf@gitster.g>
        <CABPp-BFfuDMQXCZg_5YXQLaPtc9nyrJaq8J6VEDVsaiEMeeZMA@mail.gmail.com>
Date:   Wed, 05 Jan 2022 16:17:29 -0800
In-Reply-To: <CABPp-BFfuDMQXCZg_5YXQLaPtc9nyrJaq8J6VEDVsaiEMeeZMA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 5 Jan 2022 16:08:42 -0800")
Message-ID: <xmqq7dbdg1k6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09813A4E-6E86-11EC-A177-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Are you possibly confusing pathspecs with gitignore patterns here?
> (Or am I?)  Or are you suggesting that sparse-checkout be modified to
> accept either gitignore-style files or pathspecs and handle both?

Much closer to the latter (actually, removing ignore patterns, and
make the subsystem work with pathspecs).

> I have never liked that gitignore-style patterns were used for
> sparse-checkout, but it has always seemed a bit too late to change it.

Perhaps.

> Ever since Stolee introduced cone-mode, my preferred strategy for
> fixing the gitignore-style patterns problem, assuming we are allowed
> to do so, is to deprecate if not kill non-cone mode.  (And in the
> meantime, I'm just doing due diligence when I mention non-cone mode in
> my reviews.)
