Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1387E4502B
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718149789; cv=none; b=uQ5MymPa004jWBCNc3J8FM4pibf5xItXEgUKl9qc5yefDF5C4ZzmmbUKcrduXqE49Ka7owug8cZS97njmfQt/2ivFvTvPKs3n89xhs2+hM+iXzBUH62JwrhmgPVsRNcjLu1QHC8SJhBa5OQ9+THrOdeUKjtfPjqsXyLKRjh7pNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718149789; c=relaxed/simple;
	bh=FLYpwsWf6UwKh1Ua6S6r5uklukhu8Rh3WRGmMrF6B9Q=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=d//0l8H+Ub4SRhxt3dpbmhsijNPgEyAljhjd/nep/D2fiooJpTdnWpsilqp/P/VtjzkA47QMnYjBovj4OamUjUH13pnDfQvktqyPmfRZJhf7SsjOdlB7OcsxKlCkoXgNU3hZy6M+mobFNnfcWrraxiYiCcyXflcFtMAizf8mAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45BNngUR2040599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 23:49:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'darcy via GitGitGadget'" <gitgitgadget@gmail.com>
Cc: <git@vger.kernel.org>, "'darcy'" <acednes@gmail.com>
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>	<pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>	<xmqq1q58ejnw.fsf@gitster.g> <xmqqtthzrraw.fsf@gitster.g>
In-Reply-To: <xmqqtthzrraw.fsf@gitster.g>
Subject: RE: [PATCH v3] date: detect underflow/overflow when parsing dates with timezone offset
Date: Tue, 11 Jun 2024 19:49:37 -0400
Organization: Nexbridge Inc.
Message-ID: <114401dabc5a$08a72060$19f56120$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGrj1JkHNUesZ+VzPgCmY2YHPszKQEuebTdAh/BlZQCLHsaZ7H1v27w
Content-Language: en-ca

On Tuesday, June 11, 2024 7:30 PM, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>> I wonder if this should be of timestamp_t type instead, as the check
>> is done against *timestamp in parse_date_basic() where *timestamp is
>> of type timestamp_t to match?
>
>Also, as you can see at one of the GitHub CI jobs, e.g.,
>
>
>https://github.com/git/git/actions/runs/9455916669/job/26046731619#step:6:
>1915
>
>you'd need to either exclude some "these are too large timestamps for the
system"
>tests from 32-bit systems or expect output on them to be different from
64-bit
>systems.
>
>As you are actively detecting the condition and giving an error message
"too large
>for _this_ system", I think it is a good idea to actually do the latter,
i.e. on 64-bit
>system make sure parsing is done correctly, and on 32-bit system make sure
you get
>that "too large for this system" error.

Does this imply that timestamp tests will fail on 32-bit systems? I am
unsure how to interpret this. Can you please clarify?

Thanks,
Randall

