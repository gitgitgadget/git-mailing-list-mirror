Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D8AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 16:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiCPQGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiCPQGD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 12:06:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215E5AEF2
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 09:04:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C19D618F369;
        Wed, 16 Mar 2022 12:04:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IRUolz21Z6fmUWyPScsjocq6dPXMMEuBm3O29c
        hFSww=; b=SOfReUnMx9Scb3G4gYqCHeBz3TcgQ+pq70+hrRAp/qPTU5jSYuFOQ3
        Js5K21t0LqbrDxTKl43m14sFayBybAT7uYktPUJanr+vDfblf85Ten6dnK6x8F1I
        OPasCmJ4BKae40QMODePKmNwpi2gP7cweXjgWmcZeMth07AQc38Gc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA4FF18F368;
        Wed, 16 Mar 2022 12:04:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D1A6618F367;
        Wed, 16 Mar 2022 12:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Zhang <zhgdrx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: understand Diff Formatting --cc flag?
References: <CAJcwCMMMm=ZnkV3Xxbf+CpJqhRGx1KrdUzh90W-9dEPJ+i40xg@mail.gmail.com>
Date:   Wed, 16 Mar 2022 09:04:42 -0700
In-Reply-To: <CAJcwCMMMm=ZnkV3Xxbf+CpJqhRGx1KrdUzh90W-9dEPJ+i40xg@mail.gmail.com>
        (Andy Zhang's message of "Wed, 16 Mar 2022 19:36:25 +0800")
Message-ID: <xmqq8rt9opd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB4B234A-A542-11EC-90DB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Zhang <zhgdrx@gmail.com> writes:

> understand Diff Formatting --cc flag?
>
> hi,
>
>   It is really too hard to understand Diff Formatting --cc flag.
>
>   It is hard to understand"...hunks whose contents in the parents have
> only two variants..".
>
>   My question is:
>    1)what does "variant" mean here?

You may be comparing a merge of 5 parents into 1 child.  There are 5
pairwise comparison (parent#1 with the child, parent#2 with the
child, ..., parent#5 with the child).

Among 5 parents, perhaps parent#1 and parent#2 had the same contents,
and parent#4 and parent#5 had the same contents, different from what
parent#1 and parent#3 had.  You have 3 variants (parent#1's, #3's
and #4's; parent#2 has the same contents as #1, parent#5 has the
same contents as #4).

>    2)what about all the other cases? 0 variants, 1 variants, and 3
> variants and even more?

By definition, you wouldn't be making any comparison if there are 0
variants.  1 variant means all the parents are identical, so
whichever parent you are interested in, the difference to the child
is interesting---such a change can only come from the person who
merged adding a change that no parent wanted to have.  If many
parents are different then showing the comparison with the final
resolution from them is useful.  The case that is not so interesting
is when one set of parents had something (call it A), and the other
set of parents had something else (B), and the result is A.  There is
no interesting merge conflict in there.

