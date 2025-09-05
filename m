Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7B72633
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083766; cv=none; b=VTLxVl1mrAehTf2cTyK1M/OApOop/IoSOB6Ann/Dlody8rv0Ez4sX/xDr2MDFanoydpxbdFcWpBhXJJxtsZjH1POX2Kg7TPktW6KuTkZ4apvn3P/Epn51q1g5dEjImlPBrMgS5QFfPQ3Xe9sDw2ND/PwcQUEQyjnEiBAsCXBhoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083766; c=relaxed/simple;
	bh=nodV7ssBGV8Y+MFFL+HIRjFuzAwhNg7ZzOI2U0W2NSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t97px4faesXeNM1ObS/e6Tv2bnIQ8UTHNEIYTDnZerTdIYBRhceeWbeEAJT3wiPnkYsOMcfrQ/aVtTUSwsx86K7D1Tc4GaGzpB/uPyrbWyjOgeU4aD00Op3PTjYF/4Q11ebwAS2sZVGIXQilSgd2URTFp7JYjz0qhpoYWFNawrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mmttkxiG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mmttkxiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ABEC4CEF1;
	Fri,  5 Sep 2025 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757083766;
	bh=nodV7ssBGV8Y+MFFL+HIRjFuzAwhNg7ZzOI2U0W2NSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmttkxiGuwcDxub7tU2AXRHBktDIsGeXRccrPSdqbxstaxb54UoVZXmFom48V8WWl
	 j2SYp0J0PRbvaP9Apuvyc320BwhaF0nr/8qDEiL+9YkJwRBcsfqKFphGWGRxnl2fUF
	 Emr0A/rNrbtEfgjETbaTki/c7wsDekB4Qs0Q+Qoc=
Date: Fri, 5 Sep 2025 10:49:24 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>
Cc: git <git@vger.kernel.org>
Subject: Re: Doing blobless clone by default; switching between blobless,
 treeless and full clones by a command
Message-ID: <20250905-markhor-of-impossible-happiness-df5e58@lemur>
References: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>

On Thu, Sep 04, 2025 at 12:33:08PM +0300, Дилян Палаузов wrote:
> Rationale:
> 
> The reason people execute  git clone  is hardly to issue immediately
> afterwards  git log  or  git annotate.  The reason for git clone is to (try
> changing something and then) build the software. (Provided that git manages
> source code.)  Doing by default a reduced data download with  git clone
> will sped up the initialization, it will save bytes in transit and reduce
> server load.  In fact I think that by default (without extra configuration)
> git clone  should do a reduced download (blobless) and git should download
> the other things, when asked to do so.  This default download preference
> should be ideally managed by an option in global gitconfig .  When looking
> at https://git-scm.com/docs/git-config for “filter” I do not recognize
> anything relevant.

As a counter-rationale, shallow clones generate a lot more load on the server
side, because there are no packs available for this operation. Making this the
default behaviour will likely result in slower clones for everyone and more
unavailable servers due to high load.

-K

