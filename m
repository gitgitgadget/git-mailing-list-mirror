Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF8C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3531B61153
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 16:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhHYQN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:13:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55548 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhHYQNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 12:13:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3103DDBFB0;
        Wed, 25 Aug 2021 12:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IX0wXvIJ60jYCZ64XcfvPXc6XEcO9k0mCM5baR
        4GdlE=; b=eJqbsiZBz2eJ/hSUHGdesFEuPtGjm0qS9+nfsJlWW5rKbAfj4xpUCt
        ZhkmJ04beKnSSs95jySnbOCQRzfoyaPnsLfLwm+jsORFfBGrfaRqcPRQdIwmQOGx
        MBavFAe2az53en9XDa1/5mfW+pegUgqXYGwM+outDJ0a3ags7I18U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2815BDBFAF;
        Wed, 25 Aug 2021 12:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1554DBFAE;
        Wed, 25 Aug 2021 12:12:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Mickey Endito <mickey.endito.2323@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] t5582: remove spurious 'cd "$D"' line
References: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
        <xmqq8s0rpwiw.fsf@gitster.g> <20210824185942.GE2257957@szeder.dev>
        <YSWeeEgzCCT/3kxR@coredump.intra.peff.net>
Date:   Wed, 25 Aug 2021 09:12:37 -0700
In-Reply-To: <YSWeeEgzCCT/3kxR@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 24 Aug 2021 21:35:52 -0400")
Message-ID: <xmqqsfyxjyfe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4470E81E-05BF-11EC-BC3F-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm. I think that one is different, in that the "cd" is not redundant,
> but wrong. But it turns out not to matter to the test. ;)

Funny. 

We are lucky because 'cd ""' stays in the same repository as the
current one and not to a random place, and because the current one
happens to have no pack and running the command in a repository
without any pack is what the test wants to do anyway.

Thanks, will queue.


> diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
> index 8b01793845..8dbbcc5e51 100755
> --- a/t/t5323-pack-redundant.sh
> +++ b/t/t5323-pack-redundant.sh
> @@ -114,9 +114,9 @@ test_expect_success 'setup main repo' '
>  	create_commits_in "$main_repo" A B C D E F G H I J K L M N O P Q R
>  '
>  
> -test_expect_success 'master: pack-redundant works with no packfile' '
> +test_expect_success 'main: pack-redundant works with no packfile' '
>  	(
> -		cd "$master_repo" &&
> +		cd "$main_repo" &&
>  		cat >expect <<-EOF &&
>  			fatal: Zero packs found!
>  			EOF
