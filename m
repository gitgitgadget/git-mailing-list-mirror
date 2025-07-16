Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEC2F1987
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658739; cv=none; b=eDLfsRgxg+uF9CXXFUuVgo8SkAqXJcfx5HXjrCX2QBUJGoHMLmrQesVaED+fc7MfULdi/STs3ZN/FSaXGU/Hm1nMk9ZsPSc2FJa4+gPGOuVU60RiuMZWKY0dDe+24IgRGx4vYVgHyKjpgj5LfUgbHv7Q7SaIXA1IYeiyFJKjxtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658739; c=relaxed/simple;
	bh=n0eTdpoZUuwjPorimo6lAo+FvshyT9Sc5XATYAi+KRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYoiC1VONjUMeDrrXZpF++lFfj2Jonc2Txi5HzeO2ta3k1OBAXkmyO0jkfSbi00lF2wIC+v5VOuxmQxHQhMsub8KL9m1dkNLxtrpqDiQjxFXvEqND6AmC1nqYsj8Ff/SwNeSpNUWxnbsftPv+59kiQJ0Itnv+jrcBNFyL2khAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=SAK5VCXT; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="SAK5VCXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752658726; x=1753263526; i=l.s.r@web.de;
	bh=WmOKhVktwG7HjmY3c6RuIVedGYUjYY+dUe1V6U949t0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SAK5VCXTpLGRCAYa3pBwlNgHrd8CQXRUIDXGsrHrFkZ9GW9YYHXtf8wDzixuhF7X
	 lwFEUJ47ol0oyjI4dYligBd8Rxpd7vPSB0HINIjYhwIloZy91NVqFkd6LesaGnCB0
	 ZEkpii3shuBRxD84U8aQwonBypg3Xc4esvX0XnH2Qm6l9dTM5ihrqVwJQBXQDnCW4
	 4x5T80/xQwJZP7hMRIBsJgfwoasq5oy1X1M4ZDU/TkjfpdmiHXjnWh+1mDAn/4aqE
	 unkAxpfp7AxnjiDj3IJcuFIPG4xPV1tBDC2Mt06kS7WufPv50kTjUoKzUBQA8o6/y
	 WJjyqYa21zBWwQEzOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkSI-1vBsBE0u6w-00nVEH; Wed, 16
 Jul 2025 11:38:46 +0200
