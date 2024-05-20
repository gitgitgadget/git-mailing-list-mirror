Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD328E7
	for <git@vger.kernel.org>; Mon, 20 May 2024 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716249276; cv=none; b=PpRFVwHYAT/0rDjCrC6bR5HoBREqS14Njlrl6HNzj/eJu6hpUXoEvVp1sTf787eBmfZHsyxepPeZgDexVzUlz0Ljd6C82i1U/75zucHAcId5M/haRG9fOB3YuOSfIGSiKfmD7H53QxP0fJpIi+eJzLQf4EmbIyeTInQ+zc1EQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716249276; c=relaxed/simple;
	bh=i7rMd7N64fl2U07yETlNpfXwEwvg3gRwTMzpo4ugqQ4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Rl6DxPxi8eUR4hheBITTsfSMnAXYF5gT4LEH0JVQuneby/mDY+5MAVHaFdX6jHmmlQoR3l6xxPUSNafcD8gk3vzWnt7e5IIaqTEta7Qxs+YXgcNBYmChi+QdNrCywcyzHuW0FrR4GLXQCmETXaXBF+lx3ExsOovSDh9pbBU0uaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JQwTEnXs; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JQwTEnXs"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716249262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1M4OKItqHeBqElR7fcE20wD9qzZI3AJCEZi0RUN1VI=;
	b=JQwTEnXs4cxn1f2sdsgSo0QeCmmWI/wuDW4VMBq0vUOx2qOcjqNsWgmQ/31yxz5UqBGfB4
	1CX79WEpdkx4G0RMCcy5nxY7NnaPygko6guBVetIGlDXPc0wNJ9OOJWE0OjTadQhA6fp7k
	bDYxPmpH2TpSvgaRdHjkpEB51d9fieAKM2yOWGzQ8pEmlsUU7pTOKiBKCDWkbuCYeb3g7Q
	58eT4I+e2/SObMLlCl5h1nPEe9tTaU+MyTZsp2akyqgXgn81vW/glV6JTiEIgKIxUA4EyT
	r2pdRocBUztiMAkc0R3ZS82mB+RprW3ZtOwskhDIRIJzsynx6w2R86MyGECTjQ==
Date: Tue, 21 May 2024 01:54:22 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <83071f70-e8a1-41d6-9fb1-108a31602baa@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 <xmqqh6esffh1.fsf@gitster.g> <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <83071f70-e8a1-41d6-9fb1-108a31602baa@gmail.com>
Message-ID: <516ffe6bafb71f5645e93e6c01f721a7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-21 00:35, Rubén Justo wrote:
> On Mon, May 20, 2024 at 09:45:51PM +0200, Dragan Simic wrote:
> 
>> Thus, if someone wants to have a complete longer-than-one-screen hunk
>> displayed and use the terminal emulator scrollback to inspect the
>> hunk in its entirety, passing such (or all) hunks through the pager
>> would make such inspection impossible.  I'd assume that at least some
>> Git users already do that (I do, for example), and we surely don't 
>> want
>> to make that no longer possible.
> 
> I'm not sure if I understand the problem... disabling the pager is
> still an option, no?
> 
>     $ git -P add -p
> 
>     $ git -c pager.add=false add -p

Please read the thread [1] that I linked in my previous response 
carefully.
I know, there's _a lot_ of text, but I already tried to sum it all up in 
my
previous response.  There's even a video clip [2] in that thread that 
shows
the issue with the corrupted scrollback in a terminal emulator.

Frankly, the "-c pager.add=false" approach is a bit cumbersome.  
Basically,
the new "-P" option would be like "-c pager.add=true", while the already
existing "-p" option would be like "-c pager.add=false".  Though, I 
think
that we don't want to add "pager.add" as a new configuration option, 
because
throwing it into the mix would make the "-p" and "-P" options for "git 
add"
quite confusing.

As another idea, we might also add "p" as another option in the 
"y/n/q/a/d..."
menu when the user decides about each hunk in "git add -p" or "git add 
-P".
When running "git add -p", pressing "p" would display the current hunk 
using
the pager (which would be opposite to the "git add -p"'s behavior of not
using the pager), and when running "git add -P", pressing "p" would 
display
the current hunk by bypassing the pager (again, opposite to the "add 
-P"'s
behavior).  That would allow greatest level of flexibility.

[1] 
https://lore.kernel.org/git/8289ef15266172cbfa10bb146afe9797@manjaro.org/T/#u
[2] https://youtu.be/MsxtQgrKM50
