Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116430BF67
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765454026; cv=none; b=bRAdlrDtxnxetVw849kXiJHLRjlQ04TotXkvG2ZRq38j9Q6lfHb1KN4ykhlGNsj2fu4ZOcDImECTcrrLQrW2irtf9G1orlFdWql9IHhakL/hrmggfCTLuLB9tn+j12NIlofmbkumtZFhxnpWnH0xzcFWuETMZmcWWRQBbjKCkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765454026; c=relaxed/simple;
	bh=h89wBfXo7Dh6EG7ICsvRS2SHnQz4DP5DAit57mjgFKQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKE5BmO2evdPF9daQZmTAOqxJFxvWZDY/UmcM188QsB4pRBhHWgXnUtvhL+H2zUJb5FvafSruzSbSMa2HbogvzGb1yU90mtOKAkEFba9DbQH7Lzji+VSWfUyc48zurg97/OhmSjhxyB5NS3tYKTSMWlsFSGxD1pphmmqfPNXI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bYrFCHRz; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bYrFCHRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1765454021; x=1765713221;
	bh=nJZCCt/n4nZeaYftB4+SzsaaJvoxRuwZk/nm9jb961g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bYrFCHRzNJ98YNHoH4ywdKOJCODc0xFlgsY2yLutbbGlEThubQzyynMPSZff9nbn0
	 XE8q9eF3wOcMVKEMoCEeBEt0ajcLbjkjEw/cAGOMvuQ0JJ4Yk1r05KqQxx4+nOeRTg
	 ZUHfqcw1/4nBTkgHwDAWZWPU/g3vMBqW8co6vQPhVzVgZ6lRIGyVUlccclmEsX+RlT
	 /VSvEBAqTE/s0ckdLCAJEe/XblAmKvquPmrNWOs8beJJ+42vIQ+ZcnL4WV0LBJORqm
	 iL7jI4EWvE9ia+yx8Mz10WH85jQqYARXxXzmQe3toYMDraFwjpErd7Buil7TTFNxR+
	 zpbCfDgdSZIqA==
Date: Thu, 11 Dec 2025 11:53:37 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] reset --hard: warn before discarding staged content with no commit history
Message-ID: <0lbeTWjDGq8hINMi-lj65HLgAIlUNZe_tzANStd9xxHQqAyZaEnaA0yPzVeY_VcReQIKNjY7eBEUGwMGvlbZ-0W0QZpux22cIHnosa0eX_k=@proton.me>
In-Reply-To: <xmqqldj9g0pj.fsf@gitster.g>
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me> <xmqqldj9g0pj.fsf@gitster.g>
Feedback-ID: 140350232:user:proton
X-Pm-Message-ID: b14b8d6f67889a3e7170dd126410efa04a01df25
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me> writes:
> > When running "git reset --hard" in a repository where staged
> > content has never been committed, the staged files are lost. This
> > seems like a case where requiring --force could be helpful.
>
> The thinking has always been "'--hard' means what it says!  HARD
> removes things harder than other modes---there is need to add
> '--force' to it".

I agree that "--hard" conveys serious intent. But I would argue there is a =
meaningful difference between "lose your uncommitted changes" and "lose you=
r entire project".

To be clear, I'm addressing a very narrow scenario:
the user has run init on an existing codebase, staged files
with git add, but has not yet made a first commit. Running
reset --hard at this point destroys the entire project
with no realistic recovery path. This is almost certainly
never intentional.

Thanks,
Stefanos


