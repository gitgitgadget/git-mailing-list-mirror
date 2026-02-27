Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B4288D6
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180301; cv=none; b=Wez5Oqw2VHrChJyHHJK1uaXjvZ9KgtRpTecpUUBuGR3E77lyawpm/p3fJNk/oRitFio9euSHrYn8Wz9j2KtWpSID41mPJ0skGepFtg8nuBe0e38rV8PGCG+c3szSdXwMN27TSmzKPmH9eeXcHVK+Sust6q/w7Pep0qIaKnNogqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180301; c=relaxed/simple;
	bh=P8jI8xv4E3/w50DgUyavf4Z89ByvnVsWt/JAX4onG84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3x2C2mPc8FcWK3r2A9MDa8QAlVURta/aAX96v/z1MxizmJcs1/q2Y4AkrVcj168M1Ia/6Nq42SSMIPjBkPFN8IRaPx+8t0OILggJO4kLnWytZ9V+o8cxS4IX9vkMV1wCa/sdjKaYrPqO5x73K6GKHBSHY7fh9KCloQY8gt65CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4fMgCJ4n1Cz7Rp0d
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 08:37:32 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4fMgC63FCMzRpKt;
	Fri, 27 Feb 2026 08:37:21 +0100 (CET)
Message-ID: <ffd58cd5-811b-4ebf-8572-cca681ec9bf7@kdbg.org>
Date: Fri, 27 Feb 2026 08:37:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: support config the color of linkfgcolor via Gitk
 Preferences
To: Wang Zichong <wangzichong@deepin.org>
Cc: Gary Wang <git@blumia.net>, git@vger.kernel.org,
 Gary Wang via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2217.git.git.1772109195114.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2217.git.git.1772109195114.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 26.02.26 um 13:33 schrieb Gary Wang via GitGitGadget:
> From: Wang Zichong <wangzichong@deepin.org>
> 
> As a dark-theme user, I use the Preferences dialog to set colors
> for gitk, the only color I cannot change via that dialog is the
> link foreground color, which will lead me to use the default link
> color on a dark background that make it not really readable.
> 
> This patch makes the link foreground color also configurable in the
> Gitk Preferences dialog's Color tab, so user won't need to dig into
> the code/manual to know if the link color is configurable and can
> simply set the color there.

Makes sense.

Our usual style is to not say "This patch does X to...", but to write in
imperative mood "Do X to...".

> 
> CC: Mark Levedahl <mlevedahl@gmail.com>, Paul Mackerras <paulus@samba.org>
> Signed-off-by: Wang Zichong <wangzichong@deepin.org>
> ---
>     gitk: support config the color of linkfgcolor via Gitk Preferences

In the subject line, perhaps:

   gitk: support link color in the Preferences dialog

> +    label $page.linkfg -padx 40 -relief sunk -background $linkfgcolor
> +    ttk::button $page.linkfgbut -text [mc "Link color"] \
> +        -command [list choosecolor linkfgcolor {} $page [mc "link color"]]

This text "link color" is used in the title of the color selection
dialog. It then reads awkwardly "Gitk: choose color for link color".
Let's just use the text "links" for this purpose, and then also just
"Links" as the label on the button.

> @@ -11891,6 +11896,7 @@ proc prefspage_set_colorswatches {page} {
>      $page.hunksep configure -background [lindex $diffcolors 2]
>      $page.markbgsep configure -background $markbgcolor
>      $page.selbgsep configure -background $selectbgcolor
> +    $page.linkfg configure -background $linkfgcolor

The variable's value is already serialized in the configuration and
needs no additional treatment. Good.

-- Hannes

