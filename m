Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9C1BC4E
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669669; cv=none; b=ce5qIyQEjnjs1R6uSsr1Y4/lUuj0mgbxYBY8Z1PflqKQnNmfLA2iNZLJOTbEqPgKPdpLs3LGIFDAbFgda43Lf7h9W+RjXogGnurob68AAP3Ogn3OC9Y5ImldsrMBpltLcMmyx5DpSz7m/O0Kbv6Tw+yVWU0Y1w7q6nfhERJ7z1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669669; c=relaxed/simple;
	bh=m+yIbcJ9qlTZvbpiYrsY2cpDewPnsl6PSy59PXfUBu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TFGJEQWb0ktGWHXt2h82YcIxYu//EyObZE7Kfnqa6ZuZpy/Qfr2uYYZ+ZAxdzVze8/hXdFfCS9tS9EjUcWUwnZ5XLBhmI/oTah76n4m+g58z+ozNPfMDqj6NH/HT16H+Q30JMtBQ+AzPzLFiDidYCWg69ywRDsrTM7m5KlU+NGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.92] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 3EE023F072
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 07:55:48 +0200 (CEST)
Message-ID: <e069a7ca-fba4-432a-9a05-a68b2b6ddbc7@hogyros.de>
Date: Wed, 20 Aug 2025 14:55:43 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git: prepare to regularly change hashsums
To: git <git@vger.kernel.org>
References: <198c2b87f70.ff0fbb4065293.4919681043907358329@zohomail.com>
 <aKTqHTnOMp1LFNLD@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <aKTqHTnOMp1LFNLD@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/20/25 6:18 AM, brian m. carlson wrote:

> There are many fewer places where we have hard-coded hash values in the
> tests and a lot more places where we compute values (for instance, if
> what the test wants to know is that we're three commits before HEAD,
> then we write `HEAD~3` instead of a specific object ID).  Instead of
> lots of hard-coded 20- and 40-based constants throughout the code, we
> have a few #define constants and a hash algorithm abstraction.

For me it would be great to still be able to use commit IDs in this way 
in the future.

My use case is a script that is able to build old versions of a project, 
basically it is a long list of commit IDs that require me to change the 
build instructions, and "is-child-of" tests.

So e.g. in a project we switch from cmake to meson, and the CI script 
checks if the commit we are building is derived from the commit that 
switches cmake to meson (which has a known ID), if so, it configures 
using meson, if not, it checks more commit IDs to find out if it should 
use cmake, or just plain make.

So if the hash algorithm changes I need to either still be able to make 
ancestor tests using the old IDs, or a quick way to convert them.

    Simon
