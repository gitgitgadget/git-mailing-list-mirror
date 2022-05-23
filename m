Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B1C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 19:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiEWTUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiEWTUV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 15:20:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93014AF4F
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:55:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1317312147A;
        Mon, 23 May 2022 14:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=10X27iHAxgKRbE1Yph49vZR2z
        LUiBlVh6IEfexoNihc=; b=opjXQoXdnjNNrTEsv31KxPiGnw0bRQHYQRvYxD8w1
        wQIO3sQLDXjn45NvKUedImgOoNtCZI+j4CqsUQVHbtk7Zej0sD6Yi0UISYPjQm6w
        cP1Y1h7Z6bJF1pQMWLKqad0KNA5kHin0Y+HiE6F4AEe1vHnZ3Hs0BF+crgGkBjTG
        P0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C56BF121477;
        Mon, 23 May 2022 14:55:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D44D7121476;
        Mon, 23 May 2022 14:55:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
        <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet>
        <xmqq35h2cwrm.fsf@gitster.g> <xmqqee0l9mhl.fsf@gitster.g>
Date:   Mon, 23 May 2022 11:55:05 -0700
Message-ID: <xmqqwnecqdti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DDFD1A2C-DAC9-11EC-9EA7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not want to taint other folks' eyes with my observations, so I'd
> send my impression in a separate message as a response to this
> message after waiting for some time.

Between the previous and latest of the Johannes's topic, the test
output got a lot shorter by discarding the "ok" output and keeping
only the failures and skips.  Because the readers are mostly
interested in seeing failures (they can download the full log if
they want to), and this design decision probably makes sense to me.
The same "while scrolling, the user has to stare into the gray void
for several seconds" is still there and needs a bit of getting used
to (I do not know if it is a browser's problem, or something the
output can help giving a better user experience---the lines in the
folded part may probably not be "counted" correctly or something
silly like that).

The ones with the topic from =C3=86var last night, as I've mentioned
already, lacked the main part of the logic, and it wouldn't have
worked correctly because there was a show-stopper bug in one of the
steps in it.  With that fixed, the "extra click" I complained last
night seems to be gone.  I guess the same "discard the test steps
that successfully ran" trick would give us the same "shorter"
output.  I observe the same "staring into the gray void while
scrolling" when it comes to the print-test-failures output, just as
in the output from Johannes's topic.

Common to the both approaches, folding output from each test piece
to one line (typically "ok" but sometimes "failed" heading) may be
the source of UI responsiveness irritation I have been observing,
but I wonder, with the removal of all "ok" pieces, it may make sense
not to fold anything and instead give a flat "here are the traces of
all failed and skipped tests".

In any case, either implementation seems to give us a good
improvement over what is in 'master'.

Thanks.
