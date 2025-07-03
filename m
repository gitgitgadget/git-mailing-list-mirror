Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8924B26
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751506968; cv=none; b=Kif/bjfwbMc3UHG47UFKGIN3UMc7KVlJcMB2cKIGOjVI7gsFKzN0slcKm4kCM82Ai3Ez6ekhyEx89U4JEhHTeF7l25vohClpmX/6H6nwumkKsDmHqr+82icZEPjkPRzyBWZjrTA1rq7aUZoLO18rQCHZBZCXzY10nhfU6UOCy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751506968; c=relaxed/simple;
	bh=brUXKU/vxPDK7857q7+7p402zDtgFFVzmlY9v+kKajk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nlRC9ecw91s7zmibdjXa5eSeG7XlE/S4v27OXA5hRSZtGpxbTsnfiJ0QCXKklqkoOAS/HSVdIZyiX0YqOSgoiafCbjuglOuofjTOSmC53lSUbiZn6d7jVMmvVnWsTFOs78RGTybbxFbAKzBsoIb9gQp+IdkLVh5XeSvin3DMnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz3t1751506931t9d748960
X-QQ-Originating-IP: T8y6x+eGtkQxLu/wsaBET0rh4Gp1H668aTNp86UdHD0=
Received: from smtpclient.apple ( [202.119.46.106])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:42:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4571789961461901736
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 1/2] bloom: replace struct bloom_key * with struct
 bloom_keyvec
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqy0t6curr.fsf@gitster.g>
Date: Thu, 3 Jul 2025 09:41:59 +0800
Cc: Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B02F0A96-0D2F-41E8-A3CE-A840024092ED@smail.nju.edu.cn>
References: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
 <20250628042140.1097910-2-502024330056@smail.nju.edu.cn>
 <aGVLZ9VUf2M1sWhL@pks.im> <xmqqy0t6curr.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OU1KiBGGGpgtTCgp8TkHb+gSUBZlo8whVSXlH7j7ROmE5Bj/hnuW/1Aa
	3RvrGf1jDSJviL30mTXJnG8TvygCbLL6Suh999mQfx7x/7oFe2x2AR/4ZPORzprfUKMVR0A
	ELQy2XZWlCpTC05ichnUaGN55NEj4isEMjmQmftaK+uAbxPfK0UPvMB0n34lNHD/3OrlBy/
	V1+3J43QIRFnqn20QEpPEcnsn6vYfxe2JvV/IIH0Wgw+6TKzFR6vpIQU7u9CsrULpNLe7Pn
	1ui0oYfGMXDjFQHXcGjNvrRTJQYD36gkCYl8/Uc3lL9bQoqQPRxudLypIApsKSnytk7JDNU
	B0unO3Bt7QV0/3xIMibXqKY7DYX1hCvjQkOdf6EG4KwJtOqAC2r2hQvVTgRfsbst5XWL1Mk
	PsHEt7EnKJtXi6vyEZDT/VOYX8fv4bOvBaqZrsW+Ojkj0ic3hg2Cxiy8kqvsnpLfVhWUVGe
	ry6H4uE3wpR/q/BqTLj6Jc1ZcUZRXFH5wfmwYM75luYf+I9slgkdoV2Uxo5yzbECd9dDNzg
	zB5jywVRrE5KPcVc97ynz6mqPMSpGPlLQrLSG7gjG1BNxd3aXQJtT2CMo17vXdbOKNK873e
	lH56m8Ti4Ovf9td4gLhnznnofRqqwM1SCTKLJFqh+REESWAgEOkFiZCprQWFvJmy6n/Tolk
	9nF66Uo3jPKVcdhtsrk2+y4qQmNbUQ0DlNObWeTQHnrgu3Xmm4SUbxzTWQssmqO90+r+uZE
	RrpmRGhwq7V4NxIHEZwRGl9NVpIx+TVf3GnOMdBGpQ9ahQ1WaPjT+xYrapDdnKLmhiFqVpG
	wV5dt41842IAowaw11UAGBcdlmLmnveR41nazJOvDamEKkcVaZPlCutUOcvC5XqKJDk24UV
	/1/+dIrNYB/x2sV+zGK1fhaAuzZCXrM36o0YXN/h6YZ9QbNji1Dk8yGY19IhuJIokIvaLwK
	BXo9axdRNBWf9usSn/3I1FCseM4zkEFCVG5ei4aWy0HY67DCwCCWsKDJf
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes:

> It is very dubious that murmur3_seeded_v2() is exposed (nobody would
> know it is for Bloom filter subsystem from that name); as far as I
> can tell, it is only needed for t/helper testing, and makes me
> wonder if we can come up with a better division between the
> production code and t/helper/ code around there.
>=20
> Thanks.


Maybe we can do something like this:
    struct bloom_filter_settings settings;
    struct bloom_key key;
    uint32_t hash0;

    settings->num_hashes =3D 1;
    settings->hash_version =3D 2;
    fill_bloom_key(argv[2], strlen(argv[2]), &key, &setting);
    hash0 =3D key->hash[0];
    clear_bloom_key(&key);

    return hash0;

In t/helper, so that we don=E2=80=99t need to export =
murmur3_seeded_v2().=
