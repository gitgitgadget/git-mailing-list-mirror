Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF5C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A7B61971
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhC1Gi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 02:38:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64315 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhC1Gio (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 02:38:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F2C4123BFE;
        Sun, 28 Mar 2021 02:38:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mMDazou/AyAv
        y9yEdaoWefH+7hk=; b=LRgDG8rAGYFKBIWhjpZRoI2rPh2sKTJ0E7C0NIMYqCem
        FuGCPe5StcrQhi+2KRFcGbdLiRvo5a/qnvQXlWYCbayH6GXDztzxydPzEPQa8yBD
        lO7CaHHZfH2JGBHtJcDuD2RB3T8uuOSOckuFmI6D34tohuBwcer4ktAGRAGgDTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qdX9i8
        nFSECSdtqDHFTAFgAnh3owFAyyV78tJGf70pFNkisW9fCrUrDAY0c64H9CvZUpFv
        MouRZkGKC+RcNs4TjYCJNiybk4g/JAQ54bwJt/WMrphohTjQ+QqqpkyaUNAbcC/I
        HrLvwSNu37m5VI3nolrD/yvrAfAQTkkIgwfMM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7812F123BFC;
        Sun, 28 Mar 2021 02:38:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C050C123BFB;
        Sun, 28 Mar 2021 02:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] doc lint: fix bugs in, simplify and improve lint
 script
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
        <patch-4.6-5c8e8f21495-20210326T103454Z-avarab@gmail.com>
Date:   Sat, 27 Mar 2021 23:38:40 -0700
In-Reply-To: <patch-4.6-5c8e8f21495-20210326T103454Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 26 Mar
 2021 11:36:49 +0100")
Message-ID: <xmqqv99bn5ov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3C7FCE7C-8F90-11EB-85B9-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  - Was using File::Find to recursively find *.txt files in
>    Documentation/, let's instead use the Makefile as a source of truth
>    for *.txt files, and pass it down to the script.

OK.

>  - We now don't lint linkgit:* in RelNotes/* or technical/*, which we
>    shouldn't have been doing in the first place anyway.

I understand RelNotes (which I consider is plain text file), but are
technical/* documentation forbidden from referring to our manual
pages for the commands they talk about?

>  - When the doc-diff script was added in beb188e22a (add a script to
>    diff rendered documentation, 2018-08-06) we started sometimes having
>    a "git worktree" under "documentation". This tree contains a full
>    checkout of git.git, as a result the "lint" script would recurse int=
o
>    that, and lint any *.txt file found in that entire repository.

Ouch.

>    In practice the only in-tree "linkgit" outside of the
>    Documentation/ tree is contrib/contacts/git-contacts.txt and
>    contrib/subtree/git-subtree.txt, so this wouldn't emit any errors

Hmm, the nested copy of git has Documentation/ subdirectory of its
own, and we do not want to scan it, I think.

That is a problem worth fixing.  Thanks for noticing it.

> Now we instead simply trust the Makefile to give us *.txt files, and
> since the Makefile also knows what sections each page should be in we
> don't have to open the files ourselves and try to parse that out. As a
> bonus this will also catch bugs with the section line in the file
> being incorrect.

OK.

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 7313956d73f..6bfd8c75772 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -4,6 +4,7 @@ MAN5_TXT =3D
>  MAN7_TXT =3D
>  HOWTO_TXT =3D
>  INCLUDE_TARGETS_TXT =3D
> +ALL_TXT =3D
>  TECH_DOCS =3D
>  ARTICLES =3D
>  SP_ARTICLES =3D
> @@ -49,6 +50,13 @@ HOWTO_TXT +=3D $(wildcard howto/*.txt)
>  INCLUDE_TARGETS_TXT +=3D $(wildcard *.txt)
>  INCLUDE_TARGETS_TXT +=3D $(wildcard config/*.txt)
> =20
> +# For linting
> +ALL_TXT +=3D $(MAN1_TXT)
> +ALL_TXT +=3D $(MAN5_TXT)
> +ALL_TXT +=3D $(MAN7_TXT)
> +ALL_TXT +=3D $(HOWTO_TXT)
> +ALL_TXT +=3D $(INCLUDE_TARGETS_TXT)

The "INCLUDE_TARGETS_TXT" looks more and more like "all txt
sources", which is a superset of MAN1_TXT and its friends.

Listing all of them in ALL_TXT duplicated feels somewhat iffy.

>  ifdef MAN_FILTER
>  MAN_TXT =3D $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)=
)
>  else
> @@ -477,7 +485,11 @@ print-man1:
>  	@for i in $(MAN1_TXT); do echo $$i; done
> =20
>  lint-docs::
> -	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl
> +	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl \
> +		--section=3D1 $(MAN1_TXT) \
> +		--section=3D5 $(MAN5_TXT) \
> +		--section=3D7 $(MAN7_TXT)	\
> +		--to-lint $(ALL_TXT)
