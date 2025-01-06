Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991642056
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181404; cv=none; b=ZFhD4Hu4uafQmU8Hkszmu8+GFv7virEmBCdZ+91nQzaDK2hUPwVqwefQPYt2KvehnpM2h3nt7SJKsEc7k1uiPT7vGAyPSKiJO4Th/sLd6FZXi3IJyrBkkFTi2aQw6E52Ov6RwOKiWvX0IP10PZ72iHBjLu4L/nqA51tJ7ZPfvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181404; c=relaxed/simple;
	bh=ar7A+1zxRdsEbtmfGNG47hIyoKrk3lJf8+StekOaa9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTF9dwjpY+nqMefoROi/tRzKkhDpNr/VKoDUdVgpWSlPwb7w1IwG8uSRlG1xYCQF9NmVSIFpl6ipAnItDikXUz5tbK6Nrn7Pp72N7rz5m7ODhoH4hv+ONQRMCzHlRXtPaEBewBs18JpXFWoMDUoVlOLICviy22+hVeEySTFDnvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=m27V1dsT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="m27V1dsT"
Received: from cwcc.thunk.org (pool-173-48-117-149.bstnma.fios.verizon.net [173.48.117.149])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 506Gaa7c019418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Jan 2025 11:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736181398; bh=JKUUd8/Deekz/QOqVJYKdteXDtFrMaFuBm4yf/LMlbc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=m27V1dsTmn25TiB/9Z/e3w1c8lFTmVGNUd1gJ2Cd2Rvq9NiLLya2Bi1MBfH1hYu1F
	 Xm5xYh606HlIwxD6hZLFqZFTs2Nl1DxEQeokaZpXAD3evCSSFBv/hmhpVS85Pum//q
	 qsjs5OjpmkOZVCmlTuPeknBBLWGlIy90gX3rcI/SeD1+OOTWg8wQNDv6INRzInr29w
	 /tzAZzkGHWeMKo3Vb7DURTugwB1ggL3qvBiLtmlgZphgicv2q5zg7IoMdABUChsd1C
	 Morh6b8tznv3CdAk0PLG1Y2JT3gbX7Cn9R9SPNoXau+v+wqZWVC1VHg9zdmY5QYOEL
	 bF9LxlibKSThA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D64A615C0164; Mon, 06 Jan 2025 11:36:36 -0500 (EST)
Date: Mon, 6 Jan 2025 11:36:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
Subject: Re: Testing for existence of a remote branch from a script
Message-ID: <20250106163636.GH1284777@mit.edu>
References: <CAFOYHZDQs-mftqLQn5HiFgBWcFN6Z-WDscJt=zVLRyGTo36=HQ@mail.gmail.com>
 <20250106065121.GA8844@tb-raspi4>
 <xmqqsepw0xk7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsepw0xk7.fsf@gitster.g>

On Mon, Jan 06, 2025 at 07:30:32AM -0800, Junio C Hamano wrote:
>  - Would it be useful if we introduced the ability to advertise
>    "custom capabilities" from the receiving end of the connection,
>    that does not affect how the rest of Git behaves at all?

So if enhancing the git server's functionality (either via git
ls-remotes or some other operation) is on the table, one of the things
that I would really love is some way of asking the question is "git
commit <SHA hash>" in the remote repository reachable via some branch
or git tag?", and optionally, "which git branch/tag should be fetched
if the testing infrastructure wants to be able to test that specific
git commit ID?"

I could solve that problem by doing a "git fetch", but in my case, the
specific repository in question might not even be on the local client
where the user is executing "gce-xfstests -c ext4/4k -g auto --repo
stable-rc.git --commit 47c2f92131c4".  (This command launches a VM
which actually builds the kernel, and I'd like to be able to give
immediate feedback about whether the command will fail due to the user
typo'ing the git commit id without either waiting for the Google Cloud
VM to launch and then fail, or doing a "git fetch" and determining
whether the git commit is there.  I might be executing this command
while on a very slow networking link, such as when I'm in an airplane
or on a cruise ship, and so the cost of doing the "git fetch" might be
prohibitive.)

Thanks,

						- Ted
