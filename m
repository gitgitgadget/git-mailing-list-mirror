Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856D1C2D0E7
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 20:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA192080C
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 20:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IKw6O7K7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCYUS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:18:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52071 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgCYUS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 16:18:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 633E35BA46;
        Wed, 25 Mar 2020 16:18:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rXcoRzT9VlpV5x8ZGLK2xCMj+Lo=; b=IKw6O7
        K7TVfHsA1Il8FTHVN4wzNnkFUw96vm5G6IqaJWOZwfBOtDc+dzVucOrKXy9wJr/r
        bdUwP1qlbGv6j+9IRTwpSp7vokSVDmdRLaAxr0iVG1Q/ptu9psD43WkQWcHoBUNJ
        +8irquOIkkauTTYm/3EqYrHAqb9l0aOqsVoQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=otacnLjApqOx1tmsTABRZopDAUQfPqAv
        KMq1Tsj72OFcb7XrAXQn6GgLgPN3j66CnDE/eORW/TqXY8zYe9lqvuFg5x8uZ6oK
        SXrA/OspAia5jQDdZ7jQnOjk7Bb/396nABBmu07cv/Ai5Q68K4Etz4cnZIM8NW50
        5yXoAalIWK4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 596B05BA45;
        Wed, 25 Mar 2020 16:18:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D30E05BA44;
        Wed, 25 Mar 2020 16:18:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
References: <cover.1585027716.git.matheus.bernardino@usp.br>
        <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
        <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
        <xmqq7dz938sc.fsf@gitster.c.googlers.com>
        <CABPp-BHtfb4g3-EsiT_X-hCZYiDeDE0mbrV1ZUpOfWujRjAO3Q@mail.gmail.com>
Date:   Wed, 25 Mar 2020 13:18:55 -0700
In-Reply-To: <CABPp-BHtfb4g3-EsiT_X-hCZYiDeDE0mbrV1ZUpOfWujRjAO3Q@mail.gmail.com>
        (Elijah Newren's message of "Tue, 24 Mar 2020 12:07:49 -0700")
Message-ID: <xmqqh7ycw5lc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA5C5FD4-6ED5-11EA-864B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> It sounds like you are describing partial clone rather than sparse
> checkout?  Or perhaps you're trying to blur the distinction,
> suggesting the two should be used together, with the partial clone
> machinery learning to download history within the specified sparse
> cones?

Yeah, I guess it is a little bit of both ;-)

>>  Regardless of the choice of the default, it would be a good
>> idea to make the subcommands consistently offer the same default and
>> allow the non-default views with the same UI.
>
> Agreed.

Yup, thanks.
