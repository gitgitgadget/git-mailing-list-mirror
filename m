Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25213C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 18:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBAD360C3D
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhC2SkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:40:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59872 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhC2SkM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 14:40:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFD06C50DF;
        Mon, 29 Mar 2021 14:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bgrBdc6hC0XN
        ckbCE7C/prZuWGQ=; b=KqU3NYXu9nBKhlNnUvKnJLLMMx96LxbPvTd8mP7gUK4I
        Ln+BuUdxplALyqaF9HrWb9aEgCCosnCVMBtUz6cz++sJDgicfBaa0JQsKPx+hcIZ
        vtnTAwgO9U24SRM7mGkQTiSduZ3arru8g3MYVku8MTq0DkeMiiE6ZzUxWWGiIF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FEOYPL
        3jOcKiOPjuT2DY5OJjm653kMO5ilOjt9+Gr6I6OvMeDi8mugR6BDP9nePUctUQYT
        WO4j6hHaRAgcvvDd2/ZsWmeyku12G5XCQjlv72FWtGajEmnAxS4O6pqbRn0MsLDL
        HjhfPkdMLzHDK4OJmiGEpAB703MKmGP+m0lCI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E523AC50DD;
        Mon, 29 Mar 2021 14:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47892C50DC;
        Mon, 29 Mar 2021 14:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/5] Makefile: rename scripts in-place, don't clobber
References: <20210307132001.7485-1-avarab@gmail.com>
        <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <patch-2.6-49dbd54d0ff-20210329T161723Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 11:40:10 -0700
In-Reply-To: <patch-2.6-49dbd54d0ff-20210329T161723Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:20:09 +0200")
Message-ID: <xmqqk0ppkdmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 317BF0DA-90BE-11EB-B43A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> It'll also guard against any weird issues with e.g. a command that
> wants to read GIT-PERL-DEFINES to generate one of the %.perl scripts
> racing with either a concurrent instance of "make" that has partially
> updated the file, or test-lib.sh dying with some particularly weird
> error because GIT-BUILD-OPTIONS was partway through being updated when
> it ran.

If something like that happens, doesn't that indicate a bug in the
dependency graph in the Makefile or the implementation of "make"?
The generated file is depended on for the consumer to be able to use
a non-stale version---so the consumer should not start before the
generator finishes.

You may be able to hide the breakage coming from "partially written
file is easily recognizable and the consumer would barf".  But I am
afraid that you are introducing a problem harder to diagnose, i.e.
"the consumer reads from a complete file so there is no syntax error
or other things that easily tells you there is a breakage, but what
is used is stale and not up to date".

The same comment applies to this step.  I do not think it would
break (other than adding intermediate crufts) the result if you
generate into temporary and rename to final, but it is not clear
to me what the point is in doing so.
