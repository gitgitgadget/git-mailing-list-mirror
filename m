Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1D7C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E3564EF2
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhCQRiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:38:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64878 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhCQRiG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:38:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D243134465;
        Wed, 17 Mar 2021 13:38:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Jmgjs9Fu6NRM
        RzKURgEK7gkNsQM=; b=nJt51MY7kB37rsJbVwejXefR50aJCanErhWU3H0FiXV+
        Eg7bxFdlhnE5Ze0csSpDSwcGRGZbczvMsKEF1e98+5ibwyOSCbHNObIWImQPIbSt
        cMSJ+L/AxQ5Emb7icGloU6CmMm9kUSwxuN9snnpGrLB4PT97uZ3sRu1prT4f+/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eQ611I
        QYAqkuP0Tn/JNJx0ei2Rrz7yJF6o0XPUBLSHIAJOF6dIJkI2PLbC0pL+S/n/2jFM
        zmX4l4XUxAXazwBHHS8ySGZpxXkVa2M80eBZ+AiYP90llKlfJuAfWkMApXGngv/T
        M2+JkTe+tr9GmLm+NUjzf2GFKz7BD9h5FvnuA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9533B134464;
        Wed, 17 Mar 2021 13:38:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA038134463;
        Wed, 17 Mar 2021 13:38:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/9] read_tree() and read_tree_recursive() refactoring
References: <20210308022138.28166-1-avarab@gmail.com>
        <20210315234344.28427-1-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 10:38:02 -0700
In-Reply-To: <20210315234344.28427-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Mar 2021 00:43:35 +0100")
Message-ID: <xmqqpmzxy939.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 86CF67F4-8747-11EB-8714-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A v3 of a refactoring of tree.c. See v2 at
> https://lore.kernel.org/git/20210308022138.28166-1-avarab@gmail.com/
>
> This brings back pretty much the old read_tree_recursive() under the
> name read_tree_at() as suggested in
> https://lore.kernel.org/git/xmqqft106sok.fsf@gitster.g/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9):
>   ls-files tests: add meaningful --with-tree tests
>   tree.c API: move read_tree() into builtin/ls-files.c
>   ls-files: don't needlessly pass around stage variable
>   ls-files: refactor away read_tree()
>   tree.h API: remove support for starting at prefix !=3D ""
>   tree.h API: remove "stage" parameter from read_tree_recursive()
>   tree.h API: rename read_tree_recursive() to read_tree()
>   show tests: add test for "git show <tree>"
>   tree.h API: expose read_tree_1() as read_tree_at()

The end-result looks good, but it seeps through the structure of the
series that the steps #7-#9 are afterthought of fixing a mistake
made in the step #5.  If #4 refactors away and removes read_tree()
and makes the name available, a natural next step would be to
introduce a thin-wrapper read_tree() around read_tree_recursive(),
which is to be used by majority of callers that do not need
non-empty prefix and stage, and that would become step #5 if I were
doing the series.  That step makes the codebase ready to change the
callers of read_tree_recursive() to call the simpler read_tree(),
which would be step #6.  The read_tree_recursive() would only have
one caller (i.e. the new read_tree() which is a castrated version of
read_tree_recursive()) and renaming it to read_tree_at() would be
another simple step #7.

>  4:  e78d1810b89 =3D  4:  1c96d5d3611 ls-files: refactor away read_tree=
()
>  5:  05eecdd7519 !  5:  367cb99224b tree.h API: remove support for star=
ting at prefix !=3D ""
>     @@ Commit message
>          ffd31f661d5 (Reimplement read_tree_recursive() using
>          tree_entry_interesting(), 2011-03-25).
>     =20
>     -    If in the future we need to support recursively reading trees =
without
>     -    starting at the root we can easily add a read_tree_recursive_s=
ubdir(),
>     -    and make that function a thin wrapper for read_tree_1().
>     +    As it turns out (Murphy's law and all) we're just about to gai=
n a new
>     +    in-tree user that would need this parameter[1]. Let's remove i=
t anyway
>     +    as the common case is going to be to not supply it, A later co=
mmit
>     +    will bring back this functionality in different form.
>     =20
>     -    In the meantime there's no reason to keep around what amounts =
to dead
>     -    code, just in case we need it in the future.
>     +    1. https://lore.kernel.org/git/xmqqft106sok.fsf@gitster.g/
>     =20
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>
>     =20
>  6:  fcecc82e1c8 =3D  6:  38e36780e22 tree.h API: remove "stage" parame=
ter from read_tree_recursive()
>  -:  ----------- >  7:  859902ffd83 tree.h API: rename read_tree_recurs=
ive() to read_tree()
>  -:  ----------- >  8:  a63c9b49f13 show tests: add test for "git show =
<tree>"
>  -:  ----------- >  9:  570642c8625 tree.h API: expose read_tree_1() as=
 read_tree_at()
