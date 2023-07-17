Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F6DEB64DD
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 02:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjGQCjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 22:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGQCjS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 22:39:18 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E6E56
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 19:39:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0AA5185B7;
        Sun, 16 Jul 2023 22:38:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=grw1+G7ord8QU/3KoRfqfQEeidHWhtiGAHzWv2
        4UjIY=; b=voG5htJO9oDZxZxqXBgl6fcrrJe9x+N1z1qbA36nYMAya26KjtpQPR
        rAqTJcEgRTS31H7pAnufLepLSbhvY0yjj4FudeUuY7YWJ0FoqUJotuIj3eOSl4dv
        yyUxBNuo2n+b/UfWhe1J9O8xxG24oO7i7Pnp3FqNTfO7mecrGyaBE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B7DE185B6;
        Sun, 16 Jul 2023 22:38:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 30BDE185B5;
        Sun, 16 Jul 2023 22:38:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Subject: Re: [PATCH] t2400: Fix test failures when using grep 2.5
References: <20230715025512.7574-1-jacobabel@nullpo.dev>
        <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com>
        <vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462dhqjbno@uwghfyfdixtk>
        <3f3a3f5b-70fd-ec3f-acbb-d585b5eb6cbc@gmail.com>
Date:   Sun, 16 Jul 2023 19:38:55 -0700
In-Reply-To: <3f3a3f5b-70fd-ec3f-acbb-d585b5eb6cbc@gmail.com> (Phillip Wood's
        message of "Sun, 16 Jul 2023 16:34:52 +0100")
Message-ID: <xmqqo7kbjm80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 136D8E96-244B-11EE-85BB-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> One thing I forgot to mention was that I think it would be better to
> explain in the commit message that "\s" etc. are not part of POSIX
> EREs and that is why they do not work.

Yes, that is a very good point.  We have been burned by regular
expression implementations that use or do not use "enhanced" bit in
the recent past, IIRC.

> I think it might be better to just diagnose if HEAD is a dangling
> symbolic-ref or contains an invalid oid and leave it at that. See the
> documentation in refs.h for refs_resolve_ref_unsafe() for how to check
> if HEAD is a dangling symbolic ref - if rego_get_oid(repo, "HEAD")
> fails and it is not a dangling symbolic ref then it contains an
> invalid oid.

Sounds doable and sensible.  If we can easily test it without
peeking into the filesystem, that would be very good.

Thanks.


