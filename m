Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4237C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 23:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63473206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 23:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u8pPR/4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLUXr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:47:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61782 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLUXr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 18:47:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 961D9AAE1F;
        Sat, 21 Dec 2019 18:47:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vf9020MnGup+vh7F1Dyu9EohSbo=; b=u8pPR/
        4BHTRKH6/a6bDkZRS4dpsyRjFJgEgFvdSUkaDOLKKm4kTmBLfMw6CYkVdTRxDP5L
        5s2ZBGZd5WylxZDXHSilaNedP8xu1IfhwDoKppFr1WICBJNB+jDh1IstE9mjPMal
        mrFqcZCBLUjQVu3CCQUkkmT5QnLymaDnNpdQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QgqkybT9CeOukFKdIse0/wPRUP7UN1Q4
        ZJLrlZUEMEztM2y3DlsSGtQAk3Y5xS31EmhY1vcYNegjl47z0XOhhsQVcScpSJ9T
        WX55zCYNB/tjnx8uPJrrbz8q3nEFBRRB/zPAhDIS8kYnE8xM1A9csFm136P+NBPv
        MneLQYuuehY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E572AAE1E;
        Sat, 21 Dec 2019 18:47:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B99C8AAE1D;
        Sat, 21 Dec 2019 18:47:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] config: allow user to know scope of config options
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
        <9a91caa0-72c3-3a38-3eb7-55a43537762e@iee.email>
        <03b001d5b601$09b950e0$1d2bf2a0$@gmail.com>
        <xmqqtv5wb3nm.fsf@gitster-ct.c.googlers.com>
        <CAOjrSZsiW-vxHKBqbEuBS6rpQ7m22wRp0UwGVVAJE2WE3bh-XQ@mail.gmail.com>
        <xmqqtv5u76ag.fsf@gitster-ct.c.googlers.com>
        <CAOjrSZvkT3TZwEvvnhRBVcuivhy46n8p9sV+3wZdvD=5f_cuRQ@mail.gmail.com>
Date:   Sat, 21 Dec 2019 15:47:52 -0800
In-Reply-To: <CAOjrSZvkT3TZwEvvnhRBVcuivhy46n8p9sV+3wZdvD=5f_cuRQ@mail.gmail.com>
        (Matt Rogers's message of "Fri, 20 Dec 2019 22:08:35 -0500")
Message-ID: <xmqqpngh6y1j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EE1D1D8-244C-11EA-B181-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Rogers <mattr94@gmail.com> writes:

> And that origin and scope correlate, but aren't necessarily
> one-for-one.

Yes, exactly.  When I see "orthogonal", I expect the word describes
things that do not correlate.

I can see values in the option that gives scope but not path in
order to write scripts that limits var-value pairs to be used
(e.g. "I do not want to be affected by the per-repository values",
"I do not trust settings that comes system-wide").  I also can see
values in the option that gives only path when debugging the
configuration file.

I briefly wondered, for the purpose of such "I do want to see only
those settings coming from these scopes" script, it may make more
sense to have the command _filter_ the var-value pairs, instead of
showing all of them with label, but that feature always exists ;-)
