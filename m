Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD401BF50
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709880360; cv=none; b=KYiX3PNm0UH6dWXL4l61nL5HLnK0g3dlK2WmISMxV/fwLtl1yn2zixJFEV5YM9nG04LYpcb4KDVxz3jtM6n8YhwGYJ09QrLCcF7MJWbVPMyPzGWN1XaaDLfRXhUhepbGys4W6KDgRAGTO8w7COfR2GxPrIIgfTM4hWvoWubwgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709880360; c=relaxed/simple;
	bh=v42YNQDG7M5tYOdHg02RpTaf7p4bgh26r82Thsd5qdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QX70uEU6Ah4/z9BX2imc2vgWLkxaxtNUTypPyHdTg8C5aLg1iwWaSshMNq4a4+NIMf98yUtWm+uu2K+mtQlIyWjMyW1ZQR+UXg7+KuFqBTBhEmv0PYNiq0zVqlarKJSQ7vz48DaV2sS+AdCEKMqQYiyW4ym+fqXMErfzorG98/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=GR4F19LU; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="GR4F19LU"
Received: from localhost (ip-109-42-178-228.web.vodafone.de [109.42.178.228])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 4286jgD2022197
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 8 Mar 2024 07:45:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1709880343; bh=v42YNQDG7M5tYOdHg02RpTaf7p4bgh26r82Thsd5qdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GR4F19LU1JxwWW3VdsWI8yJh0Wfk2Vv2PB2SHj0jSH5EBbG2j56uJI8CDZJAGEu62
	 aJ0HtrYuYoEwKWNxTT5cieuh4+R+9W4cXXTFs/LtgrC5psdpVlCrRhgOzQJXyub8+H
	 5JLyUHqsYxYF7l92Uk9rKkGis6YN9aH+VThT+MqA=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation/user-manual.txt: example for
 generating object hashes
In-Reply-To: <xmqqil27c5p1.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	29 Feb 2024 13:37:46 -0800")
References: <cover.1709240261.git.dirk@gouders.net>
	<a3902dad424983a4f0dfcda68e0b8bf64a0b2113.1709240261.git.dirk@gouders.net>
	<xmqqil27c5p1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 08 Mar 2024 07:45:37 +0100
Message-ID: <ghbk7p43xq.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Dirk Gouders <dirk@gouders.net> writes:

>> +The following is a short example that demonstrates how hashes can be
>> +generated manually:
>> +
>> +Let's asume a small text file with the content "Hello git.\n"
>> +-------------------------------------------------
>> +$ cat > hello.txt <<EOF
>> +Hello git.
>> +EOF
>> +-------------------------------------------------
>> +
>> +We can now manually generate the hash `git` would use for this file:
>> +
>> +- The object we want the hash for is of type "blob" and its size is
>> +  11 bytes.
>> +
>> +- Prepend the object header to the file content and feed this to
>> +  sha1sum(1):
>> +
>> +-------------------------------------------------
>> +$ printf "blob 11\0" | cat - hello.txt | sha1sum
>> +7217614ba6e5f4e7db2edaa2cdf5fb5ee4358b57 .
>> +-------------------------------------------------
>> +
>
> ... something like the above (modulo coding style) would be a useful
> addition to help those who want to convince themselves they
> understand how (some parts of) Git works under the hood, and I think
> it would be a welcome addition to some subset of such readers (the
> rest of the world may feel it is way too much detail, though).

May I ask what you meant by "modulo coding style", e.g. where I should
look at to make the code of similar style?

I would also add that git-hash-object(1) could be used to verify the
result if you think that is OK.

In addition to a suggestion in another mail, the commit would
consist of substantial content you suggested and perhaps, you could tell
me how to express this; would a Helped-By be correct?

Dirk
