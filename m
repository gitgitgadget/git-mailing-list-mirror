Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138F2231C
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299751; cv=none; b=MYv4Arsu8/6ix28uLVM8dwyaOnx4V4ern7Kz20Rx9CsqS4E9Wk2tgCQuHjodm3pH9xLJcf6jb4BpcHBQZtuRBQK9ShgrqFOrph1zK7nHt0AbdV/o+UmcJLXd5wn8fBvSZ10WRmGr5gp7W1xp/X+dJdxcJCIpUNXvCustN98/Jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299751; c=relaxed/simple;
	bh=yAzF9ONKfug8z2KvXLbBKQ6fdlKFN7vFWFc9uw4LrIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bvN1F6fn19cH5TC8oQB16uWON5nbFD9OHIFzk4qne/vI8e+6hcl8LCKow9p9KXYhuP6rnGz6hDGloFYeH2yI7RJ1zalnN6tpnJs2CQ1GVM8GLcu6P7hnCHF2lXkqEKZvJsRTbos6oBlUljNEC896IRaFG28SOQvK0i72mTSlOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hKykKOPg; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hKykKOPg"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07ABF1D7282;
	Tue, 16 Apr 2024 16:35:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yAzF9ONKfug8z2KvXLbBKQ6fdlKFN7vFWFc9uw
	4LrIU=; b=hKykKOPgj+5w9kP1UtIiVGNsKy+rhBcLUS5UHO83CBzDXbuBI+PTUh
	SWJVC/U2P0/hMgSD8dSsKjg2kMHzJX5gSMWtptIa8lYVEAUBIa9wK5e0JsGszHkv
	/eoJVV1+T+RazK6I6VMgIDmSAC9xm7ElOEN5HvrUsyi+lOOLdRvU0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1D511D7281;
	Tue, 16 Apr 2024 16:35:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62AA71D7280;
	Tue, 16 Apr 2024 16:35:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] advice: Add advice.scissors to suppress "do not modify
 or remove this line"
In-Reply-To: <Zh7NZhB1n2o1k7jI@localhost> (Josh Triplett's message of "Tue, 16
	Apr 2024 20:11:34 +0100")
References: <0a7b9172add0a0107e0765a59a798b92161788dd.1708921148.git.josh@joshtriplett.org>
	<Zh7NZhB1n2o1k7jI@localhost>
Date: Tue, 16 Apr 2024 13:35:41 -0700
Message-ID: <xmqq7cgxdp0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4E93E3A-FC30-11EE-9618-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Triplett <josh@joshtriplett.org> writes:

> On Sun, Feb 25, 2024 at 08:21:54PM -0800, Josh Triplett wrote:
>> The scissors line before the diff in a verbose commit, or above all the
>> comments when using --cleanup=scissors, has the following two lines of
>> explanation after it:
>> 
>> Do not modify or remove the line above.
>> Everything below it will be ignored.
>> 
>> This is useful advice for new users, but potentially redundant for
>> experienced users, who might instead appreciate seeing two more lines of
>> information in their editor.
>> 
>> Add advice.scissors to suppress that explanation.
>
> Following up on this patch. Happy to rework if needed.

I am not personally interested in the feature myself, and I doubt it
would help the end-user experience very much.  You'd need to find
somebody else to cheer for the topic ;-)

Thanks.

