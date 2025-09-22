Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461B78F43
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538301; cv=none; b=qD8cpFLmR237R+jRETK7PFOSIXwaP7WJAajQ5I5BhQ9jYT9CzxmZnVj5V3hbuTNJPI7Z4qMKoaGJaeTPYQ6tjtCi70OnLg8kUF4Ds3QAE5pXywlbwaQ4npUGVqPZZFNfohrVyq4GcOqVV/NlbbSgK1+P5XBltjCGP2DLm5O2IZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538301; c=relaxed/simple;
	bh=/7YDxUvlFBr+LYHXDclJ3Sce72RzZLV3yj8sDHIqSc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lAuTP6QKXukl8AcU1r28mxojxzpHX6orzS1XUG2d4WlHEuIsCRWMflKWclvZsZiYU1PoabErTxMbz+Lz3L4FMYJztOGPpktFp6yHCaTgbyoHe0O5RBsfdRTUGBLibVc71TN69oltWUDBwpCX/VXefC9dAGMZKk4e90CfG8apMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 674DF3F006;
	Mon, 22 Sep 2025 12:41:26 +0200 (CEST)
Message-ID: <f478fc6f-77ab-4d4e-a8d9-2d44622ba8dd@hogyros.de>
Date: Mon, 22 Sep 2025 19:41:23 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Could Git be smarter about object reuse?
To: Sainan <sainan@calamity.inc>, "git@vger.kernel.org" <git@vger.kernel.org>
References: <pmKix6R7b3WVLrcK6ig1Lh7RhrB5G4Hm5yam_fEoC839aatB-OjJEmSJJ-weErGEnt4Mvgf5slxgu6Pm1xlGZ4mr_i4MIAAEMYy8DjJnWgk=@calamity.inc>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <pmKix6R7b3WVLrcK6ig1Lh7RhrB5G4Hm5yam_fEoC839aatB-OjJEmSJJ-weErGEnt4Mvgf5slxgu6Pm1xlGZ4mr_i4MIAAEMYy8DjJnWgk=@calamity.inc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/22/25 7:06 PM, Sainan wrote:

> It's especially annoying because I know the server already has basically all the blobs needed and hence would only need to receive the commit and tree objects.

Git already does this. The receiver sends a list of commits it has, and 
the sender omits all objects (of any kind) that are reachable from any 
of these.

For this to work, the sender needs to be able to follow the commits from 
these references, so this does not work properly if the sender is 
operating from a shallow clone, or is missing branches, because the 
receiver only sends a list of branch tips (and, if the receiver is 
shallow, missing commits), not a full list of objects present, because 
that would be a lot.

    Simon
