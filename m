Received: from hu-is-mx-01.gaijin.team (hu-is-mx-01.gaijin.team [213.163.39.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40971179652
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.163.39.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022329; cv=none; b=fx/QaL3ejnp422ii0PiPT+h3lgoq3bOHnWVCyevlXBjPu+lZWdXoc8Q4h0iJOoeT9uk4fGlhNZ2MGwtNZlsvz9cle2BTfF1KeuhYSFC2981dxk6A1h8cNm4Q97s1VAhmfDFUgBgstdmroLFqFwB36AJkiG6vFKtxwUP4snXGRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022329; c=relaxed/simple;
	bh=kls3gl9UJfMNXGRJvtZlbrIiCUuZGgRmwMxgSHZpbng=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GzFpccoStImwBY7Dx5lJeF120WiuFA0MxP11U6xJUvLmKfrQcAIhRKv8BcNgTT0AH+gqyq4FSN4vsnG0IXldSSnTFPqzIBr/h4CxyKs8eYG06+u1v6uq9DgstmQ/iKa3lFQYLKg1BviLmBtI8fnMZNEezZPpGfCA2VAyH9Okp70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team; spf=pass smtp.mailfrom=gaijin.team; dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b=GJT3OELO; arc=none smtp.client-ip=213.163.39.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaijin.team
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b="GJT3OELO"
Message-ID: <3eda2715-3b44-469e-85d5-f25504212928@gaijin.team>
DKIM-Filter: OpenDKIM Filter v2.11.0 hu-is-mx-01.gaijin.team 4F70138A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaijin.team; s=mail;
	t=1725022325; bh=jSGmjK8bqYA2IR8O/ZLnN/4hCLrx9Lp3EgXEt9hHchU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=GJT3OELOAqq4nrIDXh3/I1NSFDXKWFj58KHqkgMy51CMYX8LrZozk0ZOHkGeYRgoe
	 jJj2VTTFIFg9YtwlXPMBCrgY4KW5/06O7hDJ/7Fofe/4ol3RinKNDZKZDPOik59Ejr
	 pKosAXhmyl8IrIkOgT6NGbE3vapktD7eCrbiQl+0=
Date: Fri, 30 Aug 2024 15:52:05 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Committing crimes with NTFS-3G
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
 <ZtEWvQOwLPgjIFks@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Roman Sandu <r.sandu@gaijin.team>
In-Reply-To: <ZtEWvQOwLPgjIFks@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes, I am aware that the index will be fully refreshed on the first run 
of status. That is completely acceptable. But that is not what I am 
observing, it is being refreshed on every single run of `git status`!

After running stat before and after a status, the sha256 is identical. 
Both for files and for folders. Maybe Windows has somehow corrupted the 
index with its negative aura which makes git invalidate it on every 
single run? Are there tools in git to diagnose the reason for the 
index's cache being invalidated?

On the topic of Unix permissions -- as far as I can tell, they ARE in 
fact working, because I've created a UserMapping file that tells NTFS-3G 
how to map between NTFS/Windows user UUIDs and Linux user IDs. See 
NTFS-3G's github page (https://github.com/tuxera/ntfs-3g).

On 8/30/24 03:47, brian m. carlson wrote:
> On 2024-08-29 at 20:43:40, Roman Sandu wrote:
>> Good day!
>>
>> I have a decently sized (80K files) monorepo on an NTFS drive that I have
>> been working with for a while under Windows via git-for-windows. Recently, I
>> had to (temporarily) switch to Ubuntu (24.04) via dual-boot for irrelevant
>> reasons, and I decided that simply mounting my NTFS drive and using the
>> monorepo from Ubuntu is a great idea, actually, as NTFS-3G allow for
>> seamless interop with NTFS via UserMapping. And so that is exactly what I
>> did and It Just Works!
> 
> In general, I would not recommend this.  NTFS doesn't support Unix
> permissions, so I'd expect a lot of things to be broken.  A lot of
> people like using NTFS to share data across Windows and Linux, but UDF
> is a much better choice and I'm not surprised that NTFS isn't working
> the way you'd expect.
> 
> Also, when you share a repository across systems, you should expect the
> index to be fully refreshed each time you change the OS, reading every
> file in the repository[0].
> 
>> So, what do I do about this? It honestly looks like a git bug to me, maybe
>> it silently fails to update the index with new timestamps because it was
>> initially created on Windows? But I have no clue how to narrow this issue
>> down further, so any ideas or suggestions would be appreciated!
> 
> Can you pick some file in your repository and run `stat` on it, before
> and after running `git status`, and include the output?
> 
> For example:
> 
>    stat http.c | tee /tmp/before
>    git status
>    stat http.c | tee /tmp/after
>    sha256sum /tmp/before /tmp/after
> 
> My guess is that NTFS-3G is not emulating something properly and it's
> differing at some point.
> 
> [0] https://git-scm.com/docs/gitfaq#sync-working-tree

