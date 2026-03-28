Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF417D6
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774659519; cv=none; b=hvM+Eh++H+1QrsCLvtU6PdifEfcUGB9p26egeUsRVLqvVVS+PGSz111miL9ee6AMHuUFwNqmnCPCkQ8Oxmz6DDVnlY2qB2M31PZYma1ES3MD64cPZHLdau7RWHKT2GGMV0kPYQTX+1VuHV46dmM1gHO2WtpJ1YqydY6hyzkU43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774659519; c=relaxed/simple;
	bh=s1rqdMZTT1y3hgkd6FyQ8XFDErwGRc2TuxpX62p2cIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAz6Ahnd8PezPiz3a3GLVBxwgOD14Q1Fw1nIB2m6DdB7OnmVWLSHH9nBo/4waxbCvDj63rrXAcG7uvcacn989ITnMAedtgqe8CJpLnj72MO8Xdq7gYDGUjdWRn2Fuwii+fZ00ud6snDb1bAlgdxv061GEGtIr+9tfTWhXaPN78c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fjJzR5SM7z9vL3;
	Sat, 28 Mar 2026 01:58:27 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of wesleys@opperschaap.net designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=wesleys@opperschaap.net
Message-ID: <3e9d8d71-9595-4151-8133-300b89b3b7f8@opperschaap.net>
Date: Fri, 27 Mar 2026 20:58:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] connect: Rename name to command in connect_git()
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jiang Xin <zhiyou.jx@alibaba-inc.com>, Derrick Stolee <stolee@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <20260326233739.2911354-2-wesleys@opperschaap.net>
 <20260327213308.GA598533@coredump.intra.peff.net>
Content-Language: en-US
From: Wesley <wesleys@opperschaap.net>
In-Reply-To: <20260327213308.GA598533@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4fjJzR5SM7z9vL3

On 3/27/26 17:33, Jeff King wrote:
> On Thu, Mar 26, 2026 at 07:37:36PM -0400, Wesley Schwengle wrote:
> 
>> connect_git has `char *name' in its signature and it caught me a little
>> offguard. I initially thought it was the remote name. But when you look
>> closer at the various call sites it is actually a command that is send
>> over the wire, eg . `git-receive-pack'. Change the naming makes it
>> easier to read the code and understand its intention.
> 
> I agree that "name" is not all that descriptive, but I think there's a
> hidden gotcha in the explanation above. This string is _not_ the command
> that we send over the wire. That's "prog" in the same function. And the
> reason that "name" exists is that it is a stable name for the operation
> we are performing, like "git-receive-pack", even if configuration or
> command-line parameters (like "--receive-pack=foo") tell us to use a
> different command name.
> 
> So probably "op" or "type" is a more accurate description. This
> conceptually ought to be an enum, too, since it is selecting from a
> limited set of operations we know about.

That's a fair take on it, "name" is really a not the best name for this 
variable. I think "op" covers what you describe here best, it reflects 
also why I named it command. When you check what is sent via ssh, it 
looks like the command:

    ssh -o SendEnv=GIT_PROTOCOL git@gitlab.com git-upload-pack 
'waterkip/git.git'

That's why in my change it was named command, op, or operation covers it 
too.

Cheers,
Wesley

-- 
Wesley

Why not both?
