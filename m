Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DB8C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 22:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhLOWI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 17:08:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61867 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhLOWI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 17:08:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A53BE1720F2;
        Wed, 15 Dec 2021 17:08:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MZWBsJP0QiSxz65iqlDWwuwtXoiLsMu71y94wd
        oxQ8s=; b=Ir/ZQ/lqNgluhVM5ffRcGwZFxPx+4nCpX1f/Ay9IZISNyWMTfUghgL
        R/Oy7Wxb9sCyr0qu2Dwq19a4p3oG+mS8oYR8ukhL3Jd2w/HnoYwgDY615mn3cmxu
        U+YvxhV1AQXgtla+ySkuhbpbCEldafdy6OMAzVk+Rr21ST4QlGcqw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E54B1720F1;
        Wed, 15 Dec 2021 17:08:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 067881720F0;
        Wed, 15 Dec 2021 17:08:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dotan Cohen <dotancohen@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git bug: Filter ignored when "--invert-grep" option is used.
References: <CAKDXFkMvXJm5+5Qxz2N5NH-s+nptayG_7+yTSPxynZxkOcaVKw@mail.gmail.com>
Date:   Wed, 15 Dec 2021 14:08:51 -0800
In-Reply-To: <CAKDXFkMvXJm5+5Qxz2N5NH-s+nptayG_7+yTSPxynZxkOcaVKw@mail.gmail.com>
        (Dotan Cohen's message of "Wed, 15 Dec 2021 11:50:44 +0200")
Message-ID: <xmqqzgp134i4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96D21402-5DF3-11EC-9004-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dotan Cohen <dotancohen@gmail.com> writes:

> What did you do before the bug happened?
> $ git log -8 --author=Shachar --grep=Revert --invert-grep
>
> What did you expect to happen?
> I expected to see the last 8 commits from Shachar that did not have
> the string "Revert" in the commit message.
>
> What happened instead?
> The list of commits included commits by authors other than Shachar.
>
> What's different between what you expected and what actually happened?
> The "--author" filter seems to be ignored when the "--invert-grep"
> option is used.
> I also tried to change the order of the options, but the results
> remained the same.

I think --author and --grep uses the same internal pattern matching
engine, so with --invert-grep, I would not be surprised if the
command looks for commits that do not have Revert and (or is that
or?  I dunno) not authored by Shachar.
