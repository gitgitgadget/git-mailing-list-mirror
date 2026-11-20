Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204495;
	b=Xs0olfrLdKi1cxdtW/gAuee6rMy89hvFa5VRCbqDgyVTqVR81WWM4Tx/qQwYZUFkg/vj
	 7cU5VEnqsOuNSxOmPM8mm7aMZYQQFCyLvbTvy1q3oQ17uVnNPs/Dsq0l7Q3XWGMkEbMEo
	 y+Evw+QojpQmpnwSvGZvPMxwCmt2VFVEwic7ESlZ7A3e/rPsDxu5D3GXNbcC58aqHFz5/
	 YRo/ffVu7WpXrzFC6yhdB75zfHhnxpbL0NhB3HejWtAFToCwQ8u6lO7xCuZnl3PSCvvqX
	 4DTwQogYfNF+U246X2f+wBdxCRSD8OHPGcXxowCWDvlifNp8bAN0zWciyQ6K/ih+fPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204495;
	h=DMARC-Filter:Received:Received:Date:From:To:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=xoQKa5tBisFLh/Zr8FwU7TDAW4fawCEkzPlA8fBlnPk=;
	b=I8zBfLmZZqmG4oSaavKYp2wKfKM12qeIbwtwOc6WkiowI9v5GvZEckS4xINW2m5NkqOm
	 c1m7wS3UMildnQ9AeDOd5xpwVoDdlxxTAsHDyMpYwJKPr11Hg0C94nWJMnhXkYXybZCgG
	 KD2TvM22v0o9t/zDNhzS/KmEGuvIrC1gXWTuSxO+ITPAxSdHIi7IE0G/Bx4V3xVicIYhP
	 AyZ5bU5oeGK8BayF3yThYWZwQSimL0WPgaXiQdm3kcjD8ExzVU2Q14GZkWhdyFduKvRQP
	 XzYorJL7Y1rkTwTXJtGFy9XJSPDSjiskfqkhzcadNv2QmA8NYx2iNcJ+jK28CdtIUFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Iqbiv3aD;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F011C606A6FA
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F011C606A6FA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Iqbiv3aD
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id AEF4114014A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:54:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 6C44317
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:54:45 +0000 (UTC)
Date: Fri, 20 Nov 2026 14:54:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: git@vger.kernel.org
Subject: Prevent git reset --hard from losing data
Message-ID: <20261120145444.13061eb7@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6C44317
X-Stat-Signature: bmyafxtsueiesgzjmcomw7j3q9ey5at3
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/vDow/sqbWW7RkYE8e6KWeV5Y3gF4Hd08=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=xoQKa5tBisFLh/Zr8FwU7TDAW4fawCEkzPlA8fBlnPk=; b=Iqbiv3aD8fCJJDr/tn++w15EQyhg94Apu2CQV5VBSiwu0MACs+3a+kyDmgw0tkbSUGM6VRtNP8mr2fUrixFDvW7rUinnBEDF/XOoWrYbXu7F1zDd39KVosLmjYHZKRF9+UtBTgQVhLtD+bNHn+4ljsOFHitPFpuVazLXQS3U4so=
X-HE-Tag: 1795204485-52353
X-HE-Meta: U2FsdGVkX18C4/eD5xhNV+uh0FZ67ygSHPmsL8l3MMPlFOVjQVSY/KgLLUQDIQkvhGRFbohaZNVbLccPHEMzql5/mnW0qsXYme/gbsPhPEd7wI+8eaKGyDPcl7/K88dLTnWN5+HPaRrRM1bUAsZS6T53jYTj0D4VTDLrgQVxnGyc8gtP1Hq3Wx88xkvnn8WFy/7DUKoW62+Jkvklbc0ZMO3MMFQoSI6Bzptl66xHT6E2Hz5lj5FfFDiFSUcC7zJtRZR+hslrcPy+30ua9jVmpx7hRjp+RUkhLts0T+8EfVndHeDWu5xAr64pzaHILyG7

Hi,

Too many times I do a "git reset --hard" in the wrong directory and end up
losing uncommitted changes. Is there a way to add a configuration to have
that command check if there's any uncommitted changes and ask if you really
want to do the reset?

[ I'm writing this after I just lost some uncommitted changes from doing this :-( ]

Thanks,

-- Steve