Message-ID: <2cec288f-e632-431d-aba0-e98798b833ad@web.de>
Date: Wed, 16 Jul 2025 11:38:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] commit: use prio_queue_replace() in
 pop_most_recent_commit()
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <aa89082f-34ab-4ec7-bdce-70f0a33815e6@web.de> <xmqqh5zdgp6r.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqh5zdgp6r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hP6Zg6ljkfB4NFel8tY2Jd8JOHZVz3/UGzdmyEwq8WEYFFWWN+m
 pAD5Zy9uk+F86VsFf3cO+wMyPM4C5+BfsVXr20YNybh6AgiQe5KKKByMHoEGIByZ3VhevxM
 q5zx/7+64U1+y+I6FZHf1L+xzOWviFT1TkL0M42vgNb+TKzPfwPOrxRV9FAmV0TGbcatbET
 g0gu/fqAzzgRH5BsOO6hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5d2oiOIYKGM=;UyHRvcPRr15Dc6UiBDI1XPZHsFY
 PqXvhvngGgk5Z8zIdEHvBxj6c6ULzkvuzUmExYiOAa3kYg9quYRGNhRp0syzWBZRIzQANnoas
 lZeMiwXyofbrvcidHZiyLVWL9NdRQUNBqEv7E4s6BodcAqLp/HdesrvrWwunzqqpt8yuPrlvc
 4losZhei18FezLHmJt1M69a41ad0aRVdEoTwRT1qjO1oc2xiXwqryxHGS9Y+m1joVjQf61HQy
 Sl+kKJh8x5beOOj8z8RX0lS2h31Z/hJmJDxQAtRa1ddKejv2A4nmj4v57FGW/qCkiNXu3SC4L
 tbMUfNqNejLNJcCcVKePAwmRfEGeFwGDRpedM90a9IiEE+XbYHEYpLuyU2HSM1XkJn3RnIiAq
 iBcV2XueP+MHIGd6mGE3K972YCeyt3mS5BNerKS54IQSEwW01aZfFHQafu4iA2Ywq4Mxfui1h
 i72KfqQYSUzU9Lc4mpEvf/m5jcuQPovgnYfPvrHfqY4dhihdcQi4E+HYv4PtntaXCPmrhrqu0
 Y8h/h2gz2mFONKd+HyARS4LqCBeLv+ZL45oB89SKWshVEcnsoBBX0NnAV4If6ZNDSrtPo/yLE
 iYH/G5XI99rASY3DxU3vvWbGg7TNwRGmsWg0M2ee0WfpX63VHCjxPqw3DVuzXYMgTdP7rFyaW
 Hk3qtRytoQ42S7L9jiU5nPc/a7FlJuQZZTddIXCexBDDlTiajFYwrM37JUxc+z/hvWWxhBuLh
 pyzR2ky6SYqLIBA0wJAziCivZj+s5RADViQeDCWpogUzJe0R0Eeu5IM8VwK9H5lS9fAgWayed
 ax9h573HWQXkCMGhVG4016eIDAtuV0HeACRovnZ1PGVrigX+dwq/INf6EKQwdP1mlpFrueoB1
 u6pud1LDAm/dcGDAL/+dU+aob/H2Nx0WI049LD2gBHmGtgL370w+GHuc6i6EnPx/mbmbyaMpm
 iKRnc3YxFWByyP8He0oXA0zlqfvt74nRUHRRcgFaqonqEzTh11qCsfE9hddGMpUXBaoxXUxht
 +EfR2qH+9HgrjaSeC5HygjuH0rm7Q6o6cGgpJJPI076eOqw7S/E/W9wJ32GN20fRRGMSWmjsq
 BNEBpgK8xyGFxtLUEgsCNdusqgyukn72x9RNTu0/d4KlOxEe786f5jyBSGbpoWYNIfSujM4/c
 k01zO78IVZLr8J808jUuWvCSNMK2eCpzUjVKJiXRMuTNrWj7b8YVeBcizSlgId2TB+nBSg3th
 0di9VjxoVuGMRJ1UAppcvWwh9rZxkaovyzO77TcfXacPZHAvpUJVCXASeteeCCfMipInAzjAK
 C/tRnuhhGmU8Uwtih/2rB6xju28sVrD7MhpCRICD1d5+ND7LOem0orBcSXvH8Hf/I5C7fcc03
 R8xhJ1STEEDI5qW937Rw4DQObfJPUY/A/IojxhhTbAt1HXWh3d+xN3PeK87CxO6XunrIT2P9S
 jxXaHE1VQ/ha+PiJDe/tSYUnnkeCxBIjcBmLsljeqL/Jt3QsFJr7Y2vqfzY7fS2pmgj2EpiJ5
 ICYNRdYohk2Y4nIq7NiXPtD5Itwv8TnfXWmPgSo8ENVVrjoLvcqLbUGrwUtU/TSLigLKJlqDQ
 GqWGVKLdzCCPfEegYd1i19x6aCg4gUnZ3qxWSu1h6ywFG78k30uKiIBEvRGTFCYf8dD27h0m5
 sNx6Uq7yPGfp694aVl5Hu30RgpdM/YHkM5DHXW/+df7906fnSHt5bqP5bIDRyRwg3cmkDh3j7
 NMXwTDKv9mMaN/TkOz/BeIrwdh+iKfOrRxMV/f49ywf06qkWyRALUY7c5kgvlwfmo0UR9SdNm
 MjUYaeDxslT6F29XYaEnL9mouVVexqjBFO1SxHExLfaoZItz7kAUgrYFDtiUDPcqkwGFicV3s
 rOwTFWx/pPGQhcSV3qqnVLnKYVlWIqUDpqTgLmzdnK1c2ol9Aygysuowe2Up19YscxHYpmsN+
 i5bJk7QPsM3bgIPV675FF3KhWW+ek33gn4pSkJSE/QNAA5VXcAVY7bTHdRolNRFgPnr0moNy6
 iP0TYIf/jXMm8eMwXwJO7S0XKanPcmd6mODAphFcI1DAz/LaXEr0fSVE8nUEF1Z4LimhPYZqk
 YVna3xfhmEpVv+3EhocAevO+YkRclqaic6cFTZA/yignVn+4fW+t7QdGuw7ZVbGIaJxsKwEJJ
 vjJZXzB41WQzvZ5BUnHMzanVEpVNEiuKjaEjpJnJwwx/S4WZv93ZeIbFNTUwgyIXVfENBbBHw
 bmaHqrv+rVRTqo+wWhDTghy5Bg9WTRZMXHL+MCeszrYeQdERgB4NfnJWBd+XgZZbkidVWPqRj
 N0rH1Bn1r2g70IwLzlgZru9kXaO58cXHJQ5l/7Sdtj46B2Id+hcpKNib4Z7VoLybsd3Ev3Pzv
 uxg1E95UQoV9yn0zeQzCC+mhpznvRAvXhc0xlbhY04yApcmpE9QREGwkjYlJ0badVLD0uaUe9
 ahKoLPL5MYzwjk16FMFvSIXNCzd5F5VHS+6i6gRElKdDhzyvngEgOmmgZ4xWqnRNu2IA3umRe
 UiDBwOJ8ckDZtN9BM2Mjtk33Ppa4SDJOp7YlheSfBL0c6XvhcG2IYNkShJjPqeA/RP9M8U3yz
 xCkhiT9j4TM9CmITMUsFa+XGl/KMBizEm5U9w8Mti1F6JxHvK9Ow6mg9Z1Iiman9CfmkYq5yJ
 jXKiW9j6f5LCVbyEacuKTfCtXWhw+Nd2SfqC+jGhA4Dt22U+389upegnFt5m+k3aMHwHDpVtF
 TF9K/mJvRF87uW/pD9KLEAriWACCMbGdTHuEY0ieerKLZ3c1xAUx2v/dW4q+Zweuy7hFzrk6b
 IAVbfsrTfOvBNVzAyk9aasU++bXz+2QoMznSD77hviZNnG1b9qAmGXr8gSbq56pJKyqmYn14o
 X4CvDRmytthPvdXIcihMf/mnUSum2YrBpDrgFlgcD7n9kKNhm5UpSY6GLphOroauxIOclG+oV
 56GFRFSvb8oTIBs8HbOHeSru+MaiyHKXBOkrCYPNlMlQ7mBiCpeoAkkjocyKzH67ahXbBLt2z
 o4bzG8k8HHhzEaF5HBPZlasq3HWBKu/cABusvndrZ0pM7BL6rrv7FvZA2FbN59TRSSp3tIMFR
 A85tpGG+8oJ+5cueW8Ue4q3GXZfuVq78hUKLhR8EI+gcnGg6w7nIwIytdV410hpUxy5a5N3s0
 u23MUDIrLT9sVEyYtV0yQ/05nH3cb+qd7vVLnFRwqQWw74I19mdg2cYArUmDaW5UdyX3AiXHb
 tARUydcJHmrlvj4o/NiTLeBFSUmO/ui/oW/MWFlh0Goo2vn0qA+ZEJNkOeDnAdZ1KVmTcaN3w
 woB/enVG/1yX431bgbqzp8QWaQc61Y71VtxRvsBEPeZf9FsEevC7TXpiTLIUWcwyK3etOQ0AQ
 KV0V4HbiDnVGfErtTI4RJRz4sJwqx5o+MY0Ql6p5cB5z/hY7VH4zZCVQEsIrQX7NpaVWs1xWa
 nO0VPt83NgoEZN538EGPDg6GxsD34MmgVL00idMz1aWO+20woIr+wA88K6NgfEXty+y05G8Gw
 NEikggcQYYkRucIlWeBEy7e6aAZuhg/Bejf8rbH9cxb1

