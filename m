Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B729A2
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519135; cv=none; b=BvbLlj8AqQCL0DuPtIyI33NuZsp+a9StkAtlOgRkyRIAy22KR4onwDNvKkdk/PAwQut/tDoTaDodQUX5FpaHmPfrKUNFI98r2jvmWlupL9crufnJIlvSq6bdHUo1E/2yBB/6u34+5crRM3q1LM1Lc9mlDbNaiQL4qCD8vGvgXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519135; c=relaxed/simple;
	bh=JXLNPzmVZFGoG7k98332Oi5afnKFF9o83AjQK3DGrSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V5RJlqJSanD8glrJjfjpglwFNpXyl+juxvlewnKMIaQMJsWE6H/Cl4dsQ+ul9hJZ4Z/mdw46Jok4KPO8C1uTOmqrL+YkxgDW9p7UM559zvYAXm6DrAjXPOydDrGfPZHkvSpufg73wRa6LefUQlGlbGr8N+UrK5wqX1TJC8u0Xh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eCZIXbpa; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eCZIXbpa"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFA063B660;
	Tue, 30 Apr 2024 19:18:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JXLNPzmVZFGoG7k98332Oi5afnKFF9o83AjQK3
	DGrSw=; b=eCZIXbpaLZtN3/JEsVG5xL9xelnSLCuKC9UdogIKOenBfruuYU780E
	/3+uqckyaYuFg6zh5eA5Q7vjIkcHaBgNbdSyC8ssSwpOSwPQ9xwCtKhdNGWjMFNg
	LabpfNuUrAc+gwBvdpqSRW10PbcGQP12SBsbNV9/YYbXfbtZ6XHMQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B53C73B65F;
	Tue, 30 Apr 2024 19:18:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20BFE3B65E;
	Tue, 30 Apr 2024 19:18:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Felipe Contreras <felipe.contreras@gmail.com>,
  "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH] completion: zsh: stop leaking local cache variable
In-Reply-To: <pull.1725.git.1714513995564.gitgitgadget@gmail.com> (D. Ben
	Knoble via GitGitGadget's message of "Tue, 30 Apr 2024 21:53:15
	+0000")
References: <pull.1725.git.1714513995564.gitgitgadget@gmail.com>
Date: Tue, 30 Apr 2024 16:18:49 -0700
Message-ID: <xmqqzftawiau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 013C521C-0748-11EF-ABED-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Commit beb6ee7163 (completion: extract repository discovery from
> __gitdir(), 2017-02-03) anticipated this problem by marking
> __git_repo_path as local in __git_main and __gitk_main for Bash
> completion but did not give the same mark to _git for Zsh completion.
> Thus make __git_repo_path local for Zsh completion, too.

Will queue.  The explanation makes tons of sense.

Thanks.
