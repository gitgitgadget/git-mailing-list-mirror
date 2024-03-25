Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825CA5C8EC
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399938; cv=none; b=CsP2QLGYg2Yr28KAvTNQUCjiQj5gol0hUdBhlfbuulSVTBzJojGuPg9d3NFJUnCFvcf67vxDzyl+WACoThSpEvO6raqaXQAeYOGdNXlekcy5viJ+hJay8urXBwoFMwi1dHGJ0ZyxyPzCKYnOviZIKlgDNlV/DYx00in1Df4QV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399938; c=relaxed/simple;
	bh=4R4b74cS1fU8BeSy7CEuXKd8/xA7vCQnsWg5gqE9zEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/lNHJJ33Bgxx8As5QaTxGjGpdGjpflGzaFdhMGFEapN9JjSZs5+r84C9KkRgdmPq2uM66KHPiEE6IBtEpk5MSBGwzmnaB0hVYpWqJx4Ql+x14Ofy1ximfQZmLkjmNpRMHdDMiuoQbOZjbPQuuzx723FxGGdSiCeQ3S+tMH0RUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=KUmuetl/; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="KUmuetl/"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42PKq8l3027611
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Mar 2024 21:52:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711399928; bh=4R4b74cS1fU8BeSy7CEuXKd8/xA7vCQnsWg5gqE9zEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KUmuetl/FOjUoWKLk3Gwix9UZgNsYdTE5pV6klWFG4Kp6W0+UxDhyTFl4Dtn2nWG0
	 96Mgmz5Xx85Hnr3945LhySoCgaFNRffvvP68LHjMSAe+BT261i1ga+f9IitJXINJUE
	 82X1lmQo6BIRSvmcrSivxpE8kX+O9ee3rqeWdYEE=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v3 4/5] MyFirstObjectWalk: fix description for counting
 omitted objects
In-Reply-To: <xmqq34semden.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	25 Mar 2024 10:25:52 -0700")
References: <cover.1710840596.git.dirk@gouders.net>
	<cover.1711368498.git.dirk@gouders.net>
	<cfa4b9ce503e98035d3ce09b0c9e00bcfb6ff70a.1711368499.git.dirk@gouders.net>
	<xmqq34semden.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 25 Mar 2024 21:07:03 +0100
Message-ID: <ghplvikrdk.fsf@gouders.net>
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
>> Before the changes to count omitted objects, the function
>> traverse_commit_list() was used and its call cannot be changed to pass
>> a pointer to an oidset to record omitted objects.
>>
>> Fix the text to clarify that we now use another traversal function to
>> be able to pass the pointer to the introduced oidset.
>>
>> Helped-by: Kyle Lippincott <spectral@google.com>
>> Signed-off-by: Dirk Gouders <dirk@gouders.net>
>> ---
>>  Documentation/MyFirstObjectWalk.txt | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
>> index a06c712e46..811175837c 100644
>> --- a/Documentation/MyFirstObjectWalk.txt
>> +++ b/Documentation/MyFirstObjectWalk.txt
>> @@ -754,10 +754,11 @@ points to the same tree object as its grandparent.)
>>  === Counting Omitted Objects
>>  
>>  We also have the capability to enumerate all objects which were omitted by a
>> -filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
>> -`traverse_commit_list_filtered()` to populate the `omitted` list means that our
>> -object walk does not perform any better than an unfiltered object walk; all
>> -reachable objects are walked in order to populate the list.
>> +filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
>> +change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
>> +able to populate an `omitted` list. Note that this means that our object walk
>
> "this means that" could be rephrased in a way a bit more helpful and
> to readers with clarity, perhaps:
>
> 	Note that our object walk will not perform any better than
> 	an unfiltered walk with this function, because all reachable
> 	objects need to be walked in order to ...

Would it be OK to rearrange it even more?  To me, the above raises the
new question "How do I use traverse_commit_list_filtered() to do an
unfiltered walk?":

 	Note that our object walk with this function will not perform
	any better than the previous unfiltered walk, because all
	reachable objects need to be walked in order to ...

Dirk
