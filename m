Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CE9C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 19:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DECF2075E
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 19:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CEtuWgF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgHTTtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:49:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63383 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTTtP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 15:49:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 78BBED9FBE;
        Thu, 20 Aug 2020 15:49:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tpMsYCQ2XLAI
        00A3Nsu9WgVcX1s=; b=CEtuWgF+PrfuaA/1aCmddZk7MfaAISP4L86W6GU8qSOf
        PzWhLG4ti3ptvy/ky5d23uPuyqUMHAYGr9+n+7HIK1SlM52WG8xCL9FhTqi96QXn
        wgbG0RGmGs9YBmtZOpQqDo01jWqgjvubAlgZH6kUD5hQZrhsRqIiqNVISMw9R88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aofQ4g
        YCkpNGTMORUhOQyjsCBZesGDz3gfDkz7r9ouPvCELTVQpVrr9kxlXDmjv7cDsihL
        lC4ZHGaXcreyjmLXeHviqXDE5ivoc2+lVKYUbTQKRt6veisaMCTQdmvIPvTDx0RX
        TH4YtUo5dFZxJEE2SOcPQnc/RL5UrnrAvxh5U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72102D9FBD;
        Thu, 20 Aug 2020 15:49:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A76B2D9FBA;
        Thu, 20 Aug 2020 15:49:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] t4013: improve diff-post-processor logic
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <cover.1597926783.git.congdanhqx@gmail.com>
        <a52d0e59ecd5777f2a1d242a37c6bb6aaafb1ed2.1597926783.git.congdanhqx@gmail.com>
Date:   Thu, 20 Aug 2020 12:49:05 -0700
In-Reply-To: <a52d0e59ecd5777f2a1d242a37c6bb6aaafb1ed2.1597926783.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 20 Aug
 2020 19:35:34 +0700")
Message-ID: <xmqqr1s1ayj2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 35A92248-E31E-11EA-BBD9-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> From: "brian m. carlson" <sandals@crustytoothpaste.net>
>
> From 72f936b1 (t4013: make test hash independent, 2020-02-07),
> we started to adjust metadata of git-diff's output in order to
> ignore uninteresting metadata which is dependent of underlying hash
> algorithm.
>
> However, we forgot to special case all-zero object names, which is
> special for not-exist objects, in consequence, we could't catch

"for missing objects" would probably the best, even though
"non-existing objects" would also work.

> possible future bugs where object names is all-zeros including but

s/is/are/

> not limiting to:

"not limited to", I think.

> * show intend-to-add entry
> * deleted entry
> * diff between index and working tree with new file
>
> In addition, in the incoming change, we would like to test for

s/incoming/upcoming/?

> diff with 10 characters index, which is also not covered by current

"test for customizing the length of abbreviated blob object names on
the index line"?

s/covered/supported/

> diff-processor logic.
>
> Let's fix the bug for all-zero object names and extend object names'
> abbrev to 16 while we're at it.

"and support abbreviation of object names up to 16 bytes"?

Also while we are at it, we fixed the post-processing not to touch
the file modes, which were mistakenly munged in the older code as if
they were object names abbreviated to 7 hexdigits.

> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 5f97dd6d65..f6bdfc13fd 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -130,27 +130,45 @@ test_expect_success setup '
>  EOF
> =20
>  process_diffs () {
> -	_x04=3D"[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
> -	_x07=3D"$_x05[0-9a-f][0-9a-f]" &&
> -	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
> -	    -e "s/From $_x40 /From $ZERO_OID /" \
> -	    -e "s/from $_x40)/from $ZERO_OID)/" \
> -	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
> -	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
> -	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
> -	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
> -	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
> -	    -e "s/^$_x40 /$ZERO_OID /" \
> -	    -e "s/^$_x40$/$ZERO_OID/" \
> -	    -e "s/$_x07\.\.$_x07/fffffff..fffffff/g" \
> -	    -e "s/$_x07,$_x07\.\.$_x07/fffffff,fffffff..fffffff/g" \
> -	    -e "s/$_x07 $_x07 $_x07/fffffff fffffff fffffff/g" \
> -	    -e "s/$_x07 $_x07 /fffffff fffffff /g" \
> -	    -e "s/Merge: $_x07 $_x07/Merge: fffffff fffffff/g" \
> -	    -e "s/$_x07\.\.\./fffffff.../g" \
> -	    -e "s/ $_x04\.\.\./ ffff.../g" \
> -	    -e "s/ $_x04/ ffff/g" \
> -	    "$1"
> +	perl -e '
> +		my $oid_length =3D length($ARGV[0]);
> +		my $x40 =3D "[0-9a-f]{40}";
> +		my $xab =3D "[0-9a-f]{4,16}";
> +		my $orx =3D "[0-9a-f]" x $oid_length;
> +
> +		sub munge_oid {
> +			my ($oid) =3D @_;
> +			my $x;
> +
> +			return "" unless length $oid;
> +
> +			if ($oid =3D~ /^(100644|100755|120000)$/) {
> +				return $oid;
> +			}
> +
> +			if ($oid =3D~ /^0*$/) {
> +				$x =3D "0";
> +			} else {
> +				$x =3D "f";
> +			}
> +
> +			if (length($oid) =3D=3D 40) {
> +				return $x x $oid_length;
> +			} else {
> +				return $x x length($oid);
> +			}
> +		}
> +
> +		while (<STDIN>) {
> +			s/($orx)/munge_oid($1)/ge;
> +			s/From ($x40)( |\))/"From " . munge_oid($1) . $2/ge;
> +			s/commit ($x40)($| \(from )($x40?)/"commit " .  munge_oid($1) . $2 =
. munge_oid($3)/ge;
> +			s/\b($x40)( |\.\.|$)/munge_oid($1) . $2/ge;
> +			s/^($x40)($| )/munge_oid($1) . $2/e;
> +			s/($xab)(\.\.|,| |\.\.\.|$)/munge_oid($1) . $2/ge;
> +			print;
> +		}
> +	' "$ZERO_OID" <"$1"
>  }
> =20
>  V=3D$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
