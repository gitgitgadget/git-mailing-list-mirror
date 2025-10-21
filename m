Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1D2777FC
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083569; cv=none; b=X7rda76HtsD32MQJatbTgOT9Zl+rt367uwlYLSMReiOML7cjB+HhKj+zTQ0thVkIKN338/jc3bs6kvlXIF7uQpZ0CUOafOeyaEY1Jbxcvq4puH+DH4saAqVBRYucVhSMlDgD+136nUH1qOuGbQSJz3C0Oc9QHTpxwhB/xd6Elos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083569; c=relaxed/simple;
	bh=sLRUklkOXbWW4ft/4yHXRaSuk8sdx0mNbOpMvYwB2Tc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rTqq3dF/fCTKrcZTfULfpmsA3OQeCyVklW3EfDQAmdPBEUF0MuOp+jitAhHQZlOxzpskrhMOVrrcOsbQRSptjvclI9dJVY4VWEdgmvUVwQB4XHDtxZIFrr4xuC+mR3Yd+PatgyZtGj1BZYUiqwG9SOTx83Mlf1BuRr3odiBmyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59LLqhbE115941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 21:52:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'D. Ben Knoble'" <ben.knoble@gmail.com>
Cc: <git@vger.kernel.org>
References: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com> <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com>
In-Reply-To: <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com>
Subject: RE: [BUG] Strange git notes completion behaviour
Date: Tue, 21 Oct 2025 17:52:38 -0400
Organization: Nexbridge Inc.
Message-ID: <013201dc42d5$07a71550$16f53ff0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHjmO9AERlM/1ZhxKXB7Q1XH17MtgEgLITOtLV2LoA=
X-Antivirus: Norton (VPS 251021-10, 10/21/2025), Outbound message
X-Antivirus-Status: Clean

On October 21, 2025 5:33 PM, D. Ben Knoble wrote:
>On Tue, Oct 21, 2025 at 5:07=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>>
>> Hi All,
>>
>> I tried the following in git 2.51.0 on NonStop (big endian x86):
>>
>> git notes add -m "Test Note" HEAD
>> git notes show HEAD
>>
>> The git notes show reports a completion code of 037777777764 (-12).
>> This gets hidden by bash, which truncates negative results so it =
shows
>> as 0, not -12.
>> This
>> only seems to happen in git notes show, not any other commands or
>> sub-commands. I checked in gdb and this is in fact happening. =
Anywhere
>> I can look to try to find where this is failing?
>>
>> --Randall
>
>Exit code or shell (tab) completion? I'm a bit confused, so maybe =
someone else is,
>too.

It is the exit code. When in gdb, the return from notes is -12 as above. =
By the time
It gets back to bash, the lower bytes are dropped so I end up with a =
0xFF, which
bash thinks is a 0, so the exit code is hidden from view. I tried the =
!!fn construct
in a standard alone test program with no wisdom gained.

