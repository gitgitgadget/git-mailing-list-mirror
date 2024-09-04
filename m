Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFE1DCB26
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468566; cv=none; b=d7HEMuz/Qjx/WP/Ci1xX3PssZU8IoO0cs++Y4C6ABVjvVb/OO8FIubSKZ5TU2el9ENtK4buvjSAih/FceDygOmYZVgbtIRH86Pn3A4KXclzxRNnHawqosrVQPov4bJ10WfFRsS32DmuZVMnGMaOV3kO8u8ZTTYJTGX0ed/LzhjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468566; c=relaxed/simple;
	bh=buweZcapmZWVxfnIn8Z02MWdAlE8hVjBANQLUhdKaAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ADwP1YV6bVvzmRJwL6MwF2qYkOUQfJ2AiFGjn84a6UnRiFVysFCxl/WDy7Y26teY+TkRJYMzaxY2wn7AkXigZU8/EhG1RR7qN/WmfpD+Dn0dF7VNkratGif6OwWMAW2fsJCSnwhE8fxO/CCVikxur0qF4JNY8GicNqMWx6cdyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4WzT3l1S29z5vWW
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 18:49:23 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4WzT3Z0lGSzRnlK;
	Wed,  4 Sep 2024 18:49:13 +0200 (CEST)
Message-ID: <0e0fb1c3-d4f7-413b-9985-d71cb1c300df@kdbg.org>
Date: Wed, 4 Sep 2024 18:49:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git log alias with --all and --exclude
Content-Language: en-US
To: Rene Kita <mail@rkta.de>
References: <20240904090614.GZ15670@t480>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20240904090614.GZ15670@t480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.09.24 um 11:06 schrieb Rene Kita:
> I have an alias
> 'gr = log --oneline --abbrev-commit --all --graph --decorate --color'
> and I would like to be able to sometimes exclude a branch, so call it
> with:
> $ git gr --exclude=pattern
> 
> This does not work, though. Also does not work without the alias and
> typing the complete command by hand. Apparently the --exclude must be
> put before the --all to take effect.

That is very much by design, so that you can express "branches except
the wip and preview branches and remotes except those from the remote
archive" with

--exclude=wip/* --exclude=preview* --branches --exclude=archive/* --remotes

These collective branch options --branches, --remotes, and --all clear
the exclude patterns after having them applied. Therefore, in this example,
the first two --exclude do not affect --remotes.

-- Hannes

