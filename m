Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1310C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FF32065D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DtDDnmpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgHQTdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:33:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55744 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbgHQTde (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:33:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 234806F812;
        Mon, 17 Aug 2020 15:33:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KHWaPFRBQVuJXf0vN66zpYq2OCg=; b=DtDDnm
        pCZ4FhrWf7GyahyPsMGuOAzxbqYS/4ox6BVnw2HjwFi4enxnxJM54FcpcfKyBtrT
        GLfA40hySHEatrISjHpp4QjzZ+Mew85qNRovIgzZxtsVXxG0hI5ZvET5s3JmXAvT
        ZGFccPovfST7z6aEZA5ZIR1BA9yHz7856keHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DOtikLeoC+uoDhQwN/2PAeimY/Vyt5Uy
        QY0coakP715CeVxkmcf2lq0WW7ez1bSuQq4FyNekF2/rW1aAsICASkJCy7kphBl7
        Bflt4+3SXXOle4to3NOPqg+rm3CBfJMOTJ65eQZLTh/L6OC63PfNauGpgfE7pOIw
        1q85+7eCSeI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B9A16F811;
        Mon, 17 Aug 2020 15:33:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D8106F80C;
        Mon, 17 Aug 2020 15:33:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 8/9] format-support: move `format_sanitized_subject()` from pretty
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <7a64495f99ec97258687695d41d106e3f946d551.1597687822.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 12:33:30 -0700
In-Reply-To: <7a64495f99ec97258687695d41d106e3f946d551.1597687822.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Mon, 17 Aug 2020 18:10:21
        +0000")
Message-ID: <xmqqlfid1305.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8875662C-E0C0-11EA-B352-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Hariom Verma <hariom18599@gmail.com>
>
> In hope of some new features in `subject` atom, move funtion
> `format_sanitized_subject()` and all the function it uses
> to new file format-support.{c,h}.
>
> Consider this new file as a common interface between functions that
> pretty.c and ref-filter.c shares.

Sorry, I do not see a point.  Let's not do this and keep or add them
in pretty.[ch] if you are making some of the static ones public.

Thanks.

