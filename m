Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AB202F8C
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740265215; cv=none; b=r5yJ1eIAtwt9rPfJRfspV1uI0ZWHmCudd/b5/OcMP9prUu7twfxpD4muRVu7IDTuXwPQTbsEy5GBEDsIqQgEKfrs9RtdkzWTkW/BoRw3sskq46kHsc0/q6RkS5dcw3lySM8Cw/rZF78/CrENIOjdTuULh6EmG4KXxOrvVYkyG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740265215; c=relaxed/simple;
	bh=fobgdi24CfeR2IKl2pXLmqZ4lNCbcrd3csdnkJzMU0Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BGOzOBVUopXxiCwM6FuxqFMobTKAHIGTTQrEbXtek6bmWW8w7VDXw+BI/psdi4lIIjpd7w0nTIoh4YfSTIAYV3h+404Xs7TyBMe168lhWaaVku7BCWtTfX7LgWATS0EkfTlzLE2XqRPD2Wp3j+wz43wcnc0nSR6fo4sDYkVnb6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uxp.de; spf=pass smtp.mailfrom=uxp.de; dkim=permerror (0-bit key) header.d=uxp.de header.i=@uxp.de header.b=rMDsCbSz; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uxp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uxp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uxp.de header.i=@uxp.de header.b="rMDsCbSz"
Received: from himalia.uberspace.de (himalia.uberspace.de [185.26.156.126])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id B950717F904
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 23:50:25 +0100 (CET)
Received: (qmail 6911 invoked by uid 988); 22 Feb 2025 22:50:25 -0000
Authentication-Results: himalia.uberspace.de;
	auth=pass (login)
Received: from unknown (HELO unkown) (::1)
	by himalia.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sat, 22 Feb 2025 23:50:25 +0100
Message-ID: <e650f4e4-e267-4f1f-bb3a-c71b1fe0b276@uxp.de>
Date: Sat, 22 Feb 2025 22:50:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Content-Language: en-US
From: Markus Gerstel <2025@uxp.de>
Subject: 'git gc auto' didn't trigger on large reflog
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.114041) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.214041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=uxp.de; s=uberspace;
	h=from:to:subject:date;
	bh=fobgdi24CfeR2IKl2pXLmqZ4lNCbcrd3csdnkJzMU0Q=;
	b=rMDsCbSzdai0oH2l7n9zZUWqEJ0bCFTALgzEuQdXf85yRwzF/m+ToTuf/HXrWbYCm1QJ7BOije
	FZItRUwyr2lzhfyVOxMvQOXwrHuTozvOLoEpMoz1qcgzni5zZpZdaou6SrU+Eu1rMfK8aCQND3ip
	TCEyGx2Us5wF3VJKbw2I0LwfRcPJaLIoNAKgZ8JV5TAaUmYhxMUIUGVVuU3aEoocEPEYUnepOIqt
	r2denoOfruTFIay06oHPTcBl0mvgY16mHaXLUWGmYqJ68IDlPr8KA3+aVbXSxc8/Scp3BNUjUhXs
	xd4cHADOXS5CxXC74CM5amVDQ1kQpvX7WEdgG5hSAQhxv3iO1Qf7fmfpHCDed8lF4hAhHn3uAb2A
	bjbGzVB4bQiUxz910rx3tkkL0IcO+IAJwaK//qGRBnfPZXRxLUDBDqnGIPCYFXKiWygyGK2CiLKh
	jrlub3icVAJAk8vAQN/MjxNqDHVMIkcCuur+IKjZqwurcH7Rf/iMvKJM21+nTBfZnBn2QxxuhpEq
	W96jozE0Ue/Jy9zCt+JdBIVFGudEQaltzQOoYH4FukmB+Q9/mxTu3l+F+G69egRCKL1yiq23hqlk
	Ut2GuArf0G2XtN2qfcHQu0YyPESxxw1JwybnAqDtkbgjWEb6yekjZAHjVip+JSZT/pPIdavmXlO5
	A=

Hi everyone,

I was looking on a machine that does not normally get any attention. On 
this machine a daily cronjob has been running

     git checkout -q master && git fetch && git reset --hard 
origin/master && git gc --auto

for 6 years. The git directory now contains a .git/logs/HEAD file of 
180MB with 823921 lines.

The repo config contains

[core]
         repositoryformatversion = 0
         filemode = true
         bare = false
         logallrefupdates = true

and the system git version is 2.36.6.

I can't change the git version -or install my own one- so I can't tell 
if this has been fixed since.
A manual git gc fixed everything, so I amended the cronjob to just do 
that instead.

I was just slightly surprised (and amused) because I expected 'git gc 
--auto' to pick this up, so I thought I'd share this with you.

Thanks

-Markus

