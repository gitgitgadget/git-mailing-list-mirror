Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3643E480
	for <git@vger.kernel.org>; Fri, 15 May 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836306; cv=none; b=pDSC4pSPCxRvWO9KFw02NnvsW+uydWMZIX4Jvlyk9fjAyQ5sJSGj3asC0ndFzKEfxEdJ/8NOv9Ozs4n9HWWo+1IXQWM+/y+wtDdsy/2Hd8OLUdxT2Fu1kQyVbNdbNDXMne9tjfbgF9NCOTGs7DSkA/TvVOkZYMWmejCPNf472Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836306; c=relaxed/simple;
	bh=faqSoguYgmX6i/6+rS7Ta7dK98DkOgtI+8WzZUwZCMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEJxVGlCwjZEEeQFwtCQIxZsuqLicmbLP8CaY77J2qetCTGPL4AjmOTA1vJWW1vKLZL2W6e8m7i3HnuRJ+bQDV5h6m3Serah2oRwEX/GJHL5pTtKHHVCzzdgDVqlmPaooH7JihS8wgVRTOuBlxK9NU8u6IQrPMrKuC3ZajpCErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4gH0hW557qz7QhcP
	for <git@vger.kernel.org>; Fri, 15 May 2026 10:28:27 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4gH0hL4g9pzRnln;
	Fri, 15 May 2026 10:28:18 +0200 (CEST)
Message-ID: <f02e354d-a182-4207-8723-e5261e19351b@kdbg.org>
Date: Fri, 15 May 2026 10:28:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] git-gui: disable gitk visualization when no
 worktree available
Content-Language: en-US
To: Shroom Moo <egg_mushroomcow@foxmail.com>, git@vger.kernel.org
Cc: Mark Levedahl <mlevedahl@gmail.com>, Aina Boot <bootaina702@gmail.com>
References: <tencent_DDD6467B3F6184562B51C23BB9DBB79EA409@qq.com>
 <20260509133756.1367-1-egg_mushroomcow@foxmail.com>
 <tencent_A6BA86DF71476C6948398C167C0E0919550A@qq.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <tencent_A6BA86DF71476C6948398C167C0E0919550A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.05.26 um 15:37 schrieb Shroom Moo:
> When git-gui is started in a bare repository with the 'bare' option
> enabled (e.g., for blame/browser), there is no working tree.  The
> "Visualize Current Branch's History" and "Visualize All Branch
> History" menu items remain enabled, but clicking them triggers a Tcl
> error because do_gitk tries to change directory to an empty
> _gitworktree.

I cannot reproduce this claim. The failure is not a Tcl error, but an
error in some `git` invocation that cannot handle an empty
GIT_WORK_TREE. And that happens only beginning with the *second*
invocation of one of the "Visualize" calls, because then an empty
GIT_WORK_TREE is exported into the environment.

> 
> Fix this by disabling the two visualization menu items when the
> repository is bare and the 'bare' option is active.  Also update
> current_branch_write to keep the state consistent when the branch
> changes, and add a defensive check in do_gitk to avoid the error
> should the menu state somehow become out of sync.

This change is not correct. Gitk can operate without a working tree. The
menu entries should not be disabled, ever. The bug is somewhere else.

See also my suggested replacement patch in my reply to 3/3.

-- Hannes

