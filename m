Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF1274B58
	for <git@vger.kernel.org>; Sat, 23 May 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779545314; cv=none; b=SRnNvuR6H0PQ2f7w9whONgWm4NRtGw+1r0DKHPqqBXf14gVApNttm5tKC9YgiyjY6JPyrDc96dgnFiSK19CYclVvldIk09l4KDJAjIG2D+PJGeTHuDOSuinKVYai+WAyMcDP7MkLb2zaLwmFrfJQDbMgJWqu47uBG1wtyUx0IQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779545314; c=relaxed/simple;
	bh=kAEAiLA+GuHCVqntASecNotn0oP+qI0+RbElP6/jOME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcJi3wKEF0FWlnFWmOLgc5tFPKrvrTJzSQE9n2X0RLk4XTh98pK1ZmPyCw27yowXwEZ6TwvlRZMOv+zKM1tcwiGdhVIFHE52ZI1YmLNL6CQ9eRv9DWxHq7MY499AlZQLwNuTvByAKb8ooVxW7nO+x6mNfFrEN2oxgrXt5gJoJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gN3s90sXbzRnlL;
	Sat, 23 May 2026 16:08:29 +0200 (CEST)
Message-ID: <d677972d-2578-4261-8264-95b48ef65a07@kdbg.org>
Date: Sat, 23 May 2026 16:08:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] git-gui: use HEAD as current branch when
 detached (bug fix)
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-9-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-9-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:24 schrieb Mark Levedahl:
> commit f87a36b697 ("git-gui: use git-branch --show-current", 2024-02-12)
> changed git-gui to use git-branch to access refs, rather than directly
> reading files as doing the latter is not compatible with the reftable
> backend. git branch --show-current reports an empty branch name when the
> head is detached, and in this case load_current_branch needs to report
> HEAD using special case logic as it did prior to the above commit. Make
> it do so.
> 
> This addresses an issue with git-gui browser failing with a detached
> head.

Nice catch. I'll reorder this as the first commit.

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index aeb7ed3548..a72d8a59ec 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -648,6 +648,9 @@ proc load_current_branch {} {
>  
>  	set current_branch [git branch --show-current]
>  	set is_detached [expr [string length $current_branch] == 0]
> +	if {$is_detached} {
> +		set current_branch {HEAD}
> +	}
>  }
>  
>  auto_load tk_optionMenu

-- Hannes

