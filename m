Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68235C433E0
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 20:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3A9614A5
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 20:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhCGUfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 15:35:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55642 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhCGUe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 15:34:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23A31BFD43;
        Sun,  7 Mar 2021 15:34:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5vAHWwtiLTQ16IJ6a/avWHQt8ag=; b=GdLckZ
        qdSmhpTMNWLOl5IwJAl4AMENyyKyXkf+PqLldM+dAPId2/uZWd6DnGyHzw8IKYMz
        Zy4/6G2OGLuRs7K8qHAh6+svjMOLMGnqyUakxiKHpqQcueLE6Vk47fAIJUE1dqIw
        OECeTv/VgBLPuXulFZI3/WSRn/KdLAd5efJ6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c1BA+uGXrEPHmHz3XBpyKjQJPRgMtEX9
        TgFcT5/b7RGHKSdEQfsIpbZS4LTstyVHwtPcok6rp5sKGDFstzgxrDWiiwB1kqNs
        ExaKmBjl6KqtEjnCNGfaspcFkldh302zWnPYzc8kqO2BHIdINyRx9QJ49knkSx/x
        RAre8298SxA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C373BFD41;
        Sun,  7 Mar 2021 15:34:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91A8CBFD40;
        Sun,  7 Mar 2021 15:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "HG King via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, HG King <hgmaxwellking@gmail.com>
Subject: Re: [PATCH] fix: added new BANNED_EXPL macro for better error
 messages, new parameter
References: <pull.896.git.1614991897210.gitgitgadget@gmail.com>
Date:   Sun, 07 Mar 2021 12:34:57 -0800
In-Reply-To: <pull.896.git.1614991897210.gitgitgadget@gmail.com> (HG King via
        GitGitGadget's message of "Sat, 06 Mar 2021 00:51:36 +0000")
Message-ID: <xmqq7dmi8zym.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95899C9E-7F84-11EB-80A3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"HG King via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  #undef strcpy
> -#define strcpy(x,y) BANNED(strcpy)
> +#define strcpy(x,y) BANNED_EXPL(strcpy, buffer_overflow_risk)

That does not help programmers that much (the above does not say
what to use instead, for example), and the mechanism inherently
does not give you sufficient space to give helpful guidance.

Adding a comment around each of these definition may be OK.  Upon
seeing foo_is_a_banned_function, somebody new to the codebase would
look for where it is banned, and find the above, so that is a good
place to give guidance.
