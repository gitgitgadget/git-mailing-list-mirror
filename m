Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B281494C3
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916921; cv=none; b=npMuetHC9LVkcmTi+z+cb/ott1wi0EA2cXQx8gg3JOHHwxxnl87ZFNSifuBoMWaCG/IS7gjnZHDa5yaN+vc1NQFcrX5MBfXfJ75cooMea04rCIgHZfvQvNLxYM9/QsfboYwKvAErthpQTcjxVdn97Oa6WQH7BUhInEnd80lm+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916921; c=relaxed/simple;
	bh=EfxMnOJ6Sbp4xPkzQgDx0zbYOOq4W4y/Ml6TfkP41gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPH8kf0hb0Gvu6YBs3OCwKps3woKtZNbaFLikGn5iPXHGhHgG+1J6LW429TcjF6HtlnWyBjDSDwilDDJizAQqlNgfCIdPHKX/JQt7vRcAg50au3vPOP+oIv4sFPg1eBtXS8sqnNWsKr0OyJKm33r1X8PW86Q4fLMxtMibSm5XgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=jYNvZtUG; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="jYNvZtUG"
Date: Tue, 24 Feb 2026 08:08:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771916917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1FDLtNKJzFzAgPtPELPxWpYGt8Y2PDa86zUk7GO6ek=;
	b=jYNvZtUGufE7W2xpD0An2nF/ESORneEMRGtFPACxjXao6Q3/LgYdUK2BJehdxsl4sF7UDv
	j2TXdp2SQ7OOs1/y45E5lndgVMCbPlYC/D41ChOkb7LDXIdOF7iYQP6vz8KcP+CLlP9Uug
	V321Dx7etfFmY4BYM1wwsIzolbkFD20B1sz3a0fUAbGT7s2jWicLaCXZCxpMIZOU8zdC4l
	gK9xPlhdyF5lo/6i6AodQHd+8wGYlStvmz4wnKbRXq8wQ+IH4YhNY+pF6igCz96sQwdw3b
	sgZ+Ijtg69YVcczJk1hQk55VFQ/PWw6mXeJeYeqJMSsM6JdBp19D131crB80Sg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH 1/3] pretty.c: fix null pointer dereference
Message-ID: <aZ1JND7sGspCJEoc@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=mroik@delayed.space;
 h=from:subject:message-id; bh=EfxMnOJ6Sbp4xPkzQgDx0zbYOOq4W4y/Ml6TfkP41gc=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnU5SblxNaPRfCkUSYP5BQToHgW13Ev7FawN3J
 6sh2UnV6OmJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ1OUgAKCRBIeX6hnBm+
 0Y7SD/96Bn5fHdi5itMgYhMfpaCtTXjHmhwOtiHEjWjV2Pegcwc9bouMIewuxhFyMAoYIRDp/tz
 j95P/uia0FGGRalOszV4weiS1ZZ3h5iEWElUQHmiLxEPSSYlYAg6/Si7S3H/QrpGlNyrDJqoBJD
 Cf9/CKUM50c94o+3EoqnAD26yro1orI1IX9EB0c1Ba4KfRkgOlXBAY0NXMxCXrTaJNmsQTIdPEl
 aNb8Cd+xCV+2iTaWKuFrT+4AIYZDWs9RJXlhxgXHIVBSv5HlGoqaO63conbrVFbvzkNTu6Eh7nx
 ETbv5raa7i7m9Ri5SPVkWbOa/kzngA0XkbQ9SGD20euA0M4raAkBvZBBzLUPTnsGWY8ehKQ21n8
 pLG/XdwIdW2lEqaQiDjZ0xSX8oUebSA5YiBXDn12nGadzYg2RLHQ3lLYktmgNujE2sI7QweNNAQ
 UXHHF5/7wFsKN5l0tmlFqIPGh3G6W1mNM8Wmsh4ClI3cT5EhMl/sTB1N+oeb5BWlKxQNtqWWPRy
 7vzjxmkZpoItTqkvor6zpxPVdBkrpE1vvdKzQVjt6zkXwjOwrZ/8TAvGTRhy/X827iOyKVcIt5b
 56h5eBNLtp5LSyXZD2v5vaYGumRGja0QpCcnndCMtpnPMOz6R8dMO/cQ6TzmWgQbfqPjRzjjxAS
 KEHEzKj+2ALqEvg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260220230633.132213-1-mroik@delayed.space>
 <20260224040400.751247-2-mroik@delayed.space>
 <xmqqcy1uk69o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy1uk69o.fsf@gitster.g>
X-Spamd-Bar: /

On Mon, Feb 23, 2026 at 10:25:07PM -0800, Junio C Hamano wrote:
> Interesting.
> 
> Are any of the existing calls to this function that passes
> CMIT_FMT_USERFORMAT trigger a segfault with certain condition?
> 
> For example, there are only two places where CMIT_FMT_USERFORMAT is
> assigned to something.  One is save_user_format() where user_format
> gets a non NULL string before rev->commit_format gets assigned
> CMIT_FMT_USERFORMAT.  Another is git_pretty_formats_config() that
> parses configuration variables "pretty.*" and populate
> commit_formats map.  This is later used in get_commit_format() and
> that function always calls save_user_format() we just saw when the
> format used is CMIT_FMT_USERFORMAT.  So the existing code paths seem
> to be safe by design.
> 
> What I am wondering is if a NULL user_format should be flagged as a
> programming error, instead of getting swept under the rug like this
> patch does.  IOW,
> 
> 	int commit_format_is_empty(enum cmit_fmt fmt)
> 	{
> 		if (fmt != CMIT_FMT_USERFORMAT)
> 			return 0;
> 		if (!user_format)
> 			BUG("never called save_user_format() and using USERFORMAT?");
> 		return !*user_format;
> 	}

This doesn't convince me, I think it is a bug. If dereferencing NULL was
done on purpose why not use die() instead? Also, the only way for us to
check user_format is through commit_format_is_empty() as it is static.
In a complex config setup it might be useful to double check just to be
sure, and I wouldn't want the program to crash on a failed check.

save_user_format() is not available neither, so evaluation of the format
string has to be done through get_commit_format(). If I pass any of the
predefined formats (CMIT_FMT_*) get_commit_format() won't set
user_format. So the only way for us to check if it was set is through
commit_format_is_empty() (well technically there's
rev_info->commit_format but it still doesn't feel like it was
intentional).

But if the intended behaviour was for the program to crash then I take
issue with the name.
