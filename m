Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C834F28E7
	for <git@vger.kernel.org>; Mon, 20 May 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221159; cv=none; b=rGNuDCdR32ROz7P428sNXOQy29pSHH+TFoZqSH+5z1Jo31RlCL7cvfbxRuxuR2HqM/WyPQMiJlb9vDZjf5qMwyD7mfA1zLFT0Tdw2f7Etg5NrQ04Fc1LU51HZ1W1vgMSkpaUri040M+XI906+RvYDwrAiLs9U0VBeSXSkYQjkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221159; c=relaxed/simple;
	bh=kYeLYDokmYUw/dCBom6ltU/L243Xwo4uE+CI1myRPIc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lxilDk4U2f6XboDaWcxFeOoAtfDh3lGXnsO+Obxf+tIXu012oMCXr8rv8j4MJvBaguwQ/NRgASk+/4zVw+zWia13EHvcV72M1e3FvmCI/Drx7cUvJb81SvxLpboriRtxOVDplULDpZ4Dk0CLfHi75X1WmEeEkGNhOumwxG2vqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=hQwq2LqQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="hQwq2LqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716221133; x=1716825933;
	i=johannes.schindelin@gmx.de;
	bh=kYeLYDokmYUw/dCBom6ltU/L243Xwo4uE+CI1myRPIc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hQwq2LqQMAOjZLF66Hjnu6E4RItJsQUAhKee5ZFPBfdLoS5WnJVIBqxv2Kflw9nn
	 e6LTdI0L2bYOqz1KHNZ06StV1KENZuKKD6kwN72zytjAu7UU6Ird/QqQRRG7U/r2r
	 pZw3p8bcy+C+2Sx9hxm9TIKDkCiKtQ4PNufGcbaNkZdWceskcGTBjcK1Y8iL/WEQg
	 0e3UoivnuJ7m2arR4swt49F3TfmKKi1Mt1TCbYykHv95Kk3UOhqDqsJ1DwMKZfCGi
	 jDQSZUiLo/RJvDggfdyhB/S4e7V7CgfGW385kPjvYwue8G450feM56Xe7vDfaM+Rm
	 85N6Pk2uNKCdFlCxZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1smG1X0YfS-00eIhm; Mon, 20
 May 2024 18:05:33 +0200
Date: Mon, 20 May 2024 18:05:30 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Jeff King <peff@peff.net>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
In-Reply-To: <xmqqed9yob4v.fsf@gitster.g>
Message-ID: <5e0d660a-b1ee-2202-752c-d46d3b0c8a19@gmx.de>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com> <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com> <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com> <20240518181432.GA1570600@coredump.intra.peff.net>
 <c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de> <20240518194724.GB1573807@coredump.intra.peff.net> <86d57213-e3b2-c985-6d69-71568c66fc9c@gmx.de> <20240518211224.GA1574761@coredump.intra.peff.net> <xmqqed9yob4v.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M9BmMESTIAakFIk+hZyuDoTO4JrJRYdhyRJKauuKIarl+zDKWDy
 YLU7IIQliOhwlYUJDBKmmGGfKf5wgcZNHM3bgq4y3sVRtTyOpiuST3o4oz8AC68VK/YazEi
 6RAL87/emNUArnCrSrXbKxItu3voV0fsQxF4zAYAxdMh/+yGXYM3KsN29v/qhuDOcBqqwBX
 jsO+2wuZRYG8mSWPHLW1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lDHxPg+Fvgo=;rszaAxQuJamSjX7/YT/anTQmOZT
 hcQNFvCvJk7tyyjRj88IWbowD5lz7IIf3Oe2IVUaRVchX5qvK0gcevt84hW5pdESpzsYkvOrV
 25f8VhkpOJWxogYWzDn44P35yJl2BWcdQF4XXoVtY9JPIV/rSO/ORgbOHjTDGMnD7d6pFf87m
 oa3pUosWQrQLjq0UzBhjy565UT7BBE/VwoLOOTOEyl4VQmJ02qp+ok4rS+Kx6AL9rBMOHtbkY
 yCRbyPwlfg6IxAkaBYrkti9D+vMlYufQaARJjNbc+eSHGMTyOtssk+yMy7zetFAY/Qt7xLAzj
 2LcyaufHZK2fhhHXuIxqAq7Lx7tsnfAGQ7hBuq4JDb3MqLfjNYx1ays2oB2u6+7WfQDTjFOmD
 DR4KY6KLzu1jcLoukjjMWmWUcFE9Rf5teh1Qj9YZgPUu60aSvuRrmTGVxlzcGpjkV5yadYft6
 yPaof2P20AheCvcL2fO5/sJmu3WfG3Aml4F/T+3Zuvtf4/oGbps0Oqq9RT6YD95PV+4FnGHMl
 4DS4iqR+aBX/DHWPXxL83wrKqBzPojziaz4WMCujcjf8dx/937W662z47ki4KaET5p3vHByrw
 NkzOhd1znTSNRmzDYX8Anh85SD3095Wk0r3mHmINVYMDPiILSO388EzM8v8/bKUf/LutM3a4Y
 hDcuKun8VY/wug9Cjuy2Kywz+u9dFkis5xopW9TYDhJDoCa4vzAulGDe8BVys486Re1AKL1Io
 dwc6QNSXaOcInQxmd+aQXdZKjsxqrT/neOvFN4f9ZBYD4UsdrqLr9gRT8nhX3GouIZwd9CjcC
 SCKyooiS16z73DyBVSgnePROIf02lYfkQdVCQXoovFwrQ=

