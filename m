Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C384DEB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 16:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjF1Qju (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 12:39:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63791 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjF1Qjs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 12:39:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3370618D644;
        Wed, 28 Jun 2023 12:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JG/cGBNbz0+Ivd0fOZYCO3BDy0KtLdoUDcpV1H
        x2mmY=; b=aA1TR0Xp9WR/UiPPuo+sfsTKUuFCAkytM60rAXcQbIj4jyiN66tl0i
        zEGRKXIQthOLB+vfitSqTp+pNAj83XCFSymIy+tG4EPJl+j9gcOGNVuW5rGQg4IM
        Oaqfm08LABwyevcDGY/dH7/kmTIDGQJDUBtvg/kytw1ZQLptuCRJo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CCB718D643;
        Wed, 28 Jun 2023 12:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FC3018D642;
        Wed, 28 Jun 2023 12:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Namikaze Minato <LLoydsensei+git@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-switch history and checkout compatibility
References: <CACmJb3yoHagaU1wb4qRT-nZV4Wptao8boaUXCAYrFxfrxcmUYg@mail.gmail.com>
        <CACmJb3xWh+0BR_V6sxfMK7iMSdWfvY9d2rjt1hnZhFw70zWweA@mail.gmail.com>
Date:   Wed, 28 Jun 2023 09:39:46 -0700
In-Reply-To: <CACmJb3xWh+0BR_V6sxfMK7iMSdWfvY9d2rjt1hnZhFw70zWweA@mail.gmail.com>
        (Namikaze Minato's message of "Wed, 28 Jun 2023 15:03:22 +0200")
Message-ID: <xmqqa5wjee25.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64F2ABCA-15D2-11EE-964D-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Namikaze Minato <LLoydsensei+git@gmail.com> writes:

> I have trouble with getting used to git-switch instead of
> git-checkout, but have even more trouble to get people to adopt
> it.
>
> Please consider the two following git-switch statements:
>
> git switch remote/branch # fatal: a branch is expected, got remote
> branch 'remote/branch'
> #and
> git switch -d remote/branch
> git switch master
> git switch - # fatal: a branch is expected, got commit 'commit_id_here'
>
> Both as retro-compatibility with checkout and for user-friendliness, I
> would expect both to work.

I wasn't among the primary advocates to add "switch/restore" pair
for those people who felt "checkout" was overloaded, and I may be
misremembering why they decided to deviate from what "checkout"
(one that checks out a branch, not the one that checks out paths)
did in these two cases.  Having said that ...

 * I suspect that requiring an explicit "--detach" is deliberate, as
   they were trying to make "newbie friendlier" version of checkout.

 * I am on the fence about the latter one.  While I think it is a
   bug if "switch -" and "switch @{-1}" did not work exactly like
   "checkout @{-1}", combined with the previous point of requiring
   to be explicit when detaching HEAD, "switch -" that tries to go
   back to a detached state may be justifiable---it stops you in
   order to avoid accidental detaching of HEAD.

> Maybe a setting checkout.autoDetach could control such behavior if the
> current implementation should be kept?
>
> What do you think?

Personally, I think those who are familiar with and expert enough on
Git and do not feel uneasy working on detached HEAD can and should
just use "checkout" not "switch/restore", but that may be just me.

Thanks.
