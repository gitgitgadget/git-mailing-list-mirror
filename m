Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8267BC433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 16:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbiC1QgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 12:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242380AbiC1QgY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 12:36:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEBB1CFD7
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 09:34:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76AB912D588;
        Mon, 28 Mar 2022 12:34:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uhXLt6IGIiGX
        MrlfEl/eNt34Zz6HCtEU8yA1BNExayg=; b=xVgZGI3CzILXGEpePMS6m2FQGZcD
        H2VaxSCx6uOOjJZ0fYtyByPqn0N69tD0fVVaH3q7mmhUdJTJtO2I+XaSt2nMzyTM
        G4M7DC1gAO6OmsGQ7ugGNqDYm/bCM2BN0tV25dOS3uXXZQy2klS/MtuxGgTz3k5D
        JKiu4DOZss1r4QI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E18612D587;
        Mon, 28 Mar 2022 12:34:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D276712D586;
        Mon, 28 Mar 2022 12:34:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
        <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
Date:   Mon, 28 Mar 2022 09:34:39 -0700
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Mar
 2022 19:37:51
        +0100")
Message-ID: <xmqqsfr22fz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F7592C4A-AEB4-11EC-8656-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A re-roll of my improvements my series to simplify the CI setup a lot
> (see diffstat), much of it was dealing with constraints that went away
> with Travis et al. CI for this series (OSX runners failing for
> unrelated reasons):
>
>     https://github.com/avar/git/actions/runs/2040223909
>
> For a much more detailed summary of how the output looks before/after
> see v1[].
>
> This series heavily conflicts with Johannes's
> js/ci-github-workflow-markup in "seen", but in the v1 I suggested
> basing that series on top of this one, because it can benefit a lot
> from these simplifications.
>
> I'll reply to this series with a proposed rebasing of that series on
> top of this one, which allows for removing almost all of its changes
> to "ci/" with no harm to its end-goals, i.e. the splitting up of
> "make" and "make test" output is something it'll get for free from
> this series.

A sample run for this can be seen at

  https://github.com/git/git/runs/5715128999?check_suite_focus=3Dtrue

With the output, I can point at a specific line, e.g.

  https://github.com/git/git/runs/5715128999?check_suite_focus=3Dtrue#ste=
p:7:1150

The URLs with Dscho's one that correspond to the above two are

  https://github.com/git/git/runs/5699946885?check_suite_focus=3Dtrue
  https://github.com/git/git/runs/5699946885?check_suite_focus=3Dtrue#ste=
p:4:1826

The specific breakage (which has little to do with the comparison
between CI error pages) is that diff_setup() is called and populate
diff_options.parseopts member but diff_setup_done() does not seem to
be called and ends up leaking it.

I wonder why options->parseopts is not freed immediately after
diff_opt_parse() calls parse_options(), but need to be kept until
diff_setup_done().
