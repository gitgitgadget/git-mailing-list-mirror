Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4984EC874D
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 18:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbjIGSYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjIGSYD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 14:24:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC5D172E
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 11:23:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8817834FF8;
        Thu,  7 Sep 2023 14:23:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zBCgd2trTiz5
        y3UuunTirPL5QWY3KoG0om+HuU38HEs=; b=Ywep/MVCluC8kjyVoNCumxF5ZsjH
        VoqGXIsijzS/myM4FVeMMeBnGTY3Lw1ybflP9Q4abMuLOLZ2mwCY0bf3BXkIgxjZ
        nx4taqY0dAO72Vnu5X6RxIpNJ1udpyfXotBnfvo12p566ZFu2tWMoix/Ss+M7QSJ
        5t1gZM6fj08g06w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8022734FF7;
        Thu,  7 Sep 2023 14:23:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E851E34FF4;
        Thu,  7 Sep 2023 14:23:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     "Sergey Organov" <sorganov@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>, "Tao Klerks" <tao@klerks.biz>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
In-Reply-To: <d59a97e7-81fd-472b-9a18-32d993f8c1c8@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Thu, 07 Sep 2023 17:07:01 +0200")
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
        <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
        <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
        <87edjbuugw.fsf@osv.gnss.ru>
        <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com>
        <CAPMMpohgkH3h1zC_Q7O-07gYw8_7mdSsyX7vu1K1u5+CxKUaUQ@mail.gmail.com>
        <xmqqledjm4k2.fsf@gitster.g>
        <d59a97e7-81fd-472b-9a18-32d993f8c1c8@app.fastmail.com>
Date:   Thu, 07 Sep 2023 11:23:05 -0700
Message-ID: <xmqqv8clkfli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9763AA30-4DAB-11EE-A42B-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

>> 	fatal: '../there' is a main working tree.
>
> This gives the same error if `there` is a bare repository. Is that
> intended?

I do not think so.  The above is from "git worktree remove" and the
candidates to be removed is listed by "git worktree list".  I do not
know if it is sensible to include the bare repository that the
worktrees are attached to in the "list" output, and I do not think
it makes sense to accept the path to the directory that is such a
bare repository and let the code proceed that far.  It should just
reject it saying it is *not* a worktree.

> PS: Is it correct that the error message says =E2=80=9Cmain working tre=
e=E2=80=9D instead
> of =E2=80=9Cmain worktree=E2=80=9D? (See cc73385cf6 (worktree remove: n=
ew command,
> 2018-02-12.) I was thinking of spelunking the history further but thoug=
ht
> that I would quickly ask in case I'm missing something obvious.

My understanding is that "working tree" refers to what "git
checkout" would give you to your "make" and compilers.  The
"worktree" is a mechanism to allow you to have multiple "working
tree"s that are connected to a single repository (be it a bare or a
non-bare one).

> Certainly. But although this looks like it completely describes everyth=
ing
> that you want, I still think it is good to explicitly mention something
> like:
>
>   =E2=80=9C Note that a bare repository may have ...
>
> Since although this can certainly be inferred from the text, it's good =
to
> have some redundancy when it comes to non-obvious cases.

That is fine.

I think I've already said everything that I think should be in the
final text, and I do not mind if there are anything extra for
helping new readers that may be more than absolute minimum.

Thanks.
