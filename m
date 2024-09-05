Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82011176AC7
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567980; cv=none; b=ejcnGVFm5fjDLoacRvBRWrPA98p3oS3JpApssWQ91FMnJkoap/afNJBfg4DqW8xn8YRRaVAwXLY5d25GBiiaF2q9e5uOo+GSTlPvNI4GJwBgyp1u/tvvrjrHWoiXn3a5YKVFPjRBEJiL+XzZs3Q5BDKyM0yDiksdsgIiPMo98Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567980; c=relaxed/simple;
	bh=p/BhcKdaQU6TDSDaZdo5f8+3bV7tbA4qbnfn2k54Sm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QgsKhrkiV8FDYmojm2lhK17u5xd91jUEsASBUP3d+ZHcJeXWamsPtNV9aTxEmy3CdOdGI+5nu2paABM67JPmzPRT1Ob1u5CxfIV9E4thihjZyvFjGgUI9I5HpUtqXRkiz482BIPmqrCBzA+NbKmjboGB4gPJrFsWu7xYp00erQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h1vlMGls; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h1vlMGls"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FB2228939;
	Thu,  5 Sep 2024 16:26:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=p/BhcKdaQU6TDSDaZdo5f8+3bV7tbA4qbnfn2k
	54Sm4=; b=h1vlMGlsbpygsfSVg3nw4B+sPNnlSCXhUZrOr4QpnFZ0WDb/OcSqzk
	v+c6W0pUUfGO4Tye1qOENFIW5gZhmOhRvGzz9Ye3yC68jcmS/UftuFFxQtCKBuHc
	UPuxFhGRaBBNMv6bQMLqEo7u2izisT48i1c8birtZh0OVNPB/1KkU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4522428938;
	Thu,  5 Sep 2024 16:26:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0CEA28937;
	Thu,  5 Sep 2024 16:26:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes.Schindelin@gmx.de,  ps@pks.im,
  james@jamesliu.io,  Jeff King <peff@peff.net>,  Gabor Gombas
 <gombasgg@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] advice: recommend GIT_ADVICE=0 for tools
In-Reply-To: <pull.1781.git.1725559154387.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Thu, 05 Sep 2024 17:59:14
	+0000")
References: <pull.1781.git.1725559154387.gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 13:26:15 -0700
Message-ID: <xmqq4j6t26fs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A5C7D44-6BC5-11EF-BCB5-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  advice.*::
>  	These variables control various optional help messages designed to
> -	aid new users.  When left unconfigured, Git will give the message
> -	alongside instructions on how to squelch it.  You can tell Git
> -	that you do not need the help message by setting these to `false`:
> +	aid new users. These are output to `stderr` by default as they are
> +	intended to help human readers. Tools that execute Git as a subprocess
> +	can disable these messages by setting `GIT_ACVICE=0` in the environment.
> ++
> +When left unconfigured, Git will give the message alongside instructions on how
> +to squelch it.  You can tell Git that you do not need the help message by
> +setting these to `false`:

This somehow makes it sounds like it is an "aside, by the way" that
these trigger by default and that you can selectively disable it by
setting these variables, but shouldn't the stress be the other way
around?  Shouldn't the mention of GIT_ADVICE be a side note, leaving
primary text target human users?

Perhaps like this?

Thanks.

 Documentation/config/advice.txt |  8 +++++++-
 Documentation/git.txt           | 11 +++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git c/Documentation/config/advice.txt w/Documentation/config/advice.txt
index 0ba8989820..d749aee7f4 100644
--- c/Documentation/config/advice.txt
+++ w/Documentation/config/advice.txt
@@ -2,7 +2,13 @@ advice.*::
 	These variables control various optional help messages designed to
 	aid new users.  When left unconfigured, Git will give the message
 	alongside instructions on how to squelch it.  You can tell Git
-	that you do not need the help message by setting these to `false`:
+	that you have understood the issue and no longer need a specific
+	help message by setting the corresponding variable to `false`.
++
+As they are intended to help human users, these messages are output
+to the standard error.  When tools that run Git as a subprocesses
+find them disruptive, they can set `GIT_ADVICE=0` in the environment
+to squelch all advice messages.
 +
 --
 	addEmbeddedRepo::
diff --git c/Documentation/git.txt w/Documentation/git.txt
index 4489e2297a..d15a869762 100644
--- c/Documentation/git.txt
+++ w/Documentation/git.txt
@@ -1027,6 +1027,17 @@ standard output.
 	adequate and support for it is likely to be removed in the
 	foreseeable future (along with the variable).
 
+`GIT_ADVICE`::
+	If set to `0`, then disable all advice messages. These messages are
+	intended to provide hints to human users that may help them get out of
+	problematic situations or take advantage of new features. Users can
+	disable individual messages using the `advice.*` config keys. These
+	messages may be disruptive to tools that execute Git processes, so this
+	variable is available to disable the messages. (The `--no-advice`
+	global option is also available, but old Git versions may fail when
+	this option is not understood. The environment variable will be ignored
+	by Git versions that do not understand it.)
+
 Discussion[[Discussion]]
 ------------------------
 
