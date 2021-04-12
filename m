Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F622C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE6161350
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhDLTGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:06:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58359 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbhDLTGk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:06:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69F44AB4A4;
        Mon, 12 Apr 2021 15:06:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1i+2PXQsE18n
        zS/8o0XVaVpnb4I=; b=beDhh4L2GbPp+x7Fv+1viyQ3Gw6SGFp+2K2eZGPyfy+x
        P7+iVdgPKm584EYJbQFuwrttAT04/zXXMpjpwG04dGWbLCSixThdamPXbJVbgKVf
        HXsS2vEoK3DRTREIqvk5td3tw8aZ6YBuUYZQ++Y8vFoJsjx8WT8LvmRr4VNyrhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=v9+7aK
        MLQJ4QWaO6y+IKJ+7G7B83YULtDZDLo7wdBjXiTyNPUEjjk8e/0AEOeOMSauzsit
        3W6iFBqjZ9MuzpzL9BEEDJmtox/BYTyI11FVl+6lbZ4RBdpy893yDpTYwyNeWV2n
        dUViEQyZIbptmWZYOvnW/EUD9SEjOc1rWYRmM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61FABAB4A2;
        Mon, 12 Apr 2021 15:06:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6B98AB4A1;
        Mon, 12 Apr 2021 15:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/16] test-lib: bring $remove_trash out of retirement
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-02.16-44223ae777e-20210412T110456Z-avarab@gmail.com>
Date:   Mon, 12 Apr 2021 12:06:20 -0700
In-Reply-To: <patch-02.16-44223ae777e-20210412T110456Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 12 Apr
 2021 13:08:51
        +0200")
Message-ID: <xmqqo8ejcogj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2ACDA38C-9BC2-11EB-A655-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> There's no point in creating a repository or directory only to decide
> right afterwards that we're skipping all the tests.
>
> So let's partially revert 06478dab4c (test-lib: retire $remove_trash
> variable, 2017-04-23) and move the decision about whether to skip all
> tests earlier.
>
> I tested this with --debug, see 4d0912a206 (test-lib.sh: do not barf
> under --debug at the end of the test, 2017-04-24) for a bug we don't
> want to re-introduce.
>
> While I'm at it let's move the HOME assignment to just before
> test_create_repo, it could be lower, but it seems better to set it
> before calling anything in test-lib-functions.sh
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

I am not clear what the reasoning behind this change is.  Is it
correct to say that the idea flows like the following?

 0. If we do the $GIT_SKIP_TESTS check early, specifically, before
    we create the trash directory to run the tests in, we do not
    have to create and then remove it.

 1. If we na=C3=AFvely do the above, test_done called in the "ah, the
    entirety of test is skipped" case will try to see if the trash
    directory exists and complain, so we need to add more code in
    that test_done codepath to avoid complaints.

 2. As a part of that "more code", we mark the fact that we created
    a new repository with $remove_trash variable.

Assuming that the above flow of thought is what is behind this
patch, I think the patch is mostly sensible.

remove_trash needs to be cleared at the beginning, perhaps where
store_arg_to and opt_required_arg are cleared, though, to protect
us from a stray environment variable.

Thanks.
