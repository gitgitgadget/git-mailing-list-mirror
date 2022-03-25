Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E181C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 01:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354817AbiCYBNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 21:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357195AbiCYBNg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 21:13:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D66BD2D7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:11:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2F47110266;
        Thu, 24 Mar 2022 21:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N4lwxnuXCChu
        RJeuvrtJgKvrOm4rtdgI7m5qMvWu41c=; b=Yw4oybFh0qBBbPFrkZ3dWejURZOc
        SvscFgjpVUw55+lMbYq6L5c6RGW/D/myUjx9bQlfjxD9xqvyP/tE43BO6WX636lW
        gTH6UoFZ4znpcGF5XctYcPxT6uvfuqthDAbxWgug5ltTDIdG0BWN3euJBGsCCW69
        PbaAl/PQRRl/wfQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAD57110265;
        Thu, 24 Mar 2022 21:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B4CC110264;
        Thu, 24 Mar 2022 21:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 17/27] revisions API: have release_revisions()
 release "mailmap"
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-17.27-a93251edf85-20220323T203149Z-avarab@gmail.com>
Date:   Thu, 24 Mar 2022 18:11:57 -0700
In-Reply-To: <patch-v2-17.27-a93251edf85-20220323T203149Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 23 Mar
 2022 21:32:07
        +0100")
Message-ID: <xmqqwngideea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 917EA514-ABD8-11EC-90D5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Extend the the release_revisions() function so that it frees the
> "prune_data" in the "struct ref_info".

Huh?  The patch text does make sense but it is all about mailmap as
far as I can see.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index c7eda9bbb72..cd6cebcf8c8 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1100,7 +1100,6 @@ static const char *find_author_by_nickname(const =
char *name)
>  	struct rev_info revs;
>  	struct commit *commit;
>  	struct strbuf buf =3D STRBUF_INIT;
> -	struct string_list mailmap =3D STRING_LIST_INIT_NODUP;
>  	const char *av[20];
>  	int ac =3D 0;
> =20
> @@ -1111,7 +1110,8 @@ static const char *find_author_by_nickname(const =
char *name)
>  	av[++ac] =3D buf.buf;
>  	av[++ac] =3D NULL;
>  	setup_revisions(ac, av, &revs, NULL);
> -	revs.mailmap =3D &mailmap;
> +	revs.mailmap =3D xmalloc(sizeof(struct string_list));
> +	string_list_init_nodup(revs.mailmap);
>  	read_mailmap(revs.mailmap);
> =20
>  	if (prepare_revision_walk(&revs))
> @@ -1122,7 +1122,6 @@ static const char *find_author_by_nickname(const =
char *name)
>  		ctx.date_mode.type =3D DATE_NORMAL;
>  		strbuf_release(&buf);
>  		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
> -		clear_mailmap(&mailmap);
>  		release_revisions(&revs);
>  		return strbuf_detach(&buf, NULL);
>  	}
> diff --git a/revision.c b/revision.c
> index 13b568aea76..d9e2b171f6d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2933,12 +2933,21 @@ static void release_revisions_commit_list(struc=
t rev_info *revs)
>  	revs->commits =3D NULL;
>  }
> =20
> +static void release_revisions_mailmap(struct string_list *mailmap)
> +{
> +	if (!mailmap)
> +		return;
> +	clear_mailmap(mailmap);
> +	free(mailmap);
> +}
> +
>  void release_revisions(struct rev_info *revs)
>  {
>  	if (!revs)
>  		return;
>  	release_revisions_commit_list(revs);
>  	object_array_clear(&revs->pending);
> +	release_revisions_mailmap(revs->mailmap);
>  }
> =20
>  static void add_child(struct rev_info *revs, struct commit *parent, st=
ruct commit *child)
> diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
> index 2630e756dab..752aa8c9454 100755
> --- a/t/t0056-git-C.sh
> +++ b/t/t0056-git-C.sh
> @@ -2,6 +2,7 @@
> =20
>  test_description=3D'"-C <path>" option and its effects on other path-r=
elated options'
> =20
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
>  test_expect_success '"git -C <path>" runs git from the directory <path=
>' '
> diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-exp=
ensive.sh
> index bb5fea02a03..d0c4d38b4d4 100755
> --- a/t/t3302-notes-index-expensive.sh
> +++ b/t/t3302-notes-index-expensive.sh
> @@ -8,6 +8,7 @@ test_description=3D'Test commit notes index (expensive!=
)'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> =20
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
>  create_repo () {
> diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
> index 741e0803c1a..73048d0a526 100755
> --- a/t/t4055-diff-context.sh
> +++ b/t/t4055-diff-context.sh
> @@ -5,6 +5,7 @@
> =20
>  test_description=3D'diff.context configuration'
> =20
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
>  test_expect_success 'setup' '
> diff --git a/t/t4066-diff-emit-delay.sh b/t/t4066-diff-emit-delay.sh
> index a1de63b77f8..0ecb3915412 100755
> --- a/t/t4066-diff-emit-delay.sh
> +++ b/t/t4066-diff-emit-delay.sh
> @@ -4,6 +4,7 @@ test_description=3D'test combined/stat/moved interactio=
n'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> =20
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
>  # This test covers a weird 3-way interaction between "--cc -p", which =
will run
> diff --git a/t/t7008-filter-branch-null-sha1.sh b/t/t7008-filter-branch=
-null-sha1.sh
> index 9ba9f24ad2f..93fbc92b8db 100755
> --- a/t/t7008-filter-branch-null-sha1.sh
> +++ b/t/t7008-filter-branch-null-sha1.sh
> @@ -1,6 +1,7 @@
>  #!/bin/sh
> =20
>  test_description=3D'filter-branch removal of trees with null sha1'
> +
>  . ./test-lib.sh
> =20
>  test_expect_success 'setup: base commits' '
