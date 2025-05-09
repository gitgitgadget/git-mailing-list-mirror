Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC182147E7
	for <git@vger.kernel.org>; Fri,  9 May 2025 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755673; cv=none; b=Vp57jKr7AN5av55jEdPbkboOp+W+tVNUQjoabijpHq5MyXqAlwoq185IQNabEmcdRDeilxkRwc8s0e9XUGEMhKy6d6am2HWSqoX+birXWboqPfHqkZ6wAq7KSymhNGCty9DSwvhuSiPO2eUt4n7r/4nJ/OHadpF2uMohLoUnboo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755673; c=relaxed/simple;
	bh=yhurATk8UjTO22ulsNOr7AEQfhawUlfrcaAP/Zj5oKA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VIutR7c0PtV9W4xE5GMtGpZ+MqzDrZjME8U4Qr05cB6LOcjoqxjvrTFwK620uHyVquiiiLkbdyEsJxrSH5AozDSc0o7Kw/1+Q6kB3bccU4Z2Ph6nwS1eOXKp2M1efEpBJRSICeFcazpH3dEspiQ5E/+KsndEAeY/MwFz2zfcXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpgz10t1746755657t26e944ae
X-QQ-Originating-IP: Vs9WmmccSc9KtZ/bnVV9pRxunIe/aQO1qEmpgcVMXNU=
Received: from smtpclient.apple ( [36.152.24.174])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 09:54:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11098516378694086880
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] REFTABLE_REALLOC_ARRAY: fix potential memory leak if
 realloc failed
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <174cb568-e2bd-41e0-b090-eadd919d1ddd@web.de>
Date: Fri, 9 May 2025 09:54:05 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B1B3827-C617-4026-BE09-DBD91DCB5FF1@smail.nju.edu.cn>
References: <pull.1955.git.git.1746711583166.gitgitgadget@gmail.com>
 <174cb568-e2bd-41e0-b090-eadd919d1ddd@web.de>
To: =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MpO6L0LObisWJzowoGJeNMVF6DTJ1nsp76slRsf3Xrvqp4tF7WtdKEDT
	X8GOemw8D+zJbwTePWc9wxI9PfKwyYthWMZcfJxGYlSLOxklNpfhmQ5jWlN+IvW7EQrLqYF
	O3/DQWcQ7OPFyurUjY2/ArFrNA+DDbRSZNPOzPKLmdfIcWcbGb5Jm0E8sADEKMb2n14oFjZ
	4dOdHz9dvoPHT6TjVLZF9OqtI5R4pA4a2XuBENFYcaWcapW3+AKW9815tDjpR7wQP6SfPwU
	4Nzkkvddn9xBpVW07rZDhPFqHulWW07kPG5IJH7+pMxOzsvHEtHT68GEYld631Ag2KHGOtf
	nyig6tN1aHXhQ4FN9FjUJ/Q8zAB17KvOoGxYGbiwrctYOSRiD35wT8eH5rWJLq40ZJxIXFN
	HsSJY53eSkqJSLypMi0/jKrvMaYMo8X5dNEfuok4N4Q8fzbCYoUOmShWqa1Di7xOZpZdN6O
	3yL30tyCRUP4wXVcobCBW2AqJvlvDcjPcAv5bgIAmZP5Te6dDaLd/L+12kRXc10DffHmrj4
	bBXaww0uJ4H5XDKbjIfF8Y25Bch31RX5sH1Zt9x/Ztg6Ce+Y3OGZsmTlaQsIElEHTgBcJab
	9Fnxdyg7xlmoniVBNRr+R3lYEpEz1clhb86THO2A+OuEsPkeKK5IypOwM95BJuQv9jvIEG/
	8JFzzV60atL+6gOWIaAK99eS/KROwgxUyPMqQtCz7sfFLTQ/JoicjHrSyeyL04Fb/cSxRzP
	H+Z3mDJuM8ldU+6hyMmZi0/R0IU8nhKt7fPWDOl0wnBMo4wQ47bgL95xx4p15LMnFfntCR4
	dIrVmnS7G3bdJvHJwHn8i6Yia6X3fpUvB8Q4yKIJwhFUGj43XAmNNmZ6w5XCYU+Y3twTgHD
	UpHNX8oxwGuO1X6jYxdkfH4uCYLLGR8UyuekXdTwLs4HPwhOyLlLe8AR6Qt78OOOWiwUUEF
	YqNVT2NY6tmiANHjMQbZA29RK9Y1tFkyE5CqoR8liWuBflA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Ok, I will remove it in the next patch.

> 2025=E5=B9=B45=E6=9C=889=E6=97=A5 05:42=EF=BC=8CRen=C3=A9 Scharfe =
<l.s.r@web.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Am 08.05.25 um 15:39 schrieb Lidong Yan via GitGitGadget:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>=20
>> REFTABLE_REALLOC_ARRAY doesn't free origin pointer when =
reftable_realloc
>> failed. This leak can be fixed by add a free(x) before set x to NULL.
>=20
> Hmm, this macro is unused.  Perhaps remove it?
>=20
> Ren=C3=A9
>=20
>=20

