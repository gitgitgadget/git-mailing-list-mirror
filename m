Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16194C433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 13:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347280AbiEQN6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 09:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348275AbiEQN6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 09:58:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69FA4D604
        for <git@vger.kernel.org>; Tue, 17 May 2022 06:58:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id n23so7601887edy.0
        for <git@vger.kernel.org>; Tue, 17 May 2022 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SfEdqcXW7R5kWLef2TihZhV5qO2BvwnWueJDclCpKTI=;
        b=anGEXkjzeSMvB65An4oR9PYl7RsCMI75kFhvBiNM22QoTu1UB7vJd2cNxLTkteSN45
         giWc6zprL6SrM4JhdIzi7GrowPPlqlTLB6S2r9lejv3TRMAF9/odxZi31p8ABGyizQHB
         LrO+TjlQq1VoTJcYVNtgmSyXGj6UgA9UKzVjgsGtogLXc9XWGjFiCtYHCXJ4BdJK0WS6
         Fob2KWQvSmnWijpBUzT4aQNllrqXbOU8Gc2kyvIJugVaMd+6iaE9LfMfBKpyPKKym8T1
         q1YypJMKHYjSmnjIh69BeTq1JkgL7SffewBMa/ySOR58zpNwTq4VfsYQXO+CQI+vXlDz
         fXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SfEdqcXW7R5kWLef2TihZhV5qO2BvwnWueJDclCpKTI=;
        b=tlZzvEcsBRCZx8Z0Q9GG1KRVIjV5TKaj6ujANAP5udEl2BSTtE7M2I5VzyEx+m/pds
         fwO573zUzpHKBoNMbza4Jj/E9/kRprXAWm7XLqaxV1V/v2RjasOU5YisL0qCUdM1ae+i
         xziEXaAYc+GXv6kbWsYlrJUtWDOiKw9JEjKRYojmLP/0gPcvkSEfSCPMyUK5vuWcHe5W
         HqrKboCfkXOlUJHWxob9VDv9XvMAj4SsSepfBLu9rwfC3gnP7Y/0su7eDoKa7SeOdTGQ
         fcloZFnMqvme13TJZa2CzqymOCpeOFCaeea6ddhtEr4kqmaaoJ2wcihBmaWfsqcT0gVY
         3Emw==
X-Gm-Message-State: AOAM5327KwelBbSu9B8SQnanzoFs0g1YdTVejgqvrDXaS0LjjbsJ41Cr
        O5tuyG5jKtGi41Z46VMtnMTTgAOf49E=
X-Google-Smtp-Source: ABdhPJy446VA08f4LGEaPLgSHZ22Frdozjysf978YNA//38AtBq1rXtR+ki+NnQtTNieQd0NgxGb4g==
X-Received: by 2002:a50:ed12:0:b0:42a:a8d3:12c with SMTP id j18-20020a50ed12000000b0042aa8d3012cmr14467292eds.337.1652795921365;
        Tue, 17 May 2022 06:58:41 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090602cc00b006fe7725ed7dsm154190ejk.34.2022.05.17.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:58:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nqxih-001b5e-Vz;
        Tue, 17 May 2022 15:58:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: fix "author_ident" leak
Date:   Tue, 17 May 2022 15:48:29 +0200
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
 <xmqqzgjmcqlg.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqzgjmcqlg.fsf@gitster.g>
Message-ID: <220517.86fsl86z1s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 12 2022, Junio C Hamano wrote:

> Since 4c28e4ada03 (commit: die before asking to edit the log
> message, 2010-12-20), we have been "leaking" the "author_ident" when
> prepare_to_commit() fails.  Instead of returning from right there,
> introduce an exit status variable and jump to the clean-up label
> at the end.
>
> Instead of explicitly releasing the resource with strbuf_release(),
> mark the variable with UNLEAK() at the end, together with two other
> variables that are already marked as such.  If this were in a
> utility function that is called number of times, but these are
> different, we should explicitly release resources that grow
> proportionally to the size of the problem being solved, but
> cmd_commit() is like main() and there is no point in spending extra
> cycles to release individual pieces of resource at the end, just
> before process exit will clean everything for us for free anyway.
>
> This fixes a leak demonstrated by e.g. "t3505-cherry-pick-empty.sh",
> but unfortunately we cannot mark it or other affected tests as passing
> now with "TEST_PASSES_SANITIZE_LEAK=3Dtrue" as we'll need to fix many
> other memory leaks before doing so.
>
> Incidentally there are two tests that always passes the leak checker
> with or without this change.  Mark them as such.
>
> This is based on an earlier patch by =C3=86var, but takes a different
> approach that is more maintainable.

We've talked about UNLEAK() v.s. strbuf_release() elsewhere, so let's
leave that aside. I know your preferences in that area.

But even accounting for that, I don't see what the "more maintainable"
here refers to. The approach I suggested would s/UNLEAK/strbuf_release/
in the 4th hunk, but otherwise be equivalent.

Surely both are about as easy to maintain. To the extent that there's
any difference at all I'd think the strbuf_release() would pull ahead,
as it's guaranteed to do the right thing with all of our memory analysis
tooling (some of which will have a noop UNLEAK()).

Just a small question, I see this is in "next" already, and I'm fine
with this change either way.
