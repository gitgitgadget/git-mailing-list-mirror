Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08311DDD2
	for <git@vger.kernel.org>; Fri, 17 May 2024 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715971810; cv=none; b=IK+3VFbvPbM5C3ok91ZCZsfYCI5S33MFeVsnvNsGnR3w2vDY0/TGZ8ibz/5NolVHDH1j6CwEJUqvsT2cThx/R1DT4PqulxO/yT8Tn+QhQk0iFjaihfMtqItinxNK5s9Y8A4MPrU9iouXA70CNJjiW1wzs1KHZrpC8UxkSv3pHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715971810; c=relaxed/simple;
	bh=IKIQ9Bj5OXOdfJbSy1w6gK1Kw4RQzWUldYBlPYTbXF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uziijKi/kVPafLOkN8bW8HQiGEBViO1yPeuUA6eqhlKb7sV/+OVsnD1uktAiD/Oi8jSJ/5M92cxsYNWQcDr1kbT0Eu3FMp6VOzdDs53lPNf/oTgGXJnpOmd0TG2SdGd18mHE5wPfA66N5zZC/e4nbyHmx7oHp0Qsza7OEXtnp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 32171 invoked from network); 17 May 2024 18:50:04 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 18:50:04 -0000
Date: Fri, 17 May 2024 20:50:03 +0200
From: Marcel Telka <marcel@telka.sk>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Switch grep from non-portable BRE to portable ERE
Message-ID: <Zkem21e_kdVfZsVV@telcontar>
References: <ZkePejx-eRNrspZ2@telcontar>
 <xmqq7cfsiaff.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7cfsiaff.fsf@gitster.g>

On Fri, May 17, 2024 at 11:02:28AM -0700, Junio C Hamano wrote:
> Thanks for this and other portability patches.  You are porting to a
> new platform, I presume, where either nobody else ported to before
> or those who ported did not bother reporting test breakages to us?

Unfortunately, the latter is the case.  I'm doing this for OpenIndiana
(an illumos distro, Solaris descendant) and the testing status before I
started the work was:

failed test(s): t0211 t0600 t1404 t1700 t2501 t3404 t4150 t4202 t7609 t9001 t9118 t9210 t9902

fixed   1
success 29241
failed  38
broken  269
total   30158


Now all tests pass.

The work uncovered few bugs in illumos as well.  For example, this one
helped to find issues with grep's null RE cases in git tests:
https://www.illumos.org/issues/16561


Thank you.

-- 
+-------------------------------------------+
| Marcel Telka   e-mail:   marcel@telka.sk  |
|                homepage: http://telka.sk/ |
+-------------------------------------------+
