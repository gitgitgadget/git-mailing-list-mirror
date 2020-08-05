Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD85C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3000120792
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rwQQ/NiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHEBpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:45:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50445 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHEBpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:45:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE5578388B;
        Tue,  4 Aug 2020 21:45:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MM/tZQCHhXFTcZFb3DpmnWlgC7k=; b=rwQQ/N
        iOZ3WSo9YuuBOrK7PEdblp5zKmMn0G38OHCGYWmjrl7GKUHspAK2o1Y3lA/pby66
        8SZK/JMihwPoDiGL6PSmJ7bc7bJuJBj8wOj1krfl5FjcDwo1e01WRUzhmsFRkD54
        4SYs9QZ4a9/S1sE+mInNKTDQE452ByhEfslpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AabYzin4zm3qG5pPBkGbSYLfHpot8Vsk
        h5QJBDM4dHdo7AKJV5YQeKWpyxrmx7ZBLYNzySdaNugBfYcP8dt2RrGuHNGZ+K/q
        htCjAQ21Zbhrw72fr3y9nKi08TDR5sKR0AW2HfXYTPKa6oeKoB2T2jdPtnB1ia6Z
        xStyzjux7ZU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5F9383889;
        Tue,  4 Aug 2020 21:45:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D76683888;
        Tue,  4 Aug 2020 21:45:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
        <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
        <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
        <xmqqpn8hgca7.fsf@gitster.c.googlers.com>
        <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
        <xmqqh7tjv6hb.fsf@gitster.c.googlers.com>
Date:   Tue, 04 Aug 2020 18:45:17 -0700
In-Reply-To: <xmqqh7tjv6hb.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 03 Aug 2020 13:07:12 -0700")
Message-ID: <xmqq1rklrhle.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50F0D310-D6BD-11EA-9D23-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Which other refs that aren't really refs should also be supported? The
>> JGit source code suggests that MERGE_HEAD should also be special
>> cased?
>
> I'd think all .git/${SOMETHING}_HEAD are of transitory nature that
> can be left as simple on-disk files that are read (and preferrably
> written---except for FETCH_HEAD for obvious reasons) as if they are
> loose refs handled by files backend.

Sorry for flipping and flopping.  The above goes directly against
the spirit of 09743417 (Modify pseudo refs through ref backend
storage, 2020-07-27).  I still think .git/${SOMETHING}_HEAD except
for FETCH_HEAD should be written and read via the ref subsystem, but
I was wrong to say that it should always be done via the files
backend.  There is no reason to insist on the use of files backend
here.

> It probably makes sense not to
> even write reflog entries for them---it is not like the MERGE_HEAD
> I see now in .git/ directory is an updated version of MERGE_HEAD I
> had there yesterday. "git log -g MERGE_HEAD" gives no interesting
> information.

This still is true, but that is pretty much orthogonal to which
backend is used.

> If the octopus merge does not finish correctly (e.g. due to
> conflicts), with "git reset --hard", we can recover to the original
> state and re-attempt the opeation with "git merge FETCH_HEAD".  Such
> a merge using FETCH_HEAD will produce an octopus merge.
>
> Which means that at least "git merge", FETCH_HEAD is not just a
> regular ref where you can ask what object it points at and it gives
> you a single object name back.
>
> But to other commands like "git log master..FETCH_HEAD", it acts as
> if there is only one object recorded.

All of which means FETCH_HEAD is special and we may not want to
burden the special casing of it to newer backends.
