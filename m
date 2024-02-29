Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251F6311F
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200493; cv=none; b=ofnAVBhPZ/g4p/7l0Tbm5OCQ53PRMWZCGl/I8ihIiyS2uNMBToDKHWRNybFTbZ1EeY4f1LnrfIc4WsZIYTo6tEKWlQEQfc2kLPkBuFMCsEhCNvaY7jUvAMzpMgEs+NFqyGSnH0uSPxA6zvt0CQKI9LoOrhkC7b5/YxdlvRD6IMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200493; c=relaxed/simple;
	bh=5cb7hwD8fTDXWgplo8/IoblIgaTh5Ko1xToSoL76b2s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dgs4N2PdH37iiF1HRQjgiNRb7Ubd4LKep99LWWjf5zEhnN6oVgH/Cd3RS3Ga5to9AsahCW5PFQwtqXofCFQrmLbw04ik1ghCXZAr+u3brPnla6YxkQ8BPuakZq/U6mxvzC83aLRZlbh8fc3M9wbOBha2AbYuGuaD0x9jZ3TWfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=oLCspWIn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oLCspWIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709200468; x=1709805268; i=johannes.schindelin@gmx.de;
	bh=5cb7hwD8fTDXWgplo8/IoblIgaTh5Ko1xToSoL76b2s=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=oLCspWInT86XnvT+TfioRlcEEaok3xmiC1A2xtVMSn45dNBSy7tF6YOXA5XuP9kA
	 1RH1GzSl+fHRlrg4Uz5fQhnXkovyDMqL+fMWW+1oebiJ3oBgVBaArfdhqLEJLIvYx
	 DT3Tmt27OFHVFdkejyk3/VjUYqFCwDZFMxNNbPg42ZTtZcMBF+vQCmeAPfv46pvJI
	 pFel2mDSzE1BTssMqDuhtpGrBjZJF0mX/DFZZEXY/cNdY2jg8XdsBfIlKWbRO1KRk
	 3nCHkcIb1ilbBght96hohJeoPre6vs3Wm9AvpNzumrw3myPv7emNILBdUJuaCejP2
	 aj5TP0SDC88wHbhXqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.196.15]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGVx-1rVvOY3eqz-00PanO; Thu, 29
 Feb 2024 10:54:28 +0100
Date: Thu, 29 Feb 2024 10:54:25 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dirk Gouders <dirk@gouders.net>
cc: Junio C Hamano <gitster@pobox.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 04/11] commit-reach(paint_down_to_common): prepare
 for handling shallow commits
In-Reply-To: <gh7cioqp8p.fsf@gouders.net>
Message-ID: <7552da7e-2aa3-73bc-2e55-304b09f280f8@gmx.de>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com> <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com> <837aa5a89c640427a5de064da93f1de4934d8212.1709113458.git.gitgitgadget@gmail.com> <xmqqedcwjq04.fsf@gitster.g> <gh7cioqp8p.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NYpM165htMDg8TPb94280qpwdnXTz3HHCAOxIkScI5nq3r+ESBh
 LnjMBI6eIUpdNhfpeQtHMdHOy0PTbUltoJljzb0/WEbTMdhAo4yKuQrRoUhC8Z+mfGNwUf4
 DXlN7KIH+h5goUUX/u2noTIhp0EmfRd6ZSoatLzSfZ8QmwLCxa5SKDv2BC5z0rC0Wj/ESb+
 hZCa9yEQxerQWFmyGNCOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N6GTr/IzHLs=;QxaH3JnFXzwd1ZfCQd+tV3+n770
 uPaMNXdPIcZrCa/L/2/ELKVFc+7HI93I2wsBmOhkybubHRoU7MmnBBrDF/he/zHbMpfEC23ES
 +Lid9PcbXjQhQm2MIyiuixs/980bGbza1I7m9bFJRpmXVo1JMHSJXlH7zT1jW+HIJoZs9+nvU
 4oZM7V8yIxrcZJg5wd4e1tl6jiEUPH9xlHcQGdC+tUH/3mYfNvWRb4RMsoak6xor2c6IdHWOH
 YSY3WesfcoJSRBlG1dLHW9yx3jWJ6gKLmibCdzZ6pUSlQPTvhsXLiOY/PjN2tsno/DQ+8bDMT
 6zRgqC7YnrnVSvAls8XcOsur/XxLrUi98SevXYVMPCgq/NU54D/Zk3b7s4yUJRCuSO1zFRxKG
 77oKj9PSs5Vg+/iRuCY8LTlU4FBsA2pI6JRl8otWehUM/NlI5Jvph+agFLqTKPYMi2kkPm0oI
 ibCl1FPJHrcJBztQPvCmyb264Y2PRZOeM9QCmjHcq4yCDpFzMsVfc0XJFmqNiDPK4J7imDY90
 K+YpDP0vl80pyPaJbNbb3OwplQVzQa6XcHSFPX0EPk3xJNSdxIv7JzgOpFF+Obo1mve8ppIDK
 jGqtpbs1uFHomUFOmrMFZnIpJJ3bdzqfDQfjWSFsn23qyuFeJDM1CVM8dWUq918qYXZhmJyqH
 G1C72kp7LFYGXSA7zVhl3d8liLMfRpl3oEWHreWGu5BN3f23enHUQlg59eDFB4OKDGljiHuzs
 aKqlS40QWnXwHNc4Fm5KxxTxj3LQiqnFN92x8p+Rv6OfhPTFNqkbfV+xnfb0oowW9tqdgAFo7
 jTboopSALNdpReOyH/OA9Gm+FyhpBCugMMzDxujS5UgGo=
Content-Transfer-Encoding: quoted-printable

Hi Dirk,

On Wed, 28 Feb 2024, Dirk Gouders wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>
> >> When `git fetch --update-shallow` needs to test for commit ancestry, =
it
> >> can naturally run into a missing object (e.g. if it is a parent of a
> >> shallow commit). For the purpose of `--update-shallow`, this needs to=
 be
> >> treated as if the child commit did not even have that parent, i.e. th=
e
> >> commit history needs to be clamped.
> >>
> >> For all other scenarios, clamping the commit history is actually a bu=
g,
> >> as it would hide repository corruption (for an analysis regarding
> >> shallow and partial clones, see the analysis further down).
> >>
> >> Add a flag to optionally ask the function to ignore missing commits, =
as
> >> `--update-shallow` needs it to, while detecting missing objects as a
> >> repository corruption error by default.
> >>
> >> This flag is needed, and cannot replaced by `is_repository_shallow()`=
 to
> >> indicate that situation, because that function would return 0 in the
> >> `--update-shallow` scenario: There is not actually a `shallow` file i=
n
> >> that scenario, as demonstrated e.g. by t5537.10 ("add new shallow roo=
t
> >> with receive.updateshallow on") and t5538.4 ("add new shallow root wi=
th
> >> receive.updateshallow on").
> >
> > Nicely written.
> >
> > The description above that has been totally revamped reads much much
> > clearer, at least to me, compared to the previous round.
> >
> > Should we declare the topic done and mark it for 'next'?
> >
> > Thanks.
>
> I agree that this text reads much clearer -- even to me with close to
> zero experience, here.
>
> Thank you for taking the time to rewrite the text, Johannes.

Thank _you_ for taking the time to review the patches and help me with
improving them!

Ciao,
Johannes
