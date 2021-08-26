Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13546C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 08:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E214A6103A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 08:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbhHZIki (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 04:40:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63912 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhHZIki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 04:40:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D889A147641;
        Thu, 26 Aug 2021 04:39:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=mVu5SD9LSl+cULF4PA3rTEqZe
        UcL1nWxiksy7Fkc3ZA=; b=q2JcL7l1bHRAaah5NtNVHkcjD5ZSJxwmLa+7tKYuc
        fSrOSsjcZt7e7KONRekjlJ/NcttRREI0VYmzmyAnQz6pD6/DWGGq0ivOlUpHbEYB
        GjszM3uBaHQKOTidqJb2ZX4DSP05Tp6ZdILY2P4X7NetQjwJVJb0r2HWC+xA4OOC
        XE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD48F14763F;
        Thu, 26 Aug 2021 04:39:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1744614763E;
        Thu, 26 Aug 2021 04:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v4 00/28] Support reftable ref backend for Git
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
        <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
Date:   Thu, 26 Aug 2021 01:39:46 -0700
Message-ID: <xmqqfsuwha5p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2BEF4BCA-0649-11EC-B165-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is a version of the reftable series queued on top of my
> just-re-rolled fixes to the refs APIs, which it can make use of. For
> the base topics see:
>
>     https://lore.kernel.org/git/cover-v5-00.13-00000000000-20210823T113=
115Z-avarab@gmail.com/
>     https://lore.kernel.org/git/cover-v10-0.8-00000000000-20210823T1147=
12Z-avarab@gmail.com/
>
> For Han-Wen's v3 of this see:
> https://lore.kernel.org/git/pull.1054.v3.git.git.1629207607.gitgitgadge=
t@gmail.com/
>
> I've got no desire to take over the reftable topic in its entirety,
> but think given the rationale in
> https://lore.kernel.org/git/877dgch4rn.fsf@evledraar.gmail.com/
> (summarized in
> https://lore.kernel.org/git/87y28sfokk.fsf@evledraar.gmail.com/) that
> having the refs API fixes I noted above wait on the still-unstable
> reftable doesn't make sense.

Of course, you and Han-Wen are in much better position to judge the
relative merit to decide which one should go first than I am, but I
had an impression that the errno thing was even less stable, with
API churn that deliberately broke the other topic in flight, which
appeared to be just irresponsible.

> I'll let Han-Wen deal with that squashing in a presumed future v5 of
> this, assuming of course that Junio's happy with the plan of basing
> hn/reftable on the refs API fixes above.
>
> I'm not sure that the fix I have in 27/28 is the right one, perhaps
> we've already got information about what the tip OID of the refname is
> at that point in git_reftable_reflog_expire() via some API I missed,
> but that fix works, and is clearly more correct than the outstanding
> segfault.
