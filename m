Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071A346E43
	for <git@vger.kernel.org>; Sun,  3 May 2026 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777837019; cv=none; b=G/eWWqdFZDnV9BUNOsfxjnnB/Uj2VBNYIJDxbc8nSpXpuzoBYyR0PxK802DL60s/pyTUQH/JvOY7N6Im6XnK/MXnBAE840th/8tbgcIGrUo4d2Po/eWZbmtCesFxBSOfsaIlxu8d6D8ssiudYjckg83q4SpGfrv+3oROnTPRvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777837019; c=relaxed/simple;
	bh=XSVrau3zZmevcjXi/enZvAVJ7qA4Ozmgd+29tugkrMY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=T8WdnUKw6EoCIAnpEwpAsGi7piCooDcopDLF3B6iR1h8vTjyCf9yRisnTK+BPXQp3rmwBnEibfW6TfO+eiQ8j+aqNlTHVMi7do/GUiFm/0RrSECuTvMrIzOPO9/8t4JzRnUyr/r1NBp6hn8nj+rNjR6j0LEcgKJSPoRfb4qMuAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matheusmoreira.com; spf=pass smtp.mailfrom=matheusmoreira.com; dkim=pass (2048-bit key) header.d=matheusmoreira.com header.i=@matheusmoreira.com header.b=ucZTaP8x; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matheusmoreira.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matheusmoreira.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matheusmoreira.com header.i=@matheusmoreira.com header.b="ucZTaP8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matheusmoreira.com;
	s=protonmail2; t=1777837013; x=1778096213;
	bh=zuKgW1OOt1eXODxLgwxRICS8HEkWZKuaxR7L7lxAnsQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ucZTaP8xjhfNIepUC+fRjp0+Zo55gyBqH5+yyKre3rGdU/jKFLj+9BwRNj8zcDWrT
	 xorP+EgNUVIjNFOV8B6p+ULcZ+jpiQCvjunnvZggvN06EqsMfUe+Qqnea2YDI+qxA0
	 /kYuNv3yjRRGlfJMDFy80mgfkXALTzwkH9Kj0Ug9ex3lR4y/vWEsltGDwx0lb1OSS/
	 /4jh6kjF7VbZUaHM+PQvZSBRfPyKvO9rUqB8+JTFaLGKyaz8jZrJ1q1qzK7324kpnK
	 +/Bw+RDCgdgl4An4JkYnE/RORopjmRLqvrcOYzS8CmPtmtLJdcsismInVP8I07p1v4
	 rZLYpEiCnUlAA==
X-Pm-Submission-Id: 4g7w5J0t41z2ScP1
Date: Sun, 03 May 2026 16:36:46 -0300
Message-ID: <6c0a1601cd379bcdc87b4fe3b854166a@matheusmoreira.com>
From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
To: Torsten Bögershausen <tboegi@web.de>
Cc: Matheus Moreira via GitGitGadget <gitgitgadget@gmail.com>,
    git@vger.kernel.org,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: Re: [PATCH v3 0/8] builtin: implement, document and test url-parse
In-Reply-To: <20260503172838.GA22957@tb-raspi4>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
    <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
    <20260503172838.GA22957@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

> Reviewers comment: Nicely done.

Thank you!

> More a question to myself, may be, about t9904 (and may be other parts)
> I have in mind that the parser learned to handle
>
> file://server/share/repo
> correctly under Windows.
> I don't know if this needs to be addressed here or in a follow-up commit ?

I'd be happy to revisit this in a follow-up. It's been a while
since I used MSYS but I do remember the fact it rewrites paths
internally. I wasn't sure how to handle it properly in the tests.

The problematic test case is:

    test_must_fail git url-parse "/abs/path" 2>err &&
      test_grep "is not a URL" err &&
      test_grep "file:///abs/path" err

MSYS bash rewrites /abs/path to C:/Program Files/Git/abs/path
before git even runs. This edge case caused the error message:

    fatal: 'C:/Program Files/Git/abs/path' is not a URL;
    if you meant a local repository, use a 'file://' URL
    with an absolute path

The test_grep "is not a URL" passed but test_grep "file:///abs/path"
failed because the suggestion did not contain the literal string
"file:///abs/path". The drive letter broke the tool's absolute
path recognition: it was printing the generic error message.

The fix was to use has_dos_drive_prefix() to recognize the edge case.
However, that led to the generation of error messages containing paths
that I wasn't sure if I could depend on in the test suite, such as:

    file:///C:/Program Files/Git/abs/path

So I decided to relax the test case just a little:

    test_must_fail git url-parse "/abs/path" 2>err &&
      test_grep "is not a URL" err &&
      test_grep "file:///" err

The "file:///" checks that the path was properly recognized
and that the friendlier error message was printed, all while
avoiding the hard coding of a "C:/Program Files/Git" prefix
that may or may not vary depending on testing environment.

In any case, the parser already handles it correctly.

It decomposes:

    file://server/share/repo

As:

  - scheme: file
  - host:   server
  - path:   /share/repo

Which is the correct interpretation.

On Windows, connect.c then takes that data and reconstructs
the UNC path \\server\share\repo for the filesystem.
So the UNC reconstruction happens downstream in connect.c,
not directly in the url-parse builtin or url_parse logic.

    Matheus
