Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A4143886
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056542; cv=none; b=cEWvZjdap60DtiVNhRM6W7eQfmVawlZQdAcpXVXCvPwT6W8y0eM0xzmVYMyv3QltcTH4yTb/OBvWCXkLTwzew0rQi4pQ2J5vPfN7kR9uG23VOGtJKeL5LyWn0Spcv2+Bq4hQPVr3+H7BAXXDedEO/2pWnAXgodnos8H9x1/VrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056542; c=relaxed/simple;
	bh=0MsB63a5gpLjEygCSsUtS3vDJ47wdP7eJvqsD7HFpYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddbrNdS5tfCoGCDPNTHV8H7KoDWr9FkY3UUAc3GW4FcecfFd6DaqNeLyU/DBwobCyCdZqFPVVkXqGhl4St96ZlX5oOmMXGMf7X6ZjNJ600bfwBlrA6oY8MZBrJ+YvENJrf+vNKWDh83f86k3636SednClvMLekgyLNKWwwmv6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=horse64.org; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horse64.org
Received: from [10.42.0.97] (dynamic-176-007-201-050.176.7.pool.telefonica.de [176.7.201.50])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 5A38818574E;
	Mon, 10 Jun 2024 21:54:30 +0000 (UTC)
Message-ID: <f5c24dfc-8d35-4418-b8f6-0a03d70c0917@horse64.org>
Date: Mon, 10 Jun 2024 23:55:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>
Cc: Jeff King <peff@peff.net>, rsbecker@nexbridge.com, git@vger.kernel.org
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
 <CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>
 <xmqq5xug1qrf.fsf@gitster.g>
Content-Language: en-US
From: ellie <el@horse64.org>
In-Reply-To: <xmqq5xug1qrf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for again another total newcomer/outsider question: Is a bundle or 
pack file something any regular git HTTPS instance would naturally 
provide when setup the usual ways? Like, if resume relied on that, would 
this work when following the standard smart HTTP setup procedure 
https://git-scm.com/book/en/v2/Git-on-the-Server-Smart-HTTP (sorry if I 
got the wrong link) and then git cloning from that? That would result in 
the best availability of such a resume feature, if it ever came to be.

Regards,

Ellie

On 6/10/24 10:34 PM, Junio C Hamano wrote:
> Emily Shaffer <nasamuffin@google.com> writes:
> 
>> It seems to me that packfile URIs and bundle URIs are similar enough
>> that we could work out similar logic for both, no? Or maybe there's
>> something I'm missing about the way bundle offloading differs from
>> packfiles.
> 
> Probably we can deprecate one and let the other one take over?  It
> seems that bundleURI have plenty of documentation, but the only hit
> for packfile URI side I find in the output of
> 
>      $ git grep -i 'pack.*file.*uri' Documentation
> 
> is the description of how the designed protocol extension is
> supposed to work in Documentation/technical/packfile-uri.txt and not
> even the configuration variable uploadpack.blobPackfileURI that
> controls the "experimental" feature is documented.
> 
> Perhaps whoever was adding the feature to the public side stopped
> after pushing out the absolute minimum and lost interest or
> something?  We should update the documentation to reflect the
> current status (e.g. is it still experimental? what more work do we
> need on top of it to make it no longer experimental?), add at least
> minimum description for server operators how to configure it on the
> server side, etc. (I am assuming that the end-user does not have to
> do anything to get the feature, as long as their version of Git is
> recent enough).
> 
> Thanks.
> 
