Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0340C2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AB5206D3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xg/Tx5n8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLXTPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:15:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56464 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfLXTPt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:15:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85AC732721;
        Tue, 24 Dec 2019 14:15:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZhoET7wYA+2qRswuWbhFO+Fynrg=; b=Xg/Tx5
        n8K4hgkoQIGLnFg8TM2Z8eWZMFMS6TSNwkfLooDPYvN0MF2dakcRNyZtdfv9Xi8Q
        UMKFEgpqIBE/AWiDbGVztFSh8cwzYtpFaUpdBCw0DIK5YPFHx9oLMmZ45s67C8Ne
        Gxx4KHbBe3+0YUOZgDCoTAfJG+IIt22EUJ1MU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FSevoEUVF1FcwywUoIlF9YhbrPEC65h0
        oDIZDTFNiDQEZCiBXAsSX5iLLsqBh1bPEvB/oI+pnBmf0G50HQD+DJ9FD4nB8WMu
        3d9LGrfqaUQqlVG+IxS/X1du6FALjq+Tu6V9wd7rcJ0vBk3ZW049RC0OWE460uUo
        fTAzk357JZw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E2CE32720;
        Tue, 24 Dec 2019 14:15:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3D443271F;
        Tue, 24 Dec 2019 14:15:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gal Paikin <paiking@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Updating the commit message for reverts
References: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
Date:   Tue, 24 Dec 2019 11:15:42 -0800
In-Reply-To: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
        (Gal Paikin's message of "Tue, 24 Dec 2019 12:06:51 +0100")
Message-ID: <xmqq7e2l5ych.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8307328-2681-11EA-BD1C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gal Paikin <paiking@google.com> writes:

> I work on the Gerrit team and I would like to change the default
> behavior for suggested commit messages for Reverts.
> Currently, if the user is trying a change called '"Revert "change X"',
> the suggested commit message would be 'Revert "Revert "Change X""'
> which is silly, since sometimes users want to revert the same change
> many times.
>
> The suggestion is to change the behavior to "Revert^N" instead of
> multiple Reverts one after another.
>
> I'm happy to change those things in Gerrit, but it would also be nice
> if it were changed inside of Git.
>
> What do you think?

I do not _think_ anybody lets the exact phrase 'Revert ...' in the
log message to be read by scripts to perform machannical action, so
in that sense it may be OK to special-case the reversion of a revert
and rephrase it in a more human friendly way.

BUT

 * what does "Revert^47" even mean?  Not just the proposed phrasing
   looks horrible, it is not even clear what happened at the end.
   Was the patch turned out to be OK after all these reversion war,
   or got rejected for now?  It also misleads readers who know Git
   can perform a merge with more than two parents that it may be
   reverting the effect relative to 47th parent of the commit.

   It _might_ be slightly more acceptable to flip the phrase between
   "Revert X" and "Reinstate X" (or "Reapply X"), without saying
   "this is the 47th round of our reversion war".  I dunno.

 * how often does it happen in practice?  If a group of developers
   find themselves reverting and reapplying the same commit more
   than a few times, wouldn't they rather stop and think before
   doing yet another round, which I expect to result in a better fix
   implemented as a separate and brand new patch that takes
   inspiration from a patch that was earlier reverted, and at that
   point it won't be the 47th iteration of reversion war anyway.

So, I am fairly negative on the change in the proposed form as-is.
