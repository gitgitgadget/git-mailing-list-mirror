Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C53268C73
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021410; cv=none; b=NtGtXVqEWTpYlX4uhEXTiHC308bnYh/+UJnDRrXrR3B4jDycLy8E6b8OPDEgjqW4Y/fflbtGBdM2ig0L/kIdkiDVksG81NE+4/v0CdOtBv3fWTeMvlXlFvYfBevRcrbiqXO5dSlps/tjpEl56niE8NEwDD8DakrvI2ECh7oS9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021410; c=relaxed/simple;
	bh=Yuy8a3JUzvAE8PcgbZyueCqn9YL+4NwzIXCl99UGLoA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rvNZtiUIeNORpatl/DY8YdX7CuJHlHZ1awcB8IMXaFolYFqzoJnL9hOAM/eh6YCkLunSknWYli8XBbuHrD73mEq82H8YeZ818QB8vs6otgfAG/UsNuAd7Nk00o734aqn4fg9cPLmMKAP4WqL18hwCMKA8+zGzAgILC4Ojq7eVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QDiH8goO; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="QDiH8goO"
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id 97DAA40A3272;
	Tue, 12 Aug 2025 17:56:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 97DAA40A3272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1755021397;
	bh=LKQsq8UeRx1/iQuYcVTSuu8It9I9/gFBo6O+NRNqzsQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QDiH8goOKW8oQSPCRH3U9hZIS06FvYcEDMtEideXqfHaXzBAf77dN/3yFGUXFTWuj
	 fgAlJ3jLVZK1y1G2U2KqjSPGgUSO73/AWLiLrhT8ucPPwKsPKH15uZN7cpA2ZeLQz+
	 /V27dN33JU+MpMptRCTG6xSuvxeQCr8XChTyd4+I=
Date: Tue, 12 Aug 2025 20:56:37 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
In-Reply-To: <c2fe3b69-8436-af46-c47d-dde5bb037227@ispras.ru>
Message-ID: <0379ba2d-837b-761e-9d5a-d65ca9d051d6@ispras.ru>
References: <20250728190520.10962-1-amonakov@ispras.ru> <20250728190520.10962-3-amonakov@ispras.ru> <aedb1be1-3151-421e-94ce-27bc77d80b83@gmail.com> <353c7865-d9b5-2a1c-4d71-cd1136581f01@ispras.ru> <5cf47722-7073-4761-8698-090af840d0c4@gmail.com>
 <c2fe3b69-8436-af46-c47d-dde5bb037227@ispras.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

> On Mon, 11 Aug 2025, Phillip Wood wrote:
> 
> > > That's what the 'cycles' column in the table gives (6.21/5.8 = 1.070...)
> > 
> > It would be helpful to add a column with those calculations in it rather than
> > forcing the reader to calculate the speed up for themselves.
> 
> Ok, will change it to
> 
> version | speedup over (A) | cycles, bn | instructions, bn
> ----------------------------------------------------------
> A                            6.38         11.3
> B         1.027              6.21         10.89
> C         1.1                5.80          9.95
> D         1.094              5.83          8.74
> ----------------------------------------------------------

On my Skylake:

version | speedup over (A) | cycles, bn | instructions, bn
----------------------------------------------------------
A                            5.77         10.96
B         1.076              5.36         10.60
C         1.12               5.16          9.66
----------------------------------------------------------

A is today's master, B and C are patch 1 and 1+2 like before.

Alexander
