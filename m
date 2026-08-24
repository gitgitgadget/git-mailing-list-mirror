Received: from mta1.migadu.com (out-80.mta1.migadu.com [95.215.58.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D38544683D
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585623; cv=none; b=VGr+HvAq53V++DisC7/XRcV5jeCtMiNeo1fycUJ4pJSVgetqmB9BsNeqmzmdjvgOYgG87QYmLRUWYnAs9PSXOsn3KDVmjKiYItvwd/AMUsEZtUg/BAqABs+7kpp3kK9sNtC+aGIU9p5d0hubtZiiWwvjO4BQIUNgXclcP6B27Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585623; c=relaxed/simple;
	bh=6UzFIOMNBIMqTToL8kHUVEF7kBp+IQ4AfsE7NG3DiJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX/QQ3O7k2Emc/6vaMEOiMHY0/3XyqOft/WC/lRZaKrbeXoQ11vejSKCb4tX3uZ3igGpgH8mJT5GAOQGMJLozJWq0dRtDnXGdDz5cDCk/cC/1sta6eXFU7lYLSa4ucgQASm7lRfEdWgxEjzXBO2g3heI4LoE4svoVM9Nqn2c+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=DoPlfepm; arc=none smtp.client-ip=95.215.58.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="DoPlfepm"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6UzFIOMNBIMqTToL8kHUVEF7kBp+IQ4AfsE7NG3DiJc=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787585618; v=1; x=1788190418;
 b=DoPlfepmfZWIzWfLnW/jaeyyhlvvv3oZpXqaIwn+ZVo6Oup7JioWPlSL+/G1Gfm6KTRQpYaS
 s7aH+7+asXbcGVoGtyy+BPOnSryp6GakEXZlWng9viHf5EIycp/x9UCblKMHHPuRibbnNqEoJTU
 kae82RY886sBMBM42a5R4CpVeOkaWSoDEEFS8f6O7WVQjJINvF+DU/N/XB4dPq7q5lVHwuZqHo8
 O/Kkz6WruBwFkSJJL5IuJnUNfUsaYb8Baar/7Pto4OV/aG8CfzJ57dp/Mo1Nb/UczK3vHkbHtod
 yQxWVgVoudmZ4uSdq/1RaQ0txplWN7IZSkPtIX0zHDKfg==
X-Envelope-To: git@vger.kernel.org
Received: from localhost (117.176.242.187)
	by smtp.migadu.com with ESMTPS id c8e18ae75c614d56;
	Mon, 24 Aug 2026 15:33:28 +0000
X-Mizu-Trace-ID: c8e18ae75c614d56
X-Migadu-Flow: FLOW_OUT
Date: Mon, 24 Aug 2026 23:33:20 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alexey Samsonov via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Alexey Samsonov <vonosmas@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
Message-ID: <aoxkQHCGJENGxV2I@wyuan.org>
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
 <aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
 <xmqqzeyeujde.fsf@gitster.g>
 <aor07LvsXOy1p7vh@wyuan.org>
 <xmqq5x10vowf.fsf@gitster.g>
 <aosVkqwcsmAWrDr6@wyuan.org>
 <xmqqfr04thhe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr04thhe.fsf@gitster.g>

On Sun, Aug 23, 2026 at 06:49:49PM -0700, Junio C Hamano wrote:
> Weijie Yuan <wy@wyuan.org> writes:
> 
> >> We know Johannes well enough to trust that his patches were sent
> >> with sufficient due diligence.  So...?
> >
> > <xmqqzeyeujde.fsf@gitster.g>:
> >> If work submitted under a DCO later turns out to be based on
> >> something we cannot legally use, the submitter may of course be in
> >> trouble, but we would also need to bear the cost of ripping it out;
> >> the later we discover the problem, the more substantial the effort
> >> necessary to deal with the fallout will be.
> >
> > What I meant is that you said we should be wary of content that might
> > carry legal risks,...
> 
> I am not sure what your point is.  Is there any part in "we trust
> Dscho well enough to trust that he sent them with sufficient due
> diligence" that was hard for you to understand?

Sorry, I think I failed to make my actual question clear in my previous
replies.

I do understand, and agree with, your point that you trust Johannes to
have submitted his patches with sufficient due diligence. I was not
trying to question Johannes or your trust in him.

What I was trying to understand is how that fits with the particular DCO
concern being discussed here.

You pointed out that if something submitted under the DCO later turns
out to be based on material we cannot legally use, the project also
bears the cost of removing it, and that the fallout becomes worse the
later such a problem is discovered.

As I understand brian's concern, if a significant amount of a
contribution is generated by an AI tool, there may be uncertainty over
whether the submitter can make the DCO certification with sufficient
confidence.

That is why Johannes's existing commits with an Assisted-by trailer
came to mind. I am not claiming that those commits necessarily contain
AI-generated content of the kind brian is concerned about; I do not know
what the assistance actually consisted of.

But if the disclosed assistance did involve generated content of that
kind, wouldn't the same DCO question arise? And if we do not know
whether it did, isn't that the sort of question that, following your
point above, would be better clarified sooner rather than later?

At the same time, I can also see the point behind your:

"if you use one, do not tell us" ;-)

Thinking about it from that angle also makes me wonder about
Assisted-by trailers themselves. If I understand the point behind
"if you use one, do not tell us" correctly, then perhaps we should
simply not encourage Assisted-by: LLM trailers, since such a trailer
explicitly records the very fact that we might prefer the project not
to be told about.

Of course, I am simply worried that an Assisted-by trailer might
create some legal risk. I am not a lawyer, though, so I do not know
whether that concern is actually well-founded.

On the other hand, I can also understand why the kernel community made
a different trade-off and prefers disclosure. Knowing that a tool was
involved gives the maintainer additional information, and the maintainer
can then decide according to their own judgment whether that information
should affect how the patch is handled. (possibly there are other reasons)

That was what I was trying, rather unsuccessfully, to get at before. I
am sorry that my earlier replies made it sound as though I was singling
out Johannes as a problematic case.

Sorry again for the confusion and the noise.

Thanks,
Weijie
