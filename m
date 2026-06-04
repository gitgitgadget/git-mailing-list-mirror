Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA772617
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610168; cv=none; b=H/pOMWKvzS9F8t/h22d2zz++UNyQNigEexxJ45zMQOboI5ci9wMn5bE/a//FMari21u+Ijw4ldl8vRHlk+QNc0pjRaW0L0cVvDmKF0RY/mWIffQWwc/NfBlsRRTWGhUVWWamiW2DZKzKbh5qFzyS/OQNoKuLj99rm63GVO+Z9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610168; c=relaxed/simple;
	bh=25OoceX/tYtTyZzOOw6mveRiJunU7GbuRH+ZysjOGkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqqfmV7LAKdLeEAFePNpF5EjIQjuo19uyzaohwLdyGk3nQ87IiPsp4UJ1N32m+rjchgfK5yipj1Kpb5uY0FjnEwWaftP5H2wTIOmv9Ohl6Ts9R1Y1ZtEdLSdYrrpoDd2AIJlA8BBXIQqcxODZgTeTsz4UcvzHgojh1xv+vf5jtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email; spf=pass smtp.mailfrom=iee.email; dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b=jy6MiYbI; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iee.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="jy6MiYbI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2026022700; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=6cr6SUFBNdgQEMy9IRDaVmSaqGAjAIRb+c7ZWeblGrw=; b=jy6MiY
	bIGaHZzqi+Zphl00HeneH2lbZAdn+HWIpS5Sy1khc4RSYyOy/tdAi8yBBPqd9lj+CE//npAaACfKh
	h2ZZ09g5BbBMMX60kQizk2BGm3ZY/iSLlWtUh5UONonQlLSP8T4dK5O47YhJ/5zvra0p/ijVwFGEi
	Hi1iz6G0Fio=;
Received: from host-92-26-4-16.as13285.net ([92.26.4.16] helo=[192.168.1.57])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1wVG2l-000000063yI-35mS;
	Thu, 04 Jun 2026 22:56:03 +0100
Message-ID: <4e3430a1-e8ee-47de-b6f0-25abafe3c45b@iee.email>
Date: Thu, 4 Jun 2026 22:56:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Support hashing objects larger than 4GB on Windows
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
From: Philip Oakley <philipoakley@iee.email>
Content-Language: en-GB
In-Reply-To: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/06/2026 18:15, Johannes Schindelin via GitGitGadget wrote:
> Philip Oakley has contributed these patches ~4.5 years ago, and they have
> been carried in Git for Windows ever since.
> 
> Now that there are already other patch series flying around that try to
> address various aspects about >4GB objects (which aren't handled well by Git
> until it stops forcing unsigned long to do size_t's job), it seems a good
> time to upstream these patches, too, at long last.

Yay. I approve this message ;-)

Philip

> 
> Philip Oakley (6):
>   hash-object: demonstrate a >4GB/LLP64 problem
>   object-file.c: use size_t for header lengths
>   hash algorithms: use size_t for section lengths
>   hash-object --stdin: verify that it works with >4GB/LLP64
>   hash-object: add another >4GB/LLP64 test case
>   hash-object: add a >4GB/LLP64 test case using filtered input
> 
>  object-file.c          | 18 +++++++++---------
>  object-file.h          |  4 ++--
>  sha1dc_git.c           |  3 +--
>  sha1dc_git.h           |  2 +-
>  t/t1007-hash-object.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 52 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2138%2Fdscho%2FPhilipOakley%2Fhashliteral_t-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2138/dscho/PhilipOakley/hashliteral_t-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2138

