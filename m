Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E24A92E
	for <git@vger.kernel.org>; Fri, 30 May 2025 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748577086; cv=none; b=Md48KnaU0Yb5yAv+WdDryp/mlt/o9Q3933Ib242yQyMZF4bZy6p4ScER/UCxikH/4pKsImgk2AeXSkO8pC5GKrxDa5UEHlcUPUCoo3tExiFxyDtVVlszT3Ysrl6vueGLjBgWN+VkakZ7CatV9KTtNEC3aMYg0tRSXMEDlLzNaZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748577086; c=relaxed/simple;
	bh=Jxd2Asmvo6NibJ+0mHkVD9o+GvqmzkQuUTSUUzYfjvE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EquFSDXh8Hq1XHBlrEl14KEC4T8h9TfXljApDg/RR5TUJtkeYS1t34Nky0oowCrys1LGflcybFJ9dv430y5KS6ZIzwb7x51s80gvfi3isxmvdFHh5kMpE2rQCVoqHf3qUQ+G7xVa0pYKGkNuAMkZEDvnaEmSAds3kvisOF3YliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz8t1748577024t12abb1ad
X-QQ-Originating-IP: 3t8XYxMB/GIKKYW4X1oYU0dZfP/768UNQ973arExcVc=
Received: from smtpclient.apple ( [36.152.24.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 30 May 2025 11:50:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10526655384023579017
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 1/2] pack-bitmap: fix memory leak if load_bitmap()
 failed
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqjz5zmnxy.fsf@gitster.g>
Date: Fri, 30 May 2025 11:50:12 +0800
Cc: Taylor Blau via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <68A128BD-DB63-403F-82DF-B8B6C78D5308@smail.nju.edu.cn>
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
 <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
 <b6b3a83a22486d0c104c494d1950fdaa2f2a658c.1748140983.git.gitgitgadget@gmail.com>
 <xmqqjz5zmnxy.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NcfXIs+Ms1qH5dMA2TrfaQugUktnwnJLKiKn1aGi1RcXc2PWoeqwWXCa
	6MqBB2IjV84pmJf/E53YB+wwsTQJD0WiQzT6q1uMxiY2QNzd5aAkEpv/RiHCyZama3l6iQN
	S8WshNZEbXKjSEbgg1XuQyyxWsmoFvzAVWcZOTqGe+iosYgmPLJtJ5blOASRSkZCDg8q7BE
	jvSH3SxhKS+LVlpuWsL2znpkV58geM+bY8gC9qv9TqCicmXHhj+B5z9VH+hy3PtS/VuYWON
	TPwukiOSo5HuhuYoZLaspNhIFSh78xV0FzJjbZkIRXLeQmOLqbeq20z4p5D4ipTZKkpzwCu
	LiveBZ+5LhKZRKCP7DaNTkHuul2tcfGB6fJ9yDp+kJ8I+bVtlrWi4aN6dmcEttxaU/GJkQn
	mZ4gbQfGdxgi5rLJ+zUW3DQoI24hHU9ZQ4Xe/eliJGb9cMwrQmWnBLcSqHc1xZnE2nlppvY
	eaHuWUGNmQ93U/Mqq6A+ixGEt2otwvckWv5BmSShVsky6gxHXsK1H6la1P0nc+fJSvlGAHO
	RnoM8SWFNbpIl6hyaDzgnPWiLpvMUJbyME+tbJpv0otvVmcAjdNrkEvgUAW3CoYIYLWupE+
	jzI2/LfUG2WB8M3tqxzIC6zWbhfCJt/Kk2deeIpFauffK7d7XGtZwWtfTEzxKWdkxYCtUc7
	3iaErkiq12VedAajx/1LypHktOWV8uyfVGJNMphPpV1yL6dJ4aizFMwO/zajkWmovUL0Cun
	NOblrfvyT9NSoXYxF/RsL2BZPcf8uoxZgB/mwmAC9iSs0L7Dy103X0lRUGW1wgEVxEppSnj
	ocbL4Ev56Z3jPKmi8/0tvC6th5wbWW/KEYy+J+tAZu44nbc1HZsrePKOU1uAIGBX4YZv9oo
	SAXuZXJJAx2uON6lT2/m+wDL0fnTr8MN55g0zgVafGLCgi8COKDV1IiOD4mNtkVJYg7Zx9y
	qxVXPRu5RBWkkFTd7ddiEED1t86RIiAFQbZwNdIvZXQ+KCtgnjVW3cjD6JaOQwaraYGk=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Got it, I will add my sign-off.

> 2025=E5=B9=B45=E6=9C=8829=E6=97=A5 23:33=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Taylor Blau <me@ttaylorr.com>
>>=20
>> After going through the "failed" label, load_bitmap() will return -1,
>> and its caller (either prepare_bitmap_walk() or prepare_bitmap_git())
>> will then call free_bitmap_index().
>> ...
>> The solution is to remove the error handling code in load_bitmap(), =
because
>> its caller will always call free_bitmap_index() in case of an error.
>>=20
>> Signed-off-by: Taylor Blau <me@ttaylorr.com>
>> ---
>=20
> As this is Lidong relaying <aCOFqYdnPp1Lne4Y@nand.local> that Taylor
> sent to the list, shouldn't Lidong's sign-off be after Taylor's?
>=20

