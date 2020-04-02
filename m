Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42014C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DD22078B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qq1sxrdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbgDBRDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:03:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55544 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389797AbgDBRDI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 13:03:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 981BBCB8AA;
        Thu,  2 Apr 2020 13:03:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Zl9xTATPckKu
        Pw1U2wz/l0swJ34=; b=Qq1sxrdrK4TbSZKH9n535S+80KsNFiJDGHa3VNo0+GWL
        ypQT9AFOwViTKR6TQNvwSpF2oulrXC6gbSg81tv7GvWIjeKHSanf8nVXI2AN3nUl
        BT3QUQDBo0hOg+/Fyy6eir4hTrvnwdfRNCN4OsmBD9jsLDyIZFoIFr+u1hiBH4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RD6aYB
        MW5HXplSZXA0SH0rMScWzwQsk40vWtw9NE/i0KUwcPHYEXbnKmj5jR7ans7fyAjf
        pfmZOCQGkCE3SzluuEtNtKyUGeFqwv3h+rfNb55ORgHmX2BUAAglKkb10cUb+RvX
        SkD3VVr/6/cVHmqeQCcSspuq1xuBoU+u/KrIM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F111CB8A9;
        Thu,  2 Apr 2020 13:03:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D62CBCB8A7;
        Thu,  2 Apr 2020 13:03:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: make MAKEFLAGS available inside the Docker container in the Linux32 job
References: <20200401212151.15164-1-szeder.dev@gmail.com>
Date:   Thu, 02 Apr 2020 10:03:03 -0700
In-Reply-To: <20200401212151.15164-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 1 Apr 2020 23:21:51 +0200")
Message-ID: <xmqqftdl4y7s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D187E5D4-7503-11EA-9BA0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Once upon a time we ran 'make --jobs=3D2 ...' to build Git, its
> documentation, or to apply Coccinelle semantic patches.  Then commit
> eaa62291ff (ci: inherit --jobs via MAKEFLAGS in run-build-and-tests,
> 2019-01-27) came along, and started using the MAKEFLAGS environment
> variable to centralize setting the number of parallel jobs in
> 'ci/libs.sh'.  Alas, it forgot to update 'ci/run-linux32-docker.sh' to
> make MAKEFLAGS available inside the Docker container running the 32
> bit Linux job, and, consequently, since then that job builds Git
> sequentially, and it ignores any Makefile knobs that we might set in
> MAKEFLAGS (though we don't set any for the 32 bit Linux job at the
> moment).
>
> So update the 'docker run' invocation in 'ci/run-linux32-docker.sh' to
> make MAKEFLAGS available inside the Docker container as well.  Set
> CC=3Dgcc for the 32 bit Linux job, because that's the compiler installe=
d
> in the 32 bit Linux Docker image that we use (Travis CI nowadays sets
> CC=3Dclang by default, but clang is not installed in this image).
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>
> The 'dd/musl-libc-travis-ci' topic needs some more updates, and those
> will depend on this fix.

Thanks.  I'll queue this on top of v2.26.0 so that others can be
rebased on top of it.
