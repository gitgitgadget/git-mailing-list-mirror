Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CF81AC8
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566345; cv=none; b=sLjS4GsspMuJdfigr5wmVtHBNJJhUAFWQDEQTHTL20QlhnS1W2RnJhZbEJxyt8pN+LAVlEAThjeSN4v8DWvgYrjswUQCI+LI6t80N7NbS1Af7bJPsTb9i0vVtVT2h/Cq2L+Z/4ze14cjdnBdiNzhdS846Rp2MACMH7CrvkqGDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566345; c=relaxed/simple;
	bh=1T55LRw69lHZGXW4erJpZ419bSNI3LtL3ShveoAwQDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tY4n5c826OPxYHnLcB0Id/XbdRkaW4Z5LtoCYfQOUIB2ZTGOhMxQRpus3JFRLqJt1/VW+ix8upL1Ejhr8DF1HT2GathMsIvcO9TvkNaLFWOiUsQ2gympfY/9vTQ/ZBlmrtRLanZujd1MJ+lGAArjEcwWvqhIhiLPwQDWXOgkV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rYqadHCd; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rYqadHCd"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 96FFB3CCB3;
	Tue,  9 Jul 2024 19:05:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1T55LRw69lHZGXW4erJpZ419bSNI3LtL3Shveo
	AwQDk=; b=rYqadHCd5nqk9bcBupP9DuszEyZ1MUxeov1xzeDuEopvD2dsFqpjSA
	5ibwmmupv2tFNXUCAGRgrfVEpL59bSW6Urq8iCS9o60vqi9qmeQYQZ7yHBWqbbS2
	6d9ACjN/EIOrX6qExNj/gunshaq+8IykbFH2p9gnA5f7FXMl+pl4k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 902E93CCB2;
	Tue,  9 Jul 2024 19:05:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3732F3CCB0;
	Tue,  9 Jul 2024 19:05:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Piotr Szlazak <piotr.szlazak@gmail.com>
Subject: Re: [PATCH] doc: update http.cookieFile with in-memory cookie
 processing
In-Reply-To: <pull.1733.git.git.1719177846725.gitgitgadget@gmail.com> (Piotr
	Szlazak via GitGitGadget's message of "Sun, 23 Jun 2024 21:24:06
	+0000")
References: <pull.1733.git.git.1719177846725.gitgitgadget@gmail.com>
Date: Tue, 09 Jul 2024 16:05:36 -0700
Message-ID: <xmqq4j8ycgjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C18A2482-3E47-11EF-9D12-C38742FD603B-77302942!pb-smtp20.pobox.com

"Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  http.cookieFile::
>  	The pathname of a file containing previously stored cookie lines,
> -	which should be used
> -	in the Git http session, if they match the server. The file format
> -	of the file to read cookies from should be plain HTTP headers or
> -	the Netscape/Mozilla cookie file format (see `curl(1)`).
> +	which should be used in the Git http session, if they match the server.
> +	The file format of the file to read cookies from should be plain HTTP
> +	headers or the Netscape/Mozilla cookie file format (see `curl(1)`).

With line wrapping it is hard to see if there is any change above
here, but I assume there is none?

> +	Set it to empty value, to enable in-memory cookies processing.

Is it understandable what "in-memory cookies processing" means to
expected audience of this manual page?  I somehow doubt it (I
certainly do not know what you wanted it to mean).

https://curl.se/libcurl/c/CURLOPT_COOKIEFILE.html has this to say:

    By passing the empty string ("") to this option, you enable the
    cookie engine without reading any initial cookies.

But http.cookiefile is also used for CURLOPT_COOKIEJAR when
http.savecookies is true.  Its documentation page does not say what
would happen if you give an empty string to it.

So, a casual one-line mention you added is a bit irresponsible.  At
least you should warn against setting http.savecookies if the user
chooses to use "" for this, or better yet, fix the codepath to use
http.savecookies to prevent us from writing to a file with an empty
filename.

Also the libcURL documentation for CURLOPT_COOKIEFILE has another
thing that is a bit worrysome:

    If you tell libcurl the filename is "-" (just a single minus
    sign), libcurl instead reads from stdin.

So you can easily get your git get stuck by doing

    git -c http.cookiefile=- fetch https://.....

as libcURL will want to read from your stdin, while you are waiting
for the fetch to finish and are not typing anything?
