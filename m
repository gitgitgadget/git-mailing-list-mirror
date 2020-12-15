Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28F1C2BB48
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 11:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F02224B2
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 11:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgLOLTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 06:19:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51164 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbgLOLSy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 06:18:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65D04111F31;
        Tue, 15 Dec 2020 06:18:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=fcZPTVaqMRSt6wm2NGMAFZTTErc=; b=MCEeOH1g5iq7a1mKLp0G
        zbTxm7lmeMAnk8izEcp4OI5AubiV742rkLAnOExNLq/gYNoUFjmebQ8Y7HMJmZMA
        z9oX72p7EPQZrL7nGEfgsPwOjTc0OlPQauiRVlj2A3hdwxFlfBH1T9PTUhrEziFL
        vxfiFBIUMKDbQZnLN3+N4S0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=okXBu43jrPW2k3bhS/bhZaBLHF0w9YaoZ4hJw4kNMkTvNg
        7xQC010LT56P1yFsel3tt4PX8O62itBqTf9ePe1qpQ3E2X5z7tRSiQ1m5F8O9gsp
        dOfZnrw0shX9ylBkFAHjmq82+UyfTuJNZk6mpW0DHLBNUY3WfqhBrCQztvOik=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D397111F30;
        Tue, 15 Dec 2020 06:18:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A59E7111F2F;
        Tue, 15 Dec 2020 06:18:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
References: <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
        <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
        <xmqq360h8286.fsf@gitster.c.googlers.com>
        <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
        <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
        <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
        <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
        <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
        <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
        <xmqqtussirsl.fsf@gitster.c.googlers.com>
        <X9ggAxk/z0D9Qom+@coredump.intra.peff.net>
Date:   Tue, 15 Dec 2020 03:18:05 -0800
Message-ID: <xmqqh7on8gia.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35343DF2-3EC7-11EB-99DD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I like pull.mode in that sense. But it is also weighed against the
> fact that we'd still have to support pull.rebase, and we'd still have to
> support pull.ff, and explain how those interact with pull.mode (and I
> think any new error in this area must be squelched by those existing
> variables, or it would be a regression for people who already picked
> their default long ago).

I agree that if we were starting from scratch, things would have
been much simpler; choose among three ways to reconcile histories
(merge, rebase, or ff-only), without adding --[no-]rebase, and allow
--[no-]ff only when merging (i.e. things like --ff-only --ff,
--no-ff --rebase, would be nonsense combinations).  The additional
complexity of introducing pull.mode is the primary thing I am
hesitant to support it, as we have to design and explain how
existing knobs interact with newer one.

> Using advice.* to squelch the advice would be fine with me, provided it
> was _also_ squelched by the existing config options.

Meaning "once you choose between rebase or merge, facing a non-ff
history would not trigger the advice message"?  I think that is
already the case with the released versions of Git, and I think that
is a good thing to keep.  The advice is only for unconfigured folks
who did not tell --[no-]rebase from the command line.  One bad thing
about it in the released versions is that it would trigger even when
the history fast-forwards.  The latest round of patches in 'seen'
squelches the advice when pulling a fast-forward history even for
unconfigured folks as we'd just fast-forward without erroring out.

> Which I think is where your thinking is ending up.

Pretty much.  

