Received: from mail.rackland.de (mail.rackland.de [212.86.200.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A74622157E
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.86.200.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766803432; cv=none; b=SA+rjhdFuCSJlf0xvTlF3WCRpQ7c5v3n4bitA4L9+z8XR2xyoqL0ygrRTsXUfYZNxFDY7d/xLBQRvFQ1CxruAT5bWfwq+JS3FZgrQoCOuB3suPCBWLeSnV9/5pIcPbQZTqw8Rh1y50qY7OEf2sLB+OFcHtbh0xeTpgehimRmcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766803432; c=relaxed/simple;
	bh=6VonYaTZnIcGkLhZkz9zHLUkhnQHrf3C6WVl3FZzJr4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=XOh4O6f+pGb0+SU3Tb3AAQlSu0jKCEzgI0AQ+giNbzYxfmBNeNMzP+VL23qMgnkOdygGnxd1D1Kt+lSPR5f/as/oySufYWzrlIICStx7gN4GHNcvCOVVwQrZGwNo6RZc+qzuyGx0jlxsPuEo8kfrKXcC0yR/eK7UxyyHwYvfBFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danisch.de; spf=pass smtp.mailfrom=danisch.de; arc=none smtp.client-ip=212.86.200.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danisch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danisch.de
Received: from [IPV6:2a02:8109:d486:800:dfb4:32cb:1421:fb1d] (unknown [IPv6:2a02:8109:d486:800:dfb4:32cb:1421:fb1d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.rackland.de (Postfix) with ESMTPSA id E33936032A
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 03:37:51 +0100 (CET)
Message-ID: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de>
Date: Sat, 27 Dec 2025 03:37:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hadmut Danisch <hadmut@danisch.de>
Subject: Git destroys u+s and g+s directory modes
To: git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

(please respond to my e-mail as well, not just to the list, I'm not 
subscribed),


I do have a problem with git 2.43.0 (ubuntu server 24.04.3) and 
directory modes:


I do need my git repo (owned by me) to be readable by a system user 
(running a rootless podman container).

I therefore set a special group for the directory, and set the sgid bit 
of the directory ( chgrp ... and chmod 2770 ), but when doing a git 
clone onto that directory, git rewrites all file modes, including the 
one of the root directory, and the  S_ISGID is lost.


The only setting I found about file modes is core.fileMode, but git docs 
tell that this is for file systems that do not keep permissions 
correctly, such as CIFS or Windows bases file systems, not for keeping 
git from changing.

The only way I found is to define a hook to correctly set modes after 
git pull.


Is there a way to keep git from destroying group permission and S_ISGID?


If not: Proposal to set a bit mask with file mode flags git shouldn't touch?


regards

Hadmut




