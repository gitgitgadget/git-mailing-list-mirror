Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A65C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349526113B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJNAIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62966 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJNAIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BDBAF18FA;
        Wed, 13 Oct 2021 20:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QRMq+AzcvEFFxNfg11jzv1PgTlN8OY7sLlN1wr
        MDXPo=; b=AnBXmULzz9NlZ3t5hbSnpIv4PfeIWBEI0PHpQpbV1OHsqKXg/wosJB
        cWA6vvOcNG0Haz3AsHiVl6lOtz+fEGMJpmVdYdNAFY9JbpT302rRJSODTQzp/Sgr
        VoT0/kzXc23m22dmwtmCGnSaBMDURf8AWTN1x20UYT24IgozDgwCI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30795F18F9;
        Wed, 13 Oct 2021 20:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34B1DF18F8;
        Wed, 13 Oct 2021 20:06:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v3 0/9] submodule: convert the rest of 'update' to C
References: <20210916103241.62376-1-raykar.ath@gmail.com>
        <20211013051805.45662-1-raykar.ath@gmail.com>
Date:   Wed, 13 Oct 2021 17:05:58 -0700
In-Reply-To: <20211013051805.45662-1-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Wed, 13 Oct 2021 10:47:56 +0530")
Message-ID: <xmqqczo8eahl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 835557C4-2C82-11EC-9278-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> I have attempted to make a version of this series that is based on that topic [2],
> and added the superproject gitdir caching code in C [3]. It passes the tests,
> but I am not too confident about its correctness. I hope that branch can be
> helpful in some way.
>
> [1] https://lore.kernel.org/git/20210819200953.2105230-1-emilyshaffer@google.com/
> [2] https://github.com/tfidfwastaken/git/commits/submodule-update-on-es-superproject-aware
>     (fetch-it-via: git fetch https://github.com/tfidfwastaken/git submodule-update-on-es-superproject-aware)
> [3] https://github.com/tfidfwastaken/git/blob/a74aaf2540c536970f2541d3042c825f82a69770/builtin/submodule--helper.c#L2922-L2930

The "C rewrite" of the code [3] that unconditionally sets of the
submodule.superprojectgitdir varible seems straightforward enough.

Emily, how solid do you think your "superproject aware submodule"
topic already is?  Would it be stable enough to build other things
on top, or is it a bit too premature?
