Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2328D2F48
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708393370; cv=none; b=QlMrI4qbG/ue/q7+gXaZeYfY0R+Li9oI1GeAgg8zYHSFgwk/aDJQ9l9LOm1+7LjFirhPfasr2+L2ut3CU19uRuSEE3W3C1PQzUhUOneLN2jJaOCWfIVcLemp9Ln2wKyFOl0R06GeGDUkt0WrWOkFvn21eCKqNkuK2Zj5DPr0kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708393370; c=relaxed/simple;
	bh=APagHZNFFAcckpoLmA63TYGPQ9NRc6iHtcCmCEnudn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eDZKzilP6cn5AQYT7K2/N2w4VLrT2G3yLlq2j/nUC5KA6tyw3TibgF1IDTsJsj/nYhUFe9HWYsIEmF5+u1XHxnkFLJQcBUQJQawORU/ZFtTU9ABCj9HOdhjjfPA7Sm9Jf6ltomjjgEUpiEI96BVyMn78CXGCWojbue9dzsrqxWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nt5FcJbm; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nt5FcJbm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 656DF273F9;
	Mon, 19 Feb 2024 20:42:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=APagHZNFFAcckpoLmA63TYGPQ9NRc6iHtcCmCE
	nudn4=; b=Nt5FcJbmNIdCuoyo/UIzLFLQGl7OU9lA3/OrO/5ctGZ2oNXkAWKh3N
	AKybjxjVqAS1UYZnKbd+foGm7xa8w8rntbC9E3sqcqCJlqp3jgxdRKM2lYQNnI/A
	28RoERpAiJALA3rTB4n5qtPt25DZ4s7eCC53dDVCWO47HbRz8UWtw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FC50273F8;
	Mon, 19 Feb 2024 20:42:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C5033273F7;
	Mon, 19 Feb 2024 20:42:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>,  "'Dominik von
 Haller'" <vonhaller@fastec.de>,  <git@vger.kernel.org>
Subject: Re: Why does the includeif woks how it does?
In-Reply-To: <01d401da6379$635fdb30$2a1f9190$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 19 Feb 2024 16:19:51
	-0500")
References: <FR2P281MB1686B7258CFB60A0F33FE108BA522@FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM>
	<ZdO1oL73SF5ZKOJT@tapette.crustytoothpaste.net>
	<01d401da6379$635fdb30$2a1f9190$@nexbridge.com>
Date: Mon, 19 Feb 2024 17:42:43 -0800
Message-ID: <xmqqedd7ykq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 57F93B18-CF91-11EE-A5EB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

<rsbecker@nexbridge.com> writes:

> I have considered contributing an "includewhere" option that would
> do that and differentiate from "includeif". I'm not sure it is
> required, and what would happen with symbolic links.

Other potential gotchas would include how it interacts with
directory hierarchies.  You may be inside a directory /a/b (where
none of /, /a, and /a/b is controlled by git) and want your "git
init" invocation to be affected by some configuration included into
your $HOME/.gitconfig via include-where mechanism.  Would it work
recursively?  In other words, if you had

	[includeIf "gitdir:/a/b"] path = $HOME/gits/a-b-in-repo

	[includeIf "cwd:/"] path = $HOME/gits/others
	[includeIf "cwd:/a"] path = $HOME/gits/a
	[includeIf "cwd:/a/b"] path = $HOME/gits/a-b

would all of them be included?  Just the last one?  Does the most
specific one win?

After your "git init" succeeds, the one specified with gitdir: would
start kicking in.  Would the "cwd:" ones that are meant for cases
outside any directory under Git control be ignored then?

I am not opposed to such a feature existing at all; just pointing
out there are sources of end-user confusion we need to be careful
while we design the feature.

