Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193954BCB
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C/ePy9JD"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CC1C1D611B;
	Mon,  8 Jan 2024 12:32:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GNuBvDKpa++jGzhtiRZ6EgW6OQ/3CVQoCoKB1h
	jy7jY=; b=C/ePy9JDJ9nLNgvFaJVBafZ/gSa7PY6mbI91B6sTN1/tQDfh05Ng/u
	Ub64YJtPnlERNTpnQ52h67ogVBkl1hgjTDIl/KpOQED0Jw4NhvLyyihfONQZtxA9
	YOSi/p+riAWpBhdjMo139VQwmBKwGi4+/SPHePr3pKuWkBkPInIgo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 14CF61D611A;
	Mon,  8 Jan 2024 12:32:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 777D91D6119;
	Mon,  8 Jan 2024 12:32:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
Cc: "Elijah Newren" <newren@gmail.com>,  "Christian Couder"
 <christian.couder@gmail.com>,  <git@vger.kernel.org>,
  <johannes.schindelin@gmx.de>
Subject: Re: [GSOC][RFC] Heed core.bare from template config file when no
 command line override given, as a microproject.
In-Reply-To: <CY7M09XT547N.2OOTI5APX9RIX@gmail.com> (Ghanshyam Thakkar's
	message of "Sat, 06 Jan 2024 17:37:18 +0530")
References: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
	<CAP8UFD1wMJMY6G4SaPTPwq6b9HbeXG1kB97-RRrL-KGN1wE0rg@mail.gmail.com>
	<CABPp-BH+cPdfsctquE60tw_nD6_LCaWf0JwGusuZ0tvQQuWy4w@mail.gmail.com>
	<xmqqjzonpy9l.fsf@gitster.g> <CY7M09XT547N.2OOTI5APX9RIX@gmail.com>
Date: Mon, 08 Jan 2024 09:32:09 -0800
Message-ID: <xmqqo7dvloiu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA67C400-AE4B-11EE-B7B1-25B3960A682E-77302942!pb-smtp2.pobox.com

"Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:

>> Specifically, the commit that introduced the comment never wanted to
>> honor core.bare in the template.  I do not think I has core.bare in
>> mind when I wrote the comment, but I would have described it as the
>> same category as the repository format version, i.e. something you
>> would not want to copy, if I were pressed to clarify back then.
>
> Then I suppose this warrants updating the TODO comment in
> create_default_files(), which currently can be interpreted as this 
> being a unwanted behavior. And also amending the testcases which
> currently display this as knwon breakage.

I obviously agree with that, after saying that I suspect 0f7443bd
comes from a misunderstanding ;-).

>> If somebody wants to always create a bare repository by having
>> core.bare=true in their template and if we wanted to honor it (which
>> I am dubious of the value of, by the way), I would think the right
>> place to do so would be way before create_default_files() is called.
>> When running "git init [$DIR]", long before calling init_db(), we
>> decide if we are about to create a bare repository and either create
>> $DIR or $DIR/.git.  What is in the template, if we really wanted to
>> do so, should be read before that happens, no?
>
> That is what I proposed in my original email, after which I had a
> working solution which passed all the tests. That solution was indeed to
> check for core.bare in the template before we set GIT_DIR_ENVIRONMENT, 
> which subsequently creates either $DIR or $DIR/.git as you described 
> above. 

Yeah, if this were still in soon after 4f629539 was written, then
such a change might have been a useful feature enhancement, but risk
of breaking people (third-party tools) who use the same template to
initialize both bare and non-bare repositories is there, so...

Thanks.
