Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EC197A97
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108807; cv=none; b=ojs/6oK/pFelnhLNq8P7QreUh7c6Zqf3XKLKWrvkefzTQ96C1Lz/NZjYY0KFir+AQ8/jPeivK4CkgWtFJD+XzHbU+QD5VJeiG/vKguVMdCjy89tktMBFSyrDBv49WUyqRBR/NavwbD9iEJtViYLk2irHs6RatrHrDTQlD92bvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108807; c=relaxed/simple;
	bh=u6jGkxi73wX6d0EXvaRvUVR5FGDoo9PeN3cEo9ulV8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rwTG7dEOOZ+MsmHliPQsQ3Nunsz8zZx+KcUYVJ1KUwdiIqo3xfDWA2toouBNTimuuowd4ZaypXMtidiGxR8fbWMb+h0iTn9d91fJNtgBNXwIkkQcA0oQOHQzrrtWYP9unD7DGZgJk3d06qHNKnl2OhsaCHYbyadMbyHKYwFyZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uok4EUg9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uok4EUg9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D369D26C6A;
	Mon, 23 Sep 2024 12:26:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u6jGkxi73wX6d0EXvaRvUVR5FGDoo9PeN3cEo9
	ulV8s=; b=Uok4EUg9uzHS2ZForux2zY0SvxvPdIzf+q49cLtNRF2HIlm33yzFED
	ADiu2SwkThav6+3EMNzPf1MAOmRc7t3aTwPoiodHB8/PCtma2yXFCvM4Kdka7jdQ
	qSr6FSZ/xfBrCKC4H3zd59ADRvi0TWLzvSYOx2Chrcg+m3Ha7bUco=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA3C226C66;
	Mon, 23 Sep 2024 12:26:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A66E26C63;
	Mon, 23 Sep 2024 12:26:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Matt Liberty
 <mliberty@precisioninno.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] submodule status: propagate SIGPIPE
In-Reply-To: <pull.1799.v2.git.1726925150113.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Sat, 21 Sep 2024 13:25:49 +0000")
References: <pull.1799.git.1726837642511.gitgitgadget@gmail.com>
	<pull.1799.v2.git.1726925150113.gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 09:26:43 -0700
Message-ID: <xmqqo74e49q4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9F2A80E6-79C8-11EF-B86F-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> It has been reported than running
>
>      git submodule status --recurse | grep -q ^+
>
> results in an unexpected error message
>
>     fatal: failed to recurse into submodule $submodule
>
> When "git submodule--helper" recurses into a submodule it creates a
> child process. If that process fails then the error message above is
> displayed by the parent. In the case above the child is killed by
> SIGPIPE as "grep -q" exits as soon as it sees the first match. Fix this
> by propagating SIGPIPE so that it is visible to the process running
> git. We could propagate other signals but I'm not sure there is much
> value in doing that. In the common case of the user pressing Ctrl-C or
> Ctrl-\ then SIGINT or SIGQUIT will be sent to the foreground process
> group and so the parent process will receive the same signal as the
> child.
>
> Reported-by: Matt Liberty <mliberty@precisioninno.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     submodule status: propagate SIGPIPE
>     
>     Note that I haven't checked if any other submodule subcommands are
>     affected by this - I'll leave that to someone more familiar with the
>     code.

Thanks.  Queued.
