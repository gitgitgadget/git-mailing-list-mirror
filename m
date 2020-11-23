Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABB9C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED02F206D9
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c3RJgnkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbgKWTCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:02:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59213 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgKWTCH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:02:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FD34108A7B;
        Mon, 23 Nov 2020 14:02:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lWVLgzU5Sgle
        goNXLAfqOCMhQfQ=; b=c3RJgnkjJq0DFm082Goh4aP2d16dCR2dlWnB5su6gJJp
        nkhD2Ua+GcI3uG0Ugq+uMcUaUVJpqMBCL0PVLg6IdrMWPNXUwXxJXlfkHXKeiVul
        mGLPau+v12GZDDWBWlc52uFT6X1GG2JpAoVuJu0nf5ulRQ8/wxfhjagjMOO7EDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wnqYu/
        8qQzpcfs5AmsfPrcNqMWAWPlsZLmVwCqLcgY5uy5+v8z/+H4c1AUmK2+omhmDA35
        OQiKehwIW1sxnnuypc8k0C1dSY0m+pZEGuTTB62u1HQ29Zenwxhnw4NUdB0FKPQa
        2AUqCrfBoqS027jwdlAdKpw9Ih6bY1y/Gmsjc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 275A2108A7A;
        Mon, 23 Nov 2020 14:02:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4AB88108A78;
        Mon, 23 Nov 2020 14:01:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mktag: don't check SHA-1 object length under SHA-256
References: <20190826014344.16008-11-sandals@crustytoothpaste.net>
        <20201123120111.13567-1-avarab@gmail.com>
Date:   Mon, 23 Nov 2020 11:01:57 -0800
In-Reply-To: <20201123120111.13567-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 23 Nov 2020 13:01:11 +0100")
Message-ID: <xmqqlferoq1m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5D0ECE56-2DBE-11EB-81B6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
> index fa6a7561236..bbcc0a086bf 100644
> --- a/Documentation/git-mktag.txt
> +++ b/Documentation/git-mktag.txt
> @@ -23,7 +23,7 @@ Tag Format
>  A tag signature file, to be fed to this command's standard input,
>  has a very simple fixed format: four lines of
> =20
> -  object <sha1>
> +  object <sha>

Perhaps <hash>? or <objectname>.

> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 4982d3a93ef..3fa17243e34 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -5,13 +5,15 @@
> =20
>  /*
>   * A signature file has a very simple fixed format: four lines
> - * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
> + * of "object <sha>" + "type <typename>" + "tag <tagname>" +

Ditto.

>   * "tagger <committer>", followed by a blank line, a free-form tag
>   * message and a signature block that git itself doesn't care about,
>   * but that can be verified with gpg or similar.
>   *
> + * The first four lines are guaranteed to be either 83 or 107 bytes;
> + * depending on whether we're referencing a SHA-1 or SHA-256 tag.
> + *
> + * "object <sha1>\n" is 48 or a 72 bytes, "type tag\n" at 9 bytes is t=
he

At least <sha> to be consistent with the above, or <hash>.

>   * shortest possible type-line, "tag .\n" at 6 bytes is the shortest
>   * single-character-tag line, and "tagger . <> 0 +0000\n" at 20 bytes =
is
>   * the shortest possible tagger-line.
> @@ -46,9 +48,17 @@ static int verify_tag(char *buffer, unsigned long si=
ze)
>  	struct object_id oid;
>  	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb, *p=
;
>  	size_t len;
> -
> -	if (size < 84)
> -		return error("wanna fool me ? you obviously got the size wrong !");
> +	int minimum_size =3D
> +		/* Minimum possible input, see t/t3800-mktag.sh */
> +		strlen("object ") + the_hash_algo->hexsz + strlen("\n") +
> +		strlen("type tag\n") +
> +		strlen("tag x\n") +
> +		strlen("tagger . <> 0 +0000\n") +
> +		strlen("\n");
> +
> +	if (size < minimum_size)
> +		return error("got %"PRIuMAX" bytes of input, need at least %d bytes"=
,
> +			     size, minimum_size);