Hi,

On Sat, 18 May 2024, Junio C Hamano wrote:

> But considering that we are not talking about lifting vulnerability fix,
> it may make sense to do the (partial) revert all the way down to 2.39
> track but do the "fix in the next cycle" only for 2.45 and later (or
> even in 2.46 only, without even aiming to touch 2.45 track).

To ensure that I don't misunderstand you: You are talking about reverting
8db1e8743c0 (clone: prevent hooks from running during a clone,
2024-03-28), right?

It is _technically_ true that this is not a vulnerability fix. But only
_technically_. Practically, it is preventing vulnerabilities from reaching
the critical level.

Let's take the most recently-addressed critical vulnerability,
CVE-2024-32002. I carefully crafted above-mentioned commit such that it
would have prevent the Remote Code Execution attack vector noted in that
CVE.

To put this into perspective: If this protection had been put in place
before v2.39.4, the CVSS score of CVS-2024-32002 would not have been
9.1 (Critical), but instead 2.2 (Low).

In other words, even if a vulnerability was found, Git's users would have
been safer with this defense-in-depth in place.

The same `post-checkout` hook attack vector likewise raised the severity
of CVE-2021-21300, CVE-2019-1354, CVE-2019-1353, CVE-2019-1352, and
CVE-2019-1349.

It also raised the severity of the vulnerability fixed in v1.8.5.6 (for
which we did not obtain a CVE).

Based on past experience, we must expect the semi-steady trickle of Git
vulnerabilities to continue, and having this defense-in-depth in place
will invaluable in helping to keep the severity of those future
vulnerabilities low.

Therefore reverting that commit would put Git's users at risk.

In combination with the fact that we have a path forward via the patches
that are under discussion in this here mail thread, a path forward that
avoids that risk and incurs an acceptable cost [*1*], the plan to revert
8db1e8743c0 instead should be questioned.

Ciao,
Johannes

P.S.: A concern was raised about `safe.hook.sha256` not having tooling to
generate those SHA-256 checksums, and putting a burden on 3rd-party tool
developers.

However, tooling to generate SHA-256 checksums of files is ubiquitous,
there is `sha256sum` and `openssl dgst -sha256`, just to name two tools
that are widely available.

And it's not as if _Git users_ would have to generate those checksums. It
would be a one-time cost for the developers whose tools install those
hooks during a clone (Git offers no option to install hooks during cloning
other than templates, which is not broken in v2.39.4, ..., v2.45.1).

Which brings me to that mysterious mention of tools other than Git LFS
being potentially affected. It is quite dubitable that tools other than
Git LFS use this method of changing the Git repository configuration in
such a major way as to install hooks _while running a `smudge` filter_.

It must be put into doubt, too, that this method of abusing the `smudge`
filter is the best design to address Git LFS' needs. A serious downside,
for example, is that this Git LFS strategy is in conflict with
user-provided `post-checkout` hooks that are copied via templates. A
better design that comes immediately to mind would be to add a new,
generic batched-smudge filter that Git LFS could use, and that would be
configured in the system or user-wide config just like Git LFS'
`smudge`/`clean` filters, without the need to play hacky games during a
clone operation that are very similar to malicious attacks' strategies to
abuse Git's hook feature to allow Remote Code Execution.
