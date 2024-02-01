Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E88528E
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818853; cv=none; b=jA1B6qw/tlsin9Bxp8Dg4eLeExt8Ti0qIl88SJsvFuOYX/WU/g0Ee8tsQlPRshJ+HpL2ZI8fig6m9hx5rSXEWpfVCdXnKZhZRj4rg3kMTWqCshKEbfrRqDcvda8MXYHN0r+JUDfuz1kEfQXuLS0HWLycNz9h2l2GMkmONerxbCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818853; c=relaxed/simple;
	bh=eST0zo6nargVK7BGvYMEclwmbgpRUEPGCVtWYhJa/7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QBb7TcGBuRCyxPnHltdy9B82GNQRlLNTUBqzOjThFvOyAc7pm0TXKJO09o2M+iyeWTlMjzxZuHocYW+UKczC6WGkxfJxqfXABY8lBLAxN6YIMDWlZ+fe94nEAUiL7QIjkqr+XC8Fu8YxhWANYaX3Hq7jDCaGRkH3X67y69h3njQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JZd41N/m; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JZd41N/m"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C89D1D5A4;
	Thu,  1 Feb 2024 15:20:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eST0zo6nargVK7BGvYMEclwmbgpRUEPGCVtWYh
	Ja/7I=; b=JZd41N/mkmWa5nbcDFsjAUCGLWmU3nR1ZPfkdKSZH/xQ8PMjUF3nSF
	uFKfeLD1jPczwbsSfx2yCKMJCiJHSpfnz5FuGggECGJ0c6798XwxtF8A8KLPwwYx
	7m8bTNLC/9tYVObNASc93ayjrW7QtEXVYzrdwZpCqg6tGUiG0tB2E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 64AEE1D5A3;
	Thu,  1 Feb 2024 15:20:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 954D81D5A2;
	Thu,  1 Feb 2024 15:20:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with
 --missing=...
In-Reply-To: <20240201115809.1177064-4-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 1 Feb 2024 12:58:09 +0100")
References: <20240201115809.1177064-1-christian.couder@gmail.com>
	<20240201115809.1177064-4-christian.couder@gmail.com>
Date: Thu, 01 Feb 2024 12:20:45 -0800
Message-ID: <xmqqo7d0x7fm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6297D184-C13F-11EE-BFA7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> In 9830926c7d (rev-list: add commit object support in `--missing`
> option, 2023-10-27) we fixed the `--missing` option in `git rev-list`
> so that it now works with commits too.
>
> Unfortunately, such a command would still fail with a "fatal: bad
> object <oid>" if it is passed a missing commit, blob or tree as an
> argument.
>
> When such a command is used to find the dependencies of some objects,
> for example the dependencies of quarantined objects, it would be
> better if the command would instead consider such missing objects,
> especially commits, in the same way as other missing objects.
>
> If, for example `--missing=print` is used, it would be nice for some
> use cases if the missing tips passed as arguments were reported in
> the same way as other missing objects instead of the command just
> failing.
>
> Let's introduce a new `--allow-missing-tips` option to make it work
> like this.

OK.  Unlike a missing object referenced by a tree, a commit, or a
tag, where the expected type of the missing object is known to Git,
I would expect that nobody knowsn what type these missing objects at
the tip have.  So do we now require "object X missing" instead of
"commit X missing" in the output?  If we are not giving any type
information even when we know what the type we expect is, then we do
not have to worry about this change introducing a new output logic,
I guess.

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index b3f4783858..ae7bb15478 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -562,6 +562,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  				break;
>  		}
>  	}
> +	for (i = 1; i < argc; i++) {
> +		const char *arg = argv[i];
> +		if (!strcmp(arg, "--allow-missing-tips")) {
> +			if (arg_missing_action == MA_ERROR)
> +				die(_("option '%s' only makes sense with '%s' set to '%s' or '%s'"),
> +				      "--allow-missing-tips", "--missing=", "allow-*", "print");
> +			revs.do_not_die_on_missing_tips = 1;
> +			break;
> +		}
> +	}

It is unfortunate that we need to add yet another dumb loop that
does not even try to understand there may be an option whose value
happens to be the string strcmp() looks for (we already have two
such loops above this hunk).  I have to wonder if we can do better.

An idle piece of idea.  Perhaps we can instruct setup_revisions()
not to die immediately upon seeing a problematic argument, marking
the revs as "broken" instead, and keep going and interpreting as
much as it could, so that it may record the presence of "--missing",
"--exclude-promisor-objects", and "--allow-missing-tips".  Then upon
seeing setup_revisions() return with such an error, we can redo the
call with these bits already on.

Anyway, I digress.

> diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
> index 527aa94f07..283e8fc2c2 100755
> --- a/t/t6022-rev-list-missing.sh
> +++ b/t/t6022-rev-list-missing.sh
> @@ -77,4 +77,55 @@ do
>  	done
>  done
>  
> +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
> +do
> +	for tip in "" "HEAD"
> +	do
> +		for action in "allow-any" "print"
> +		do
> +			test_expect_success "--missing=$action --allow-missing-tips with tip '$obj' missing and tip '$tip'" '
> +				oid="$(git rev-parse $obj)" &&
> +				path=".git/objects/$(test_oid_to_path $oid)" &&
> +
> +				# Before the object is made missing, we use rev-list to
> +				# get the expected oids.
> +				if [ "$tip" = "HEAD" ]; then

Style:

                                if test "$tip" = "HEAD"
                                then

> +					git rev-list --objects --no-object-names \
> +						HEAD ^$obj >expect.raw
> +				else
> +					>expect.raw
> +				fi &&
> +
> +				# Blobs are shared by all commits, so even though a commit/tree
> +				# might be skipped, its blob must be accounted for.
> +				if [ "$tip" = "HEAD" ] && [ $obj != "HEAD:1.t" ]; then

Ditto.

> +					echo $(git rev-parse HEAD:1.t) >>expect.raw &&
> +					echo $(git rev-parse HEAD:2.t) >>expect.raw
> +				fi &&
> +
> +				mv "$path" "$path.hidden" &&
> +				test_when_finished "mv $path.hidden $path" &&
> +
> +				git rev-list --missing=$action --allow-missing-tips \
> +				     --objects --no-object-names $oid $tip >actual.raw &&
> +
> +				# When the action is to print, we should also add the missing
> +				# oid to the expect list.
> +				case $action in
> +				allow-any)
> +					;;
> +				print)
> +					grep ?$oid actual.raw &&
> +					echo ?$oid >>expect.raw
> +					;;

OK.  We do not say anything more than the object name (and the fact
that it is missing with a single byte '?'), so my earlier worry was
unfounded.  Good.

> +				esac &&
> +
> +				sort actual.raw >actual &&
> +				sort expect.raw >expect &&
> +				test_cmp expect actual
> +			'
> +		done
> +	done
> +done
> +
>  test_done

THanks.
