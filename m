Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639813D622
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766329; cv=none; b=nEo5CeVC+ULgG1S1x3/+HNgneig+wi0RjU9XZI2jS2AfFYbLeFejX/4xNf7F0eO7zeS0CC2myaJRrJhsnxsnoaxncdPuykGqwrxEPGsNFtg+DHFLdnKsgZ/5Davdeb5Ph4u6wa/2VNpdQddd2afAsdP+pNEt+1Y5Mx+UsxJsyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766329; c=relaxed/simple;
	bh=HIlHp8Ul921VUylFjKEe4pfojZbuVrOWFr7w+WdUEYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=chmVpdmq9dfxAIdXhKCo6cXD+zr+gZJPQy7joY5ODzcSz6I/ed300/Ww/r9I4aOziChHWHti7p4w9i9RQUP4GGy9LnHfuoW5Rr8rcJCZt1Zk1HCWraghnWXqpDd0UQ0exTDsZRBipm5Wpb3rNagWDMlk3TNwpfYzfEgW3K+zVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=urSQhy8p; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="urSQhy8p"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 861273227A;
	Tue, 23 Jul 2024 16:25:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HIlHp8Ul921VUylFjKEe4pfojZbuVrOWFr7w+W
	dUEYk=; b=urSQhy8pajgA5o/P/hwE3zfAKl160WCR9BmIqM/uuUGM087RVnpY9A
	U/QIn9P640Z/oOi75cG8E2sKYvlkkPiher8JJtr5/cnPgcwgm3knS+7spYrEJvzk
	rMLo2QRyn1HQfwJaVYrSCmHsbCTSVIkTluv0jV2+mBwa1whQaebO4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F66832279;
	Tue, 23 Jul 2024 16:25:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08C5432277;
	Tue, 23 Jul 2024 16:25:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
In-Reply-To: <1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com>
	(Avi Halachmi via GitGitGadget's message of "Tue, 23 Jul 2024 19:18:24
	+0000")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 13:25:22 -0700
Message-ID: <xmqqy15rzwi5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B0D1706A-4931-11EF-A02F-9625FCCAB05B-77302942!pb-smtp21.pobox.com

"Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>
>
> $'...' is new in POSIX (2024), and some shells support it in recent
> versions, while others have had it for decades (bash, zsh, ksh93).

I will not look at this series futher during the current development
cycle that is about to conclude, but ...

> +__git_SOH=$'\1' __git_STX=$'\2' __git_ESC=$'\33'
> +__git_LF=$'\n' __git_CRLF=$'\r\n'
> +
> +if [ $'\101' != A ]; then  # fallback for shells without $'...'
> +   __git_CRLF=$(printf "\r\n\1\2\33")  # CR LF SOH STX ESC
> +   __git_ESC=${__git_CRLF#????}; __git_CRLF=${__git_CRLF%?}
> +   __git_STX=${__git_CRLF#???};  __git_CRLF=${__git_CRLF%?}
> +   __git_SOH=${__git_CRLF#??};   __git_CRLF=${__git_CRLF%?}
> +   __git_LF=${__git_CRLF#?}
> +fi

... given that these are not used literally in-place but are always
referred to by their __git_BYTE names, if we are making this script
portable across shells to the same degree as other shell scripts
following our coding guidelines, I would prefer to see it done
without any "fallback".

$(printf '\r') would work with bash, zsh and ksh93, too, and one
time assignment to these variables is not going to be performance
critical.  Just forbid use of $'\octal' notation in the coding
guidelines document, and implement just one variant.

Perhaps we should spell more things out that you wrote in some of
your proposed log messages more explicitly.  I think these have been
rules we have followed (grep for them in *.sh files outside
contrib/) but I did not find mention in the guidelines document.

Thanks.

 Documentation/CodingGuidelines | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 1d92b2da03..bb058fcc87 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -107,6 +107,8 @@ For shell scripts specifically (not exhaustive):
 
  - We do not use Process Substitution <(list) or >(list).
 
+ - We do not use Dollar-Single-Quotes $'<octal>' notation.
+
  - Do not write control structures on a single line with semicolon.
    "then" should be on the next line for if statements, and "do"
    should be on the next line for "while" and "for".
@@ -140,7 +142,8 @@ For shell scripts specifically (not exhaustive):
 	sort >actual &&
 	...
 
- - We prefer "test" over "[ ... ]".
+ - We prefer "test" over "[ ... ]".  Never use "[[ ... ]]" unless in a
+   script only meant for bash.
 
  - We do not write the noiseword "function" in front of shell
    functions.

