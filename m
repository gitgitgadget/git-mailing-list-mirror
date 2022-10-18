Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA3CC4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 09:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJRJLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJRJLW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 05:11:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC97F112F
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 02:11:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B43A1B80E6;
        Tue, 18 Oct 2022 05:11:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=yGk2a5YWtT0IKOLM+/LNQNVUV
        z1tUfkF54xbnOyqCoM=; b=LYow1ro3EVtlHG/MC5/H4FRyEYfTxCIZ7avY7TEcI
        mbfuvSJZ/2jaN2tHuD0ynFSLaBg0SsUB3qIUN8rK1vRPbn+4JHogeq1wcRZmJ1k6
        WsjDpbhWQKomMdLn5K4cN50JVFjFZ79tsCV7Sz9BNtdh3td5rsXHqmDOJI1TekvE
        1g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 13B8E1B80E5;
        Tue, 18 Oct 2022 05:11:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4AF1C1B80E3;
        Tue, 18 Oct 2022 05:11:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
Date:   Tue, 18 Oct 2022 02:11:16 -0700
Message-ID: <xmqq4jw1wl6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D2A91102-4EC4-11ED-99FC-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series provides a more idiomatic set of run-command API helpers
> to match our current use-cases for run_command_v_opt(). See v1[1] for
> a more general overview.

Hmph...  I somehow thought that the concensus is rather try the
complete opposite approach shown by Ren=C3=A9's patch to lose the use of
run_command_v_opt() by replacing it with run_command(&args), with
args.v populated using strvec_pushl() and other strvec API
functions.

One of the reasons I would prefer to see us moving in that direction
was because the first iteration of this series was a good
demonstration of the relatively limited usefulness of _l_opt()
variant and also it seemed to be error prone to use it.
