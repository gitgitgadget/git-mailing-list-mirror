Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C96F068
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074738; cv=none; b=ndfzm92jzidf3KkXZbacl8oMMdJesrY/650+5uGLmOgEMfuVO5XymyEx/bMOOdaip0d7DpU2BDRYVWnfn5nFKRBpVb1U2Acajt6OStFwrAB5FtnsP1dhCLV63Et1jVrYHf5quoF8WqTqV6BcxzFGnVfRMjgOk90aakptrgyrUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074738; c=relaxed/simple;
	bh=Isw7ecjIr/6BnfQj2OgvMUuNdP6lT+SD3iSrAqVs7A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N2iJu/R+lSrgCxfcdxxfFoCIagLvZnmIbezJjBEbCvfS/ToDC4aCNxNw/i2wfcuzLoa7Pdgbzut+LcSC7jd5AVvgHn7MXq7LragfgaK8KFujUtcylELkdLcQe1ljSioXTfbt99gH390UJVjpVtj2mmYF3pyHW9FaXFR/+LJc/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dT2kmo9t; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dT2kmo9t"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24A4A349D6;
	Mon, 15 Jul 2024 16:18:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Isw7ecjIr/6BnfQj2OgvMUuNdP6lT+SD3iSrAq
	Vs7A4=; b=dT2kmo9t1fV5+oFGls29lMq44heouEx2TRcaLb8LSbLJ3aOK4ILpW/
	7omjuQQtxsqT2fZwMqxA7UyWewhJ7AFQ/MrvcF3IvFOkxQ+trApN/mIQLdbfTPRD
	hxj65JQe30KtyN/Wt5cK8+7G2o7PxO5GkT2sa2OSzwRjXRvjiKyK8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B659349D5;
	Mon, 15 Jul 2024 16:18:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84A9B349D4;
	Mon, 15 Jul 2024 16:18:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Scott Moser <scott.moser@chainguard.dev>
Cc: git@vger.kernel.org
Subject: Re: Can dependency on /bin/sh be removed?
In-Reply-To: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
	(Scott Moser's message of "Mon, 15 Jul 2024 14:41:43 -0400")
References: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
Date: Mon, 15 Jul 2024 13:18:52 -0700
Message-ID: <xmqq8qy21k9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 74C2FBC0-42E7-11EF-970F-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Scott Moser <scott.moser@chainguard.dev> writes:

>   [credential-helper]
>   helper = /bin/myhelper
>
> In that case, the shell is only being used to tokenize 'myhelper get'.
>
> Is there a solution that I'm missing here?

Isn't the above example faulty?  Shouldn't it be more like

	[credential]
		helper = /bin/myhelper

> Would upstream be open to some modifier on the helper value that would
> indicate "do not pass to shell" ? Like a '@' to indicate "direct
> invoke" rather than letting shell handle?

Absolutely not.

My first gut reaction regarding what needs to happen was that
somebody needs to teach credential.c:run_credential_helper() the
same trick as run-command.c::prepare_shell_cmd().

In the latter codepath, run_command() calls start_command() which in
turn calls prepare_cmd().  The prepare_cmd() then dispatches between
prepare_shell_cmd() and strvec_pushv(), but even when .use_shell is
set and prepare_shell_cmd() is called, prepare_shell_cmd() knows
that it can bypass the shell altogether if the command is simple
enough (and /bin/myhelper is indeed simple enough).  And when that
simplification is taken, shell is not involved at all to run that
simple command.

Even though the code path starting from start_command() is what
run_credential_helper() does use, what is run is NOT a simple
command "/bin/myhelper".  It will receive arguments, like

	/bin/myhelper erase
	/bin/myhelper get
	/bin/myhelper store

etc., because the caller appends these operation verbs to the value
of the configuration variable.  And as you found out, to tokenize them
into two, we need shell.

We may be able to teach credential.c:credential_do() not to paste
the operation verb to the command line so early.  Instead you could
teach the function to send the command line and operation verb
separately down to run_credential_helper() though.  That way, we
might be able to avoid the shell in this particular case.  That is,
if we can 

 * Have start_command() -> prepare_cmd() -> prepare_shell_cmd()
   codepath to take the usual route _without_ the operation verb
   tucked to the command line, we would get cmd->args.v[] that does
   not rely on the shell;

 * Then before the prepared command is executed, if we can somehow
   _append_ to cmd->args.v[] the operation verb (after all, that
   wants to become the argv[1] to the spawned command) before
   start_command() exec's it

then we are done.

Having said that, I do not think you can avoid /bin/sh if your goal
is "minimal image *to run git*", as there are many things we run,
starting from the editor and the pager and end-user hooks.  The
credential helper is probably the least of your problems.  What's a
minimum /bin/dash image cost these days?


