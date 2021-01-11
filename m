Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D59C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 20:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8926422B51
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 20:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391188AbhAKUKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 15:10:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54535 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbhAKUKn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 15:10:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 104CE122959;
        Mon, 11 Jan 2021 15:09:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IeWmgs+cE193ef30cPOMnTPByH8=; b=LKnrO7
        tnF/sWL86WnjkEryYNjZJRRhTx0KdO1fqIoGCty85XS0jLpD3IGmM5Esa8HRcNa9
        Fx/DW9S2KHeAIS7nZkHWWRCPbizO0oDiWtt31MJ+aQUQ9EcwRTuUP5cI/b5SFPXQ
        Zjvg/f1feF3i9mhZvzhpLYrVfxBJnoMDRJxIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uMfYmlOF3dHwPjyyx8HzTwjCpCWMwnM0
        QIixEWvJU42bDd8TtwxIW0E+iDMU1FIJmNC0K4Txhxkk92UTtOu51BZHC9EL209l
        VWFFYdZg+HBvL+kb7VojB67kxBiVov3M3fqRA2CCV3ai/np45Du1mUg/Vj3TW1ml
        l3X190dndXM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08E64122958;
        Mon, 11 Jan 2021 15:09:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48D38122957;
        Mon, 11 Jan 2021 15:09:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v5 1/3] test: add helper functions for git-bundle
References: <xmqqbldxg466.fsf@gitster.c.googlers.com>
        <20210110143019.5625-2-worldhello.net@gmail.com>
Date:   Mon, 11 Jan 2021 12:09:52 -0800
In-Reply-To: <20210110143019.5625-2-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 10 Jan 2021 09:30:17 -0500")
Message-ID: <xmqq1rer8cbz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F82EF7B6-5448-11EB-A994-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> +# Create a commit or tag and set the variable with the object ID.
> +test_commit_setvar () {
> +	notick=
> +	signoff=
> +	indir=
> +	merge=
> +	tag=
> +	var=
> +
> +	while test $# != 0
> +	do
> +		case "$1" in
> +		--merge)
> +			merge=t
> +			;;
> +		--tag)
> +			tag=t
> +			;;
> +		--notick)
> +			notick=t
> +			;;
> +		--signoff)
> +			signoff="$1"
> +			;;
> +		-C)
> +			shift
> +			indir="$1"
> +			;;
> +		-*)
> +			echo >&2 "error: unknown option $1"
> +			return 1
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +
> +	var=$1
> +	shift
> +	if test -z "$var"
> +	then
> +		echo >&2 "error: var is not defined"
> +		return 1
> +	fi

We need to check $# immediately after the loop to ensure that we can
carve out $var and at least another arg.  [*Nit 1*]

The previous round required the command line to have at least one
after the loop (including parsing of $var) parsed it, but now we
fall through from here when a command line were:

    test_commit_setvar --merge -C there VAR

and because "$1" does not exist, such an error is propagated down to
"git merge" not getting the side branch, "git tag" not getting the
object to tag, etc.

> +	indir=${indir:+"$indir"/}
> +	if test -z "$notick"
> +	then
> +		test_tick
> +	fi &&
> +	if test -n "$merge"
> +	then
> +		git ${indir:+ -C "$indir"} merge --no-edit --no-ff \
> +			${2:+-m "$2"} "$1" &&
> +		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
> +	elif test -n "$tag"
> +	then
> +		git ${indir:+ -C "$indir"} tag -m "$1" "$1" &&
> +		oid=$(git ${indir:+ -C "$indir"} rev-parse "$1")
> +	else
> +		file=${2:-"$1.t"} &&
> +		echo "${3-$1}" > "$indir$file" &&

Style?  [*Nit 2*]

> +		git ${indir:+ -C "$indir"} add "$file" &&
> +		git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
> +		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
> +	fi &&
> +	eval $var=$oid
> +}


> +
> +
> +# Format the output of git commands to make a user-friendly and stable
> +# text.  We can easily prepare the expect text without having to worry
> +# about future changes of the commit ID and spaces of the output.
> +make_user_friendly_and_stable_output () {
> +	sed \
> +		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<COMMIT-A>/g" \

Is "$(echo $A | cut -c1-7)" the same as "${A%${A#???????}}"?  If so,
the latter may be a bit shorter.

> diff --git a/t/test-bundle-functions.sh b/t/test-bundle-functions.sh
> new file mode 100644
> index 0000000000..0853eb1eca
> --- /dev/null
> +++ b/t/test-bundle-functions.sh
> @@ -0,0 +1,47 @@
> +# Library of git-bundle related functions.
> +
> +# Display the pack data contained in the bundle file, bypassing the
> +# header that contains the signature, prerequisites and references.
> +convert_bundle_to_pack () {
> +	while read x && test -n "$x"
> +	do
> +		:;
> +	done
> +	cat
> +}
> +
> +# Check count of objects in a bundle file.
> +# We can use "--thin" opiton to check thin pack, which must be fixed by
> +# command `git-index-pack --fix-thin --stdin`.
> +test_bundle_object_count () {
> +	thin=
> +	if test "$1" = "--thin"
> +	then
> +		thin=t
> +		shift
> +	fi
> +	if test $# -ne 2
> +	then
> +		echo >&2 "args should be: <bundle> <count>"
> +		return 1
> +	fi
> +	bundle=$1
> +	pack=$bundle.pack
> +	convert_bundle_to_pack <"$bundle" >"$pack" &&
> +	if test -n "$thin"
> +	then
> +		mv "$pack" "$bundle.thin.pack" &&
> +		git index-pack --stdin --fix-thin "$pack" <"$bundle.thin.pack"
> +	else
> +		git index-pack "$pack"
> +	fi

I wonder why we shouldn't always do "--fix-thin", so that the caller
does not even have to bother passing the "--thin" option.

Is this to protect us from "git bundle" creating a bundle that
contains a thin pack when it should not?  A caller that knows it is
storing a fully connected history can deliberately omit "--thin"
from the command line and make sure "index-pack" that is not asked
to do "--fix-thin" indeed finds the pack data fully self-contained,
so it may be a good idea to have these two separate codepaths after
all.  OK.

> +	if test $? -ne 0
> +	then
> +		echo >&2 "error: fail to convert $bundle or index-pack"
> +		return 1
> +	fi

Do we even need the "error" message?  "git index-pack" would have
already given some error message to its standard error stream, no?
If so

	if test -n "$thin"
	then
		...
	fi || return 1

would be sufficient, I guess.

> +	count=$(git show-index <"${pack%pack}idx" | wc -l) &&
> +	test $2 = $count && return 0
> +	echo >&2 "error: object count for $bundle is $count, not $2"
> +	return 1
> +}

Looking good except for a few minor nits I mentioned above.

Thanks.
