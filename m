Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF3EEDD
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423350; cv=none; b=EwscRb4/tTickviiEjq9kGOPHpCWi5Ot5L7IjIpQH3kyW0FGAML6BMRJhuV+QmgIaxOrcr0deDvTFqvSqCYmsPp1DxXvgHcdC2Kv9sc0sYNLLsTPK6mQ+u+yZScJ4PkWxHhZBLtkR3PA0hkV3XA/feR32FPnnEyLPUZL1Dr/gNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423350; c=relaxed/simple;
	bh=H6llLoa6oPvKeGhNbgNp2gouJpHj7HRq4g6rj5gwO2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kik3gxhC9M7I5sPaHV05KD8Pa9TY77nhkcbcxl3YbpL9prpVrK/L7A3PUQIg0eKak6uEwi9r9fgImRUPSLW1nXAwxtgpj3rlqiX+Jgg9bBaVvG3TIpGPGYehS0jFsJMgtYY+So37fOTD4cggFjmjTgWoxNX6n5OiiDfaHKkbO5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KOzRbxa+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KOzRbxa+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A2382FE1D;
	Wed, 26 Jun 2024 13:35:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H6llLoa6oPvKeGhNbgNp2gouJpHj7HRq4g6rj5
	gwO2o=; b=KOzRbxa+nUmgIedQ5NQBoU4rfFMc8qvjEQAhPf0iIdVfR76E4P+RsE
	uaMiLTqQbHasBQPoA6abbslzIJQuvSJBAqPwSoOHzAtieM6+TJIlnaqkGcFgrViF
	Y3APVpdUneBMx3JOe7YDOdlEPAJZSu3OW6clSM9gbl/+aS+m0byRo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CE632FE1C;
	Wed, 26 Jun 2024 13:35:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AB1F2FE1B;
	Wed, 26 Jun 2024 13:35:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Paul
 Millar <paul.millar@desy.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH v5] describe: refresh the index when 'broken' flag
 is used
In-Reply-To: <bbc223a3-2c82-4108-adf1-5e8518ff776e@gmail.com> (Abhijeet
	Sonar's message of "Wed, 26 Jun 2024 22:59:22 +0530")
References: <xmqq34p1813n.fsf@gitster.g>
	<20240626065223.28154-1-abhijeet.nkt@gmail.com>
	<CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
	<2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com>
	<xmqqikxv4t1v.fsf_-_@gitster.g> <xmqqcyo33cgu.fsf@gitster.g>
	<bbc223a3-2c82-4108-adf1-5e8518ff776e@gmail.com>
Date: Wed, 26 Jun 2024 10:35:46 -0700
Message-ID: <xmqqsewz1ua5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 860E6BBC-33E2-11EF-A0EB-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> To me, this looks much better.  child_process_clear's name already
> suggests that is sort of like a destructor, so it makes sense to
> re-initialize everything here.  I even wonder why it was not that way to
> begin with.  I suppose no callers are assuming that it only clears args
> and env though?

I guess that validating that supposition is a prerequisite to
declare the change as "much better" and "makes sense".

