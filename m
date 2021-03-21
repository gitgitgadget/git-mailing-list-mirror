Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBAAC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 06:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF746192F
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 06:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCUGAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 02:00:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52827 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCUGAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 02:00:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 683F3117129;
        Sun, 21 Mar 2021 02:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sI7/te7Fm6v7S+fU8ExM0yxFOj8=; b=W0DvYR
        nD6s4PUUsjgTtdp2LddlU2wlzBk/bxQpFOtRG9D8l6PacDG86lsV01TSikr5Qx4v
        0vj5/z9mzEV+cX2A0WK8EZ61ZpTqaVualz9s+17hVpwNaDkxK/ySA5caPg86YL7Z
        ZaZwM5VHSZFiGBoilWreuZ4VwRDYo2f69IoTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OwBo+94U93y41l2GUPtyzKG5KhojKQsy
        DYEikW8UBFImLbfit4TC4qAue6npS4leQO1GT9J90nDSq95zToQg92l5XOGMZqaO
        u7mdBXz/Z1KUQ42z89iwwj4nTMVP3w5uIzq93Cb4PP0KeRwx0LXto02X+5UXwcHk
        eGLeAKUKzIo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6104A117126;
        Sun, 21 Mar 2021 02:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC293117125;
        Sun, 21 Mar 2021 02:00:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH] gitweb: redacted e-mail addresses feature.
References: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 23:00:33 -0700
In-Reply-To: <pull.910.git.1616283780358.gitgitgadget@gmail.com> (Georgios
        Kontaxis via GitGitGadget's message of "Sat, 20 Mar 2021 23:42:59
        +0000")
Message-ID: <xmqqft0pcagu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0FF8CFE-8A0A-11EB-B9D9-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +    # To disable system wide have in $GITWEB_CONFIG
> +    # $feature{'email_privacy'}{'default'} = [0];
> +	'email_privacy' => {
> +		'sub' => sub { feature_bool('email_privacy', @_) },
> +		'override' => 0,
> +		'default' => [1]},
>  );

I do not see why this should default to true.

It would break existing installations, who have been perfectly happy
with the convenience of supplying a ready access to potential new
contributors who/which addresses to contact plausible mentors in the
projects they are interested in.

And more importantly, I do not see why it should be made impossible
to override per repository/project in a multi-tenant installation.
Some projects may be more "privacy" sensitive than others.  Those
who want to use tighter setting should be able to enable it even
when the side-wide default is set to false, no?

Thanks.
