Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F542C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B952074F
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CXz51eAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgDIWzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:55:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59068 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgDIWzc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 18:55:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48831414E7;
        Thu,  9 Apr 2020 18:55:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=phOv4EDzhZO+KKFNPUwUUltbfLw=; b=CXz51e
        AU3F4DvnHzrgXmue5keQA6MfYPToUlh/R8/OYXdqus9gLDsWhCybFG/PDTy+iZhw
        zm35Q5+/5Ep34bSFOCuo/Jv65nrsa+bf2yRASywOK2liW2dnZQg3NE4r/TfvLtP2
        z5FpNxrhlrgjgEfq7RH/nxxEUb95Gty6lt06E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WQCWNpfiHtJ636OLq6r4US/EPZ0H0NvS
        w9s0Fx/j85ImpRIaeJ2ULBplAumCXyy0JcCjRD8gxdMdLYuaIm+snnAycHU1sUR+
        UqWtal7co8kTchC9/6sByp8qbiMe/2bzVmph0Ntmtt+1/gDpr3FjCr92NwFlb/0s
        SE+ENfdcKgs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FDF7414E6;
        Thu,  9 Apr 2020 18:55:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6416414E5;
        Thu,  9 Apr 2020 18:55:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Norbert Kiesel <nkiesel@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [git 2.26] stat counts reported by commit and log are different
References: <CAM+g_Nv4UqQNAuYyo5zsTsiomCe4ueoM6ZGU1aqAjLGV9+jQJg@mail.gmail.com>
        <20200409135959.GB3494212@coredump.intra.peff.net>
        <CAM+g_NuZ3pKAd80+HoR8-_0=N9wV28L-yyb1VhJhTbYH+RS0og@mail.gmail.com>
        <20200409224747.GA4173825@coredump.intra.peff.net>
Date:   Thu, 09 Apr 2020 15:55:30 -0700
In-Reply-To: <20200409224747.GA4173825@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 9 Apr 2020 18:47:47 -0400")
Message-ID: <xmqq8sj4mfq5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3657C874-7AB5-11EA-A2AA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It might make sense to do so (and/or to make it possible to enable it by
> config like we did for years with diff.renames). But it definitely is
> way more expensive.
> ...
> So not quite as bad percentage-wise, but still pretty expensive. And for
> not a huge benefit. There are ~261 impacted commits. You can see a
> recent example with:
>
>   git show -B -M --stat --summary ce6521e44
>
> where we find that most of builtin/fmt-merge-msg.c was moved to
> fmt-merge-msg.c. It's nice, but it's expensive enough that it probably
> shouldn't be the default.

Not only that, it can cost correctness-wise.  Until this

  https://public-inbox.org/git/xmqqegqaahnh.fsf@gitster.dls.corp.google.com/

gets corrected, it is not advisable to enable -B and -M at the same
time.

