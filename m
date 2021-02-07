Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F967C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 20:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD6B64DFF
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBGUNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 15:13:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60072 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBGUM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 15:12:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E7CD113B2E;
        Sun,  7 Feb 2021 15:12:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vNtL+jzt9w7L
        YWAXukJZMR4C3OI=; b=W1SIKVwcHpvujFUx/iuoTypFOOlCh2xAPJDvrOntdixC
        YXg0VKQutftD7jkZk1Iyn0CBQNz1J6Az3NzlP/X3QrgeT9U5lSgK5RhOih9GRVdb
        VHO8xWM0EEfLWtPT2h7412NiXqZB/pXIOT39qkUOyQgK3safLG0bQKlPfJseafs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Rq6r3T
        7FcFrA9lJJjIzaD20CE57xk6fYkoSi/jPSFUTmwS8TqYz90ytJN0iniaoQhGx6Ja
        cpyqyr70SWrkHF90dFYeIEzRjV7h/APgr58VaJlinO2ps0tnkoOl9y0S0ArNnVva
        8obs9gtuTFF3s51CucQVKXmyjK6xeD7jiJCyg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76D64113B2D;
        Sun,  7 Feb 2021 15:12:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAE9F113B29;
        Sun,  7 Feb 2021 15:12:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        abhishekkumar8222@gmail.com, Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
        <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
        <YBn3fxFe978Up5Ly@google.com>
        <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
        <xmqq7dnpewg4.fsf@gitster.c.googlers.com>
        <20210207190415.GB1015009@szeder.dev>
Date:   Sun, 07 Feb 2021 12:12:13 -0800
In-Reply-To: <20210207190415.GB1015009@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Sun, 7 Feb 2021 20:04:15 +0100")
Message-ID: <xmqqh7mn7i3m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C5106750-6980-11EB-83E9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Tue, Feb 02, 2021 at 06:06:51PM -0800, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>=20
>> >> - what is the recommended way to recover from this state?  "git fsc=
k"
>> >>   shows the repositories to have no problems.  "git help commit-gra=
ph"
>> >>   doesn't show a command for users to use; is
>> >>   `rm -fr .git/objects/info/commit-graphs/` the recommended recover=
y
>> >>   command?
>>=20
>> "rm -f .git/objects/info/commit-graph" as well, no?
>>=20
>> > That, followed by `git commit-graph write --reachable [--changed-pat=
hs]`
>> > depending on what they want.
>>=20
>> Just out of curiosity, how important is "--reachable"?  It only
>> traverses from the tips of refs and unlike fsck and repack, not from
>> reflog entries (or the index for that matter, but that shouldn't
>> make much difference as there is no _commit_ in the index).
>
> Scanning all objects in all packfiles is a very inefficient way to
> find the commits to be recorded in the commit-graph, and depending on
> the repository's shape and size can have several times higher runtime
> and memory footprint.

But wouldn't it make the resulting graph file not very useful for
the purpose of say deciding what object to pack when running "gc" or
"repack" or "prune"?  The fact that it ignores the index and the reflog
entries as roots of traversal with "--reachable" bothers me.
