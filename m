Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD72D248B
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375965; cv=none; b=HFY4oATU2x3kzGz81vqxDOkBfwKaojtxxbOeYxDbNOs6V77RD+CAClHrX83z7v7kJiNV99ccAO4uet67smLXLlwTh2lZkG4gmsXMIXTnSoKHiM5wTEwDbtlS1rOmlyFxqfMdARvT0wQokj4MGcWk9JVepm9juIoJaQ8HRmR1N3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375965; c=relaxed/simple;
	bh=Q5S2lvGSP+DIUEDB8vtrKHH0K7vm3j8SBch7qqck2RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W71pIzGjDoz98HgQhCDHfaSVuRnMENhecySvSDS+445JZ4TOAdt9hlOoRSniKtJRgYPPOSJh7vImsKcayGQI90rPA61wIpIMiAFDlxl/WbJe5PtwAi3QKf1tXzgO8Ff9uIr+VoCw7DlLfXWNqiyO+rLwxcUk+Jh7EYQ5Pb+Zgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 3B5ED3F209;
	Tue, 28 Apr 2026 13:32:39 +0200 (CEST)
Message-ID: <a54d57b6-9270-406a-9056-ffaa939c6c21@hogyros.de>
Date: Tue, 28 Apr 2026 20:32:37 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git generated tarballs and Debian
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 git <git@vger.kernel.org>, Ian Jackson <ijackson@chiark.greenend.org.uk>
References: <9030b26d-02ed-4452-b212-a69a4ff21e2d@hogyros.de>
 <afCLFJX86yEPKKfk@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <afCLFJX86yEPKKfk@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 4/28/26 7:25 PM, brian m. carlson wrote:

> I'll just note that we don't make any guarantees that `git archive`
> produces identical output across versions.  Incorrectly making that
> assumption broke kernel.org when we changed the format in the past.

Exactly -- that's why I read the tarball and calculate the checksum of 
the corresponding tree object, but we have a few cases where we need 
extra information that isn't in the archive, and I'm wondering where to 
put that extra information: inside the archive itself, or into an extra 
file.

> Also, if you use `export-subst`, then it's possible to emit short object
> IDs, which can differ in length depending on how many objects are in the
> repository.  It's also possible to use zlib or pigz instead of gzip to
> produce tarballs, in which case the compressed data will also differ.

export-subst breaks verification completely as soon as a blob changes.

Compression isn't an issue, because we're comparing tree checksums.

    Simon
