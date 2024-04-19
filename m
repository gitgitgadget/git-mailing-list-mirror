Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715D1304B6
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541396; cv=none; b=k7FQVNA3kAKjl0YEZJCaf0iTTs/VEVnK4gIDz7FhbjHgHi0K+Gvo9iltW/oOkOF5VY3Jo2Ngbm9V6jHu+SXsx3Abp8QDjXkaNf81MGV+J9DrYtdjf1Z/jdJPGfkXA2miWiF+3Rg6JnOUUN3Ttungp/u/JET8yc8KeklRl6uvoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541396; c=relaxed/simple;
	bh=bprlks1LF+/3csF6MbJ8V0NgX8ARMG95fgn2fPydbTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSGPnfg97FxX1je7llvFMHX5qqGzMgLUhs5xHSgrCHnS5qDZ+f/HQBlE90J/RGmrpfebgB24r+YIAv8azUzCQTXOpFGDS2xcQidznQ7TovmVMjUlwJ3eEUiDGUTUWmsUuBVBv7N/1b1u6wFUQwoJOxM5DSoA+L5WyiVJvALz4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVyu60xb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVyu60xb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23D881F394F;
	Fri, 19 Apr 2024 11:43:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bprlks1LF+/3csF6MbJ8V0NgX8ARMG95fgn2fP
	ydbTY=; b=kVyu60xbIYJKFECWlwWSmBtg95f63Iqm+5bQmNNygVaPhGsNn6Jzyr
	rTym4WeyvD4oZFhV9fjoG6d+ErLh9hZj8giYk+JNuOfhjSYDayTG0NGU4zg/jpzC
	Z7SkfHmKrMZ1y2wq/aHQbjdEqjpzU4V+d5wPYbYcZmYUn+3lbj/I4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B0A21F394E;
	Fri, 19 Apr 2024 11:43:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8194E1F394D;
	Fri, 19 Apr 2024 11:43:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Dragan Simic" <dsimic@manjaro.org>,  "Eric Sunshine"
 <sunshine@sunshineco.com>,  "Phillip Wood" <phillip.wood123@gmail.com>,
  "Patrick Steinhardt" <ps@pks.im>,  git@vger.kernel.org,  "Drew DeVault"
 <sir@cmpwn.com>
Subject: Re: [PATCH] format-patch: ensure that --rfc and -k are mutually
 exclusive
In-Reply-To: <0d584b86-0b48-4e7f-b81c-fdb672dac98b@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 19 Apr 2024 15:43:10 +0200")
References: <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>
	<0d584b86-0b48-4e7f-b81c-fdb672dac98b@app.fastmail.com>
Date: Fri, 19 Apr 2024 08:43:12 -0700
Message-ID: <xmqqo7a5mk8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 88356C24-FE63-11EE-B0FE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Fri, Apr 19, 2024, at 03:05, Dragan Simic wrote:
>> Fix a bug that allows the "--rfc" and "-k" options to be specified together
>> when "git format-patch" is executed, which was introduced in the commit
>> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets").
>>
>> Add a couple of additional tests to t4014, to cover additional cases of
>> the mutual exclusivity between different "git format-patch" options.
>>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>
> Looks good to me FWIW. Also very good description of the changes from
> the previous version to this one.

Yup, very easy to follow what changed and how.

Will queue, thanks all.
