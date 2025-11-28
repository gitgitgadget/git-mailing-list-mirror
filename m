Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47F2D29CF
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764368439; cv=none; b=lkSe/8QsTSFcifI7OzoHqPJcXtETRe7KzG7wZlKnYe6nLy0Id3JEzkInz3wykFEoBlLqbn6Tj8DAwlR8YYpYsr9e/qIWxISAefIj8xKzqVgnBGSqapnIAYAPkD3ZAM9bjEm946BDh91sbxk/CUGNOOlh5qzmq/BYjuav+B+okzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764368439; c=relaxed/simple;
	bh=tPiF0NRM6Gk263zhEDwbdSAWIo3PQ0T7k/jmS2DYgi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGbr2+MEs3/8xfl+8Gw0IAWZ6PT468qrok+fKb7bBD+MbT/enDyrdcIcD/QBOTz/a29fhxy8YxvY7Y7ZYzpuYb0aGY3g0n68BU49SU8NhZPFh2NcZHkhoniPBOhsyvXAs8iQZnUQQtrXnJ8UbrWuhuC47JHory/NO0SQkfgeB7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=StM9J4sS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="StM9J4sS"
Received: from [192.168.9.110] (157-131-184-197.fiber.dynamic.sonic.net [157.131.184.197])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ASMKMkn010889
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 28 Nov 2025 17:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764368424; bh=KKPjcCSvFSyqi0OAsbbIhvkasW5QsaAxJrplbOGvJGA=;
	h=Message-ID:Date:MIME-Version:Subject:From:Content-Type;
	b=StM9J4sS052Y1f/onFoaHl1oBu55wUSBzcwRCZA5DKPjhTWyG/x3GCnRTHbF5KAAe
	 hpqmlAic7zKC4/oT90q5Ae0OUSraUUxYu44rszlJaPuM2iAT0VJv6Lq+n4D6lV7rg4
	 lfTW6RO3eT33WGEqFg+lWPXcHFyjtjoWVFoAHIpbXuCW/osTJGEMYnjNrQm24x5YyC
	 9Th5D/rHIcMXWf5KSBzh3l0aLvVTv8KJXGH5DiNU3Uyxrij4kUTt4aM3finBYpnhQZ
	 qApVZB8yR7aLQNfH4FzLbFPKY9fmqhWWiBVuQHIoGyWpQCdg9Sz2iT89HphuhIqVgL
	 tnEW0rPdlcYKQ==
Message-ID: <5699f2cc-5157-441e-af98-4d8df492ec72@mit.edu>
Date: Fri, 28 Nov 2025 14:20:22 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized
 memory
To: Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
 <20251128205514.GA605489@coredump.intra.peff.net>
Content-Language: en-US
From: "Anders Kaseorg" <andersk@mit.edu>
In-Reply-To: <20251128205514.GA605489@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/25 12:55, Jeff King wrote:
> In the same vein, probably using "sizeof(lm->scratch->words)" is 
> better than "sizeof(eword_t)". But again, I find it an unlikely 
> detail for us to catch under the hood.

As words is a pointer, you must have meant sizeof *lm->scratch->words or 
sizeof lm->scratch->words[0].

Anders

