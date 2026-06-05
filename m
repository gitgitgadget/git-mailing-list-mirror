Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2A39D6FD
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652098; cv=none; b=A91K4319+uyotkSZYr28BSvZi4iangEI19FHp33gchbww0lvtERidOoQUjHEVMiizpjhI9d6nU32rVpKfiQT7WAyZYYgEyfbgcAd3uZf6RTNt7kvk0m2pLZk50ZpKYFF2Be43hzIthOb6y6RmBMstafGUnb/KGfrNNxtWu6rHLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652098; c=relaxed/simple;
	bh=LkdsgGjF6B1EjF/KirvMG9GBhKeyzrnUiGOfkKO3CJc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ZjNBXwMkftWbh/CLhc09QKgdosDrBkMCy6oFTkLuGBsVJ3QvXlI3dnH0HUnXaBMwkOYFOPz9flGxoCEAl41cYN//bDlXgZoR+ZfN2Jd04o7KXlA2zWqcSSmy3+FGwV4wdkcE0DJOthjCGwFJ9aI0pr+/yq0kX9lWksK3XuTM1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=MeharuIn; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="MeharuIn"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 1534B60007;
	Fri,  5 Jun 2026 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1780652090; bh=LkdsgGjF6B1EjF/KirvMG9GBhKeyzrnUiGOfkKO3CJc=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=MeharuInxgvELq93Ljm3tF8xN7SVD8P9RiJyaqU2UubXkbBxET6bw3rMeWBFBhzNp
	 NUpUAW37A+BBKQgKY4v9zoQQxpfxtIG9Se8VctWFu+oxkQMciCKwP7BEt2GHI3a7Fa
	 oChrzBzaMwvgXDBhJkVhWntJ6IYIBETt4XMwvbMg=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 05:34:49 -0400
Message-Id: <DJ10HH5HZF0E.3000F6WUQ1M08@lfurio.us>
Cc: <git@vger.kernel.org>
To: "Benson Muite" <benson_muite@emailplus.org>, "Simon Richter"
 <Simon.Richter@hogyros.de>, "Junio C Hamano" <gitster@pobox.com>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: Mirror repositories for submodules
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <875x42vlgv.fsf@emailplus.org> <xmqqcxy7qfgk.fsf@gitster.g>
 <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
 <87pl25r3tz.fsf@emailplus.org>
In-Reply-To: <87pl25r3tz.fsf@emailplus.org>

On Fri Jun 5, 2026 at 12:47 AM EDT, Benson Muite wrote:
>
> For submodules, the metadata consists of the url of the repository to
> clone from.  One could have a list of absolute URLs.  The default would
> be to assume that the URLs are tried in order, and if a URL times out,
> the next one would be tried.  One may want to change the default
> ordering as a user setting, or do a ping test to get obtain content from
> the closest repository.

Another idea is for the client to attempt in a random order as a kind of
load balancing.

>
> As an example, for linphone-desktop, the first part of the .gitmodules
> file contains:
>
> [submodule "linphone-sdk"]
> path =3D external/linphone-sdk
> 	url =3D https://gitlab.linphone.org/BC/public/linphone-sdk.git
> [submodule "external/google/gn"]
>
> This could be updated to
>
> [submodule "linphone-sdk"]
> path =3D external/linphone-sdk
> 	url =3D https://gitlab.linphone.org/BC/public/linphone-sdk.git
>         url =3D https://github.com/BelledonneCommunications/linphone-sdk.=
git
> [submodule "external/google/gn"]

Relevant to Junio's earlier comment about aiming for a general solution:

It looks like the remote URL configuration already supports multiple
URLs per a single entry.  It's just that git only considers the first in
the list for fetching, and will push to all.

Your proposed change to .gitmodules may be used to initialize the list
of URLs for a cloned submodule's (single) initial remote?  At this
point, any kind of mirror management logic could generically operate on
each remote's URL list.

From git-config(1):
    remote.<name>.url
        The  URL of a remote repository. See git-fetch(1) or git-push(1).
        A configured remote can have multiple URLs; in this case the first
        is used for fetching, and all are used for pushing (assuming no
        remote.<name>.pushurl is defined).  Setting this key to the empty
        string clears the list of urls, allowing you to override earlier
        config.

From gitmodules(5):
    submodule.<name>.url
        Defines a URL from which the submodule repository can be cloned.
        This may be either an absolute URL ready to be passed to
        git-clone(1) or (if it begins with ./ or ../) a location relative
        to the superproject=E2=80=99s origin repository.

Note that the submodule format seems to explicitly support only a single
value right now.  Of course, I am assuming that the implementation
matches the documentation.
