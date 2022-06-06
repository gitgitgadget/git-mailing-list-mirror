Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C0C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 22:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiFFWwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 18:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiFFWw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 18:52:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7BC1161
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 15:52:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47AD01A10BE;
        Mon,  6 Jun 2022 18:52:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zyONFbKURk8K
        2h064LAzh25yfz+89XoQ+RoFEjpPRX8=; b=NayBrFHQ91jkWJXdAAA+/N9u5bFZ
        Gc9Ey1WtGfXxNnYH1aJecixzGTH4swUaG+IbJb+5a0kyYc+idOAl+p4w6FM4I6Iz
        sCpdnpx6iEP/5cgbY3gzmNkKtpyt5gRG5CCvoB/LwhlenoI2vL5w8nraI2SWTlu5
        aFuEl+MrSq3kpHU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 316B81A10BC;
        Mon,  6 Jun 2022 18:52:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B3B81A10BA;
        Mon,  6 Jun 2022 18:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH 0/2] builtin/show-ref.c: support `--count` for limiting
 output
References: <cover.1654552560.git.me@ttaylorr.com>
Date:   Mon, 06 Jun 2022 15:52:19 -0700
In-Reply-To: <cover.1654552560.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 6 Jun 2022 17:56:01 -0400")
Message-ID: <xmqqo7z54d7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 528A405A-E5EB-11EC-A8A8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This short patch series adds support for a new `--count` argument for l=
imiting
> the output of `show-ref` (=C3=A0-la the `for-each-ref` option by the sa=
me name).

It makes me wonder why we limit this to show-ref.

    $ git --pipe-to-head-N=3D3 any-command args...

IOW, having to add an option like this feels absurd.

> This is useful in contexts where a caller wants to avoid enumerating mo=
re
> references than necessary (e.g., they only care whether a tag exists, b=
ut not
> how many or what they are called) but doesn't have control of the outpu=
t stream
> (e.g., they are in Ruby and can't pipe the output to `head -n 1`).

Are you saying that Ruby is incapable of run a command line like

   av[0] =3D "sh"
   av[1] =3D "-c"
   av[2] =3D "git show-ref blah | head -n 1"
   av[3] =3D NULL

?
