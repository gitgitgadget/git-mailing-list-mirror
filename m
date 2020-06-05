Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8186BC433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 19:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A31E2067B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 19:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FPW7IF7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgFETPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:15:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64453 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgFETPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 15:15:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83025D62B9;
        Fri,  5 Jun 2020 15:15:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EvxULCgJnoP/
        0SOCERumU3sXrwI=; b=FPW7IF7d58Lw1Uh/8OeEukK/MGIC799NxWHrvaO4mqZe
        ixdrUfYc2ANBjcszHlBRC+44slWISoSOMkP2BBlA4gAYjybin31diZkYcUMKPXUF
        yTzQUCverigIo+rhy/XCsY8F3JCX+Aq9MpPuC6GN1xQVUR9J/NCdZj75LMShaPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kPBwur
        VBLXQ7t8GxBlHMwEEuwWCWMDqccrbZvh061VRQwsCYYr+4HfnNZ89oOL4kBH0Qs2
        QsTzAK+um250EKnVtueXePYmt2ZPNEg6b1vXnlfb22YqfXlrAUJNB2932kAGqC+T
        +yVIwor22vYCJPGwvA4VNAVKBzBnfG2gHOPN8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C6F4D62B8;
        Fri,  5 Jun 2020 15:15:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD4F7D62B7;
        Fri,  5 Jun 2020 15:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 2/4] fetch: allow adding a filter after initial clone
References: <20200528025359.20931-2-delphij@google.com>
        <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
        <20200528171924.GC58643@google.com>
        <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
        <20200528191739.GA114915@google.com>
        <20200529000432.146618-1-delphij@google.com>
        <20200529010119.GE114915@google.com>
        <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
        <20200605091004.208668-1-delphij@google.com>
        <20200605091004.208668-3-delphij@google.com>
Date:   Fri, 05 Jun 2020 12:15:16 -0700
In-Reply-To: <20200605091004.208668-3-delphij@google.com> (Xin Li's message of
        "Fri, 5 Jun 2020 02:10:02 -0700")
Message-ID: <xmqqtuzpmiij.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E44E8CEC-A760-11EA-962E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li <delphij@google.com> writes:

> Retroactively adding a filter can be useful for existing shallow clones=
 as
> they allow users to see earlier change histories without downloading al=
l
> git objects in a regular --unshallow fetch.
>
> Without this patch, users can make a clone partial by editing the
> repository configuration to convert the remote into a promisor, like:
>
> =C2=A0 git config core.repositoryFormatVersion 1
> =C2=A0 git config extensions.partialClone origin
> =C2=A0 git fetch --unshallow --filter=3Dblob:none origin
>
> Since the hard part of making this work is already in place and such
> edits can be error-prone, teach Git to perform the required configurati=
on
> change automatically instead.
>
> Note that this change does not modify the existing git behavior which
> recognizes setting extensions.partialClone without changing
> repositoryFormatVersion.

Hmph, I am not sure which part of the above corresponds to the
removal of "in a repository without extensions.partialClone you
cannot use the --filter option" logic.  With or without this patch,
users can butcher $GIT_DIR/config and pretend that the repository
was created with the pertial clone extension from the beginning, but
this step is not about automating those tasks, it seems.

>
> Signed-off-by: Xin Li <delphij@google.com>
> ---
>  builtin/fetch.c                  |  3 ---
>  t/t0410-partial-clone.sh         | 12 ++++++++++++
>  t/t1090-sparse-checkout-scope.sh |  1 -
>  t/t5500-fetch-pack.sh            |  1 -
>  t/t5702-protocol-v2.sh           |  1 -
>  5 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b5788c16bf..3347d578ea 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1790,9 +1790,6 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
>  	if (depth || deepen_since || deepen_not.nr)
>  		deepen =3D 1;
> =20
> -	if (filter_options.choice && !has_promisor_remote())
> -		die("--filter can only be used when extensions.partialClone is set")=
;
> -
>  	if (all) {
>  		if (argc =3D=3D 1)
>  			die(_("fetch --all does not take a repository argument"));
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index a3988bd4b8..16ad000382 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -30,6 +30,18 @@ test_expect_success 'extensions.partialclone without=
 filter' '
>  	git -C client fetch origin
>  '
> =20
> +test_expect_success 'convert shallow clone to partial clone' '
> +	rm -fr server client &&
> +	test_create_repo server &&
> +	test_commit -C server my_commit 1 &&
> +	test_commit -C server my_commit2 1 &&
> +	git clone --depth=3D1 "file://$(pwd)/server" client &&
> +	git -C client fetch --unshallow --filter=3D"blob:none" &&
> +	test_cmp_config -C client true remote.origin.promisor &&
> +	test_cmp_config -C client blob:none remote.origin.partialclonefilter =
&&
> +	test_cmp_config -C client 1 core.repositoryformatversion
> +'
> +
>  test_expect_success 'missing reflog object, but promised by a commit, =
passes fsck' '
>  	rm -rf repo &&
>  	test_create_repo repo &&
> diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout=
-scope.sh
> index 40cc004326..f35a73dd20 100755
> --- a/t/t1090-sparse-checkout-scope.sh
> +++ b/t/t1090-sparse-checkout-scope.sh
> @@ -63,7 +63,6 @@ test_expect_success 'in partial clone, sparse checkou=
t only fetches needed blobs
>  	git -C server commit -m message &&
> =20
>  	test_config -C client core.sparsecheckout 1 &&
> -	test_config -C client extensions.partialclone origin &&
>  	echo "!/*" >client/.git/info/sparse-checkout &&
>  	echo "/a" >>client/.git/info/sparse-checkout &&
>  	git -C client fetch --filter=3Dblob:none origin &&
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 8c54e34ef1..0f5ff25179 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -999,7 +999,6 @@ fetch_filter_blob_limit_zero () {
>  	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
> =20
>  	git clone "$URL" client &&
> -	test_config -C client extensions.partialclone origin &&
> =20
>  	test_commit -C "$SERVER" two &&
> =20
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 5039e66dc4..8b27fad6cd 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -348,7 +348,6 @@ test_expect_success 'partial fetch' '
>  	rm -rf client "$(pwd)/trace" &&
>  	git init client &&
>  	SERVER=3D"file://$(pwd)/server" &&
> -	test_config -C client extensions.partialClone "$SERVER" &&
> =20
>  	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client -c protocol.version=3D=
2 \
>  		fetch --filter=3Dblob:none "$SERVER" master:refs/heads/other &&
