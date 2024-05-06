Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCE197
	for <git@vger.kernel.org>; Mon,  6 May 2024 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715019803; cv=none; b=LcBEjW91xqNwy/uTSVc9ORsIQ3VejLaC/KNPUHKR89sB24RBLWNP9vKdrZ2RnQyvpqMa4Tn67XvocxJCfyxWlPi9MMASeKq6hY0QC0h/mUeWfw4XNkFy6JGpZwwVFEEk90paHVgO+9XD62aiwp4m7DZK5sqIVThONXvyNHJjnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715019803; c=relaxed/simple;
	bh=AIHOiyqjffgqwYVca/gmrIqmzjebrgHpOB2sqDtUWAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcVRIJyHS4ZTx99FHyrZzReXns3t9O8L0573CE5Em66UQS9G1AObP2uX/YSikkUhjFlL/qJ4IvXvD2hAGPd8CJ57Rz4+/jF/n9tUAswxGQItR/uCNSnU6L8sX//pFpmCWbwVuiCXMVLVtlcyX/VolU1wV2QvlefdIHuFPxXFIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=SlkNuY5j; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="SlkNuY5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715019787; x=1715624587; i=l.s.r@web.de;
	bh=KudB3NCq66HlI6xuy0Lm77DeXLmRDi7zrL3+HWqGUco=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SlkNuY5j5feZoKtCFmHvpAsnOxG15djvXOgcLtUKjAlm5pa9imognpfPoZMSVSMc
	 QfNr0S34yRRYR3G5pKYifR7GXA3Oi7ViLsZz8M+ms11nGb0qvpy9ASeKaNBgt9pge
	 /2iObb1nCFa9iJUVFaFdzptC2rs6kiSPnYLqvjafvaiHQKQ/Rfm6WgceouNRNNUzS
	 fvvtZkWZJmxLuqrVWEMqhdR0rLuOQDxeFjylquLnGtwaTPeYdx144uxeKAHCq2D5Z
	 AmG/nNrdoob4xfL2v6j0TEonwSCIEk/jFJP5VhC1zISpw129fUGZ46nOeL8TRnVWj
	 Ca18mlePsINBMQ6AfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QQD-1sgTR93pYD-017gZk; Mon, 06
 May 2024 20:23:06 +0200
Message-ID: <4bf12c41-a6ea-4939-ba76-e2c784952eaa@web.de>
Date: Mon, 6 May 2024 20:23:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] diff: fix --exit-code with external diff
To: phillip.wood@dunelm.org.uk, German Lashevich
 <german.lashevich@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <99337bc2-a691-45f7-9b6f-74ededbd9a78@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <99337bc2-a691-45f7-9b6f-74ededbd9a78@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S17Vo8Kmkm4QmnxyMEhzyn/xs63n/WTPLY6gF6IGpYaDKLraZWU
 IpIXaf3IJg+ryEg/YmXdgmmCHGk6L38o15dE/ZzM2OPR3tMPeyEUDkQpu+NHVKJ/ph8H1FI
 282a+wXrheB3OLXmUQZOEq7MaAXDvaALXqoaao2KULlhFlT6QxP3VAu2MpkLNrd4pSDwqhs
 18qtqanE/MiackgKeXGmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3B0Wbks7lrk=;gi0C8pcIwm8vg28GX7wyF4/7WBK
 vyLWh1m6rIG22lw+ZOxCIgaoUGcvyqPI7wohHN9et6+61na36zaOt9aDdLCwF5hozdakVFmcT
 CLvsGvPOu5wihJW4Y33zAl2HI6JOhzh98km1KHuqGZyuUf6h81VuXrh7gjak8V3bO/DDwWNPJ
 ehnoV0W0CUq2hVMF04mXgmuJM0Wm9VC0P0MwHgYgITZdxBibNQjQMpUMAk353vjnhkoSuDexQ
 XaBmA9K7Qak/AA0pRHbqB0E+2hA+ffx48WnVQzqNcR8IbPy6L7fJFEkAwUePZQtH9KuHqh7Ju
 TdQBtag1T15P9PHMhXkjc71wISvS6uPHvsw/eFrfo7Oe72GftbFVKbm0W28N/BBbxW9QmtNhu
 P2wn9c6xImOgtFU5rojmJRmKMfx2aIiSLpk9P7zOY5Z0uVmQUcl5Q3XY0IvJ59sMTjfEhIa9n
 kovIQJHObEcg2pXnq4HMmTmmTfmmv73wy3Hg63DfSRNzSvmSbBB6yFvGacetAdqbaSJzkECTG
 EAZdGDFzb1KJIFxs16+2Z+5rZ2Au0uQdUK2pnzhjnNMfiEHZH7HnrpzfUhglSBrvmam3uEomW
 iwkeB4YJShJkhFDa6qOl89S+RBIE8u3l2tTLf+QUhn3tamXBTUuptlBMdSe4KwBN9XyQGGR4H
 oOt57HHWCSJPCWcPrYCP1elzz78YZ6ZqO1e4Y8ablnitkMgFf5N2Zfhw51VL1kBQK6WTijQmy
 XoDjMQ/KoKtw0B6ufsBfOJV67vGZKJliA8h/IQpF8ZaVg2weERwDjEq26kv6lRZVKcccdMTpk
 4rDxQSu0MCFbPfnrGZmuBnFmjBTJ4VKt1J1BWbszzulVM=

Am 05.05.24 um 17:25 schrieb Phillip Wood:
> On 05/05/2024 11:20, Ren=C3=A9 Scharfe wrote:
>> Finally, capture the output of the external diff and only register a
>> change by setting found_changes if the program wrote anything.
>
> I worry that this will lead to regression reports like
> https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rA=
eqUCCZw@mail.gmail.com/
> as the external diff will not see a terminal on stdout anymore.

So external diffs might no longer color their output if invoked using
the option --exit-code.  I assume this can be worked around by adding an
option like --color=3Dalways to the diff command.  This warrants a note in
the docs at the very least, though.

But thinking about it, the external diff could be a GUI program that
doesn't write to its stdout at all.  Or it could write something if the
files' contents match and stay silent if there are differences, weird as
that may be.

> I'm not really clear why we ignore the exit code of the external diff
> command.

Historical reasons, I guess.

> Merge strategies are expected to exit 0 on success, 1 when there are
> conflicts and another non-zero value for other errors - it would be
> nice to do something similar here where 1 means "there were
> differences" but it is probably too late to do that without a config
> value to indicate that we should trust the exit code.
Right, such a diff command protocol v2 would not need to pipe the
output through an inspection loop.  Sounds like a good idea.  It's
unfortunate that it would increase the configuration surface, which is
not in an acute need to expand.  We could advertise the new option when
dying due to the unsupported combination of --exit-code and external
diff, but that's in equal parts helpful and obnoxious, I feel.

Ren=C3=A9
