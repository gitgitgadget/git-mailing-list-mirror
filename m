Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E22C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 04:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1469D61923
	for <git@archiver.kernel.org>; Tue, 11 May 2021 04:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhEKEQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 00:16:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64273 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhEKEQG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 00:16:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69E54BF9A2;
        Tue, 11 May 2021 00:15:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2lrz+L56o0Cy6zSRE4vMYKsdz3X7fUSjc/jpAH
        G4Bco=; b=Q79uRFPUU75y4ZO/ySmuH5B+Nl8OS3MllO1eeXR5CmP8kI1GoTBTLX
        qQDKWRc0Tr32yb/RbTQL2uB39ueNVfoNEITHIQOvqAERJMC72TGuP50FLsVixYpB
        A8q4T4dEhcb7mcpX81jGc3c+/Z2urURkI4LaTeCHsn5kYqAlCobHo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AF3DBF99F;
        Tue, 11 May 2021 00:15:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C2874BF99E;
        Tue, 11 May 2021 00:14:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
Date:   Tue, 11 May 2021 13:14:59 +0900
In-Reply-To: <20210510153451.15090-7-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 10 May 2021 18:34:51 +0300")
Message-ID: <xmqqsg2toqik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73927C56-B20F-11EB-9D28-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Fix long standing inconsistency between -c/--cc that do imply -p, on
> one side, and -m that did not imply -p, on the other side.
>
> After this patch
>
>   git log -m
>
> will start to produce diffs without need to provide -p as well, that
> improves both consistency and usability. It gets even more useful if
> one sets "log.diffMerges" configuration variable to "first-parent" to
> force -m produce usual diff with respect to first parent only.

Please make sure that you clearly state that you do not blindly
force --patch output in the proposed log message.  Explicitly
mentioning that "git log --stat -m" would not give a patch but just
diffstat would be assuring.

Also this needs a test to ensure that is what happens.  Having a
test for "log -m" and another for "log -m --stat" would be
sufficient.

And in the context of this step, the rename of the member in the
previous step makes quite a lot of sense.

Thanks for working on this topic.
