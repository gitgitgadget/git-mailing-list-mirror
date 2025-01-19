Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD313C816
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737279111; cv=none; b=P7GG6fKMEbALXkER5JsbgWTceUvl2O144nXcA888nTPZCBTzeH1ma7NeCCwbPJWiovnGM/eq+Wg30FtwbdXUgCjASvLYk79V8AFY9058yL5VxnaUPFpiQrVcMUFN12PhfDzCd+CfczOzBObmOMDK6OF3+1Vfpqqw4j9ae5PgY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737279111; c=relaxed/simple;
	bh=+/Jciytm/TNuXzE7dWR0SgzIqmXK2kuxEydPSymGrBc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NDsAf9TqYrgmVcMPVvLci3/7v4OYSkdf2B7A3FgQV4iBpN3CbmqrCIN+Rp89DWdW44Nsd37RUgLLxCbcs8c+xKx/aNIgwCmurD9IoNX7Qb8iZUacd9I3n5pLreT4VDtHdWd5KU8mYioQk72oGK70IIvwbu4iWTMq6p769s6PYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=DSu+63dC; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DSu+63dC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737279106; x=1737883906; i=l.s.r@web.de;
	bh=atRsfDQNSoPpzPPbTdTR5/AQN7ld7mX4IUIG9NMfoM4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DSu+63dCgn7WlbIterpp1JksDBXew+w5l+kDrd9dGCFT2JWS35jVp6M3bCDuE2OY
	 RLPcJb8d40hZ3Pz1aInRILImH9hPr3A/i9LadKDT7bfMvmfVBBHKx7yRXz8rtC9kP
	 9dyzwpVEgdl0eKt+Tc/SJjUAFmL/cfQWvU9FJ+EDEL3x5+ZMjSUhB57IqQG/0TwPE
	 CVyzu9FbcGpmN0EbpcFbObxzpEtSYVfiHJ7pFBLzyn0YJp10QnEerdUbjOtUTPMeC
	 y1FhY/0jceBoWs5VJjF63cC+e8Q35JfoYAiVLfshsDLenfJBap+zRT57yHMc33dLS
	 3+XydAIKq4DlpSaCtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MY5fd-1u1Ce72YKj-00UCjN; Sun, 19
 Jan 2025 10:26:26 +0100
Message-ID: <cb3d6e8c-6c39-423c-935c-db0e8619c504@web.de>
Date: Sun, 19 Jan 2025 10:26:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Jeff King <peff@peff.net>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
 <20250113051700.GA767856@coredump.intra.peff.net>
 <57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>
 <20250116095128.GA144555@coredump.intra.peff.net>
 <20250116100637.GB144555@coredump.intra.peff.net>
 <20250116102154.GA724126@coredump.intra.peff.net>
 <2fbe47c2-22c0-49ff-a211-057bd96ddbc9@web.de>
Content-Language: en-US
In-Reply-To: <2fbe47c2-22c0-49ff-a211-057bd96ddbc9@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zGgxf+f/IR8imKgooLEDB4AWb71hSMge3wfDt0aFr4qmN5+eLIE
 5R42cNXQN92UfWNwW8/FTQhT98HmsBex8mjF/dV2rHfk42gUOVdtDksJtLQi6AZ1NIgfB1T
 /EKlSA7Bx0sxwM96LhAFut6JVwcU1J8fkFWdKKiWkBwzIVwUd8fney+WdwZChundb/uVdbK
 v+FCitUo6Ei58Sduh1QPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:76qF/9icOTs=;jk5FAUA/pkm0xYIL24nGMFCjjHP
 GgcVzu57bJaj1591KMHIv482jyr+hQpgqwSUOk1Fx5oGNrSs10ElLu9hBvMwB3T+AzWwPlRhQ
 f/n8V7V8yRCLsVgMkD0qqhMLx/hqsRockqbnlm0jH6Pq01dD+BeSrMWIQrBgzvQ1171xxOBm3
 laOAGYC1b8G9qzyRELZfn1iJOYyfEurpXGOHgTS6eNF6i97O/+5vs7eiHcRFYstGeungwAUF2
 p5TW76JVN/rjfCD7XCZfWmvFYLuDYhO4atrWL5O1FlclH7x49HkH5QxDNrexDRVVvVwvG2qnB
 uaV7rfDmj5LlPLqm140MXZNKS3HHeej39B+/YmVjL5GSiraAmt7co3g9sd6xDxbBSawof/5Y1
 MZV0R28Z1W6EZiqmZfvVPsDJJCZeIz+Y88mlcNI38CDHk/ymfbVvQrI2Glv1EeMttoLR2XA+u
 DSnQxz1IL8JcRqopeD0ptwNPBjvNJFtj+oa7HaEQ2j0ub/nzBOvb7lF63oQIx2zLL1NkkdIe5
 pkdETsE8hBvPnhWGabiALnoGZM8bB9BHz2SguxRUhb+pXoelXSjGieha4LNG8Bxo2lqxxrGuO
 7eOBQaydtkeWBUO5FaAvCp33ieqz8Nk/rJOYcUH900z7IHykcKVvAANapfrYURP1/aoaNlgCQ
 B48yimhu30ytNcc0rhrIX3gbA6wir+l91gwLr/EEZh/RhSng4x3Rm6qBA4pA35GVVmAu0wfXm
 20r9VNWUAhohyCz/0Q6VobrbLVbmJ3t/typcO792p9zKiE+ZlHWRSRaysQ7JhqMyKRWH3yLlC
 yU43wn1oN7rYFJsFwI/zA9xb3/AIihPJ16I3jEH2Bs2mfCBewnEPZBPmyIrzCw7WiMjzLSz4S
 1gcuoEesQQVE7UNkD+C+8ir8S1sVQt4Gi4eIlTklBsc2nLAjB40Tf/anuPc9iorDNz1zfnLsx
 IsXEdCuf61oTccPVLFwMymFPDdr7QsxdC4fsGVGfrDVOC4l89xaSVhJ6Hmmhce9ukSnGhjNkA
 fKM0S0YTbV+Kqw4x1EYsYjjEyJ5mWpx8qC0x4UivgWAgvZ7N0HX4Zsne2VdYbZo+RhXqME0pa
 zkpZRpjiiMxaRDNEVGI3YnVhvbrpBCCc77F2l8VAoaoMUXYbtW8/BlfE15i5yL9+v2U2pRwaM
 2G1IA1JFRZptBlUq18JOeCtL+XjZgJFGP8Y+DzEKnzQ==

Am 18.01.25 um 18:11 schrieb Ren=C3=A9 Scharfe:
> I think moving to the right place in one step requires less churn.

On the other hand attribution would be more correct if we stacked your
patches on my v1.  Just don't forget to free u.base.name. ;)

Ren=C3=A9

