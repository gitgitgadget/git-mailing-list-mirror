Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50480C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265AA2072C
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nRt8uZoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgETO4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 10:56:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53325 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETO4a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:56:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 594E5D9165;
        Wed, 20 May 2020 10:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BHVgCrsTJ+zx
        gIFvWCmG+JmaeQs=; b=nRt8uZocOp4rndyyuywtSBQWW3DTjiV0rvxkb+xOMZhd
        SGFoZorkCCjorLbw1PKusL5/5fyag6L32vfLU5ru9Rch2sth/zDeFjpm2pnumo65
        6Zoa0yPS/+SXNkNoz+1iovhFwePSnLGD0ucodFdmRp0XPcl9LehmqhOxkQyIwsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h2bBHr
        pE6fT7Ue1fjn9U9XS3TEf/5LRXSoonJbeV2NpxTdaAFalnqLzeheBKkQ90aE6YT9
        kms72eIaRJp0cL68g5fqUjzs7l8PVi8CTddJ5ZMHx46yE1/oJCz2mbAQHsWLNKPT
        SeQFwYfJSlkwS/wuZMSjdm0+oBNFtvPA/K0ZU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 517C0D9164;
        Wed, 20 May 2020 10:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99824D9163;
        Wed, 20 May 2020 10:56:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, liu.denton@gmail.com, chwarr@microsoft.com,
        garima.singh@microsoft.com
Subject: Re: [PATCH 2/3] bisect: remove CR characters from revision in replay
References: <20200520034444.47932-1-carenas@gmail.com>
        <20200520034444.47932-3-carenas@gmail.com>
Date:   Wed, 20 May 2020 07:56:22 -0700
In-Reply-To: <20200520034444.47932-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 19 May 2020 20:44:43 -0700")
Message-ID: <xmqqzha2wt7t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 13425448-9AAA-11EA-9CCA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 6c722cbe5a (bisect: allow CRLF line endings in "git bisect replay"
> input, 2020-05-07) includes CR as a field separator, but doesn't
> account for it being included in the last field, breaking when
> running at least under OpenBSD 6.7's sh.
>
> Read the revision into a raw variable and strip it of any possible
> embeded CR characters, before use.

That's quite unsatisfactory, as the whole point of adding CR to IFS
was to avoid having to spawn extra processes for this kind of text
processing.  If we were to do the preprocessing, we are better off
just passing the whole input thru "tr -d '\015'".

>  	oIFS=3D"$IFS" IFS=3D"$IFS$(printf '\015')"
> -	while read git bisect command rev
> +	while read git bisect command rawrev
>  	do
>  		test "$git $bisect" =3D "git bisect" || test "$git" =3D "git-bisect"=
 || continue
>  		if test "$git" =3D "git-bisect"
>  		then
> -			rev=3D"$command"
> +			rawrev=3D"$command"
>  			command=3D"$bisect"
>  		fi
> +		rev=3D$(echo $rawrev | tr -d '\015')

As we know that "rev" ought to consist of just hexadecimal and
cannot be split into two at $IFS even if we don't tell "read" that
"everything at the end of line is 'rev'", can we do

	while read git bisect command rev ignored

so that we'll get an empty string after CR in $ignored when reading
CRLF input, and an empty string because we ran out of the tokens
when reading LF input?

That is, ...

 git-bisect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 71b367a944..2a7599b486 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -210,7 +210,7 @@ bisect_replay () {
 	test -r "$file" || die "$(eval_gettext "cannot read \$file for replayin=
g")"
 	git bisect--helper --bisect-reset || exit
 	oIFS=3D"$IFS" IFS=3D"$IFS$(printf '\015')"
-	while read git bisect command rev
+	while read git bisect command rev ignored
 	do
 		test "$git $bisect" =3D "git bisect" || test "$git" =3D "git-bisect" |=
| continue
 		if test "$git" =3D "git-bisect"
