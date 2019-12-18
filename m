Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8C3C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591C821D7D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sfWageWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLRWEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:04:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57462 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRWEd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 17:04:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40C54A9325;
        Wed, 18 Dec 2019 17:04:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QzPZ7sfUol27KmXDACxjhCyfg24=; b=sfWage
        WyFAjdLyVLe5ARb99ub7czoIIlZuOCua6FLLHtVo86BPG+ez/VrK7GarTuadKDhF
        Zf4B3EoWQrJCQ6bTAXMcZVCXsqrNpl3F5DL4zvXzUoojjGku3SwwZM3avkv4uJkG
        D5V1n2tRG3W4VcbV0mJS8GBVTzhGhVbz/Hm/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TKRxSuW10y6ipB0bT9tU14gRgFrNdaQY
        pwflORN5BlPMSVQkbSbo4hXT4jmhRmims3HLUpWrBC6Gi7fDqteVsblCfjPIJzbb
        LnDiXnDerGg38y79QwhSjK+HcpgT2H/zhaAZPSflgJtsaUFtpDsFgHof/EXnA4M+
        LrdNTQs7AP8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39EEEA9324;
        Wed, 18 Dec 2019 17:04:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60EABA9323;
        Wed, 18 Dec 2019 17:04:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 04/18] commit: forbid --pathspec-from-file --all
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <deeb860a85d25e0645a5d2e1c82654653ab1e2d5.1576511287.git.gitgitgadget@gmail.com>
        <195a5b2a-994a-5984-8cc7-280a698df2a0@gmail.com>
Date:   Wed, 18 Dec 2019 14:04:26 -0800
In-Reply-To: <195a5b2a-994a-5984-8cc7-280a698df2a0@gmail.com> (Phillip Wood's
        message of "Tue, 17 Dec 2019 20:00:43 +0000")
Message-ID: <xmqqmubpcmtx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C5CE9FE-21E2-11EA-8592-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Alexandr
>
> This looks good, thanks for the test
>
> Best Wishes
>
> Phillip
>
> On 16/12/2019 15:47, Alexandr Miloslavskiy via GitGitGadget wrote:
>> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>>
>> I forgot this in my previous patch `--pathspec-from-file` for
>> `git commit` [1]. When both `--pathspec-from-file` and `--all` were
>> ...
>> [1] Commit e440fc58 ("commit: support the --pathspec-from-file option" 2019-11-19)

Thanks, both.  I will take this separately and queue directly on top
of am/pathspec-from-file to fast-track it, rather than leaving it as
a part of larger topic that would take more time to mature.


