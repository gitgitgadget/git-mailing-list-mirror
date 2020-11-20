Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39F9C2D0E4
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E28B2245D
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WbABSkNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgKTSNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:13:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63271 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgKTSNu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 13:13:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FE51A077D;
        Fri, 20 Nov 2020 13:13:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xHH9gkPArfLFM9fOwnNrxTQDcnE=; b=WbABSk
        NrHGhg8/EKqcJTs2qDigY9sxuKeZcqno+08BPQM3OhzIyBmM53ahR3/Jye2wHydO
        gxfrQd86cWe5Ld4eWKFZ8ef56c03c+nftCk+wrz0MTCzOnUjVXhCWe4/nKE/RpGx
        KBHWg0lFyuIn5FgfPOH2RsIECe5yN3eZlmonE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d0q1X98EHfeoQqcfbRSNGCZitzUhotZz
        150XUzkhWzorvnMBdAJDBmAD/gxNrk+FJK5G2QR6n9gTMcCPyEFkp2EHszkbesE6
        q4os5l32lTBa5OauJd0mri/ZR/ajKxK+wpLpduvFqS6BydFkFMZbgctxakqwZ/an
        7atQYnnh3bQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18870A077C;
        Fri, 20 Nov 2020 13:13:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C088A077B;
        Fri, 20 Nov 2020 13:13:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Orgad Shaneh <orgads@gmail.com>,
        Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] hooks: allow input from stdin for commit-related
 hooks
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
        <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
        <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com>
        <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com>
        <CAGHpTBKHmdjqrz1ABdGUUz7AwcixU_VBy1DQzybpFizqVo8C7A@mail.gmail.com>
        <CAPig+cS5BUCaFN=MN+7gSTbvskffRdTJOgck6TrRRacxCc_CwA@mail.gmail.com>
Date:   Fri, 20 Nov 2020 10:13:47 -0800
In-Reply-To: <CAPig+cS5BUCaFN=MN+7gSTbvskffRdTJOgck6TrRRacxCc_CwA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 20 Nov 2020 01:38:58 -0500")
Message-ID: <xmqqr1onuc9w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22407716-2B5C-11EB-BFA3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> At the very least, this change deserves a documentation update, both
> to explain that the prepare-commit-msg hook has a valid stdin, and
> (importantly) that it won't be able to rely upon stdin in conjunction
> with `-F -`. (This also makes me wonder if it would be possible to
> signal to the hook whether or not stdin is available. Perhaps this
> could be done by passing an additional argument to the hook.)
>
> Finally, I realize that you followed Junio's suggestion for organizing
> the series, however, it feels undesirable for patch [1/2] to leave the
> command in a somewhat broken state, ...

True.  The split you suggest sounds saner, if we were to still move
forward with this change.  I originally threw "commit -F -" in the
"don't do it if it hurts" category, but I agree with you that it is
quite plausible that IDE would want to use the feature to feed the
log message to the command (that way they do not need to worry
about a temporary file at all), so it can become a real issue.

Thanks.
