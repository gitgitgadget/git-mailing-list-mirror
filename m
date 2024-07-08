Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F61CD1F
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467316; cv=none; b=kQCSBGbb3a4NLL6B8Qa44k8vui+VjQvgczSBB/DMrsM3k8Zzsra0I466L+APZ/ZJfzT080kA0H27Gz6BylYB+l8ujFBcZ0a2uLKb3S7mUxKitT/V2PT9scLkcsikKfs5VOr+rI/q94WroJSWYCJjHimVJPdHhLU+pY0xv+wq8Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467316; c=relaxed/simple;
	bh=utFeiw5QO6inkXySuEGzYst17FVK1TRtSP/Dm3qTnNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AgzJbAZcNr8RATsBeo4S57+gTtmvnlcC2s9JjHKsZ8uDdHMhbRlP8XH66HM2tNYjhNLngboFSKox59Ci+RUtHchdDXpQXYBTdGbyKw8QyCXB9+iPL5TfIMl5Z5swLkkvM51B+TIbFsTT/zSAauXg/9erEnYjJpjhkhMrJKpHYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=LIvpdG5K; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="LIvpdG5K"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 3A7C8240029
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 21:35:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1720467305; bh=utFeiw5QO6inkXySuEGzYst17FVK1TRtSP/Dm3qTnNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=LIvpdG5KZb6bgsNhJJSVXulCgrBsIs6ubm8nHF1WUMN89EH1MpgsmYg7tq+azEJjv
	 U7AH/F2jQvxiViGC7wS04QUeBkWoWjO6G7cWEkd8ocU4wpRus73T2MToEzt+w1f1gH
	 0MXHem2oqj5huVOS6MZaQBIxb4gZPBb315Ko3x4EdgqcZHsvxOweVp9sozZOOAKGrh
	 5cjIoLi/Mssx4vPvlem1bdz0azD1EdiGQ9+367ocqXUKevJetbWF3IvmMgLyyIrfT/
	 KEols04lLD8MN0WM9KV2Q9EM2V1MfwcvBoGpkrleTUIwfYm1UJRFYbWf1Y8i8y0UQ0
	 UpBiGs34rUUPQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WHvTh3jWHz6txr;
	Mon,  8 Jul 2024 21:35:04 +0200 (CEST)
From: Tomas Nordin <tomasn@posteo.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Unbalanced closing paren in help of git commit
In-Reply-To: <20240708085440.GA819809@coredump.intra.peff.net>
References: <87o7792xgu.fsf@posteo.net>
 <20240708085440.GA819809@coredump.intra.peff.net>
Date: Mon, 08 Jul 2024 19:35:03 +0000
Message-ID: <87le2b3cew.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Sun, Jul 07, 2024 at 12:33:21PM +0000, Tomas Nordin wrote:
>
>> The second line of the help message for git commit looks like this:
>> 
>>     [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
>> 
>> See for example https://gitirc.eu/git-commit.html. It has two opening
>> parens and three closing parens. <commit> ends with a closing paren
>> before the closing bracket. Me and gsish (on IRC) suspect this is a
>> misstake.
>> 
>> What do you think?
>
> Yep, looks like a typo introduced by 00ea64ed7a (doc/git-commit: add
> documentation for fixup=[amend|reword] options, 2021-03-15).

I stumbled upon it while working on a synopsis parsing tool, similar to
the Python docopt if familiar.

> Want to try your hand at producing a patch? (It's OK if the answer is
> no; it just seems like a good opportunity for somebody to get their feet
> wet on contributing).

I can try, why not? Should I hang it up on this thread so to say. Is
this a bug report?
