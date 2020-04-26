Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414F3C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 21:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E167C2075B
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 21:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LhsZB8ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgDZVBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:01:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59852 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgDZVBy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 17:01:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2A0FDED77;
        Sun, 26 Apr 2020 17:01:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=x17UOclm4Bm8
        ItIoTEwtYcDizr4=; b=LhsZB8ksXiGMP6YP2KtM08dIhjKV3eFbxdZK8hRLAmIV
        /lKgtDVj9mgaBHkV4Z6UGzpMz4fe49cHz6NREwkvMO3AvlzWagXI/TX4bKojHajC
        VEolH9F5wKmK2YwwWYIn5YDkLUNQ/LS/PzmjhBpA0PCQqOJOTxAk3zx98uUuB5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NQdBWu
        39n3+6EHJ+/zMTvh+ymU/ouZleIGjnC1yS0OnnfKD8XMTFArp/En58plGdSw5V+A
        V0aKAOP1bvYfIUhp0TZc+uaW8zvp+BGjFG+Ppl37JOe/kMjFJv95QdV5xTnkpfMA
        urjKWY0ivp8rlZz39XWM3qqNgaAgGzlRJF9dg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBAC3DED76;
        Sun, 26 Apr 2020 17:01:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1396FDED75;
        Sun, 26 Apr 2020 17:01:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mateusz =?utf-8?Q?Nowoty=C5=84ski?= <maxmati4@gmail.com>
Cc:     git@vger.kernel.org, mattr94@gmail.com, bwilliams.eng@gmail.com
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
References: <20200425235716.1822560-1-maxmati4@gmail.com>
        <xmqq5zdn9k3r.fsf@gitster.c.googlers.com>
        <5c1005a7-273e-fab0-0d0d-78bd0d3d13f6@gmail.com>
Date:   Sun, 26 Apr 2020 14:01:48 -0700
In-Reply-To: <5c1005a7-273e-fab0-0d0d-78bd0d3d13f6@gmail.com> ("Mateusz
        =?utf-8?Q?Nowoty=C5=84ski=22's?= message of "Sun, 26 Apr 2020 21:32:05
 +0200")
Message-ID: <xmqq1roa9d1f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25EEB55C-8801-11EA-BE02-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mateusz Nowoty=C5=84ski <maxmati4@gmail.com> writes:

[jc: I do not know why your reply had two blank lines for every
line, but I reformatted them to make them repliable]

> This is what we do currently but the problem with this solution is that
> it breaks other software that also uses HOME as base path for their
> data. For example asdf version manager.

That sounds like another reason why you would want to redirect HOME
to a stable and known directory constructed specifically for the use
of your tests.  Just like you do not want the behaviour of the
tested program getting affected by random settings the users, who
are running your tests, might have in their $HOME/.gitconfig, random
settings for "asdf version manager" (whatever it is) the users
happen to have in their $HOME directory would also have undesirable
side effects to your tests, no?


