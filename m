Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9737DE89
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781319499; cv=none; b=ull8SaJuFK0YSmYDlXdANlWT5UfLfaKU1nRPBAmweoHqF9j13S5HheZWHO4irMbP7c+fFw6VrURK5zJ0mXGB+VgF5BtA62DGSjHPigVqEmmyjVe52JRGDsQt3gXk9ej+3AaZRGRgiaf9tm8R4B7HxM479F1/RjeMV5cCbht0YQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781319499; c=relaxed/simple;
	bh=JBZ5nvTBvYy25c1J+a9JtH3e3VeN12YAJwuCFgB9+g8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=XPNRSYWCPybWNOl92nnv06lrgmqkJUorjFElF7hHzm5Zvp50Vk1y3fTG8SOFPEbFVc6WUNWFvpUGT5taU3LRk8qdodHPRIk+3gmMXZfQ1XUpocjH7bKE3v7xaTNBY9rgNs19XKivYjGCOnz2fmMeBjEE0RhYILqZpromaMMUWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=VjR/lX/6; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="VjR/lX/6"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id A748660007;
	Sat, 13 Jun 2026 02:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781319496; bh=JBZ5nvTBvYy25c1J+a9JtH3e3VeN12YAJwuCFgB9+g8=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=VjR/lX/6fpNUBJoxT+hauhUT9VlJmHE3jTDSDzu34fSXJG4T7CqpyjyT3ZAHmis9k
	 2AjY3ZgHeW+NtWztP0/qOJcwqvTCUxHusZRSrx2CDyG3jqQlq2ACJ/q3NnZHxxBHSb
	 VVNqcxpAXYy6Wntgn1Y6QWrOir6+FEyu2LlG8cxw=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 22:58:16 -0400
Message-Id: <DJ7L27FXS2PG.7PMBDY817U4V@lfurio.us>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH 6/7] fetch: add configuration option
 fetch.followRemoteHEAD
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260612055947.1499497-1-m@lfurio.us>
 <20260612055947.1499497-7-m@lfurio.us> <xmqqik7nj11i.fsf@gitster.g>
In-Reply-To: <xmqqik7nj11i.fsf@gitster.g>

On Fri Jun 12, 2026 at 10:17 AM EDT, Junio C Hamano wrote:
>
> By the way, do not call a "configuration variable" a "configuration optio=
n".
> Let's keep the vocabulary forcused without using random synonyms.

Noted.  I can appreciate that the term "option" may be better reserved
for describing command-line options, to avoid confusion.

Is it safe to assume "setting" may be an appropriate alternative to
"configuration variable" in some contexts?

>
> I think these uses of strcasecmp() are unnecessary and actively
> harms end-user experience.  This is especially true because the
> value given to remote.<name>.followRemoteHEAD is case sensitive.
>
> [...]
>
> Admittedly values to some existing configuration variables may be
> parsed case insensitively but we should aim to fix the mistake in
> the longer term, and we should certainly not add more of them.

Thanks for clarifying the correct form here.  The use of strcasecmp()
was largely to match surrounding context as I assumed it would meet most
people's expectations.

I think a detail like this can be especially confusing since it seems
like the parsing for config variable **names** generally is
case-insensitive.

>
> Is it sensible to die() here?  If you are fetching from somewhere
> without keeping a set of remote-tracking branches for it (i.e., a
> single shot "git fetch https://github.com/gitster/git master"), you
> do not care what garbage value is in fetch.followRemoteHEAD.
> Perhaps the version of Git that is slightly newer than the version
> that ships with this patch defined new valid values that this patch
> does not know about, and such a user who is doing a single-shot
> fetch may have that setting to help them working with their usual
> non-single shot repositories, but they use a newer version of Git
> for such regular work, and they are using slightly old version of
> Git to perform this single-shot fetch.  The point is that the
> configured value will *NOT* be used for such a user, and dying only
> because this piece of code does not understand the configuration that
> will not be used is of dubious value.

Very good point about forward compatibility.  Agreed that die() is the
wrong call here.

The most sensible thing is probably to leave fetch.followRemoteHEAD
UNCONFIGURED if the value is unrecognized, so we fall back to the
"create" behavior unless the remote in question defines its own
followRemoteHEAD policy.

Will incorporate each of these in the next round, thanks!
