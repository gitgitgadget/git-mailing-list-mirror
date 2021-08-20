Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A632C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 02:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D005610E5
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 02:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbhHTCbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 22:31:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56583 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbhHTCbN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 22:31:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F7E8E2147;
        Thu, 19 Aug 2021 22:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=52HAcvgenPMd
        KGAxgJEs3vJ70i3MQqtAI6hbkE09Qxs=; b=haY/w8ijYc62M1Jt6h0HxkvdY1o8
        RdLFcWk4xqoDXSmARbYeFfQ6Orqu2kqwQdpyiz2jE6Zb+NCFM5SlUneD47gi26Im
        zt6ywgDqNYOEIrhDfrmQcbDgFDkECIKY+pbv4+Uu+hCAjBbNBIKoeeBBM0KQ9ee8
        HF6jy/oLqy03IBw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8504CE2145;
        Thu, 19 Aug 2021 22:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9A23E2144;
        Thu, 19 Aug 2021 22:30:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 09/11] reflog expire: don't lock reflogs using
 previously seen OID
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
        <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
        <patch-09.11-60d6cf342fc-20210716T140631Z-avarab@gmail.com>
        <CAFQ2z_MhNgimn=7qcu-G823X=yTRT3xXrDP7qRiELShXY9A3AA@mail.gmail.com>
        <xmqqlf4y4g6v.fsf@gitster.g> <YR4tFHW7oVDjgOJC@carlos-mbp.lan>
Importance: high
Date:   Thu, 19 Aug 2021 19:30:33 -0700
In-Reply-To: <YR4tFHW7oVDjgOJC@carlos-mbp.lan> ("Carlo Marcelo Arenas
 =?utf-8?Q?Bel=C3=B3n=22's?=
        message of "Thu, 19 Aug 2021 03:06:12 -0700")
Message-ID: <xmqqbl5syhiu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9927E098-015E-11EC-991B-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> FWIW the crude revert of this commit (cut below for easy access)  does
> almost (except for the pedantic fixes[1] that are expected with the nex=
t
> fsmonitor rollup) allow a CI run[2] for "seen" to go fully to green.

Thanks.

I've decided to kick these topics out of 'next' and move them nearer
to the tip of 'seen':

    ab/refs-files-cleanup
    hn/refs-errno-cleanup
    jk/refs-files-cleanup-cleanup

Most importantly they are now queued after the hn/reftable topic, so
that it get its turn for more exposure and priority.  Of course, we
still have the same CI breakage at the tip of 'seen'.

The jk/refs-files-cleanup-cleanup is to clean up leftover cruft in
the ab/refs-files-cleanup topic, so when ab/refs-files-cleanup is
updated, hopefully its contents can be squashed into its commit(s).
hn/refs-errno-cleanup builds on top of it and hopefully rebasing
the whole thing on top of hn/reftable after it becomes stable would
get rid of the CI breakage.

