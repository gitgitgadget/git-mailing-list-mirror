Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F1513D26D
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483777; cv=none; b=qmd+SHb+pA2LXQ7LTd7Ri7HQdlCWKkw4nZMf9bfRKjojlV2o1WFRCTLMtdmNK7EkyPT6PdPkyjvqaj2F+CpYsj4bcTltKLH3k566ImHFQiUsARW01vfmuDilvVJlL0n5jSd0mTKzzUlTMKM+UiHMq8PDFwNDCrArxBCVJ2CrdwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483777; c=relaxed/simple;
	bh=I4jIBfqXrZZIJkAeSolohLn+IoWAlTCzt2BNLSa0EdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K6UWLodo9FJRq69Xa07cThtPRKUH72SW9MjGHm20T1pK94aSoeULZvIAYD0GAYUNqme2d/aR94Cf61GY4mI0W9Dg2RmH6OIDBPgxTZzNHnPHFXMKSyGzhHkhLMV+/f2Nf3bMn+TiRAckFpRBTTNYwzmzhGj38RlYxLNaKcQK3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=CRavASKp; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="CRavASKp"
Received: from localhost (ip-109-42-178-117.web.vodafone.de [109.42.178.117])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42QK9DLt024754
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 26 Mar 2024 21:09:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711483754; bh=I4jIBfqXrZZIJkAeSolohLn+IoWAlTCzt2BNLSa0EdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CRavASKp737BeXfpN1aKHRdYzIyD19JvAGU3TSwo0VPpHusAWyCN3Z6pfe3fzAhzQ
	 g+20wOn63xgEsxQbcuf5ZBx+IZLtj34Zo8i50YCFma7D+BiL2QyFwqw3ix/Nj1OKF0
	 LNOaYZSQys83L2tRz6aRS0kT8cNQNJD/eHA6vNtY=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v4 4/5] MyFirstObjectWalk: fix description for counting
 omitted objects
In-Reply-To: <xmqqo7b1apx3.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	26 Mar 2024 10:00:56 -0700")
References: <cover.1711368498.git.dirk@gouders.net>
	<20240326130902.7111-5-dirk@gouders.net> <xmqqo7b1apx3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 26 Mar 2024 21:09:08 +0100
Message-ID: <gh34scvjq3.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
>> index a06c712e46..6901561263 100644
>> --- a/Documentation/MyFirstObjectWalk.txt
>> +++ b/Documentation/MyFirstObjectWalk.txt
>> @@ -754,10 +754,12 @@ points to the same tree object as its grandparent.)
>>  === Counting Omitted Objects
>>  
>>  We also have the capability to enumerate all objects which were omitted by a
>> -filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
>> -`traverse_commit_list_filtered()` to populate the `omitted` list means that our
>> -object walk does not perform any better than an unfiltered object walk; all
>> -reachable objects are walked in order to populate the list.
>> +filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
>> +change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
>> +able to populate an `omitted` list.  This list of filtered objects may have
>> +performance implications, however, because despite filtering objects, the possibly
>> +much larger set of all reachable objects must be processed in order to
>> +populate that list.
>
> It may be just me not reading what is obvious to everybody else
> clearly, in which case I am happy to take the above text as-is, but
> the updated text that says a "list" may have "performance
> implications" reads a bit odd.  It would be understandable if you
> said "asking for list of filtered objects may have", though.

Oh yes, you are right (as far as I can say): I would change this to
something like:

"Asking for this list of filtered objects may cause performance
implications, however, because in this case, despite filtering objects,
the possibly much larger set of all reachable objects must be processed
in order to populate that list."

(Later in the document, it is suggested to do timing with the two
versions, which kind of follows up on the performance impact that is
focused on, here.  So, this doesn't remain an unresolved detail.)

> Are you contrasting a call to traverse_commit_list() and
> traverse_commit_list_filtered() and discussing their relative
> performance?  
>
> Of are you contrasting a call to traverse_commit_list_filtered()
> with and without the omitted parameter, and saying that a call with
> omitted parameter asks the machinery to do more work so it has to
> cost more?

This answer has the potential to cause an enhancement request, anyway:

Previously, the document didn't state that
traverse_commit_list_filtered() can be used without asking for a
`omitted` list (and I didn't change that), so the contrasting
in my understanding explicitely is traverse_commit_list()
vs. traverse_commit_list_filtered().

The second of your cases is only included implicitely, for those who
know or can guess they could use NULL as the pointer to `omitted` list.

Thank you for looking at this one more time!

Dirk

> Other than that I had no trouble with this latest round.
>
> Thanks.
