Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF5BC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbiBWXHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244062AbiBWXHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:07:38 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF33C49A
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:07:09 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1E47179B7C;
        Wed, 23 Feb 2022 18:07:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9wVVUk4sRzbYP4Fo4NhWMw3WkkNRzmEsj+5Vzv
        gHDUw=; b=BCPcx/ApytwJlcYiiXzX8p18peD3wj7fXu3N3Xwz2IdzHhSCfOzkt/
        y9fUr3hqXp6CblMUMxpO5le1wJMKpDIBa8FT0Ll+NiVRVehHYYz/tCgbII5HSnrT
        layZe0Poz/36UtrGg1+07sY1Jhn6faQdAED5Li61ofRjXQlGFDfrk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A8DF179B7B;
        Wed, 23 Feb 2022 18:07:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11BF8179B77;
        Wed, 23 Feb 2022 18:07:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] switch: mention the --detach option when dying due to
 lack of a branch
References: <20220223073125.640133-1-alexhenrie24@gmail.com>
Date:   Wed, 23 Feb 2022 15:07:06 -0800
In-Reply-To: <20220223073125.640133-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 23 Feb 2022 00:31:25 -0700")
Message-ID: <xmqqwnhlp4h1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52595DBC-94FD-11EC-AFAE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Users who are accustomed to doing `git checkout <tag>` assume that
> `git switch <tag>` will do the same thing. Inform them of the --detach
> option so they aren't left wondering why `git switch` doesn't work but
> `git checkout` does.

An error message certainly would help over showing

	fatal: a branch is expected, got tag 'abc'

but I have to wonder why we shouldn't DWIM and detach the HEAD at
the commit the user wanted to.  That would also solve the issue of
leaving them wondering why switch is broken and checkout is not, no?

If the advice for detached HEAD state is enabled, then the user will
be reminded that they are not on any branch the usual way when the
HEAD is detached at the named commit.  And if the advice is not
enabled, then they will not be helped by this new advise() message
we add here.

> +	if (advice_enabled(ADVICE_DETACHED_HEAD))
> +		advise(_("The specified commit is not a local branch.\n"
> +			 "If you want to enter detached head mode, try again with the --detach option."));
> +

"detached HEAD" is a state, and not a mode.

s/enter detached head mode/detach HEAD at the commit/ perhaps.

Thanks.
