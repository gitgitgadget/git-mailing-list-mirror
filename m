Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D252C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 17:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbiFGRCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbiFGRCs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 13:02:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8922B186
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:02:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D7F61245C1;
        Tue,  7 Jun 2022 13:02:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DouqHwWgUGDo
        u4YAaYIVOvdZOh1Y/2g9+0TyBN1UcC4=; b=kTDf9wLVRJXkcikQ+w534JlLlMhY
        oYFYeCmqF30XIKe3PA5I7ZPUJqqrfj/oI0oMV0j5DKPeIaDPE9cAXPK3p0byFY56
        ssX4f3Od5IEd3zP2Hwo4WVRABzsPMf+vQQXE1QyhTKPVYaSTDDSZCZWCYKcRYrpR
        lO2S6scXHooLV48=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 151F41245C0;
        Tue,  7 Jun 2022 13:02:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BED51245BF;
        Tue,  7 Jun 2022 13:02:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 0/2] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
References: <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
        <cover-v6-0.2-00000000000-20220606T170356Z-avarab@gmail.com>
Date:   Tue, 07 Jun 2022 10:02:44 -0700
In-Reply-To: <cover-v6-0.2-00000000000-20220606T170356Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 7 Jun
 2022 10:48:18
        +0200")
Message-ID: <xmqqfskgz9sb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A6CDB87A-E683-11EC-88DE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series fixes a v2.36.0 regression[1]. See [2] for the v5. The
> reasons for why a regression needs this relatively large change to
> move forward is discussed in past rounds, e.g. around [3]. CI at
> https://github.com/avar/git/actions/runs/2448496389
>
> Changes since v5:
>
>  * Make the hook run test more meaningful, we now test with "-t" in
>    the hook, instead of redirecting one of STDOUT or STDERR.
>
>  * Add a test for both "git hook run" and "git commit", to showh that
>    the "git hook run" command and one "real" user of it agree.

Thanks for a careful review and a timely response.

>
> 1. https://lore.kernel.org/git/cover-v5-0.2-00000000000-20220602T131858=
Z-avarab@gmail.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   run-command: add an "ungroup" option to run_process_parallel()
>   hook API: fix v2.36.0 regression: hooks should be connected to a TTY
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   run-command: add an "ungroup" option to run_process_parallel()
>   hook API: fix v2.36.0 regression: hooks should be connected to a TTY

Puzzling.  Perhaps copy-and-paste mistake we can ignore.

>  hook.c                      |  1 +
>  run-command.c               | 70 +++++++++++++++++++++++++++----------
>  run-command.h               | 30 ++++++++++++----
>  t/helper/test-run-command.c | 22 ++++++++++--
>  t/t0061-run-command.sh      | 30 ++++++++++++++++
>  t/t1800-hook.sh             | 31 ++++++++++++++++
>  6 files changed, 155 insertions(+), 29 deletions(-)

