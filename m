Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65FD4501C
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985487; cv=none; b=evlg4eN3phwBQCJNHKKQ42kHr8JAd1hxz/flvNQM16G4VbpBRXo0k+YNTEfRzClrhPFxTaTVl/9K62x5tFuWDh+qIO/l5SDpL/36hBRUJxQl9G6d2/fXcJ3V7Sn6nYsTHlbrfhIb+DfDh2q3lxKvRzcNP3bemQRynxt2HpgUBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985487; c=relaxed/simple;
	bh=ruRqrD88Kr+Qw+ozFdBGiWpG4baUBSGIYXryvIuy0FI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mw5SuDBO7n6ZUtQmWI5WKiSDOfd+YtaWq8l7s1EWX77o+GPid44ocPZuqgmE8veERYywYwPdw3vq4GMXHLbPRX5t9xH5sPDlZkZrBizdVip9+LtaWBBBi+fPDkgh8gSjeNMHFV4HdpOxFBElmd71eOBrqgMD/l2blmpHUxzcex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=isSRyfJI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="isSRyfJI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BA9A1E6CD7;
	Mon,  1 Apr 2024 11:31:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ruRqrD88Kr+Q
	w+ozFdBGiWpG4baUBSGIYXryvIuy0FI=; b=isSRyfJIZEHOoLzqJq44HOAdQrz+
	HAUtUhSMdVrdPGoFWFlT3en0y90TSCDqjYw2UsT9Jm83Oq3YEHX15v0Ew1W/LGa4
	KOHs3FdQat4/ZxR1+ZcpWbnx0JIGOBXBMoGu4KehqPxO3K2+j6Qd7K8G5BAgvj0F
	NguPEpkz7+/Y4Ts=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 932891E6CD6;
	Mon,  1 Apr 2024 11:31:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED4D71E6CD5;
	Mon,  1 Apr 2024 11:31:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] completion: fix prompt with unset SHOWCONFLICTSTATE in
 nounset mode
In-Reply-To: <20240401113033.28709-1-ville.skytta@iki.fi> ("Ville
 =?utf-8?Q?Skytt=C3=A4=22's?=
	message of "Mon, 1 Apr 2024 11:30:33 +0000")
References: <20240401113033.28709-1-ville.skytta@iki.fi>
Date: Mon, 01 Apr 2024 08:31:22 -0700
Message-ID: <xmqqttklcd6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E5D78EA0-F03C-11EE-9A26-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> `GIT_PS1_SHOWCONFLICTSTATE` is a user variable that might not be set,
> causing errors when the shell is in `nounset` mode.
>
> Take into account on access by falling back to an empty string.
>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---

Obviously a good thing to do.

A related tangent is that

    $ git grep -e '$GIT_PS1' -e '${GIT_PS1_[A-Z0-9_]*}' contrib/completio=
n/

shows a hit for the line with SHOWCONFLICTSTATE, plus two lines with
GIT_PS1_SHOWUPSTREAM that lack the "if unset then use this value".
Do you want to do another patch to fix them, or are they good as-is
for some reason?

Thanks.

>  contrib/completion/git-prompt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
> index 71f179cba3..3826f52dec 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -528,7 +528,7 @@ __git_ps1 ()
>  	fi
> =20
>  	local conflict=3D"" # state indicator for unresolved conflicts
> -	if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" =3D=3D "yes" ]] &&
> +	if [[ "${GIT_PS1_SHOWCONFLICTSTATE-}" =3D=3D "yes" ]] &&
>  	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
>  		conflict=3D"|CONFLICT"
>  	fi
