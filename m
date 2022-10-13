Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D6BC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 21:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJMVMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJMVMc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 17:12:32 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3769E192B98
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 14:12:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 647BA1BDD40;
        Thu, 13 Oct 2022 17:12:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=duZe7T3DiTXFIqSV7JR8cZjFqkUfehsXHzvPTLJFqnA=; b=fR0t
        ryjqjjTcsi58al3yqT98BDrt3sWsQ46EEJlCvn+M3gMluLFoOeXI5k5yMkvkRMYY
        vOCCcmJBIXfooFEHa0Q+b2Pr1yIS+kROGmpNQHptDXMQy0/QpNvLiV3ue7I5vru9
        8JEgBp+IYKVc4QqvtZ+z3Ph66Mt0t7jZQypZ/ok=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CE8E1BDD3F;
        Thu, 13 Oct 2022 17:12:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 962C11BDD3E;
        Thu, 13 Oct 2022 17:12:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 6/7] trace2: add stopwatch timers
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
        <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <dd6d8e2841b424ba89672b4d94306f9ec882a868.1665600750.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 14:12:17 -0700
Message-ID: <xmqq8rlje8cu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8586AA0-4B3B-11ED-8E80-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Add stopwatch timer mechanism to Trace2.
>
>  trace2/tr2_tmr.c                       | 182 +++++++++++++++++++++++++
>  trace2/tr2_tmr.h                       | 140 +++++++++++++++++++
>  15 files changed, 784 insertions(+)
>  create mode 100644 trace2/tr2_tmr.c
>  create mode 100644 trace2/tr2_tmr.h

Whew.  That's a lot of new code and doc to make two calls to
getnanotime() and accumulate the differences.

It was irritating to count zeros in the same constant 1000000000.0
spelled out 9 times.  Perhaps something like

#define NS_TO_SECONDS(ns) ((double)(ns) / (1000*1000*1000.))

would have helped?

Other than that, all looked reasonable.

Thanks.
