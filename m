Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7605C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 23:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6885E611F2
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 23:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhDKXWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 19:22:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51594 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDKXWd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 19:22:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 059A0CC24D;
        Sun, 11 Apr 2021 19:22:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XXhZozPr7HED5j0EWxFBhugXEGM=; b=vSEWrL
        5BlV0oy5GihqBTKNBRFq1vswM/HTymCaMNxWleL84N8XB93S/e3+1Z0hBkoCBfP5
        VfnsG3cvhTj9JxSpt4WtuiRlHRsblvqDlSX50iKWX9qZugZGGOjqSTZbUUOGeGg0
        FK/hmo64iiOfgbXGaR09BaUI53a8Lyi9528l4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w/cfmuwgWwaH2u1DPt65sUWL9h9+Cz3R
        hDGJTEE3BAnOfyqYy95gCDjkDvL2CP5j8BR3xmr5GSX6Y6ktCpc2EQrfIku42l7k
        r4KVxacXbdQOpUvjkgFpASmxPvYVnEFzyAMPLvd57PQGwfYquxKM47ZYFUpaRxMd
        Xv8qfO3gNgk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1E75CC24C;
        Sun, 11 Apr 2021 19:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A6F2CC24B;
        Sun, 11 Apr 2021 19:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to checkout a branch (and not a tag)
References: <CAH8yC8nT-68H9Vy=zxqsKeqpBqt-OJYCpVh53cm1KoeSbSVC-Q@mail.gmail.com>
Date:   Sun, 11 Apr 2021 16:22:13 -0700
In-Reply-To: <CAH8yC8nT-68H9Vy=zxqsKeqpBqt-OJYCpVh53cm1KoeSbSVC-Q@mail.gmail.com>
        (Jeffrey Walton's message of "Sun, 11 Apr 2021 19:04:11 -0400")
Message-ID: <xmqqk0p8flui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFDBE516-9B1C-11EB-8AEA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> I'm trying to checkout a branch called REL1_35 from
> https://github.com/wikimedia/mediawiki-skins-Cosmos. The repo also has
> a tag called REL1_35.
>
> When I perform the following I apparently get the tag (with old files)
> and not the branch (with updated files):
>
>     wiki_rel=REL1_53

Hopefully this typo is not part of what contributed to your problem.
Assuming that you actually used REL1_35 here...

>     ...
>     git fetch origin && git reset --hard "origin/${wiki_rel}" && \

...this should get their branches in refs/remotes/origin/, and would
reset whatever local branch you are on to origin/REL1_35.  So at this
point, HEAD is the same as their REL1_35 branch.

>         git checkout -f "${wiki_rel}"

And this causes the tag/REL1_35, which was obtained from them, to be
checked out to a detached HEAD.

What are you trying to do here?  Do you want your own local REL1_35
branch, that starts at the same commit as their REL1_35 branch?  If
so, then instead of that "checkout", you would probably do

	git checkout -b REL1_35

Or whole thing up to this point would be

	git fetch origin &&
	git checkout -t -b REL1_35 origin/REL1_35

and then after this, your "git pull" while on your REL1_35 brnch
would integrate with their REL1_35 branch [*]


[Footnote]

* Unless you have other funny configuration variables in the
  repository possibly from earlier random hacking, that is.
  Depending on the state of the repository before you started the
  "git fetch origin" step, commands like "git pull" and "git push"
  would behave differently.
