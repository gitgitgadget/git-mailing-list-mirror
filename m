Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683BACCA491
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiFMTKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351304AbiFMTJy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 15:09:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE963BA
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 10:08:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F34F7132E83;
        Mon, 13 Jun 2022 13:08:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j+AwRvlasY+fUDRhhi5HhSFVcuY18GDbLW4qkr
        jBkb4=; b=fdTJ/MWKYlzfF6Ny9M7dIxS6DgwXKHF6vx/f7PREGF9SFQKkPgOgbS
        2Cm6rQcSex1pX6NIIVEWaWLr9sOywrcEExcyitfLfcHjoNBtAewDAZaZycZ6Ekus
        zqDspbOU1rDy76Bw/hYmY11VmzKPhLfu7OkhDrBCyVv0lCSHyb/uc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC173132E82;
        Mon, 13 Jun 2022 13:08:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40D45132E81;
        Mon, 13 Jun 2022 13:08:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] ci(GitHub): mark up compile errors, too
References: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
        <pull.1253.v2.git.1655125988.gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 10:08:25 -0700
In-Reply-To: <pull.1253.v2.git.1655125988.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 13 Jun 2022 13:13:06
        +0000")
Message-ID: <xmqq35g88p9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70644BE8-EB3B-11EC-8E74-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  * The curly bracket construct was replaced by a proper subshell, to avoid
>    jumbled output and a race where the exit.status file could be read before
>    it was written.

I do prefer () when making a subshell in a case like this (e.g.
upstream of a pipe), so I am happy with this version, but the above
is curious.

I am not sure how "jumbled output" is possible, let alone "reading
exit.status before it is written".  The output goes to sed to be
processed either way, nobody else other than "$@" produces such an
output from there, and sed would not exit until it finishes reading
from the upstream so res=$(cat exit.status) won't kick in before the
upstream exits.

Anyway, thanks, will queue.

> Johannes Schindelin (2):
>   ci(github): use grouping also in the `win-build` job
>   ci(github): also mark up compile errors
>
>  ci/lib.sh                 | 10 ++++++++--
>  ci/make-test-artifacts.sh |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
>
> base-commit: 3069f2a6f4c38e7e599067d2e4a8e31b4f53e2d3
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1253%2Fdscho%2Fci-mark-up-compile-failures-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1253/dscho/ci-mark-up-compile-failures-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1253
>
> Range-diff vs v1:
>
>  1:  5212c5ec474 = 1:  5212c5ec474 ci(github): use grouping also in the `win-build` job
>  2:  19d6e34f038 ! 2:  34daf06bb71 ci(github): also mark up compile errors
>      @@ ci/lib.sh: else
>       -		"$@"
>       -		res=$?
>       +		# work around `dash` not supporting `set -o pipefail`
>      -+		{
>      ++		(
>       +			"$@" 2>&1
>       +			echo $? >exit.status
>      -+		} |
>      -+		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 file=\2 line=\3::\1/'
>      ++		) |
>      ++		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 file=\2,line=\3::\1/'
>       +		res=$(cat exit.status)
>       +		rm exit.status
>        		end_group
