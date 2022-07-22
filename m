Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64521C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 06:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiGVGLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiGVGLu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 02:11:50 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C806390F
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 23:11:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B06A01AE205;
        Fri, 22 Jul 2022 02:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5Z50iZ7L4q5bjbdxdjhFB18l+ClP0Yj4VVGBPDaqSz8=; b=itYz
        bt3z3ExsI5ahc5BNHvFIci2o3nml/aCNh6h0d6iqKUJ9tGTW9pqZCvm5F28Kx1dQ
        Xk9s9HD+5ggJqENAL+IlM/nwJCmTeZINm0Aa1kq2Uuk1N544wFyErF3mwhU+wFuV
        u5DiQlNzTdxFKhBjNH2teiEx+hmXVbKMWhKcYm8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA38B1AE204;
        Fri, 22 Jul 2022 02:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3FDFE1AE203;
        Fri, 22 Jul 2022 02:11:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sim Tov <smntov@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: git: detect file creator
References: <CA+X_a+ycefqvz0LaO0KK1LuTqgE=iUhooPRXeo3mq-zXkp+nCA@mail.gmail.com>
        <220715.86fsj2zeqn.gmgdl@evledraar.gmail.com>
        <CA+X_a+zbG_CDP6D0zxozRoUmBeWm4dVxQ=xYRqFeWrk+FR5p0g@mail.gmail.com>
        <CA+X_a+w-tDv+Qq7dnjSaFrFpYanwBbx77UGFpDinyeWUYQaB2w@mail.gmail.com>
        <CA+X_a+zd52cB2h9txxxUeNV0t5s4-ARj+ApDb2+q=MYrY4-dwg@mail.gmail.com>
Date:   Thu, 21 Jul 2022 23:11:44 -0700
Message-ID: <xmqqpmhxd6cf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29ABB322-0985-11ED-9880-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sim Tov <smntov@gmail.com> writes:

> PS: the only way I see to approach it is to create a mechanism that
> will prevent renaming
> files by anyone except for the file creator (the one who Added file).
> Can such a commit hook be created? If yes - how?

As Git is distributed, local hooks cannot fundamentally be used as
an enforcement mechanism.

How about running "git blame" on the end-result, with -C/-M turned
on, instead of paying too much attention to file creation?  That
way, at least you can trace who contributed the words on each line.
