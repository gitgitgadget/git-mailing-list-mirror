Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A23624B3
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352775; cv=none; b=C44PbMwXeqWPvNxqkhN/6zJuQe0l99rwsOqV6+4SBA15H6ij8oVgJcInzyoK800yrR877kllksWKIcb3ZH76F7PBEe34R/2NWJ1W5teVyTrlqDWJx2Ix9xVd56ucAtCpO1XWumFuLXHeRPiLBk1yRUF/DPgKtDrpdZlsQAbwnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352775; c=relaxed/simple;
	bh=loSJmAFrZOCkZSCeK0QfpLVmH32G/+FMvVefiQ1cp1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uknnaqQxoRdhkOM/98tgXdeneeahjsv43TKsyqBGtfTu3GwHC0WfoB8/40mZIZHtzL4Enosj0gIakq4U/FZhT6SeKJ4Ao6LlHc3Z4f5ffLEPyAxrv438n7GOi09tiYrsKSeaDZKTIZ02Ka+Az24QqRr+GRh6ckhNffiCsWKWlrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=o5mYYgli; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="o5mYYgli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779352760; x=1779957560;
	i=oswald.buddenhagen@gmx.de;
	bh=loSJmAFrZOCkZSCeK0QfpLVmH32G/+FMvVefiQ1cp1A=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o5mYYgliyvUPexb6FZr03hYxQwgA/yQVp/JyG7uYbkIXN5gng7o9kMYUPLzqnUzZ
	 blSurjO1ajCe/gBiHTvor7EisIntR/Sgng0TgAGkBtOsiKAq+xs7BDM4yqoq8uCjR
	 TNropS+IKIXaRJQ5msgFhpE3aX9IuKXVBWJqP93KIYSKdJIv54NjkPn79fERvDb0Y
	 YSfGu0ATkUn2TsIiWimnypVggNF7oGl5/qUU4NvrteqEvmEnHfyIbCi3fzwCizPs7
	 mk0Zun4zCuu/muxYCvtepshSfCHbm99KKM5sZ2DK5J6K3xj6ix0Jr6JKfHT+A2wKM
	 wGvubxMK29mga5nxVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1wbJj44A0n-001fnU; Thu, 21
 May 2026 10:39:20 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wPyw2-ykL-00; Thu, 21 May 2026 10:39:18 +0200
Date: Thu, 21 May 2026 10:39:18 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>,
	Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/9] run-command: add support for timeout in command
 finisher
Message-ID: <ag7EtmUk3UCpBU4Y@ugly.lan>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
 <f58c8c522814dce9257f64733e9fbc9bd9f446c0.1779207350.git.siddh.raman.pant@oracle.com>
 <b69605a6-e841-47b9-a899-a57e184d3c8b@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b69605a6-e841-47b9-a899-a57e184d3c8b@kdbg.org>
X-Provags-ID: V03:K1:joAl3VJBf21oUyDDzutfGgAFemyBINJQS2SCHXuyGSaaWu1JSil
 k8R+FxGSkZlewqgYC86DlQP+j1TJpzTr/YY4pSIWL2WD0A7VhRc3v+3yaffFbmj9WWDZ1WU
 K490phDOj6o2ltrMbWyu7MbqcCJA1YW2BX+4k3PBZhgwIkyrJTOY4Q9bjxVtqUleL48lWpG
 KlHs6Tqy1vJ57HbGTlsPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3hKK+uMm6NE=;t6769X/pl4Ek1G1tZgvRhpdtXzt
 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
 93xPAw==
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 09:21:51AM +0200, Johannes Sixt wrote:
>Please, do not add this infrastructure to core Git, and instead fix the
>communication protocol.
>
there is nothing to fix here. proper error handling including timeout=20
handling should just be part of every protocol handler, and in the case=20
of child processes, forcible termination is part of that.

one can ignore the issue, in which case termination is left to the user=20
by ctrl-c'ing the whole process group. this isn't very user-friendly,=20
because it doesn't report the problem, and it may leave hung processes=20
behind. it is also extremely bad if keeping the parent process alive is=20
a lot more important than the child process, but this doesn't appear to=20
apply to the particular use case.

adding a proxy doesn't fix the problem, it just adds another point of=20
failure.
