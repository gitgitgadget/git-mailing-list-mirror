Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C1342CB3
	for <git@vger.kernel.org>; Fri, 29 May 2026 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071136; cv=none; b=HhSZdyS6Ww0HR85NBtUSQdK4b66PQhRWFMQksKYZ28d7mMskNcmhaWRH3r8arViy1oN1PgrNzPEamwQS0ywt+FGGV41dTYLnXey5g+HE/f33owrtFAytpSbE1IAMADNC5UeAcpDxedV3maSjAUDijNMGCZ09cGtEcSK80XcOj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071136; c=relaxed/simple;
	bh=YDKo8B9KD9faDfkLZSwdO385gfy4g6X559ywCge4VW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWv0oReTzAW+cazkX1EgvnNhhYFWI1N0G4OvOitPX8Ajtyw4EkwT/ReHt3EPAaCXlB4C7FEj8p9rSdCqZMfOZ/U6REtRKWkY+QTLL719SnkUmFCBENqGR0BKlqWCQk3+wIOIaXa1IXb1shEm4Jg/AGx6905yiqw2r7JNSPN9Y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gRpJz2g3rz9v7j;
	Fri, 29 May 2026 18:12:03 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of wesleys@opperschaap.net designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=wesleys@opperschaap.net
Message-ID: <c5527d8c-9147-4355-a07d-153d3977108e@opperschaap.net>
Date: Fri, 29 May 2026 12:11:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: git hook question
To: Jeff King <peff@peff.net>
Cc: Git maillinglist <git@vger.kernel.org>
References: <cc9fda14-d8e8-4982-9a3d-9aa816c0b90c@opperschaap.net>
 <20260529052141.GA1099450@coredump.intra.peff.net>
Content-Language: en-US
From: Wesley Schwengle <wesleys@opperschaap.net>
In-Reply-To: <20260529052141.GA1099450@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4gRpJz2g3rz9v7j

On 5/29/26 01:21, Jeff King wrote:
> On Fri, May 29, 2026 at 01:01:34AM -0400, Wesley Schwengle wrote:
> 
>> I understand the why, normally pre-push gets `<local-ref> SP
>> <local-object-name> SP <remote-ref> SP <remote-object-name> LF'. This has a
>> similar feel, albeit a different syntax. The difference feels like a minor
>> bug, but not one I'm worried about at this moment: you would expect it to
>> get the same arguments/parameters as the regular pre-push hook. But I
>> digress.
> 
> I think the "git hook" command is mostly intended for scripting, and the
> caller is expected to understand the context and provide the appropriate
> arguments. The hook command itself doesn't know about what a "pre-push"
> hook should look like.
> 
> So not a bug, but definitely a gotcha that could perhaps be better
> explained in the documentation.

I think the "normal" pre-push makes more sense than the one I'm seeing 
right now, but perhaps that's me. But I think that the docs would 
perhaps need an update to why this `remote url' are the arguments. 
Especially if you read `githooks(5)' it seems a little strange.

>> My actual question is: Is there a way to tell the hook "Don't give me
>> arguments, just run the plain command that is defined". I looked in `man 1
>> git-hook', but I was unable to find something that looks like it.
> 
> I don't think so; the command is expected to handle (or ignore) the
> arguments as appropriate. You could obviously write a wrapper script to
> handle that, but since hook commands are run with a shell you can inline
> it, like:
> 
>    git config hook.npm-test.command 'npm run test #'
> 
> Git will paste together the shell command:
> 
>    npm run test # "$@"

That doesn't work on my side:

$ cat ~/.config/git/js.config && git config --get hook.npm-test.command 
&& GIT_TRACE=1 git poh
[hook "npm-test"]
   event = pre-push
   command = npm run test #
   enabled = true
npm run test

[snip, alias expansion]

11:49:46.746800 run-command.c:673       trace: run_command: git push 
origin HEAD
11:49:46.746811 run-command.c:765       trace: start_command: 
/home/wesleys/.local/libexec/git-core/git push origin HEAD
11:49:46.749640 git.c:502               trace: built-in: git push origin 
HEAD
11:49:46.752107 run-command.c:673       trace: run_command: unset 
GIT_PREFIX; ssh git@gitlab.com 'git-receive-pack '\''some/repo'\'''
11:49:46.752135 run-command.c:765       trace: start_command: 
/usr/bin/ssh git@gitlab.com 'git-receive-pack '\''some/repo'\'''
11:49:47.549946 run-command.c:1576      run_processes_parallel: 
preparing to run up to 1 tasks
11:49:47.549988 run-command.c:673       trace: run_command: 'npm run 
test' origin git@gitlab.com:some/repo
11:49:47.550012 run-command.c:765       trace: start_command: /bin/sh -c 
'npm run test "$@"' 'npm run test' origin git@gitlab.com:some/repo

> @skirbi/semtic@0.0.18 test
> tap origin git@gitlab.com:some/repo

No valid test files found matching "origin" "git@gitlab.com:some/repo"
11:49:48.145805 run-command.c:1604      run_processes_parallel: done
error: failed to push some refs to 'gitlab.com:some/repo'

> The more
> general form of this trick is to use a shell function, like:
> 
>    f() { your_cmd_here; }; f

Also seems to fail:

[hook "npm-test"]
   event = pre-push
   command = git npm-test
   enabled = true

[alias]
   npm-test = !f() { npm run test; }; f


11:53:14.678237 run-command.c:673       trace: run_command: 'f() { npm 
run test' origin git@gitlab.com:some/repo
11:53:14.678248 run-command.c:765       trace: start_command: /bin/sh -c 
'f() { npm run test "$@"' 'f() { npm run test' origin 
git@gitlab.com:some/repo
f() { npm run test: 1: Syntax error: end of file unexpected (expecting "}")

The wrapper script seems the only viable solution. I do think it's a 
little annoying, because any linter, tester, thing that gets called by 
this infra now needs to add wrappers. Which means you either need to 
start making a githook repo for all the tests that you have.

The following circles back a little to the first response.

Tt kind of diverges from `git hook run pre-push' and how additional 
arguments are given on the command line with that invocation. Wrappers 
need to become aware on way it is called, either via hook or via a 
manual way, because of the `remote url' that gets added.

Normal hooks get that info via their STDIN, wouldn't this also make 
sense for these type of hooks? It makes differentiation much easier.

Cheers,
Wesley

-- 
Wesley Schwengle

