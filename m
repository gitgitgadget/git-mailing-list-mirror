Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F4AC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiGURQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGURQi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:16:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9367FE74
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:16:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E70C41A9DCD;
        Thu, 21 Jul 2022 13:16:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fcllznZW2e+a
        yENyciF/DAiDiXJcwG0kL14Ys6W3BNk=; b=AsbNOzsJten9eaqDl9YNIm3q+K72
        tUvuFBV2SoR6g8m8QNxZWBax2XgZQA1Jx0GYZpr2+xRbRo/0q2rbUE6pNvACJrXI
        v+pZ85cJ6uQ/i17xxHeyQP+k/ZLw0363KYdAsBtXeIMVUOqbhd+JQ7dSl2Uakj2D
        gN5tCEndfAuliVs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E05621A9DCC;
        Thu, 21 Jul 2022 13:16:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8C6021A9DCB;
        Thu, 21 Jul 2022 13:16:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: On-branch topic description support?
References: <xmqqilnr1hff.fsf@gitster.g>
        <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
Date:   Thu, 21 Jul 2022 10:16:32 -0700
In-Reply-To: <220721.86mtd2tqct.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Jul 2022 16:53:18 +0200")
Message-ID: <xmqqwnc6idxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DE8B55BC-0918-11ED-8BDD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> To steal and amend a diagram from git-merge(1), we now have turned this=
:
>
>
>               A---B---C topic
>              /=20
>         X---Y
>              \
>               master
>
> Into this:
>
>               A---B---C---M topic
>              / \         /
>         X---Y   ---------
>              \
>               master

If you mean your topic have 3 commits, then I think you want the
first parent of M to be Y, not A, but I agree the above arrangement
can also represent what I was discussing.

The thing is, it is unclear if such an artificial merge is an easy
thing to maintain by individual contributors.  "rebase -i" with some
extra options people are not familiar with may be able to reproduce
the topology without losing information after you accumulate more
commits on top of M (e.g. you build D and E on top of M and now you
want to make it A-B-C-D-E merged into Y with M that records the tree
of E; you'd amend M's message to talk also about D and E), but
"it is possible" is different from "people are comfortable doing".

If M did not have a backpointer to the other parent, and instead
were an empty commit, then you recreated what I wrote in the message
you are responding to.
