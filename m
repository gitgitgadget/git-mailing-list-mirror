Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6783314AE
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729044; cv=none; b=QruMR5z0L3+RsXBfPo2urvAYbDTvMI16aaWUHD5WGxv+j9etlpT2aAHa5eE747jWa+H9rX9okGxW2VTB/B0Y9j18cl/ku8YN/Y4bxGqti6eYXHTtZnX5+fY+m5nJjTnV6l8tDyw9t3QULEzoKHn8kiRSgkuxiRunExlVlWN6KRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729044; c=relaxed/simple;
	bh=92Ry943Fdo0yQ0SWrN6M8Y6jSct+l83gZTuxeXo1Wqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcB6c78/7MNSjf15dRot/bqz3zBOk0vpXRj90qp+NZTQnH9yjBtwkp313p98rHKTDJMSMguPSaw60NpRUCNym7/pWdvHtMIzuquzQPEZY4EOn6JKaoueuIYUj+yWS3qXNKAt4UHk1Aa/dCAAHTKGx0g+PAf02qGCf0qkQ1nKbng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=aGrlae3d; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="aGrlae3d"
Date: Tue, 21 Apr 2026 01:50:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776729034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbWZ1mofRX3rZL40tUWxVAKB6T60N2q0Xub4/UpzAMg=;
	b=aGrlae3db6JA9ixob4fKS+kLI2mjBtY6AvngL+3mV92U2NMgqjybngnnZS1+Yzb+MFpf8g
	Df6gZLcNVz9kdBfaOAm+A/7KZRehYsA5/oTqnisnDcvEqoPMoAq2hPH8p2o7YiOeC4rU9f
	1HWbTI+ESZj0K51JivqOoR7xLPJYobf2n4+Zti+mOPaKpOuQDEqdXvkdeL1Z/HbzNjI3qk
	YpGigMgljv4g2tUxWWIDP+iABm1YlTgNc9W+k8/aq/Z+O0mD9/rKfE5C5fHj5kI565wpNy
	sN7r33s9fYHAIL1qXLTVoXFHUoobj9IacNxnYviKynIy1ky8UXKRBKw7x36nsA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, 
	Jeff King <peff@peff.net>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <aea3Kun-XxGJMesz@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767; i=mroik@delayed.space;
 h=from:subject:message-id; bh=92Ry943Fdo0yQ0SWrN6M8Y6jSct+l83gZTuxeXo1Wqg=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp5ruB6rb5dYRJL0NrdjEBm35oBJw0UPVrAz4B2
 gyon6sRquOJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaea7gQAKCRBIeX6hnBm+
 0Q/6D/4vV1MPdkvmfEM40lNhILqSqwjs38QVliBaUz1hXacnaESMfUgHXNQi7rHY1hG0iWFmQge
 BFrysj1aNxNCbS4rNkFQe3I0undpJhgw8zhyzco1VVFR2NP3RQ5/9RtVJlqJY/UhBOTWKQPH0GO
 sEduBh8NMDKVBFSsspQz1grJlVIc7TalwGn8hbjhQM07Y1RtL3AETVZXlDYCPAQ2DKXnCEF7xcG
 sWu2W9Hr9DoZOm1tpygbMS6MKHuFwGe+G1bGoAXecKu8zGitPf1ROGnMrre52VTj9x4ToyYpA8q
 Ul7Q9DTMudCwgaysKdbqu8JmjR6UuzH24m2Q87d3aIYwianm7IBpt1GnL1yqXN7Sxnc3t14Ns2U
 03C1uG1X+rsXMBwyrUh/TYy/9HVPio0VGDo5p1NOFkP13UDEWog5rXG6RaxUDnvs14w/LI63EFp
 QXOymrvxsoDjs1XgCvLd1JVIsm3zRDpWeIDdlStPpFn4k6rZSCkzO32O1d+/khCGtgSO/ZhpmYP
 HInGx2ahU/Wj+DoyMnkGAD4lo77GDV8vZ6Z2IwppR27qvGzrO1YFwlN+7Ek1Vs0Av4qWYdEkBCl
 qLQbXKRuVm1+DF780+R0dNmhO3ar9P8ZofhUsKUbmPXsmf40RJvGDnDD8r9/3I+2BIr45f0Na5I
 xTDWNFCpymVGJYw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260418164736.2367523-2-mroik@delayed.space>
 <fbea5f1c-946b-400e-a9a2-2c6d7b088d46@malon.dev>
 <xmqqv7dlr4yz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv7dlr4yz.fsf@gitster.g>
X-Spamd-Bar: --

On Mon, Apr 20, 2026 at 09:06:44AM -0700, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
> > I think the space complexity here could be reduced a little. After all, 
> > since we’re only retrieving a few commits, there’s no need to load the 
> > entire reversed commit history into memory.
> 
> Does "we're only retrieving a few commits" come from the fact that
> the command example is "log --reverse -3"?  
> 
>  - What should happen when you give "git log --reverse=before"
>    without "--max-count=3"?
> 
>  - What should happen without "--max-count" but other limiting
>    options, like "--author=Tian" or "--min-parents=2"?
> 
> It might be that the right way to look at this new feature is not
> that "we are changing where reverse is applied", but "count limit is
> applied much later than usual", which may mean at the UI level, it
> may not be good at the conceptual level to sell this as an extension
> to the "--reverse" option?  I dunno.

I'm not sure about that. The way max_count actually interacts with
--reverse in the code is an implementation detail that the user doesn't
need to worry about. It should be fine to tell the user that this
feature is an extention of how --reverse behaves. Regarding "Commit
Limiting options", we already tell the user

	Note that these are applied before commit ordering and formatting
	options, such as --reverse.

so explaining to the user that this new feature acts on reverse's
behaviour might be easier (and not necessarily wrong on a conceptual
level). I find "you can choose to apply reverse before any commit
limiting option" easier to understand than "--max-count can be applied
last, or before reverse but after all other Commit Limiting options".
