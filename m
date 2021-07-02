Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B9AC11F6A
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018C66141D
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhGBPNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:13:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63401 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbhGBPNK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 11:13:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E148814C7A6;
        Fri,  2 Jul 2021 11:10:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rAzsgj8WxaOw
        S9iZMkYdpsHWL8uuj/81rO3t+iBLivs=; b=MJqZTjp+Zn4Lasjj+rjTH+5nXY7V
        m2EE5lkkf0lplMgUttPCjKMmEVggue/GjQ2DgNweXuGCTEwZdcLLgjUwf7OedhzV
        EVNnJqIoBoSOAZPgRpnXjQ+wPJ2+51up5MvPFDF/L1QQzirOHbHT84aecsAgrZBJ
        f89fpAviPFFaXjQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9BE114C7A5;
        Fri,  2 Jul 2021 11:10:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C585F14C7A1;
        Fri,  2 Jul 2021 11:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 2/3] bundle doc: elaborate on object prerequisites
References: <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
        <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
        <patch-2.3-444b06740bc-20210702T112254Z-avarab@gmail.com>
Date:   Fri, 02 Jul 2021 08:10:32 -0700
In-Reply-To: <patch-2.3-444b06740bc-20210702T112254Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Jul
 2021 13:26:54 +0200")
Message-ID: <xmqq7di8rbtj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A68B6940-DB47-11EB-BE76-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Split out the discussion bout "object prerequisites" into its own
> section, and add some more examples of the common cases.
>
> See 2e0afafebd (Add git-bundle: move objects and references by
> archive, 2007-02-22) for the introduction of the documentation being
> changed here.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/git-bundle.txt | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.tx=
t
> index 9c743aed49f..f5430029b8c 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -45,6 +45,7 @@ header is (mostly) in the format emitted by linkgit:g=
it-show-ref[1].
> =20
>  Like the the packed archive format itself bundles can either be
>  self-contained, or be created using exclusions.
> +See the "OBJECT PREREQUISITES" section below.
> =20
>  Bundles created using revision exclusions are "thin packs" created
>  using the `--thin` option to linkgit:git-pack-objects[1], and
> @@ -153,19 +154,38 @@ contained in the union of the given bases.  Each =
basis can be
>  specified explicitly (e.g. `^master~10`), or implicitly (e.g.
>  `master~10..master`, `--since=3D10.days.ago master`).
> =20
> -It is very important that the basis used be held by the destination.
> +OBJECT PREREQUISITES
> +--------------------
> +
> +When creating bundles it is possible to create a fully self-contained
> +bundle with all the prerequisite objects, as well as providing
> +negative revisions to exclude prerequisite objects.
> +
> +A revision such as `new` will produce a tip with all the prerequisite
> +objects needed for the `new` reference.

The above two paragraphs use the word "prerequisites" in a confusing
way.  The original meaning of the word in the context of talking
about a bundle is "you must have these commits in the receiving
repository for the bundle to be unbundle-able".

"git bundle create recent.bndl old..new" creates a bundle that
requires 'old' (and everything reachable from it) to exist in the
receiving repository.  We call the object 'old' (not the objects
reachable from it) the prerequisite of the bundle.

"git bundle create full.bndl new" creates a bundle that needs no
prerequistes.

It is confusing to say that full.bndl has all the prerequisite
objects needed.  It is correct to say that it has all the objects
reachable from 'new', but if we wanted to say that, we did not have
to introduce the new term "prerequisite" when we invented the bundle
format.  The concept "prerequisite" tries to convey is different.

So, the two paragraphs above use the word "prerequisite" when it
wants to talk about "reachable objects" (except for one use---the
one in "to exclude prerequisite objects" is correctly used), which
is confusing.  Here is the first paragraph with probably a better
phrasing.

	... it is possible to create a self-contained bundle that
	can be unbundled in an empty repository, as well as
	providing negative revisions to exclude objects needed in
	the earlier parts of the history.

As to the second paragraph:

	... will produce a bundle without any prerequisites.  It can
	be unbundled in any repository to obtain a full history that
	leads to the commit `new`.

By the way, I needed to read "a revision such as `new` will produce
..." three times before realizing that the reader must fill quite a
lot of missing words to understand what the sentence wanted to say,
which is:

	(feeding) a revision such as `new` (to "git bundle create"
	as the revision range argument) will produce ...

I think it is easier to follow if you spelled the command out, e.g.

    A command

    $ git bundle create full.bndl new

    will create a bundle file that contains all the objects
    reachable from the branch 'new'.

> +A revision range such as `old..new` will produce a bundle tip that'll
> +require any objects existing before `new` to already be present in the
> +repository performing the 'git bundle unbundle' operation.

Getting warmer ;-).  In this case, 'old' is the prerequisite, so

    ... that'll require the commit 'old' (and any objects reachable
    from it) to exist for the bundle to be "unbundle"-able.

would be correct.

> +A self-contained bundle without any prerequisites can be extracted
> +into anywhere, even into an empty repository, or be cloned from
> +(i.e., `new`, but not `old..new`).
> +

This is entirely correct.

> +The 'git bundle verify' command can be used to check whether your
> +recipient repository has the required prerequisite commits for a
> +bundle.

So is this.

Thanks.