I agree with the patch that this message is not _("marked for
translation"), as it is output from a plumbing.

You need to cast "size" as "(uintmax_t)size" here, probably. =20


> @@ -58,7 +68,7 @@ static int verify_tag(char *buffer, unsigned long siz=
e)
>  		return error("char%d: does not start with \"object \"", 0);
> =20
>  	if (parse_oid_hex(object + 7, &oid, &p))
> -		return error("char%d: could not get SHA1 hash", 7);
> +		return error("char%d: expected object ID, got garbage", 7);

Here you say object ID, which is better than <hash> or <sha>.  Let's
be consistent (I'd say "object name" if I were choosing which to
use).

>  	/* Verify it for some basic sanity: it needs to start with
> -	   "object <sha1>\ntype\ntagger " */
> +	   "object <sha>\ntype\ntagger " */

Here it is <sha>.

> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index d696aa4e52e..93a19bb8df9 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -26,24 +26,42 @@ test_expect_success 'setup' '
>  	echo Hello >A &&
>  	git update-index --add A &&
>  	git commit -m "Initial commit" &&
> -	head=3D$(git rev-parse --verify HEAD)
> +	head=3D$(git rev-parse --verify HEAD) &&
> +
> +	git tag -m"some tag" annotated &&

A SP between -m and its argument, like four lines above?

> +	annotated=3D$(git rev-parse --verify annotated)
>  '
> =20
>  ############################################################
>  #  1. length check
> +for objType in t ta tag

cute ;-)

> +do
> +	cat >tag.sig <<-EOF
> +	object $annotated
> +	type $objType
> +	tag x
> +	tagger . <> 0 +0000
> +
> +	EOF
> +	len=3D$(wc -c tag.sig)
> +
> +	if test $objType =3D "tag"
> +	then
> +		test_expect_success "Tag object length check $len passed" '

Here $len may see excess leading whitespace depending on what "wc
-c" on the platform does, but the only effect of that is a bit
uglier test title, so it would be oK.

> +			git mktag <tag.sig >.git/refs/tags/x 2>message &&

Do we use "message" in any way? =20

Let's not write directly into filesystem; instead do

			tagobj=3D$(git mktag <tag.sig) &&
			git update-ref refs/tags/x $tagobj &&

or something like that.

> +			git rev-parse refs/tags/x
> +		'
> +	else
> +		check_verify_failure "Tag object length check on length $len" \
> +			'^error: got .* bytes of input, need at least'

OK.  This is not an issue with this patch, but I do not know why we
want a subshell in check_verify_failure.  May want to clean it up
but not in this patch.

> +	fi
> +done
> =20
>  ############################################################
>  #  2. object line label check
> =20
>  cat >tag.sig <<EOF
> -xxxxxx 139e9b33986b1c2670fff52c5067603117b3e895
> +xxxxxx $head
>  type tag
>  tag mytag
>  tagger . <> 0 +0000
> @@ -53,17 +71,18 @@ EOF
>  check_verify_failure '"object" line label check' '^error: char0: .*"ob=
ject "$'
> =20
>  ############################################################
> -#  3. object line SHA1 check
> +#  3. object line SHA check

You say "object" or "object ID" to the tester below; let's use that
consistently instead of SHA.

> +invalid_sha=3D$(echo $head | tr A-Za-z N-ZA-Mn-za-m)
>  cat >tag.sig <<EOF
> -object zz9e9b33986b1c2670fff52c5067603117b3e895
> +object $invalid_sha
>  type tag
>  tag mytag
>  tagger . <> 0 +0000
> =20
>  EOF
> =20
> -check_verify_failure '"object" line SHA1 check' '^error: char7: .*SHA1=
 hash$'
> +check_verify_failure '"object" line object check' '^error: char7: .*ex=
pected object ID, got garbage'
> =20
>  ############################################################
>  #  4. type line label check
> @@ -125,7 +144,7 @@ check_verify_failure '"type" line type-name length =
check' \
>  	'^error: char.*: type too long$'
> =20
>  ############################################################
> -#  9. verify object (SHA1/type) check
> +#  9. verify object (SHA/type) check
> =20
>  cat >tag.sig <<EOF
>  object $(test_oid deadbeef)
> @@ -135,7 +154,7 @@ tagger . <> 0 +0000
> =20
>  EOF
> =20
> -check_verify_failure 'verify object (SHA1/type) check' \
> +check_verify_failure 'verify object (SHA/type) check' \
>  	'^error: char7: could not verify object.*$'
> =20
>  ############################################################

Ditto.

Thanks.
