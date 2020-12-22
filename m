Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B73C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 23:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527C322511
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 23:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgLVXnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 18:43:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52707 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgLVXnT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 18:43:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DD35111FED;
        Tue, 22 Dec 2020 18:42:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=whZnB3zxZ+V2lR+Sz5AeFdPCPrQ=; b=P2VTyB
        oRwo1HBe45uQaUE56X4+pxdjiHSUDWr4iZGkArdMiEPSaHlljUCmG6Dw8W7F0/J9
        GgjR9Cf5QYNMS7X6KdbopriEIx21mUT5zp/1MrRG82uLdHnCNjTCg8FGvBv1Vc9v
        3II2srcMN8EXj/Gy8lNEO0hdumNype5emVYSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xCfzWdqgLtxO12D/5I0GagiY4QBM1bzO
        SBWwhoKyV0I4P9zta+RdvnR+imLRS5SVZhhMHRo8bvZauCtHAhjiAsZGQbQkhfqk
        i0i6HDQ3uWMvGf60pOEwX+PE8Bp7IiomsOsTuDo992rdno6DtI4e53rFg2SVFPee
        U/M7Ie54A5c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56A19111FEC;
        Tue, 22 Dec 2020 18:42:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 48BD7111FEB;
        Tue, 22 Dec 2020 18:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 0/3] submodule: port subcommand add from shell to C
References: <20201214231939.644175-1-periperidip@gmail.com>
Date:   Tue, 22 Dec 2020 15:42:32 -0800
In-Reply-To: <20201214231939.644175-1-periperidip@gmail.com> (Shourya Shukla's
        message of "Tue, 15 Dec 2020 04:49:36 +0530")
Message-ID: <xmqqft3xflw7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D790084-44AF-11EB-90E4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

> Feedback and reviews are appreciated.
>
> Regards,
> Shourya Shukla
>
> Shourya Shukla (3):
>   dir: change the scope of function 'directory_exists_in_index()'
>   submodule: port submodule subcommand 'add' from shell to C
>   t7400: add test to check 'submodule add' for tracked paths

Sorry for not being a feedback nor a review, but we are seeing a
segfault from "git submodule add" when the topic is tested with the
rest of 'seen':

  https://github.com/git/git/runs/1597682274#step:6:3155

It seems that you need to be logged in to see the full CI output to
the line level when visiting the above URL.

Thanks.
