Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698A4C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 02:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiCDCpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 21:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiCDCpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 21:45:11 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C992F8B83
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 18:44:23 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C340109803;
        Thu,  3 Mar 2022 21:44:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=oufTS6DPj1WR2n9bQ/thhNGZy
        EGaGu8r/t9UH1OkVbM=; b=m2WkG9/qgqtEyoPMPopp98iTG+bmRaacYhMEtBtDP
        eA1FMoI4wO52ZCzhK7JCmCGyjxlpk/9Ctn4COXJZ8hih+7bXabP10vLCKWeWYTWF
        QGZSNYfHwUPBpQdVOM6b55cmmyTi3e+8/4z/hxbNDjrhjQD/9bPw9rW7gM+Px2hM
        Oo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02C90109802;
        Thu,  3 Mar 2022 21:44:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62FB1109801;
        Thu,  3 Mar 2022 21:44:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 00/15] tests: don't ignore "git" exit codes
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
        <76a1ff22-3eb0-08fb-5aa9-e612ee5b522f@github.com>
        <e3090436-4479-bbc2-3b62-00473f6f530e@gmail.com>
        <220303.864k4f3uqe.gmgdl@evledraar.gmail.com>
Date:   Thu, 03 Mar 2022 18:44:21 -0800
Message-ID: <xmqqlexq4et6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FF51B614-9B64-11EC-8688-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Yes, it returns the correct status code, but that doesn't help with
> (pseudo)code like:
>
> 	if (run_command("foo")) /* exits with e.g. 123 */
> 		die("oh no, foo failed"); /* exits with 128 */
>
> I should have said "code using run-command.c does not do that...",
> sorry.

Yeah, but even if callers of run_command() can tell "foo"
segfaulted, I do not think it is sensible to exit as if we
segfaulted (or, we _could_ actually die by segfaulting ourselves,
which is worse).
