Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770441E87C
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709413677; cv=none; b=W0RqHO3UHsr2YU/ReEOgeYxdgL5I3fH/nwmeEntfSAcD8+hVINj+yfFttc6+IcBcboaRYP+wrAM6K5cBDAxHhWcf4ow2g55w/nJ+4Ntz/1G8EB+pFQ4Lv7LE4XIkErKdhfgGp9AMWUbAr1O4Fahs/U8NgzsIq/6w4dFPH5PoSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709413677; c=relaxed/simple;
	bh=1WFw55QI3s8Ix6aIJPeHy1F+1UOTx1S92eun5OXRWJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K/s/hEJqU8ZvJ5XN1ATn22VzlEV0OTjwfugBr7lo/kJR4yYIZIHanpnlay+wzngAvB3Na1F2FFaORd/19R8lW5eOX3gfDxXHDEATLz/K/WL3Xv7PW7e2jG7Wfm9QexOKP7NXkH7loMRLXsNv/5gxJN2wO18bzwKKSIfy8Tc122Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ga1m3dMH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ga1m3dMH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DFE91E2FD0;
	Sat,  2 Mar 2024 16:07:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1WFw55QI3s8Ix6aIJPeHy1F+1UOTx1S92eun5O
	XRWJE=; b=Ga1m3dMHV91L2gAr52H60mGHPdDQZzEYczkOw2ShCUPK3wLnOfpFpA
	hUIX31vQ8KDo6TABixuz5PW+JvcyOtKByeWkZV3pfWUzSu2tDhRN/uPXfh9baBB0
	NDhBf6Ad2L2/VzVDLXQHbGXnQHQJ7wk6tSYRdprITqGB4xS1c4/jk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 151771E2FCF;
	Sat,  2 Mar 2024 16:07:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 727B41E2FCE;
	Sat,  2 Mar 2024 16:07:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
In-Reply-To: <87r0gs8kgw.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
	02 Mar 2024 23:09:03 +0300")
References: <xmqq34v6gswv.fsf@gitster.g>
	<51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
	<87frxam35f.fsf@osv.gnss.ru> <6033073.lOV4Wx5bFT@cayenne>
	<87r0gs8kgw.fsf@osv.gnss.ru>
Date: Sat, 02 Mar 2024 13:07:52 -0800
Message-ID: <xmqqwmqkwdef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF545DA8-D8D8-11EE-B824-25B3960A682E-77302942!pb-smtp2.pobox.com

Sergey Organov <sorganov@gmail.com> writes:

>> Oh, sorry, I misinterpreted the patch. But yet, I'm not sure that
>> specifying that this is the default or not is really useful. If the
>> configuration was set to true, it is was a no-op. If set to false, no
>> message will appear.
>
> I'm not sure either, and as it's not the topic of this particular patch,
> I'd like to delegate the decision on the issue.

It is very much spot on the topic of simplifying and clarifying the
code to unify these remaining two messages into a single one.

And involving the --interactive that allows users a chance to
rethink and refrain from removing some to the equation would also be
worth doing in the same topic, even though it might not fit your
immediate agenda of crusade against --dry-run.