On 7/15/25 10:43 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> diff --git a/commit.c b/commit.c
>> index 0200759aaa..8244221b30 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -742,17 +742,24 @@ void commit_list_sort_by_date(struct commit_list =
**list)
>>  struct commit *pop_most_recent_commit(struct prio_queue *queue,
>>  				      unsigned int mark)
>>  {
>> -	struct commit *ret =3D prio_queue_get(queue);
>> +	struct commit *ret =3D prio_queue_peek(queue);
>> +	int delete_pending =3D 1;
>=20
> Briefly I was puzzled by the name (I would have called first-parent
> since the logic was "we treat first parent specially by using
> replace instead of get/put"), but the variable signals "instead of
> get to remove the item from the queue, we just peeked, so we need to
> remove it later" with its name, which is understandable.

Indeed, we're just interested in the removal part of prio_queue_get()
here, as we have done the cheap half (the peeking) already.  We don't
have a prio_queue_delete().  Adding one would perhaps add some clarity
here, but also widen the interface and probably not bring much of a
performance gain.

So perhaps calling the variable get_pending like the prio_queue_get()
that we end up invoking would reduce the initial puzzlement?

>=20
>>  	struct commit_list *parents =3D ret->parents;
>> =20
>>  	while (parents) {
>>  		struct commit *commit =3D parents->item;
>>  		if (!repo_parse_commit(the_repository, commit) && !(commit->object.f=
lags & mark)) {
>>  			commit->object.flags |=3D mark;
>> -			prio_queue_put(queue, commit);
>> +			if (delete_pending)
>> +				prio_queue_replace(queue, commit);
>> +			else
>> +				prio_queue_put(queue, commit);
>> +			delete_pending =3D 0;
>>  		}
>>  		parents =3D parents->next;
>>  	}
>> +	if (delete_pending)
>> +		prio_queue_get(queue);
>>  	return ret;
>>  }

