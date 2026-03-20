Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A53CEBB9
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774032872; cv=none; b=tCqWNq4BLKppX5v9No3KsRcK382BIgm23zu1q4dWqcUHlaDKxybnQXHW9ahqrjTGKu3EDVdiQapgYJIvhdD2SOAf6cYMaGFq0f1wWItcou/CNxO+s9sIKVXGUkCnVZAm3f6MdQNrzk1rlJP5muVYyWoWULbohCCUjr4t6/JiKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774032872; c=relaxed/simple;
	bh=jC++PHsefQ/0WVMrWq548X/s3brIvFqbn1DvoLHHNl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERDulhCoGkMu9U9POwsBQO3/McsMEIqu82Z/lWvom2/p3mjXdpLl2KVror1pXv6E4W7omLeZF9gNR/A+yUFPowBl4+S84xYaEPwmiEUpYJfQ1WAmrTaRRr1nmGPcS+I0yKpVKBE3197n7CwQckHMJeLKTrhG/RQSGCZg/tVW++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EndZGwXQ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EndZGwXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774032861; x=1774637661; i=l.s.r@web.de;
	bh=x1drrYpuzHUKN8Xf+h7szVnTaKbbVwR/n5L7W8lyqT8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EndZGwXQKgSV7XHjqTBARsaBiZftMcshTaxXGK9HWEpgcBxaHI8hjM9dSfBjJZpo
	 9KrSsF9rihyug9fAaF7JVDGccHXnpQj41IVBz/IY/2Gp88NfDEJNckY8omM/pNEjp
	 SjWZEHgOFO0cHKX05tvUD7CUdLyete0N55ttQkq7pibUyMZz/5VX6r4cIoxHBT+A5
	 YW2blF9kml8UQ9HY/8zUACj68mviDgZ6RW4JUieCgRoI0Qv8bLSHpqwX2TyIlgVOb
	 WSqzBQMOw86Ph320f8UIPUtbMZgi+35rjSdTGXtEstl6qqu8hpgY4vML8anoxF8Dr
	 bFjiZTPnHLNMNEyOng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgiXQ-1vMbzd25Eq-00mIx6; Fri, 20
 Mar 2026 19:54:21 +0100
Message-ID: <98833ee0-4d63-4d72-9a0c-d668a421ece4@web.de>
Date: Fri, 20 Mar 2026 19:54:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] path-walk: fix NULL pointer dereference in error
 message
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, stolee@gmail.com
References: <20260320114823.3151961-1-ysinghcin@gmail.com>
 <CALnO6CDnwYaAPhp67kaYWtV48ULjWAR6ks1khVXmSs1oWUbRDQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CALnO6CDnwYaAPhp67kaYWtV48ULjWAR6ks1khVXmSs1oWUbRDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PWjeWtSc087hm/YMulPLn6E7ZkSP5ZE4BZ0cS7ndJddajR72pza
 /TxeHuEtIvWIRGqrF7YaFm13sCXpBAgf+KTy4vq6BoFruS5G8711fRdMDb3QYTBMd89VyHy
 YLkLhUHW7KUQba+rNM/46Z4oz4QiLNG/79x3i5XHSj84JIFAs1GtvsBe6tfDDe/ObzFCgTf
 VcPN+qZMAWTszU6Hc51EA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SmwdLYi35n0=;YgjVqKiFsHbxSEMKs7DW+GAQEeK
 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

On 3/20/26 4:16 PM, D. Ben Knoble wrote:
>=20
> When we compute "child" in either preceding branch using lookup_tree
> or lookup_blob, we only return NULL if !quiet in the object_as_type
> calls (assuming we hit the "else" case there, anyway). But quiet=3D=3D0 =
in
> both callers along this path, so !quiet will be truthy and we'll
> error() out there instead, never returning to add_tree_entries.

error() just prints a message, it doesn't end the program.

> Since I didn't quickly come up with a reproduction, I can't quite
> prove this, anyway. It's also possible my analysis is based on code
> that has since changed (I happened to have a537e3e6e9 (Merge branch
> 'sp/send-email-validate-charset' into next, 2026-03-06) checked out at
> the moment).

We could build a tree referencing an object using a mismatched
type to hit that.  It's possible by removing the type check from
builtin/mktree.c:mktree_line(), then using the resulting twisted tool:

   $ commit=3D$(git rev-parse HEAD)
   $ tree=3D$(printf "100644 blob $commit\tcommit\n" | git_evil mktree)

> Still, fixing such obviously wrong dereference is good, but I wonder
> if we should go further?
>=20
> You mentioned git-backfill with a tree missing from the local odb; do
> you have a short reproduction script or test-case?

I don't know about backfill, but this would work:

  $ echo $tree | git pack-objects --path-walk --all foo

Ren=C3=A9

