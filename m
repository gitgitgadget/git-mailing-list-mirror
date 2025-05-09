Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4C26D4C4
	for <git@vger.kernel.org>; Fri,  9 May 2025 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746774399; cv=none; b=Y+RWkslWpr83vkHyK3xK4XWbZAz1KtGahXSe19ZcO8YYW9vBaDpic5RElKM/c1k1isVg6eMFLsHOnoM/qCzQkpDrx/jnKhJA6nOV0zPVKKrFnPbaEqeDL7KAQysSQAK3eJh3JdbAxfCr7oGIJcilBQj2jhTl7x+wAY2IFca4IB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746774399; c=relaxed/simple;
	bh=Y+jT3XiRqldtaTNAgac8lgQandk7aJVZgmRl6p6sY0g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ItlCF2X+9bzGCjli+lDKI55TycLGYcyoOl5p26XA+VwJ5j7SaK/16dIIZQDP8t8qrMNC+WUYmpfGNhJBBostcvYvfCh1zOwc8jF00P2rDN8xLVL5N++8yzIEf5b14shAGgHAUFjBDJqwetrdo+ezhVfYtoSXm3Zu1EJBUJy5mfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpgz15t1746774373t5440392e
X-QQ-Originating-IP: IHE91uWV+zBwRp7t1+xxcxx9gABUTmeZXoemYGiDTHg=
Received: from smtpclient.apple ( [36.152.24.174])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 15:06:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11875066781342925419
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] fill_oids_from_packs: fix memory leak when
 fill_oids_from_packs failed
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aB2U2Jb8hXW3Hwt3@pks.im>
Date: Fri, 9 May 2025 15:06:01 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AC31140-BBC8-4275-B18C-37D5AAE45B6B@smail.nju.edu.cn>
References: <pull.1957.git.git.1746712275566.gitgitgadget@gmail.com>
 <aB2U2Jb8hXW3Hwt3@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NojR6Ao/DkEDb6BSVUP0xAzaC5xyCk6QFW0JnxuQrmRbeakxXWk0zucd
	bcjR6qQTT0iBJZ2ZBx/x/FbSiuNi5blqLEnEKc9EZYyYqDWKf9yYeUTm0TDiTMn2jKThXoq
	CGSRWlBH37MbRoSmmJS6248p1gZaMNUwoWUtuKbPkNfmOk+i1Nslx4cScdD9iMWk1CspEXn
	otoZEMRjGHs0vqhe0u+vd6HmlxDnY8yAjVqZhnl6AEFWEGLWDIBy8tVS805vjjLK6jW+OP4
	gE6RNQT6KJqjkvv1W9pCuD17wqQKe9aGIoWqJzqumDs2+fnIDijT/n5EmyyRQJKZAvBIFe8
	FHpw/bzpHLXrkT9dQvxHWkVQCnlrFNnRgybyH9pkZbd3EITSKB5ICb7HDlo8P9OmzOIEYW/
	WGj63WoZBNzj01hHYrWEDLmchizJLG1JFsm4e5jV7G4vxDsOv7OI83/Rwgipf3+W+W6eSvj
	7jTWWNsmQjxFXDmXXR1z10K8o9z5MszJKA/hLAwfgn+rPO62AMAXWs8LHNcha09VE9fW2N6
	+TcDS65Tgx3D1ghy3OUUQEV0hywDOKvd/5oSIdtw1dj46DEhb8gTarF5FfTBznK1EFPUccS
	2pkfIC5UIBCVp/FGBqvpjGUJuRY5sLGAqv4ByzCE9xmLOF+yv3C992fdV18Djce3A7nsCo4
	praJFD5LW/Edq4YxAXJw/TNTlZu1lOsYzFIJHr4lQrUDDR8AYogp58Ik4vIoL9wxHbW3NXg
	e/eW983DlXgVGRX3o7dB9dP973lDb7SJ2Jhc1wsds60rnom06Wpp59vswzLCKIA4chwzZUw
	PDqRYx05Kd53MNwcAu1o6TZ0l1V/flaIWBRuEet/8cTCZMJhzHYc3FbcTtqPNYzifQuBd63
	u12J57mwWvGw7DfmFLSk4OGUZEYOONJc3ZUrgMBVcxtHO8V1SJilfzEM9kT6K/wEU19pp20
	/iiexDKzEBUbkbiaSXeWOauWKPkI3SHUCAFhxjVMYDJ5yrje7VFOGvYvgqvhMAjpqQEY=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Ok, I will replace line number to fill_oids_from_packs in next patch.

> 2025=E5=B9=B45=E6=9C=889=E6=97=A5 13:38=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, May 08, 2025 at 01:51:15PM +0000, Lidong Yan via GitGitGadget =
wrote:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>=20
>> In commit-graph.c line 1930, if open_pack_index failed, memory =
allocated
>> in line 1925 by add_packed_git will leak. Simply add close_pack and
>> free(p) will solve this problem.
>=20
> The same comments apply to this commit message as Junio has already
> mentioned in other commits. We don't typically point to exact line
> numbers, but rather mention for example the function name.
>=20
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 6394752b0b0..93d867770b0 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -1929,6 +1929,8 @@ static int fill_oids_from_packs(struct =
write_commit_graph_context *ctx,
>> }
>> if (open_pack_index(p)) {
>> ret =3D error(_("error opening index for %s"), packname.buf);
>> + close_pack(p);
>> + free(p);
>> goto cleanup;
>> }
>> for_each_object_in_pack(p, add_packed_commits, ctx,
>=20
> The change itself looks correct to me. Thanks!
>=20
> Patrick
>=20

