Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3678C433DB
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 03:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A8464F8C
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 03:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhBFDAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:00:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64252 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhBFCtg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 21:49:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15B63125056;
        Fri,  5 Feb 2021 18:07:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TEVr43VQgsM7
        MyoSxYdhYlJAYII=; b=Kz7nn2jhi4IkHRhjp3TD9MA4UKppFoqS8Y1m6Pf1Nei2
        7G7eENGfW7DQlkOIOvre4cJ/XLtroF6GoyGmGZYUuwuKuc189sL8Tmc2qqsXsMWF
        Irkie0ZUKh9JjCi1uo08eG5Fh2ISpQwvjMMnSYAg2gwFdlPRIJP8RKBJrKp0eYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kvPuJW
        D5NonQHqcEjCW/+NM1yGPnaQzOv3AXw+MDcK139UmYIUqe1x8o9hZeiFGYK3DJWN
        L2oTV8goArv/yHb6c9MudKPnaMGQJ9OEjQbx00T2XMxDTqeS/BodzccBGxROzZ/8
        DXpv4aBD1Q35yaiLkMg3DcpZC3ULSZLPSAv6Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F098125055;
        Fri,  5 Feb 2021 18:07:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6DEC9125054;
        Fri,  5 Feb 2021 18:07:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 0/3] Cloning with remote unborn HEAD
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1612493309.git.jonathantanmy@google.com>
        <xmqq5z372ihm.fsf@gitster.c.googlers.com>
        <87eehucj33.fsf@evledraar.gmail.com>
Date:   Fri, 05 Feb 2021 15:07:42 -0800
In-Reply-To: <87eehucj33.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 05 Feb 2021 22:15:12 +0100")
Message-ID: <xmqqczxeyuyp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F46A6B66-6806-11EB-A275-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> And in [3] I noted that we introduced the word "branches" into
> protocol-v2.txt for the first time without defining what it means
> (presumably just refs/heads/*, but then let's say so...). There was a
> reply promising clarification, but I note that v7 still just says
> "branches".

I do not think it so bad to mention "branch" in the part that
explains things to humans in the terminology they are used to.  It
is a different matter to introduce EBNF terminal <branch> without a
proper definition of the word, but I od not think we are doing so
here.

I however have to agree with the need to tighten what gets sent;
that is why a suggested replacement in my earlier review phrased it
this way:

    unborn

    If HEAD is a symref pointing to an unborn branch <b>, the
    server reports it as "unborn HEAD symref-target:refs/heads/<b>"
    in its response.

to make it clear that a full refname is sent for the pointee by
HEAD.

Thanks.
