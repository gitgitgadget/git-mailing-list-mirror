Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8644C67
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326416; cv=none; b=q1zXMfHy+/2C4aDPb4mLGnx2l+cxRDL2CWQu3nrxWJOwxIaHx/PGO1EwHFUV11wPZyvl9s9ScljUGrb8CBUTLUG529RFRZxxQLJQn9+WvtSzJyY2xhuEraP3pQTZ7rQo8srthcbsprO/Gb+uRTbJ1rUg9SDgOsW6C07w9wUpUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326416; c=relaxed/simple;
	bh=jTBaf2GDAtnZRufnrzcHL9XrGsVpPlQBisotcjRMDZc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mB4jlWo7zC0oBrzS73BM0kBiVitIsRfMjLxldpaHL2oHApXGoDXoMdiGFRN6rcLGBBtOo9J520vyRRSVwaVB0j8Gp4HCJ1sUUWZjU2eXb50MzLLx8ew3m7z5g959rMDPy9fb3KqcE5l54a0EutpwDrYjyqdCGHqqTTVVSZbU9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MlhMNvds; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MlhMNvds"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713326412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1w1INke7fxwUpjBF6YQ5GwI3qpgT7UFcjZocWgUHZQ=;
	b=MlhMNvdswQ4P7p2QCV8FBeUXwmAhW1N2B00Y4ymj9tpdY6SgFKpqZPCuMH+olXk4GGHNVA
	IIL694btUWmLCw8lnNQPNBiazKyKNwIZuFRD53H+QXmm+W/GI6Awi2RNhywjSX45nRXh6s
	d6zakAWKWghaIU8A0gHdlE6q9Rjy6dyRO6E7z1ZUyhIOI+lrknE3g1SA4kEFEfNOACIyLR
	VgyTNKrtnzPDlE5IoH8ZBy5W+rzuTy23pRy6htXm5MAI3KNn7OsESo9uChIbHhaPgYyPvR
	/7KxTUn11q2bw/8HC8zo4wX7yPmS5iYmecgamadTWenRcIthZ1VBmmAOSAXC9Q==
Date: Wed, 17 Apr 2024 06:00:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 'Josh Triplett' <josh@joshtriplett.org>,
 git@vger.kernel.org
Subject: Re: [PATCH] advice: Add advice.scissors to suppress "do not modify or
 remove this line"
In-Reply-To: <xmqqv84hc53e.fsf@gitster.g>
References: <0a7b9172add0a0107e0765a59a798b92161788dd.1708921148.git.josh@joshtriplett.org>
 <Zh7NZhB1n2o1k7jI@localhost> <xmqq7cgxdp0i.fsf@gitster.g>
 <046c01da903e$d6d97ac0$848c7040$@nexbridge.com> <xmqqv84hc53e.fsf@gitster.g>
Message-ID: <9eede976d6be7a93199f9d53e916431a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

Please see my comments below.

On 2024-04-17 00:31, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
>> I am having a bit of trouble understanding the use-case for
>> this. Is it limited to linkgit? Under what circumstances would I
>> need to use such capabilities?
> 
> When you run "git commit" from the command line without specifying
> any message, you'd get an editor spawned for you with something like
> this in the file ("--- >8 ---" and "--- 8< ---" are for illustration
> purposes in this message).
> 
>     --- >8 ---
> 
>     # Please enter the commit message for your changes. Lines starting
>     # with '#' will be ignored, and an empty message aborts the commit.
>     #
>     # On branch next
>     # Untracked files:
>     #	+runme.sh
>     #	P
>     #
>     --- 8< ---

Frankly, I'd much rather see a new configuration option that would
suppress the two leading lines in the example above.  Of course, they'd
still be displayed by default.

> But when you run "git commit --cleanup=scissors" (or use the
> equivalent configuration variables), you'd get this instead.
> 
>     --- >8 ---
> 
>     # ------------------------ >8 ------------------------
>     # Do not modify or remove the line above.
>     # Everything below it will be ignored.
>     #
>     # On branch next
>     # Untracked files:
>     #	+runme.sh
>     #	P
>     #
>     --- 8< ---
> 
> The new advice configuration is to suppress the two lines from that
> message template.

I think this new configuration option might be useful to some users,
but I'd suggest that it gets extended to also suppress the two opening
lines mentioned in my comment on the first example above.

> I agree that a bit more background information should be given in
> the proposed log message to help readers.  It should mention when
> this new setting is relevant (e.g., when the "--cleanup=scissors"
> option is in effect), at least.
> 
> I suspect that the same configuration variable wants to also control
> the "helpful" comment in the "normal" case, in which case the name
> of the configuration variable would need to be rethought.

Agreed, a better name for the new option would be helpful.
