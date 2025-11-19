Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A3260583
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582819; cv=none; b=fgj+i9PLbeDfQ8zSDOEvr2z1xrWVYzsI5fdQTnYHxQoHqPmUas37aqVbs26XsBieqXoST6uV8xqkNbk8LF1Hd+INAWDOGPIOGzzk1WT3MDr8tIkVyYLGtUns66AH7q9+GnlPUs1bCEDF/U+3Rdd2Ev3/ZssTYVQAsm7Y64OS6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582819; c=relaxed/simple;
	bh=Zlo09/V0OGVz4HwsKApXuqbSAiFpLYB9BqsmJ5CMN/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uxcbBWCyJt2mzbzxbdl8sYHqtqdjb8hm/IzttefcfsvdMVYsOxOTZ3K/X+elhylNrKGStrEmPIjoNZXxd44xzXvbPxUWGey0bKjiIwfcWhT9ZZMVvVweO7K9G1NFOmnYykCNh+FtoNBNqJG4cgcg+xsFiZWAlCoq3cB7ApQstS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZFyvggPH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZFyvggPH"
Received: from [192.168.9.110] (157-131-184-197.fiber.dynamic.sonic.net [157.131.184.197])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AJK6Z2N007101
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 19 Nov 2025 15:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763582803; bh=hRdBz9wcM2cBgB1KNnCj5rR6abjKvovStO4ihocGlP0=;
	h=Message-ID:Date:MIME-Version:Subject:From:Content-Type;
	b=ZFyvggPHLwy4tmF+GiBRxSpQxD5z2Z8aBW5B78tbyTlgpvEXgqs+TN3EjMxqMVLIz
	 JO2XPZjBfw53SBVqfDX2HWQnr8dM+23a7cEQGXTOyUkOFqgoMRhin8lQ+nBhuYMWzC
	 8AsbPGarICHjztsTh8neSI7nPtApI1QlvnBxqzFafw+Nqi/NlhvyCRZ+0RJMpVyUFg
	 I7zrhumeV3pOrKRaOI59CZC6dLwRUWWwPIHYa/7DkmKXJ0bKAWmTX1ra7Rwf6EbeDU
	 RD/krwvoyrisPVaUzFIkA/Z1avisHiXDXRDZwADHZQsyY//YxQ+H5ltNls0ybH2a+c
	 0TH5s+8gPWTdg==
Message-ID: <ceacc47b-9d29-4e32-9d83-6bd68279c83c@mit.edu>
Date: Wed, 19 Nov 2025 12:06:35 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: t8020-last-modified.sh failure on s390x (Re: [PATCH v4]
 last-modified: implement faster algorithm)
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
        Toon Claes <toon@iotcl.com>, git@vger.kernel.org
References: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
 <20251103154726.26592-1-toon@iotcl.com>
 <4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu>
 <3b24b6a3-61cc-4b9a-a823-f1e58fd9919b@app.fastmail.com>
Content-Language: en-US
From: "Anders Kaseorg" <andersk@mit.edu>
In-Reply-To: <3b24b6a3-61cc-4b9a-a823-f1e58fd9919b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/19/25 05:49, Kristoffer Haugsbakk wrote:
> On Wed, Nov 19, 2025, at 12:34, Anders Kaseorg wrote: >> t8020-last-modified.sh is broken on the s390x platform in v2.52.0. 
 >> Bisection implicates commit >> 
2a04e8c293766a4976ceceb4c663dd2963e0339e “last-modified: implement >> 
faster algorithm” [1]. > > Does `./t8020-last-modified.sh --verbose` 
give any interesting > output?
I quoted that output in my previous message. The failures in subtests 16 
and 19 come with these diffs:

--- expect    2025-11-19 11:28:57.966106204 +0000
+++ actual    2025-11-19 11:28:58.110112543 +0000
@@ -1,2 +1,2 @@
+ac29b6e974b49803f1c6ec5a705d1bf7dbfa7d2f m1.t
  m2 m2.t
-m1 m1.t

[…]

--- expect    2025-11-19 11:29:03.492349022 +0000
+++ actual    2025-11-19 11:29:03.648355864 +0000
@@ -1,2 +1,2 @@
-b5 file2
-b2 file
+da1857e0652b6f264c0038d684ddecddc273e506 file2
+da1857e0652b6f264c0038d684ddecddc273e506 file

Anders

