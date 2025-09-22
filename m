Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D741E89C
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523272; cv=none; b=dS6H8eiIDNYWMG3uI1nosIpRF9FUJ5m/JqESLx4AWRxEnot00Ra/1FVj1eve958gYWX7leaAfq8QirNdBMGe9U5Bct5IUPLw1Rt0Yq4AvaJ+wI1xSzmcZ/ZQZl4sVSVEiNvVGfOCL3w3GJEQz+zacCD1CVdkUM5mCvQVMt8Egdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523272; c=relaxed/simple;
	bh=ySfOBCzxufxeCahfhNeJ3Ga+xaUjaWtG87UVulHx01M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QXaQqKLCt7ekiQk6KGhm8tg18wUVpfzZgC17UsQ477InoEWQP50xnjbXosa5QvVloR5oSswrhi45dL2WDGX8WNHgP4d1NTrczQbIxAA5gFxz2TmmFF0cVZCx6ter+BEMyUnE3mYqgssLvZ1bO0Ts50v7QuBjIWig3seQopqi+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4cVXXK5YFLz7Qv0f
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 08:00:33 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4cVXX85tJYzRnlJ;
	Mon, 22 Sep 2025 08:00:24 +0200 (CEST)
Message-ID: <199b7665-910a-4f44-a734-ced99bc8cb81@kdbg.org>
Date: Mon, 22 Sep 2025 08:00:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] gitk: fix the position of the main main window on
 initialize
To: Michael Rappazzo <rappazzo@gmail.com>
References: <20250920184007.26183-1-rappazzo@gmail.com>
 <20250920184007.26183-2-rappazzo@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <20250920184007.26183-2-rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.09.25 um 20:40 schrieb Michael Rappazzo:
> The main window geometry was only restoring size but not position.
> Use after idle to ensure proper timing on OS's where that is necessary.
> 
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  gitk | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/gitk b/gitk
> index 6e4d71d585..95469a8fae 100755
> --- a/gitk
> +++ b/gitk
> @@ -2775,6 +2775,8 @@ proc makewindow {} {
>              }
>              wm geometry . "${w}x$h"
>          }
> +        # Restore full geometry including position after window is mapped
> +        after idle [list wm geometry . $geometry(main)]
>      }
>  
>      if {[info exists geometry(state)] && $geometry(state) eq "zoomed"} {

I have been carrying 22d37f865268 ("Revert "gitk: Only restore window
size from ~/.gitk, not position"", 2008-05-26) since, like, 17 years in
my branch j6t-testing. Perhaps Mark can tell us why b9bee11526ec ("gitk:
Only restore window size from ~/.gitk, not position", 2008-03-10) was
needed...

-- Hannes

