Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C97A714
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414809; cv=none; b=lppVcZwJATOopN5R/F3Oa33kzb6VGn4T7jVxaXjnP4bCXUALBBt7MH390yfIJctrq2lYb08l5njGyREPP5UWEhqDoQ1+Eehph2JbOQi1W7ws4CCV+qGj4o+/WTVfeukJB9QrJJUlaYG5r4PkMlXLAefzBJf7xHf5yy60RHcYRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414809; c=relaxed/simple;
	bh=sahhgTYgv4XcToccSMlW9hbxke+eCaaU+UouY1uolOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZSxhM6BtB7nq5yN8L87zE0gpPDvEwDpN2nUawHiea5N+O61jJ4v1Y5qlCwGo2BLnYH7Czor70fb3zrsRDP96incbh6KwbbaA2bVFM6atNF1vJTVWMKWK3d+VmqnV38RJfcZ+OQUqj/4y/NcdCzLTxT7BbTUKK1yp4VklesDN7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bB4dVAKh; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bB4dVAKh"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47F041E7BF9;
	Thu,  8 Feb 2024 12:53:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sahhgTYgv4XcToccSMlW9hbxke+eCaaU+UouY1
	uolOI=; b=bB4dVAKhOTwMb3urUlqkQi/Vfv+mx8ogUGNK4+yAJTk8L+NtCcRerC
	wKspPnz4GcTKUDR6YLWGKLDHulLstavH2Bu+QSlWjSAX4ejulIG0o0CTyog3695f
	A+hIEmtUM1Y+MNMW7izmIaww7h+CI6toSVWPSU+inLVJJi2S/G+50=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 408521E7BF8;
	Thu,  8 Feb 2024 12:53:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A49DD1E7BF7;
	Thu,  8 Feb 2024 12:53:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
In-Reply-To: <ZcUOP_rWUwymhe5c@ncase> (Patrick Steinhardt's message of "Thu, 8
	Feb 2024 18:24:15 +0100")
References: <xmqqr0hph1ku.fsf@gitster.g>
	<CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
	<xmqqcyt9fdc7.fsf@gitster.g>
	<CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
	<xmqq1q9oe029.fsf@gitster.g>
	<CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
	<xmqq1q9ocje3.fsf@gitster.g>
	<CAOLa=ZQaXxwrXmbmFvGR59EDo3Eqa-Xfc3OG9+6ES-veDU8Bhg@mail.gmail.com>
	<ZcSVx4slikt4xB3D@tanuki> <xmqq7cjeq43t.fsf@gitster.g>
	<ZcUOP_rWUwymhe5c@ncase>
Date: Thu, 08 Feb 2024 09:53:24 -0800
Message-ID: <xmqq34u2onaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F5478E64-C6AA-11EE-A2DC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> That's a different problem from the one I have right now. Let's take the
> following sequence of commands:
>
>     $ git init repo
>     Initialized empty Git repository in /tmp/repo/.git/
>     $ git -C repo commit --allow-empty --message message
>     [main (root-commit) aa5eec4] message
>     $ git -C repo update-ref ref/head/foo HEAD
>     $ ls repo/.git/ref/head/foo
>     repo/.git/ref/head/foo
>
> Now the fact that you can create "ref/head/foo" is a bug that needs to
> be fixed, no arguing there. The problem is that rectifying this problem
> with the "files" backend is easy -- you look into the repo, notice that
> there's a weird directory, and then "rm -rf" it.

OK.

> But how do you learn about this ref existing with the "reftable" backend
> in the first place? You can't without looking at the binary format --
> there doesn't exist a single command that would allow you to list all
> refs unfiltered. But that is very much required in order to learn about
> misbehaviour and fix it.

I think I have been saying that it is perfectly OK if reftable
backend, being newer and backed by more experience using Git,
rejected any attempt to create anything under "ref/" (to avoid
confusion to those who are reading from sidelines, it should allow
creating "refs/mytool/" for third-party tools to store their own
pointers).

> As I said -- this is a bug, and I agree that it shouldn't happen. But
> bugs happen, and especially with the new reftable format I expect them
> to happen. What I look for in this context is to create the tools to fix
> problems like this, but `--include-root-refs` doesn't. A flag that
> unconditionally returns all refs, regardless of whether they have a bad
> name or not, does address the issue. Think of it of more of a debugging
> tool.

OK, "--include-all-refs" would be fine.  And without bugs there
should not be a difference.

Where does "all refs in this worktree" you mentioned fit in this
picture?  Should a bogus "ref/foo/bar" be considered to be worktree
specific, or is it an incorrect attempt to create a ref that is
specific to 'foo' worktree that is not the current one and be
filtered out?

