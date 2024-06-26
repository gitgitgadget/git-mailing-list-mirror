Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DCF155A26
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427770; cv=none; b=RmJSottYc9IoCEidRLr6Yw/+LTz4iwPS692MEwtDztBLNEmD3o12wBlvccDOqMxmyrW9ub7kRl8kpBxfsD2HX09HcvPISfaRRh3O7HwQOJ1XJoAtYS+hwFq6OnRvkVjLefyF7dSP6LIKjEeq75Z2VR2UB6B9AYUEK2xzevwnY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427770; c=relaxed/simple;
	bh=3DiwA5t3KK5gSqxrZHNRFGlzbeBAH21nwN2w7Y3IScc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QjukMN/gqB38eXT/AkwMSxp7It8pWDVC97geU7TfDRRelM51IAcAhev8oQkNx28eufmp91Q1AlJonNBBWz0+mBdi+YrgNZYtDyfErpbyQQ8A9iwb5v1uYQ6B2vLhGHtS4tzIJKImW5b3HR+FVL2XRfObidTjl7mqoMv9Oxv5/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UepvsTiQ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UepvsTiQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 430F02129A;
	Wed, 26 Jun 2024 14:49:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3DiwA5t3KK5gSqxrZHNRFGlzbeBAH21nwN2w7Y
	3IScc=; b=UepvsTiQ1jqGSUpBGYTAaUPbpMG8z+6Ym0Wcg44O8GWo0ejb0WbgEX
	DGWaXpAj2b1ehbTCHHKcq86NhlzcaO48KXbGFpWoo4gdbBojQ9U5yZMJZ5aNM1I2
	RoyN74LI5fsxHi+1NSn180ajXtQ3Z5pa01jqOOpYO7iicLiAmZ6ks=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 39C7621299;
	Wed, 26 Jun 2024 14:49:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 51A1821297;
	Wed, 26 Jun 2024 14:49:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Paul
 Millar <paul.millar@desy.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH v5] describe: refresh the index when 'broken' flag
 is used
In-Reply-To: <f7d0abce-b389-45ae-992a-adbc7ec10d50@gmail.com> (Abhijeet
	Sonar's message of "Wed, 26 Jun 2024 23:37:29 +0530")
References: <xmqq34p1813n.fsf@gitster.g>
	<20240626065223.28154-1-abhijeet.nkt@gmail.com>
	<CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
	<2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com>
	<xmqqikxv4t1v.fsf_-_@gitster.g> <xmqqcyo33cgu.fsf@gitster.g>
	<bbc223a3-2c82-4108-adf1-5e8518ff776e@gmail.com>
	<xmqqsewz1ua5.fsf@gitster.g>
	<f7d0abce-b389-45ae-992a-adbc7ec10d50@gmail.com>
Date: Wed, 26 Jun 2024 11:49:22 -0700
Message-ID: <xmqq8qyrzgi5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CE9D59E2-33EC-11EF-BB68-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> On 26/06/24 23:05, Junio C Hamano wrote:
>> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
>> 
>>> To me, this looks much better.  child_process_clear's name already
>>> suggests that is sort of like a destructor, so it makes sense to
>>> re-initialize everything here.  I even wonder why it was not that way to
>>> begin with.  I suppose no callers are assuming that it only clears args
>>> and env though?
>> 
>> I guess that validating that supposition is a prerequisite to
>> declare the change as "much better" and "makes sense".
>
> OK.  I found one: at the end of submodule.c:push_submodule()
>
> 	if (...) {
> 		...some setup...
> 		if (run_command(&cp))
> 			return 0;
> 		close(cp.out);
> 	}

This is curious.

 * What is this thing trying to do?  When run_command() fails, it
   wants to leave cp.out open, so that the caller this returns to
   can write into it???  That cannot be the case, as cp itself is
   internal.  So does this "close(cp.out)" really matter?

 * Even though we are running child_process_clear() to release the
   resources in run_command() we are not closing the file descriptor
   cp.out in the child_process_clear() and force the caller to close
   it instead.  An open file descriptor is a resource, and a file
   descriptor opened but forgotten is considered a leak.  I wonder
   if child_process_clear() should be closing the file descriptor,
   at least the ones it opened or dup2()ed.

In any case, you found a case where child_process_clear() may not
want to do the full re-initialization and at the same time it is not
doing its job sufficiently well.  Let's decide, at least for now,
not to do the reinitialization from child_process_clear(), then.

Thanks.

