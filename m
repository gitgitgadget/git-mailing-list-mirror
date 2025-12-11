Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF53148A0
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455761; cv=none; b=kfF5LBQ9KTCcQoBa0J6wo6twee41nPvvC1acg6T+Qnjgf5glfQmOge7UVzH4rPTzN/K/LSEovCffZ630jAwZg504QFKYAEbhEd+wukmx4atgE//q8tuUySHsknxUtlKe5KqKRWWdCkO3hV6wVrGQogDPLUvNCA6NlYCRLzPNV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455761; c=relaxed/simple;
	bh=NWcUXZQxdT47h1x0IibFspYfbtdX9iT9CWb1LjjH5Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZySVCjYyRmiCDNgvIDtsJOqfvt7ZpdRvhwBKpNz4XoC9wWMmKSlISouFjKFP8N18OwQBxwVwAj4J1YjalLu/lZlVDOsi5uSh+DVWcf4wVrl9DH05zj34iz6F87pJmoci4GMvcFy7JQSyOqziazMl3z58H+YQB82QoGPvcxQXckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4dRsD63nqfzRnmF;
	Thu, 11 Dec 2025 13:22:30 +0100 (CET)
Message-ID: <d318c46c-fbc3-4e47-8c3f-165ca9a26225@kdbg.org>
Date: Thu, 11 Dec 2025 13:22:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] reset --hard: warn before discarding staged content with no
 commit history
To: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>,
 Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me>
 <xmqqldj9g0pj.fsf@gitster.g>
 <0lbeTWjDGq8hINMi-lj65HLgAIlUNZe_tzANStd9xxHQqAyZaEnaA0yPzVeY_VcReQIKNjY7eBEUGwMGvlbZ-0W0QZpux22cIHnosa0eX_k=@proton.me>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <0lbeTWjDGq8hINMi-lj65HLgAIlUNZe_tzANStd9xxHQqAyZaEnaA0yPzVeY_VcReQIKNjY7eBEUGwMGvlbZ-0W0QZpux22cIHnosa0eX_k=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 11.12.25 um 12:53 schrieb Koutsouflakis Stefanos:
> On Wed, Dec 10, 2025 at 10:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>> The thinking has always been "'--hard' means what it says!  HARD
>> removes things harder than other modes---there is [no] need to add
>> '--force' to it".
> 
> I agree that "--hard" conveys serious intent. But I would argue
> there is a meaningful difference between "lose your uncommitted
> changes" and "lose your entire project".
> 
> To be clear, I'm addressing a very narrow scenario:
> the user has run init on an existing codebase, staged files
> with git add, but has not yet made a first commit. Running
> reset --hard at this point destroys the entire project
> with no realistic recovery path. This is almost certainly
> never intentional.
I would argue that bad "tutorials" and "recipes" are to blame. I have
seen far too many that casually suggest `git reset --hard` without
warning and in an easy to copy-and-paste format.

Wouldn't the following slightly different scenario warrant a similar
safety net:

   git commit --allow-empty -m "Initial commit"
   git add .
   git reset --hard

That said, I have some sympathy for the case. Would it be palatable to
have `git reset --hard` refuse to do anything if the destination tree is
empty?

-- Hannes

