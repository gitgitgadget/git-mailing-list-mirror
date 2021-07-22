Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B45C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA1260EB5
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhGVSKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 14:10:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59555 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGVSKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 14:10:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A03BFCB64E;
        Thu, 22 Jul 2021 14:50:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KJwb/rSOT/jJlmVfDx1QKfP/Dnw2JKF8yJ8o1B
        EfHtY=; b=XAHydjX9v7Pbtbq0FR1QC6atTk5R2kcdpVs8OQdjFmOrQnrF+LfrvT
        vPyJOnN3C4EgTv8zypJ9EPMWuuTvoEBeHAhVq+vbbCdw4qM8Rh2Ak96DZXMk4qAn
        VMDvU5eVCnHuGqo8WWIhvQfDHziObxDlq6BFLMm+4U55+zHt0PMTM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 967D0CB64D;
        Thu, 22 Jul 2021 14:50:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 272D8CB64C;
        Thu, 22 Jul 2021 14:50:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 4/5] Makefile: the "cscope" target always creates a
 "cscope.out"
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
        <patch-4.5-f8d151f1f6a-20210721T231900Z-avarab@gmail.com>
        <xmqqk0li9tks.fsf@gitster.g> <YPmxsCatUIByQnig@nand.local>
Date:   Thu, 22 Jul 2021 11:50:49 -0700
In-Reply-To: <YPmxsCatUIByQnig@nand.local> (Taylor Blau's message of "Thu, 22
        Jul 2021 13:58:08 -0400")
Message-ID: <xmqqfsw69o8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBC4E3B4-EB1D-11EB-B479-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> >  cscope.out: $(FOUND_SOURCE_FILES)
>> > -	$(QUIET_GEN)$(RM) cscope* && \
>> > -	echo $(FOUND_SOURCE_FILES) | xargs cscope -b
>> > +	$(QUIET_GEN)$(RM) cscope.out && \
>> > +	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
>
> But that alone is a good change in my mind at least. Then it's clear
> that that target is responsible for generating cscope.out and nothing
> else.

Probably.  The preparatory $(RM) is close enough to the invocation
of cscope that anybody adding other options like '-q' should be
careful enough to notice that the line needs to be touched, too, so
I can be talked into thinking that $(RM) change here is a good one.
I do not know about "-f$@", which is "Meh" to me.  Is there a good
reason to suspect that they might want to change the default output
filename?

> So I'd be in favor of rewording the patch message and only retaining
> this hunk (and dropping the other two).

Yup.  I do not mind dropping one half of this hunk, too, but again,
I do not mind keeping -f$@, either [*1*].


[Footnote]

*1* if the patch to add cscope support anew were done with -f$@, I
   wouldn't have insisted removing it, out of the principle "any Meh
   change is not worth applying once the code was written and
   working".
