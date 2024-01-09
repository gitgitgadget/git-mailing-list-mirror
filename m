Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE703B788
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xk3nwvKV"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A587F36C60;
	Tue,  9 Jan 2024 12:45:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fdHRAs0pm7DTQiolZOg6IR1zXi+TBMcY2ue91y
	v7xAA=; b=Xk3nwvKVcPByJ9BUaUkazgM+xxDmfb5xSeIDsWmftPD2jQ7YAP/TnJ
	CsedwHwYpykjZy09JmYQpEG8vJzRpDlxRrp237NIarPSxRVpswkS3EqTcEPKRDAi
	d2A3Ude8Q1NiMMCkwzlhyU9cEKxxbtbF7yaQ3RbuTJo7O27yakxgg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E01936C5F;
	Tue,  9 Jan 2024 12:45:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BC9E36C5D;
	Tue,  9 Jan 2024 12:45:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] t7501: Add test for amending commit to add signoff.
In-Reply-To: <20240109060417.1144647-4-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Tue, 9 Jan 2024 11:34:14 +0530")
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
	<20240109060417.1144647-4-shyamthakkar001@gmail.com>
Date: Tue, 09 Jan 2024 09:45:54 -0800
Message-ID: <xmqqedeqienh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F10B4ECC-AF16-11EE-B577-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Subject: Re: [PATCH 2/2] t7501: Add test for amending commit to add signoff.

The title is with unusual capitalization and final full-stop (again,
check "git log --no-merges --format=%s -20 v2.43.0" and try to blend
in).

> This commit adds test for amending the latest commit to add
> Signed-off-by trailer at the end of commit message.

"This commit adds ..." -> "Add ..."

Also what the patch does can be read from the patch text below, but
it cannot be read _why_ the patch author thought it was a good idea
to make such a change.  The proposed commit log message is a place
to describe the reason behind the patch.  Why do we want a new test?
Why do we want that new test in this particular file?  etc.

> +test_expect_success 'amend commit to add signoff' '
> +
> +	test_when_finished "rm -rf testdir" &&
> +	git init testdir &&

The same "why a new repository for just this test???" applies here.

> +	echo content >testdir/file &&
> +	git -C testdir add file &&
> +	git -C testdir commit -m "file" &&
> +	git -C testdir commit --amend --signoff &&
> +	git -C testdir log -1 --pretty=format:%B >actual &&

If you are doing many things in a separate directory, the usual
pattern is

	# create a directory DIR (usuall "mkdir", not "git init")
	mkdir DIR &&
	(
		cd DIR &&
		git do this &&
		git do that &&
		inspect the result of this >actual &&
		prepare the expected outcome >expect &&
		test_cmp expect actual
	) &&

Thanks.
