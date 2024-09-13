Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44F1D7984
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.253.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225503; cv=none; b=S4qwSSDnTedoh3o2kj0y0ym45PWnPqNFB5TIADAn2MMm3zIvrNRgU0/V2BPWiXnQ8KFyGCojF4aZ184HoMrJPv4PaSMhpDV/EOT0tzU5Q74YFv8KxjnXYN3VJS07gbX0L79gXGabQAOIA+MGMAGYyEHhyNpBjbWwdt4gu9rdVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225503; c=relaxed/simple;
	bh=xK69Ezne7OCu1N/eP1YtrlvFtFb8FFHIYia2u/Bgnzk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HGKgM07sU3TyUtQjTqi5aurNAw+RX4oXAO4bf92x1i+KyYT40RvHv+K4eDnQxDtwbvkA6275wEz5xv9Qqwe4gg7ocIVbwbdCiubyeDf50oCeqmap9DKCS0OqSFereldofH19EV86MT1oFWFpHMa1VZeg1TUbxvuZ7qyM45+2234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se; spf=pass smtp.mailfrom=haxx.se; arc=none smtp.client-ip=159.253.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haxx.se
Received: by silly.haxx.se (Postfix, from userid 1001)
	id C932566489; Fri, 13 Sep 2024 13:04:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by silly.haxx.se (Postfix) with ESMTP id C62558001A;
	Fri, 13 Sep 2024 13:04:57 +0200 (CEST)
Date: Fri, 13 Sep 2024 13:04:57 +0200 (CEST)
From: Daniel Stenberg <daniel@haxx.se>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: curl 8.10.0 regression breaks uploads with HTTP/2 and
 http.postbuffer
In-Reply-To: <ZuP168QTTMiv_DxH@pks.im>
Message-ID: <o8o7sn01-p918-34s5-387p-pprqo7499p8s@unkk.fr>
References: <ZuPKvYP9ZZ2mhb4m@pks.im> <q7soppq5-nsor-4qq9-801n-oq3461n3r889@unkk.fr> <ZuPdfsbHwjQPDPXc@pks.im> <565691o1-3451-o06o-2594-2750r90nqq6p@unkk.fr> <ZuP168QTTMiv_DxH@pks.im>
X-fromdanielhimself: yes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 13 Sep 2024, Patrick Steinhardt wrote:

>  - In there we hit the `large_request` code path. We set up
>    CURLOPT_READFUNCTION and CURLOPT_SEEKFUNCTION. The callback that
>    uses our buffer is the one set up via CURLOPT_READFUNCTION, which is
>    `rpc_out()`.

Thanks, I ended up able to write a stand-alone reproducer. Stefan Eissing 
wrote up a fix that seems to fix the case for us at least and it would be 
great if you could test this in your end:

   https://github.com/curl/curl/pull/14895

The actual code patch is tiny. The PR is mostly about adding test cases to 
reproduce and verify.

-- 

  / daniel.haxx.se
