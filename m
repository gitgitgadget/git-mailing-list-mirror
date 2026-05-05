Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CA3AF664
	for <git@vger.kernel.org>; Tue,  5 May 2026 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965266; cv=none; b=od5xochyWNt/IykmXfD2onY6sgv09ZmmPiY0i+feVMG66R1EBkb1P3US6bEXVUdRf/0OB1YJXvPxXoGnKtGxhRNMl+7RoUycT1o3w9QAXBPSk9qSD5u/XusIdGBPpNuMl18vGoNfDqfk8EkjZzItnx+FDZXyw9d9s8dcHsHbxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965266; c=relaxed/simple;
	bh=Vrr67Xo2iSyifbjqaPEfTTtG58rfGIxZts0IY3o/Rzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATwfAOaZ7eIgfFIxdJ7JmY6fv9GrZ71e7N9RHAPe3dHdpBWYDTbztU/sVI6Bdx1KPohOrxvvfyuAmDu+4egi4ZyilTaFetdoXXc8fGdiVP5wZWHIetDPpUztr4CKYG2ILQ0p453CjB2PwchLKcGXGfwQ2oNwPx/xop7qeY1yP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4g8qWY4YTHz7Qw24
	for <git@vger.kernel.org>; Tue,  5 May 2026 09:14:17 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4g8qWN3q7ZzRnlX;
	Tue,  5 May 2026 09:14:08 +0200 (CEST)
Message-ID: <d8bb745e-56d6-4da5-aac9-7ebcbc0df379@kdbg.org>
Date: Tue, 5 May 2026 09:14:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fetch: add fetch.pruneLocalBranches config
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
 <xmqqfr48rubw.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqfr48rubw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.05.26 um 00:39 schrieb Junio C Hamano:
> To break the feature down to make it easier to use by our users with
> various needs and workflows, we would benefit from having a
> collection of smaller features that can be composed, like these:
> 
>  * "git branch --forked <remote>" lists local branches that build on
>    something taken from <remote>s.  The option can be given multiple
>    times to make a union of the results from individual "--forked
>    <remote>".

Clearly, this version of --forked does something very different from the
option `--merged some_branch` that we already have.

> 
>    - <remote> may be a name of a remote, e.g., "origin" to mean all
>      the remote-tracking branches "refs/remotes/origin/*", 
> 
>    - <remote> may be "origin/master" to name a specific
>      remote-tracking branch.
> 
>    - There may be other handy things to cover with <remote>, like
>      "--all" that may act as if you listed all the available
>      <remote> on the command line.
> >  * "git branch --prune-merged <remote>..." is a short-hand for "git
>    branch -d $(git branch --forked <remote>...".

I don't understand this. The option includes the word "merged". Then I
interpret the command to prune only branches that have already been
merged into something (BTW, merged into what?), but as described, the
command removes all local branches that have been forked from some
(remote) branch.

> 
>  * "git fetch/pull --prune-merged <remote>" can trigger "git branch
>    --prune-merged <remote>" after "git fetch" successfully updates
>    the remote-tracking branches, which should be equivalent to what
>    you have here..

I think that the intended behavior is to call the equivalent of `git
branch --merged X | xargs git branch -d` for a suitable set of 'X' to be
determined by `git fetch`.

-- Hannes

