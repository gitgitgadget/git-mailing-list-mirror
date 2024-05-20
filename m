Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672BF1384B4
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233905; cv=none; b=cWZw0GBNpM0scCDcBO0GR+kaiMIbWgIZa8vTMAkwFdMeg+Ya7TpET8R3JqeFrfknkpJuxB/BUzWPlHu+nOacPnhBj+RmLDvsYFZ9BZJ2Dv8u9qSCXqWqf/eTKQH6gT8h9gY+84rxV02BsIqXjUdFMxewCgvxLWex2hDpfyGFMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233905; c=relaxed/simple;
	bh=jND64Z8zQUM9jsDyiJOAJzE867CNSBVyjywEozO6dlk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XLsw5AXPRBGQAhsMdWjpGb4Wjbx4pUG9rLl5S94wbY5B/bu8g3vprgrb/jMLpUd4O8fvAxOi/62eSA4NBYdY0MYSeKkO4+2na2GDL026TNFbUyRu3NAoDPwWmktrk7n7k1f1YR3K6Y4gTvg8y9p2iWHcj7aK7NkG27aEM681q5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=IGvGI0Rr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="IGvGI0Rr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716233884; x=1716838684;
	i=johannes.schindelin@gmx.de;
	bh=sK+ewoxYxNfhY/j/FKZ8SSMBrttEWy1dY/x2DcovcGU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IGvGI0RrxeGUqvMo7SP1TuENRp/S2Wd4Xvtgoa1IocGlxT/BjMOR18S21QEq7t3u
	 H+vJBvz1tEdRhwUlKUK60/AxfJS6g/dr6YjwNLpKPhLJ3ORVt3QyIHcqM8Pnbe3V3
	 iR+oR0KfjphrtVQabXrluvPUFsrzOmNNk6Xja/XtT7ZBXXza9IP6K3ldHtz1xJcml
	 M4VhpRc2Dzf3G3iA0z/oZHlhf6Gqx7/Co8cGPhSSln0zpiit7AjSLdT3UhYvRK/aE
	 SPVjs75F/oNXtIH0HLmdmY8/XhJL59TbUsF52WH/4UXPBbIEjTSTKD++mLqSz4N3v
	 m8t58X1dbF20fd6o8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1sv6q536Vl-00prph; Mon, 20
 May 2024 21:38:04 +0200
