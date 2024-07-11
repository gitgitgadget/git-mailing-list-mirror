Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C448479
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708901; cv=none; b=BGlHVtme0ZZ9/esg3rw9HPChwsqphYu9/mErBpCfjwBZlPggtXxf8RQetQrBwS27XQIGfdbyAiI4q2CEo0xfjbO7qPlnnjZdx50WJ5BHqvP73Jhr+g4zaTMqZV94+fKRgrrorGPBp/pt8/FPSf/4gv3+WyjH3CmwbKsABCnOCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708901; c=relaxed/simple;
	bh=xb7QfkvvfyK04z/T1eKtWXB5uR+9Lk+jT+hJxoz1VUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CH0wW5lq+FCFx91V/icfrZ1+Q5EbIY4iT/LX+Ek6o6mBDjFmZpjm3z4INYugNRofprLaBkPRytsMxhNcZb8cRXVIUE8DXb7zHsy8CNWz8PpmMghVk8Ly61viDn6svEZWN+tQSFrm0r373QtXI8mFS6c0/MY0rZ6r5eXPdeDqzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f6EYxH4l; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f6EYxH4l"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C09724D47;
	Thu, 11 Jul 2024 10:41:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xb7QfkvvfyK04z/T1eKtWXB5uR+9Lk+jT+hJxo
	z1VUk=; b=f6EYxH4l1F1et0DNCaWsILN0L+9DZfuJ2ZbNgAXXuN6z+NGE9GfZjV
	WTSHQ/diATfhdiJUcxQSa5qOgDTmbCKH3wl3mzH3Da0oCazF6bhDYuFIbAoawkvQ
	wZIKBPltbU9Og6jaSMJmK+P5NVdO64jimonmVgXrkrHepvyHwHz5I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 24A9024D46;
	Thu, 11 Jul 2024 10:41:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A75CE24D43;
	Thu, 11 Jul 2024 10:41:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
In-Reply-To: <CAOLa=ZSUZGqxHbEtpR3fadOFf=YPVxbo8W7SwyB9j5am14EB7A@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 11 Jul 2024 01:27:41 -0700")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-9-karthik.188@gmail.com>
	<xmqqbk37hjma.fsf@gitster.g>
	<CAOLa=ZQdPTnLp63eFiq1oOkgukBGsug==Cam0hGW_9koCefhGA@mail.gmail.com>
	<xmqq8qy9z14t.fsf@gitster.g>
	<CAOLa=ZSUZGqxHbEtpR3fadOFf=YPVxbo8W7SwyB9j5am14EB7A@mail.gmail.com>
Date: Thu, 11 Jul 2024 07:41:35 -0700
Message-ID: <xmqqsewgng80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AD009058-3F93-11EF-A72C-C38742FD603B-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> I was commenting on the exit status check done here:
>>
>>     +gitLogOutput=$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)
>>     +if test $? -ne 0
>>     +then
>>     +	echo -n $gitLogOutput
>>     +	exit 1
>>     +fi
>>
>> Even though the output is captured in a variable, the exit status of
>> "git log --check" is still seen by the shell and "if test $? = 0"
>> next line say "ah, the thing exited with non-zero status so lets
>> echo the whole thing and exit with 1", before it gets to the while
>> loop we have below the above piece of code, no?
>
> My bad, I thought you were referring to the code before my changes. Yes,
> here you're right, we don't need the check since the shell would capture
> the non-zero status.

OK.  

Because in the next round, you'd be checking the error condition
of "git rev-parse $baseCommit" or something that is specifically
designed to check the validity of user input, and not the error
result from the actual "log --check", the above becomes moot ;-)

Thanks.

