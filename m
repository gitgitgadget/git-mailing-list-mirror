Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84D7C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 19:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbiFCTR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiFCTR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 15:17:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379A332EC4
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 12:17:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27C1212D677;
        Fri,  3 Jun 2022 15:17:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kF3iMElICF3M
        GPZ6vANf8Q+uCzznCgPxOTYbDMH9v90=; b=JEtZX3dK7q44qaaDfbuMEjFAlH0S
        M/7mdSVY4o9heQ6e9gHPwmLWWP2fRPmw14fxbBLzMagwYNRoJhEcocqvSq3zb31V
        l1ZLGvSUb/ch2jeDBxOmN8dAZT+2utlgrAhyMoIWu99PxRb3vbWh0pmSJ4wib2eG
        NphWnYLOsWcRuFA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C17E12D676;
        Fri,  3 Jun 2022 15:17:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 724BC12D675;
        Fri,  3 Jun 2022 15:17:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] tests: don't depend on "git init" using the
 template
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
        <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
Date:   Fri, 03 Jun 2022 12:17:23 -0700
In-Reply-To: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 3 Jun
 2022 13:15:02
        +0200")
Message-ID: <xmqq8rqdftfg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC9675DE-E371-11EC-9C93-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This reduced-in-scope re-roll of [1] changes those tests that
> implicitly relied on the existence of the default "git init" template
> to no longer do so. This makes the intent of the tests more explicit,
> e.g. in the case of the .git/branch directory.
>
> Parts of the v1 were already split up, re-rolled and merged as
> a5bf611cc4f (Merge branch 'ab/hook-tests-updates', 2022-03-30).
>
> Future goals: I then have a local topic on top of this to add the
> "--no-template" option to "git init", and to have the test suite run
> in that mode by default, that's currently one of the blockers for
> making the test run without the bin-wrappers[2], which as noted in [3]
> leaves us with some blind spots in our tests.
>
> But for now this is all relatively straightforward conversion of
> existing tests to make them not rely on "git init" giving them a
> template, which they opt-in to with a new TEST_CREATE_REPO_NO_TEMPLATE
> variable.
>
> Junio: There's a trivial conflict in one of the tests with "next",
> i.e.:

Heh.  That is good to know, but I am not sure why we need to run
without template to begin with, so "why this much churn?" is my
first reaction.  Without the churn in the first place, we do not
have to worry about unnecessary conflicts ;-).

Thanks.