Date: Mon, 20 May 2024 21:38:02 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Jeff King <peff@peff.net>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
In-Reply-To: <xmqqzfskfiu3.fsf@gitster.g>
Message-ID: <736b43a1-a371-4d6f-7739-b5b64e060585@gmx.de>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com> <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com> <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com> <20240518181432.GA1570600@coredump.intra.peff.net>
 <c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de> <20240518194724.GB1573807@coredump.intra.peff.net> <86d57213-e3b2-c985-6d69-71568c66fc9c@gmx.de> <20240518211224.GA1574761@coredump.intra.peff.net> <xmqqed9yob4v.fsf@gitster.g> <5e0d660a-b1ee-2202-752c-d46d3b0c8a19@gmx.de>
 <xmqqzfskfiu3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y9X+5IMkr++HKVUY6ml1AgP2ErHUPzqqZUX58edYwYUAZLW5GiL
 66D2vH4mduXwlJJ86vVLh7Udq5X5d7/6CsShTgFUh0P3AC1ZEm9m64HS1QVB/3lEAR3j6D1
 LHE4cRy18+adhpKLaoFpngq6uaC1IhBdBbedsVD1+XbE+ICQX3e204VsP7/UVyedik8miK8
 TNfXVYVitUuwHvaKgqwAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZtF9v86qI10=;fiYu5TuATVuZulVB+75WffAdWQS
 8SKG9VSofUZ7JfAmQEdpbcMYlB3wtileNraQQUVzUYjOmLUCZdoxa6NNpfWDfyB7U6lnLgE8v
 jcjWEZuQtr0rWwLViUo2fMfbgUX3RpwKqCvYvPAYqXbPp5uDCa6M26UkRk2MrR/H3ve97v7oU
 Rmau0Q4jZ6fFE8ydwL+xbJ4QisOOxxyLh0rmE+2Zk4m0+oGs5oe+MejBAB+vG4iLuFxRuv7HQ
 2yeJuqZJSeQ7STj+yMxUHIj4VWNtElIAl3A5+PsQyCgK/33BJE3e4820QWnQRsvhKvMcgWqmE
 7IwFj/YHADfWWlEGEfXAZ2jhvrlDSJGwiOm/C73c5NiKshEQOo4rnfmr2dt0ivOdVjFOVON8I
 HNRbBSUTqHyI0VoGKj1hplO4NloV8UVYAD9WmmS58IH4QVfwNpcppMPHlL1+tv5uoLAVGDhPF
 6c0nwBd0XkhZMGQPbNXDwQBuWmzvTmJCAPQcK5pUHOP8pGE28MheUUrnL6Cd7/iggOkbwta7u
 nxnTsRRT5QFAD9sezius2ZUDH2Pn/acdM4PC/H11HyiftV4YeY0soLZhXLcDB8n0WRnpfOxt0
 j7jZHXS8R8+B2Qf001+M4hN0A7XYb2k09GimySSmdLxdCRp5IVIDcuGAIZqp7ka0Ivho7n7h7
 ItxG2aICLIf+CH0IsWMr6NAK79pTfS9DAaUQAZ7i5+oMp8rl9yCPqzOopzIGy4ka8hQQFmEzY
 QoKZ2RPtstAChgYOkyp9BEGmBBFG/RhKHlMzfilpIFB567+d7UHpNnUzntyjc3OzxcBNG3/zo
 Ooi3l/xSXGd0wghq2rHi69ZMQVDye6OUb5DRxfLI+adM4=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 20 May 2024, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > To put this into perspective: If this protection had been put in place
> > before v2.39.4, the CVSS score of CVS-2024-32002 would not have been
> > 9.1 (Critical), but instead 2.2 (Low).
>
> But we wouldn't have a working git-lfs then, so that comparison is
> not quite fair.

I obviously did not mean to break Git LFS. And obviously I did not mean to
insist on the current clone protection if we could not have fixed Git LFS.
But we have patches in hand for that.

> As brian already said, you can reduce the score by making Git do
> nothing, which is _also_ an absurd position to take "security" (in air
> quotes) over everything else like usability and functionality.  And this
> time, the layered security went a bit too aggressive.

Right. And I never said that we should do something as absurd, so I fail
to see your point.

> Also as Peff said and I agreed to, we are not talking about refusing
> to do anything on top.  It was just that the "never run any approved
> hook during clone" turned out to be not-quite-fully thought out and
> it should be reworked in the open, and reverting that wholesale
> would hopefully give us a cleaner ground to design it.
>
> The end-result of such a reworking in the open may turn out to be
> the same (or similar) "register the blob object name of the contents
> to appear in approved hook scripts", or it may look completely
> different.  But the road to get there, and the state of the system
> while we get there, would be different.

I see there is no convincing you that the difference to our regular
"revert-then-redesign-in-the-open" process is that we're talking about
something security-relevant here, and that the revert should hence not be
done lightly.

I've made my position clear, so have you. Since you have the last say,
it's what you say that goes.

Let me quickly iterate on this here patch series (as well as the
`tentative/maint-*` branches) so that we can accelerate toward a fixed
version again; Git LFS has been broken for long enough, I'd think.

Ciao,
Johannes

> I would probably see if I can take brian's revert directly; if it
> applies to the oldest maint-2.39 track, it would be the ideal, but
> we'd still need to prepare a similar 7-track cascade like we did for
> the js/fix-clone-w-hooks-2.XX topics.  If it is only for the master,
> it needs to be munged to apply to maint-2.39 first.
>
> Thanks.
>
