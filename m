Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EAE208AD
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052875; cv=none; b=m48t8gpEauEDYnrBLTvIB0bq8/dHNpwjg+DOqP4gJKO8m+Tx2BLfQpqM74oqvy6g6vqBIZqyL4gGFBfLq63bGgkO0Wzqs+Li5gBgdoCdbJQL3Rc7JpNf9Io4EooQFJ693IJ1+34kS1NfTHrFc+W9tHunuZnNKnGiI9S72QtN7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052875; c=relaxed/simple;
	bh=10U71v+1pmdcyq0QJc++NT3x6Imo62bSrBzRvVw8HkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mrKjCXC9Qbadq7j7txbHSqmZMmSNI7jaBq3syefGhcDQhX2tNh7W/8pnSHZTarx8EOfA6Eh15mTfbeMh8mye7h0aCd417U8DfNP5yiglyMnqCjJmYbPWioKQMPr+9ScJcpEG1EebgNJUC8V5vjANc++Dhfep1wIiYbOmc2tESzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WteXBbXL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WteXBbXL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D2B91DC5C9;
	Tue, 27 Feb 2024 11:54:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=10U71v+1pmdcyq0QJc++NT3x6Imo62bSrBzRvV
	w8HkU=; b=WteXBbXLI1K9fbUgi3uZshLusuX7hGlP4SOtyXbpt/hxbq7sAfe+5S
	TapiQKFkqqDldN0GL3IIzaboDPEtoAkuK+inxlDZpjGVcPtJips8jl8oAiMDvdsn
	8wzoElfmDR5eCy1YYZAxTT4wDOCBZSlOSiRDJuQUB7fJqN6DWAXl0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 861081DC5C8;
	Tue, 27 Feb 2024 11:54:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F34E81DC5C7;
	Tue, 27 Feb 2024 11:54:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 0/5] for-each-ref: add '--include-root-refs' option
In-Reply-To: <Zd2Ru7LWYyGprvcr@tanuki> (Patrick Steinhardt's message of "Tue,
	27 Feb 2024 08:39:39 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240223100112.44127-1-karthik.188@gmail.com>
	<Zd2Ru7LWYyGprvcr@tanuki>
Date: Tue, 27 Feb 2024 08:54:25 -0800
Message-ID: <xmqqr0gxvoe6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DDE9762A-D590-11EE-8F70-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Changes from v4:
>> 1. Fixed erratic whitespace
>> 2. Remove braces from single line block
>> 3. Starting the comments with a capital and also adding more context.
>> 4. Removed a duplicate check.
>> 
>> Thanks for the reviews.
>> 
>> Range diff against v4:
>
> The range-diff looks as expected, so this patch series looks good to me.
> Thanks!
>
> Patrick

Thanks, let's mark the topic for 'next'.
