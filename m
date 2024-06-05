Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D149638
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576305; cv=none; b=e3TTaaa5YJxHDLXvxIkK6kEJL/cNWxgebr5MhuH/xu+d41dR0VvUHFhOd9+WH1Z3kEJrkAbypUB68TsBsQ1Of4FKN5V9iTT5wyw3xmLLoZ5mCNa8mZCZ0Yet7lkxG6VMaFEuyIxM2DkxMX8EglAnD9kg8qRLAsLTgvIYu1U36ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576305; c=relaxed/simple;
	bh=fQXQ0GyP/00KV/hHDnr94PRBoShVSzzrhG2jKyIXIqI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FllvgDllNZ31swaYZsDwmQcoAyblCA06sW1f6Gr+ijJnuGoA0Xp1dBhKkzbndIoX3gE9fxcjsSK9TP+XVS6BmxZJ1FIbnWYYM4ERXTLKcFDNcA2hz4XJ5OLe3y2RWncnlLRnI8VreVrvEeTYVlkaYNUeASABM2GqwsblAUB5z/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=on2NOYNl; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="on2NOYNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717576292; x=1718181092; i=l.s.r@web.de;
	bh=xfZVVd4WdqmCdSqUjxlxtVutIE/fUfXI8ylEOtjhxn4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=on2NOYNljzLIJXUCTlf3ycO/sgJIZFVqs5ZfZI3C6N3PoY4HfQCgaEbf1ic/kAjV
	 HkfA9eL4jDmuO5Vl+oz+HHYSQELMrZjIkxK6DPPprUp3ar9I5bX3oTeTRAZQLpJqx
	 0VYuzu4mx8RVOq99gEead5Icj2gLdy4aSCjbt6PAdyFbJeFVRUnWfBI5UTwbF6Snf
	 b3oxrn21N2aEaQTMPFGdA1F7j/XV8gshlJIO2lk7GcXpMOIU8grZ3fLejKAqKKCgc
	 fPUKThh+EJP9CSpx5Fs5aLd2m/wJFC7zXibkR5C3KGxRfGubSTYOPUW0FBCGUsDQp
	 cxlBl3i63XqnTfPO4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgX3-1siJAt36yZ-00htiP; Wed, 05
 Jun 2024 10:31:32 +0200
Message-ID: <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
Date: Wed, 5 Jun 2024 10:31:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 0/3] diff: fix --exit-code with external diff
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
Content-Language: en-US
In-Reply-To: <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ung+cqk8yh9MLebr4bntF2bAhwOMWBoEzfAvjoahurfW16St8hY
 Fu3mmLdmSOG9dhvly/IecD/pKpWgeL5x5EOPb5o55uKEGtwYXO87pXVlw2Lbpen65+jY/UP
 sv5PdgsLCjw4x/4hvgunrVkitiNylRAIqJLOOjBcybFmF5ttFJhQvgIkc08U1atwqvzfWCc
 REUupWshHX2sNaI7lphBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5AjVwMdSRwo=;TxP/GCji9mq4r281LP99n+izVNG
 M8hstIBzq6nQhRed5JvQEIggMzA1OlkhI6zaQJMzR4F/7ho1BVLqVcFpjMfM8CF5Frj8ndtKN
 my91rW4YZkZ5nxjf0NmFU7Pei6z2gtDoWK3ECT8/adz7hG0O25EYSebZFjooQfD2xehMIOt4l
 BoVlwUMGxijzuowcjB8btFulsfxp3Cg7mQHNbIoYXPKRuD3e4MJ6JywVMwj0yGCIN0GRqgyEn
 wcIsbiuc7TJlewhimL91c2MY0BAI/4Nr+zYw9L9B0eckyklL5Cg7+CEjhqaqsGPLjgl3OTy2F
 +9P8az1k7kc+Z/4ed6B+p2RM55bixya0twVAjcSJJQKhrJmfrAj53oFlHw4Z/ELmn+sCVWTVu
 AfsUvK2TvsIx9kD4i71NedZX0ytXAR41Rlhhf/Ua0abEHAejLgq7XKB8dDNEUmggpZyXueqpo
 pJLqqfztbtA68ZHTE0T8hrzpZ2TGQSg/svRacA9na5P8mz7I5iwMVwk5PwqOlO8ME4RmvH2U0
 ftYuHzA2WcRjpLdQDRkEfBLKi/CnqXeQbaV9GcS5naSQBB4wPTBF1JvA7kU8fWUT4nZmP25Ud
 DgJ9d8KLJ8SK7FKxh99Qd+a4sr2pafSyLBHp0vo/MMlVZV3aJaE6jaCeotksQ06TCz/suiW4D
 hpxUS/GWv3859roE/TBIFn0NvMIMAYWnFLSB77svvubuNm2HUVBJY+ntg3II4gfL31ed+R3Jm
 8eOOjfbfRs4jUjWcvTxCjHTObxiVSouoJLRwC4lqQ1DG/FbSu4I5fsh/uftwn++A/AiVGxi70
 n6U4F/Yxqf60UGFwmnoIBazqFfWw2H5X8N0n/D2xy9HKQ=

Changes since v1:
- old patch 1 was merged
- old patch 2 was merged and reverted
- new patch 1 adds tests that exercises diff --exit-code and --quiet
  together with all methods for specifying external diffs
- new patch 2 adds a struct to store the flag that patch 3 adds
- patch 3 adds configuration options and an environment variable to
  accept diff(1)-style exit codes from external diffs

  t4020: test exit code with external diffs
  userdiff: add and use struct external_diff
  diff: let external diffs report that changes are uninteresting

 Documentation/config/diff.txt   | 14 ++++++++
 Documentation/git.txt           |  7 ++++
 Documentation/gitattributes.txt |  5 +++
 diff.c                          | 62 ++++++++++++++++++++++++---------
 t/t4020-diff-external.sh        | 44 +++++++++++++++++++++++
 userdiff.c                      |  8 +++--
 userdiff.h                      |  7 +++-
 7 files changed, 128 insertions(+), 19 deletions(-)

=2D-
2.45.2
