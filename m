Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC6208C0
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290253; cv=none; b=XCFb6Xg0KeYgEz689t397U36HNiSqAKCDTbku+KGCPP8ct0l9JwEsW6Wqw0kwz8U77w7fGZpSWFs9mry98PnJm/TtFjfM4PAE2Y5t2qDFRC2yn/LBAJKrd5FPygu2lacrcletGE4sYKLMyXxhUypLIfHHfGwzrhy/F8VO/7p0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290253; c=relaxed/simple;
	bh=eLQ3ul+C3Z8ryQeTYVMcUurqOq9+i6hwODEZmC3geRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TJYumE1y7fd6mxKOjov2M44Hu4xUo5+kTbuSMt+bMTaC2i3a/BwEGUxmpjY7dlGipejpluaoSUK+mfoirpqK/DoE3y8QBP9LXRDVcR53cR+5pzG0dej/nyDXWMZKiGXDdlQlDYphDdzwjRzon7loH/delaUgCuRZQNU0NaDz7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jsbWkAjh; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jsbWkAjh"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D5F42C581;
	Fri, 26 Jan 2024 12:30:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eLQ3ul+C3Z8r
	yQeTYVMcUurqOq9+i6hwODEZmC3geRI=; b=jsbWkAjhVdWDvpLSE4gRlEy5yxTk
	HQxHQ3YbRMl8UACWPVCdJZANXvcrQWaFWZed84uLTQlMzYND9sjf/icMNGXPT5f2
	41Vg048wcUrkGzbneAl3E7v7w4k3v0qBS2KHrBtIZ9Dllsv8jB6kcMYPHGW72DDO
	ybVRpk3UsfexE8k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 15E502C580;
	Fri, 26 Jan 2024 12:30:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F21022C56E;
	Fri, 26 Jan 2024 12:30:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] completion: introduce __git_find_subcommand
In-Reply-To: <221f88b9-fc91-479f-8d08-f530796e2d13@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 26 Jan 2024 13:51:46 +0100")
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
	<221f88b9-fc91-479f-8d08-f530796e2d13@gmail.com>
Date: Fri, 26 Jan 2024 09:30:44 -0800
Message-ID: <xmqqh6j0ngsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A379AB42-BC70-11EE-9B2E-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Let's have a function to get the current subcommand when completing
> commands that follow the syntax:
>
>     git <command> <subcommand>
>
> As a convenience, let's allow an optional "default subcommand" to be
> returned if none is found.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index 916e137021..5f2e904b56 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -575,6 +575,26 @@ __gitcomp_subcommand ()
>  	fi
>  }
> =20
> +# Find the current subcommand for commands that follow the syntax:
> +#
> +#    git <command> <subcommand>
> +#
> +# 1: List of possible subcommands.
> +# 2: Optional subcommand to return when none is found.
> +__git_find_subcommand ()
> +{
> +	local subcommand subcommands=3D"$1" default_subcommand=3D"$2"

Are the callers expected to form "$1" by concatenating known tokens
with a space?

I am just wondering if we can avoid looping, e.g.

	local nextword=3D${words[__git_cmd_idx+1]}
	case " $subcommands " in
	*" $nextword "*)
		echo "$nextword"
		return
		;;
	esac

It hopefully should not be a huge deal either way, though.=20

> +
> +	for subcommand in $subcommands; do
> +		if [ "$subcommand" =3D "${words[__git_cmd_idx+1]}" ]; then
> +			echo $subcommand
> +			return
> +		fi
> +	done
> +
> +	echo $default_subcommand
> +}
> +
>  # Execute 'git ls-files', unless the --committable option is specified=
, in
>  # which case it runs 'git diff-index' to find out the files that can b=
e
>  # committed.  It return paths relative to the directory specified in t=
he first
