Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A558EC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 16:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB0561964
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 16:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCSQCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 12:02:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60243 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhCSQBz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 12:01:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDB5EB5AAE;
        Fri, 19 Mar 2021 12:01:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mBcvdlTojvjb9VHPOTlntAuZvrQ=; b=IYslGg
        tEEIwHFxJnS0z68afczm2ri/1VJ3p2P4SdwQvMogvOFlKEjaKlLqXHG1zm1Jbs2T
        FBzD2uCsh85jIY30pSVR/vqEbDQgogTcB+8jGOPfTcXVbZNPp3W+EjgkDHPTw75X
        uGo28MMKKamU8OJfx/eIkiL65+wI50UhLjG4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iwmq7DSdHNTb039dR8npMCZ0gUXtk5Y4
        mE177LjFm2lAl5XXiqm3DNRs/l9KOwslattU8kKshYkB26C9qoDDPC5cz+sLlGfg
        zkOZGF4fZFXGqZ4+AV0Zv42s4Hyv63aOqS28sey4alMKT7MHSsOnTwQaIiAG+YJx
        CsS1m1IQbas=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3E29B5AAD;
        Fri, 19 Mar 2021 12:01:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7438CB5AAB;
        Fri, 19 Mar 2021 12:01:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v7] format-patch: allow a non-integral version numbers
References: <pull.885.v6.git.1616047200968.gitgitgadget@gmail.com>
        <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 09:01:53 -0700
In-Reply-To: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Fri, 19 Mar 2021 11:21:23 +0000")
Message-ID: <xmqqpmzvnnda.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CCC3A86-88CC-11EB-ABAC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     There is a small question: in the case of --reroll-count=<n>, "n" is an
>     integer, we output "n-1" in the patch instead of "m" specified by
>     --previous-count=<m>,Should we switch the priority of these two: let "m"
>     output?

In principle, if the end-user can explicitly give an input that may
(or may not) contradict what the code would automatically compute,
we should treat the latter as a fallback default and use it only
when the former is not given.  So, I would think the answer is "yes,
we should use <m> and not <n>-1, if <m> is given".
