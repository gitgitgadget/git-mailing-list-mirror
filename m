Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69A481B1
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774663292; cv=none; b=C8lJrlJre5JaUegT4noUszIetxubCus5ples8PF+r0DkwHgW2RuLgcePKJSzQsFCgSw0EeBWDYQlOcNaI1b35t6IbRnXSRYWixqW30jVn+OiaZw78F7Ih9swLpOwJ9wqt6BW2uUqzDTkgAdZPy/TqzgxvAWAkxxyReRVbon8BcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774663292; c=relaxed/simple;
	bh=LY+EF7ez6ghGHq9MMmLEl7TBNMZxo5GgJbCKn5DFXGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isxo4Ahv3yIRLX2MIExNpCYu7yk+Un87CslnNw+QXI1cp1z1zOkX4YebgUhP3LGcJ8Aod1cOCNcHKg7C+fLA+3rONkQ+VurguZ/AyD40BZERTag6VbQL/RueyPSFotkbyMvxbOTOL+1Z6qlOfUJZjmwmhyl8+oFkbhB7LNKxqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fjLN11fFWz9tX0;
	Sat, 28 Mar 2026 03:01:21 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of wesleys@opperschaap.net designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=wesleys@opperschaap.net
Message-ID: <01ca1166-c3ad-48a9-8edf-be82d380e110@opperschaap.net>
Date: Fri, 27 Mar 2026 22:01:16 -0400
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
 <3e9d8d71-9595-4151-8133-300b89b3b7f8@opperschaap.net>
 <20260328014426.GA621762@coredump.intra.peff.net>
Content-Language: en-US
From: Wesley <wesleys@opperschaap.net>
In-Reply-To: <20260328014426.GA621762@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4fjLN11fFWz9tX0

On 3/27/26 21:44, Jeff King wrote:
> On Fri, Mar 27, 2026 at 08:58:22PM -0400, Wesley wrote:
> 
>>> So probably "op" or "type" is a more accurate description. This
>>> conceptually ought to be an enum, too, since it is selecting from a
>>> limited set of operations we know about.
>>
>> That's a fair take on it, "name" is really a not the best name for this
>> variable. I think "op" covers what you describe here best, it reflects also
>> why I named it command. When you check what is sent via ssh, it looks like
>> the command:
>>
>>     ssh -o SendEnv=GIT_PROTOCOL git@gitlab.com git-upload-pack
>> 'waterkip/git.git'
> 
> Right, but it's necessarily what is sent via ssh. E.g.:
> 
>    $ GIT_TRACE=1 git ls-remote example.com:repo.git
>    [...]
>    trace: start_command: /usr/bin/ssh -o SendEnv=GIT_PROTOCOL example.com 'git-upload-pack '\''repo.git'\'''
> 
>    $ GIT_TRACE=1 git ls-remote --upload-pack=foobar example.com:repo.git
>    [...]
>    trace: start_command: /usr/bin/ssh -o SendEnv=GIT_PROTOCOL example.com 'foobar '\''repo.git'\'''
> 
> That's why I think "command" is actively misleading, because between
> "prog" and "command" it is not clear which one is going to be sent to
> the remote.


Ha! Interesting. I see the confusion :)
I'm not really sure what to call it.

I see the manpage calls it 'exec':

   --upload-pack=<exec>
      Specify the full path of git-upload-pack on the remote host. This
      allows listing references from repositories accessed via SSH and
      where the SSH daemon does not use the PATH configured by the user.

and it's the full path of the git-upload-pack command if the remote 
doesn't use the PATH. So it is command, just.. I'm not sure what to call 
it. It executable, binary, program, operation, script. I feel they all 
cover the same concept. remote-command? It could be any of them iyam.

Cheers,
Wesley

-- 
Wesley

Why not both?
