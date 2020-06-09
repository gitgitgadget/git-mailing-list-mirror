Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45111C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFFB220737
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fuQ7lgGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgFIQDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:03:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63750 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbgFIQDV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 12:03:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD4AC7768E;
        Tue,  9 Jun 2020 12:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E93LyZS+zoc9
        Uxu5B4I/FfT0ZBs=; b=fuQ7lgGe4B730PBcMGTrAOScMRDGIHYHHYHNr+sDdXju
        C5cz7j1QyssTpq3FGJbZQG13UK6qTKt1TlrW/a8HFiDAFBYRHXsnUfJFm3msFpCe
        dYzLhQrg1nu4TuHVsILNppNquUAS3Lla1VYElWUqNq4Tws+UUYfx5CR/F+qIJ3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PYdTdj
        KHLa8UQligmbCfnMNXoZcmkH6apEAf6fly1hponHt/C9vVWMi0fcVKUY/FNi5kD8
        4X3i7RldWduaGjVF9pa0rbMCZagVnmkhL4xWYLEzakawU91AlDsNRpwuC9p1dWOS
        KnxFI5IryvPXHV4O1rRH/Fk1IQz7ErSDM58zQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4D987768D;
        Tue,  9 Jun 2020 12:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30DAC7768C;
        Tue,  9 Jun 2020 12:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Lin <johnlinp@gmail.com>,
        Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] gc: recommend `git gc --prune=now` instead of `git prune`
References: <pull.652.git.1591581739031.gitgitgadget@gmail.com>
        <pull.652.v2.git.1591662224566.gitgitgadget@gmail.com>
        <87bllsa47u.fsf@evledraar.gmail.com>
Date:   Tue, 09 Jun 2020 09:03:18 -0700
In-Reply-To: <87bllsa47u.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 09 Jun 2020 13:06:13 +0200")
Message-ID: <xmqqa71ci5vd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BC6558DE-AA6A-11EA-9E0C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 09 2020, John Lin via GitGitGadget wrote:
>
>> From: John Lin <johnlinp@gmail.com>
>>
>> `git prune` is a plumbing command and should not be run directly by
>> users. The corresponding porcelain command is `git gc`, which is
>> mentioned in the man page of `git prune`.
>
> This change feels incomplete without a change to git-prune's
> documentation, see 8d308b3540 ("Documentation: point git-prune users to
> git-gc", 2008-04-29).
>
> I.e. it still talks about "in most cases you shouldn't run this", but
> here we are removing a case where it would otherwise make sense because
> the user shouldn't use it directly.
>
> I think instead the small change that makes the most sense here is to
> just add "prune" to completions,...

That's perfectly reasonable stance to take.
