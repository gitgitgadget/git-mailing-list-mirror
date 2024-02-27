Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597556741
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075435; cv=none; b=dz26AzSpb1EagxZOT87pospg8pzopvKy9NTRfczs3Uxl8PmDjcfsl51O1EdmPJlnER17+sJ6BukKCuInTA7Tokgqf4stZbCzSXhW3jFBQ6oIYyxfHRWLeQIazQjpA2PzXtE3bG0p7HcpaOvc5fxWkMJVmz8tr1GFHaoFDVFro+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075435; c=relaxed/simple;
	bh=5R91QfXyLe9fvj0ym/EnjLgoVlgNumcyknEhf7o3XKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ecWfAAM/Z2stx0jFVrNXQW+v32XNyjWgQ5LggEHKp76RSw3Ikhq4YMThm32iumX49OJZU7HC6Tn3POlQv9yBi9J3MVjkxGeUdCvCyxOP7qysu+bnrVnZaFYRo3U6rqyYLG85jn42vRuPAKG/DGIUdGj5xuiqMvD3V3+EPYvVPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MAinjqsC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MAinjqsC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E43FF26778;
	Tue, 27 Feb 2024 18:10:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5R91QfXyLe9fvj0ym/EnjLgoVlgNumcyknEhf7
	o3XKg=; b=MAinjqsCovza+nGQwNrwyG5pWKf2dOTt2QRiFbrESXtnL3q5FHIA5s
	NiJaHXIEVFpq367esMC+InsH406varliQUzVdImPRiGDmJSc5HUJTFuwdfRB+MSo
	B6njqJZ+8GEbi9eW6bgBj/Tmwbi/RVQ7XL5bQpHZQEKfnK4xK8fW0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD9B026777;
	Tue, 27 Feb 2024 18:10:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 814A726775;
	Tue, 27 Feb 2024 18:10:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>,
    Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: adapt to the Git Standard Library
In-Reply-To: <xmqqcyshsqcf.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	27 Feb 2024 10:40:32 -0800")
References: <pull.1677.git.1709045045235.gitgitgadget@gmail.com>
	<xmqqcyshsqcf.fsf@gitster.g>
Date: Tue, 27 Feb 2024 15:10:28 -0800
Message-ID: <xmqq8r35o657.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 66D3490A-D5C5-11EE-B118-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> In the commit "git-std-lib: introduce Git Standard Library" of the
>> `cw/git-std-lib` topic, the Makefile was restructured in a manner that
>> requires the CMake definition to follow suit to be able to build Git.
>>
>> This commit adjusts the CMake definition accordingly.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>     cmake: adapt to the Git Standard Library
>>     
>>     The usual CMake adjustments. This is based on cw/git-std-lib.
>
> Thanks for a fix.
>
> std-lib folks, can you fold this patch (with authorship credits
> intact) into your series when it gets rerolled from here on?

Forgot to Cc: folks who can take care of this for me.
