Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AB7C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 20:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D971061053
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 20:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhIAUuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 16:50:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52269 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhIAUut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 16:50:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B39814A323;
        Wed,  1 Sep 2021 16:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tClk+0xyBX3tKoA8Q4Wu+g627Ez49wXPCe/b0J
        yxBWc=; b=nFdrM86mU0KYNRxzwP6d1RZLPrF1saU5aV02VoCksCBglXBhvkVhc+
        Pzu0nwwDaxMRECCUsR+bMlXN+uf1Gg7DLeJogH8qCJplE0uB1uaTMteKqMXqDItD
        /fU6PwP1bUe2NRKPqP68EMBN82Qdrz01Uxe8iHYhaKw8sY3fFKhus=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22C4E14A322;
        Wed,  1 Sep 2021 16:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 61CA114A321;
        Wed,  1 Sep 2021 16:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v5 00/27] multi-pack reachability bitmaps
References: <cover.1617991824.git.me@ttaylorr.com>
        <cover.1630443072.git.me@ttaylorr.com> <xmqq5yvkqidc.fsf@gitster.g>
        <YS/Pqc7lkMlnlBYR@nand.local> <xmqq1r68qevl.fsf@gitster.g>
        <YS/juRg9N/cCoR0d@nand.local>
Date:   Wed, 01 Sep 2021 13:49:47 -0700
In-Reply-To: <YS/juRg9N/cCoR0d@nand.local> (Taylor Blau's message of "Wed, 1
        Sep 2021 16:34:01 -0400")
Message-ID: <xmqq35qoowb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26066C80-0B66-11EC-9570-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Sure, I don't mind getting more strict here in this series. If you want,
> the below could be queued instead of the original 11/27:

That may make the documentation and the code more consistent.

> As far as I can tell, supporting arbitrary directories with
> `--object-dir` was a historical accident, since even the documentation
> says `<alt>` when referring to the value passed to this option.

The synopsis has [--object-dir=<dir>], which wants to be cleaned up
for consistency (or <alt> updated to <dir>, but I tend to agree with
you that unifying to <alt> may make our intention more clear).

It is unfortunate that "git multi-pack-index -h" says <file>, which
is probably doubly wrong.  It seems this is the only instance that
abuses OPT_FILENAME() for a non-file, so perhaps it is not too bad
to fix it using the lower-level OPTION_FILENAME (instead of adding
a one-off OPT_DIRECTORY_NAME() helper).

Neither is something that would block this step, of course.
