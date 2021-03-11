Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFE3C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C29164DE4
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCKB5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 20:57:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57069 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCKB5M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 20:57:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00F821255AF;
        Wed, 10 Mar 2021 20:57:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J+VO3aY05lmwAx19NR/BS0Ro5mI=; b=Bz3Grb
        G0mpFgQhtF6Bprt1iir4fyFQ7MgN2JMau2DGHGvae+Z1EPzFlBHliMsZGFJqxHIL
        m5aZW5HyI13Tone+1AMCCYq9XYA2fM6+Que3eB0aOIR9pgn8JxhRVRQyrvxCIuSo
        MteGWia2/ZLfqXYSAu400sKS84LdJCT2Jvurw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=khFSFilypWsbqh9By1L7kVVOXwTpZudW
        EYrAWuuvLGcxjYQL+FiXJd4EvjcrrQuZIC44+WiCEAp62852Pq0BShoWcfa+JTD7
        FiCYHoovZkxz0154sxffUE2jmqL6FXp6r2u8Z49n9IeQY8Qo32WlFQoRfLdVdj/T
        rrRUFRA4vYo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDE121255AE;
        Wed, 10 Mar 2021 20:57:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 452B51255AC;
        Wed, 10 Mar 2021 20:57:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: Re: [PATCH] mergetool: do not enable hideResolved by default
References: <20210130054655.48237-1-seth@eseth.com>
        <20210209200712.156540-1-seth@eseth.com>
        <20210209200712.156540-2-seth@eseth.com> <YEbdj27CmjNKSWf4@google.com>
        <xmqqmtvbjuvl.fsf@gitster.g>
Date:   Wed, 10 Mar 2021 17:57:07 -0800
In-Reply-To: <xmqqmtvbjuvl.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        10 Mar 2021 00:06:06 -0800")
Message-ID: <xmqqzgzafo5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16C2A44C-820D-11EB-A5CF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As we want to disable the feature for any backend when the user does
> not explicitly say the feature is wanted (either in general, or for
> a specific backend), the change in the above hunk is exactly want we
> want to see.
>
> Looking good.  Let's not revert the series and disable by default.
>
> Should I expect an updated log message, though?  What was in the
> proposed log message sounded more unsubstantiated complaint than
> giving readable reasons why the feature is unwanted, but both the
> response by Seth and your response to Seth's response had material
> that made it more convincing why we would want to disable this by
> default, e.g. "with little to no explanation", "We don't have a way
> to communicate to the end-user" (both by Seth), "when ... didn't end
> up lining up the files correctly", "no way to visually distinguish"
> (yours) are all good ingredients to explain why this feature is
> prone to subtly and silently give wrong information to the
> end-users.

For tonight's pushout, I'll use the patch as-is and merge it in
'seen'.

Thanks.
