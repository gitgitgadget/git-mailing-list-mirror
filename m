Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FCEC54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 21:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C442071C
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 21:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lEApEHLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDZVQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:16:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64347 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgDZVQh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 17:16:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE0E253623;
        Sun, 26 Apr 2020 17:16:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7242dBMKj5Y5oT2XIoCBCPHPM84=; b=lEApEH
        LNKqCPH70DWcLS0bnYto1t8ibcF24RRsxxX2pTBSS23/akNIqi1OHVGYtKvUdnf1
        ENl9wg4T7sRjGWs3YnHDGhF3C8HNHl38IOGcMQUTJLDdZcw7F3iTDnDpDZc6LwkY
        EOQQ10NBLL9ANh19aaEB47YCDPaqLWnzOA5c8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YbJ0GTbf6DiPoKxwIMfN8J3tKZ8+DX6x
        hLiV/1wei/OJeJtjfT1Pwenc0HVpSPzWSFyFPptc8rUx8/MzZzqAH5xJx/vIdmnX
        mO8/5RbbFw3jl6geZnEbjcgB142El2d0CkUNWN0o5mFwN4ggT0VEFsLc6BjRBr+x
        96iwOfjG+qI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A360753622;
        Sun, 26 Apr 2020 17:16:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3025953621;
        Sun, 26 Apr 2020 17:16:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Matt Rogers <mattr94@gmail.com>,
        Mateusz =?utf-8?Q?Nowoty=C5=84ski?= <maxmati4@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        bwilliams.eng@gmail.com
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
References: <20200425235716.1822560-1-maxmati4@gmail.com>
        <CAOjrSZs33-CqV5m4wKROYJT8au1hup7bGZWiEaXMV7cU4p-J=Q@mail.gmail.com>
        <ff9a63d4-80e4-8090-c85c-03fd3ab43c55@iee.email>
        <CAOjrSZt7WJy1vv97Rw9MFJyTcB2Ehqq9BjGrXMtV95oB5p53SA@mail.gmail.com>
        <8992c1a7-a638-e823-1cb7-2c8f6b28d486@iee.email>
Date:   Sun, 26 Apr 2020 14:16:34 -0700
In-Reply-To: <8992c1a7-a638-e823-1cb7-2c8f6b28d486@iee.email> (Philip Oakley's
        message of "Sun, 26 Apr 2020 21:04:50 +0100")
Message-ID: <xmqqwo627xsd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3580D502-8803-11EA-BD38-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Mateusz's original problem was with discovery of these env variables,...

I somehow doubt it.  

Certainly, defeating /etc/gitconfig should be a part of the solution
to the "I want a stable environment to run tests reproducibly,
without getting affected by random settings the testing user may get
affected" problem.  It is not enough to defeat $HOME/.gitconfig (and
its xdg variant).

But I didn't get the feeling that Mateusz was even aware of the need
to defeat the system wide configuration; Mateusz only mentioned and
cared about $HOME/.gitconfig (and its xdg variant).

And the thing is that we do have support for an environment variable
to defeat the system-wide configuration (GIT_CONFIG_NOSYSTEM), but
discovering it would not have been sufficient to solve the "stable
environment for reproducible tests" problem, as we do not have an
environment variable to defeat the global (i.e. per user) one.

So, I do not think the problem was with discovery at all.  The
problem was two levels deep, (1) not realizing the need to defeat
the system wide settings (for which the environment may have been a
good solution once the need to solve that problem got recognised),
and (2) not realizing the need to redirect $HOME for programs other
than git, hence omitting $HOME/.gitconfig from the sequence is not
a sufficient solution.

Having said all that, I addition of GIT_CONFIG_NOGLOBAL (or
GIT_CONFIG_NOUSER) may not be such a bad thing.  We probably will
add GIT_CONFIG_NOLOCAL (or GIT_CONFIG_NOREPOSITORY) to complement
these two if that happens.  I dunno.

