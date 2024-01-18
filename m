Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78439250E4
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582415; cv=none; b=hprWbMKjkcZEhgVrn8TQg6HDmUasdvnmJ4+dgQAXH9i59GSK9J8qyp5aTBmBlLnAD8/60/bFgabhewR6OBqYHlevZK/r/2fGcK39kXhXgtSeuR1eGiWVDQ9gJhJHA1i3QT5GJeWTMLd9XEfvmYPPFdH6rJ621sJRBQw6rS2/Huk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582415; c=relaxed/simple;
	bh=zjBJfGwv0j60SjHwxQRD8c3wJwbZ/gamZ/PU7GYKCPo=;
	h=Received:Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:
	 From:To:Date:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version; b=KhP1BE8SH231rNNfZyxU22/jMij4j5e6X6cY9e+VdooVNtQ1Dz0TiKsyjiEZEacVNOBgf9RdlER4VLwgBYeGMtSSP+DBADv7i40BlNlWpfWqrlm0TjoxHR3YVC1ovOo7DWjx/45jVPDyNJL3+EbVJ8oMWd+vbu/M2efC6yKUNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=akcSCRoX; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="akcSCRoX"
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:d315:0:640:bb64:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTP id 91ED560AF8
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 15:53:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LrMjBdADfiE0-TzsT97sc;
	Thu, 18 Jan 2024 15:53:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1705582402; bh=zjBJfGwv0j60SjHwxQRD8c3wJwbZ/gamZ/PU7GYKCPo=;
	h=Date:To:From:Subject:Message-ID;
	b=akcSCRoXjYWjt7rxHDoO4U0xNwQoZTGyvROFKJ4mLuEn+Kukfmax9dX5y4AK1CmTX
	 vVNtpcHBT85VRlP4vxJm2UeArtkjGGQKfh/iiOO1ojO/EVbAbA15lreFPLMD0Czm8O
	 MP8ntgvZl0MDp2Wf58uhbFj774/YHP0bslleT1Jo=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d66ef46827fc7391bd74ece943afa2c5245896d6.camel@yandex.ru>
Subject: How to execute a command on git am/rebase/cherry pick --abort ?
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: git@vger.kernel.org
Date: Thu, 18 Jan 2024 15:53:21 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

(please keep me CC'ed, I'm not subscribed)

Hello!

There's a well-known problem of git not fully checking out changes
while doing e.g. `git checkout` and similar commands when you have
submodules. So e.g. if HEAD changes a submodule commit and you do an
interactive rebase to HEAD~2, you may be lucky to find a submodule
commit change in `git diff` (because if you don't get lucky, you won't
notice that and commit the change to the unrelated HEAD~2).

As a workaround I have a `git submodule update` inside `post-checkout`
hook.

Now, the problem is I still often finding myself having the wrong
submodule ID, and I tracked down that problem to commands such as
`am/rebase/cherry-pick --abort` also not updating the submodule, nor
executing `post-checkout`.

I looked through `man githooks` but couldn't find any way to execute a
`git submodule update` during these aborts.

Any ideas how to fix these?
