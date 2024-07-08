Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10C81745
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451680; cv=none; b=K3GuvZudbFB/m952H1fZqXZrLUg2ZGny5j7pGnwPqWJiWEBaGkL+b4fW6QOsNSfnkoGc5FYZwhfpSBaxLxWpZwS5F1bQ25EIuKKK9yHDsvH1QVcNf+q2AqAxRLXIJV4lfCiDUCAfA3q7PGjvvIBmzv6WrlwdmCs5rzcAo7Rav3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451680; c=relaxed/simple;
	bh=KLU40xH/aEDJT+X/NF7o+wSd9Yxk4T7EkjJsYeIXPBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iiLo6ShEeh6C12BcbrSdHOdUmmPQ2tEwdqp6ye8/LCgO0Jzlg4B7ObCOQh4yiylhh211vzx247Zam50WxnnNhWVkeLg9F5xDOEP+1I43n0bEeBvDo58TqbL6mOTQZUH5EW7aS5Vg1+rpq9tDOZu3gSdPp78VnCLZSfUzWSLDDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [10.42.0.97] (dynamic-176-003-149-048.176.3.pool.telefonica.de [176.3.149.48])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 05FFC18069C;
	Mon,  8 Jul 2024 15:14:33 +0000 (UTC)
Message-ID: <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org>
Date: Mon, 8 Jul 2024 17:14:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: rsbecker@nexbridge.com, git@vger.kernel.org
References: <20240708143239.vq47dg7mgh33hykf@carbon>
Content-Language: en-US
From: ellie <el@horse64.org>
In-Reply-To: <20240708143239.vq47dg7mgh33hykf@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/8/24 4:32 PM, Konstantin Khomoutov wrote:
> On Mon, Jul 08, 2024 at 04:28:25AM +0200, ellie wrote:
> 
> [...]
>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly: CANCEL
>> (err 8)
> [...]
>> It seems extremely unlikely to me to be possibly an ISP issue, for which I
>> already listed the reasons. An additional one is HTTPS downloads from github
>> outside of git, e.g. from zip archives, for way larger files work fine as
>> well.
> [...]
> 
> What if you explicitly disable HTTP/2 when cloning?
> 
>    git -c http.version=HTTP/1.1 clone ...
> 
> should probably do this.
> 

Thanks for the idea! I tested it:

$  git -c http.version=HTTP/1.1 clone https://github.com/maliit/keyboard 
maliit-keyboard
Cloning into 'maliit-keyboard'...
remote: Enumerating objects: 23243, done.
remote: Counting objects: 100% (464/464), done.
remote: Compressing objects: 100% (207/207), done.
error: RPC failed; curl 18 transfer closed with outstanding read data 
remaining
error: 5361 bytes of body are still expected
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output

Sadly, it seems like the error is only slightly different. It was still 
worth a try. I contacted GitHub support a while ago but it got stuck. If 
there were resume available such hiccups wouldn't matter, I hope that 
explains why I suggested that feature.

Regards,

Ellie
