Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5D1CD24
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649669; cv=none; b=USl1tH5TYx++jURjbDW2Hbe9vKeREHQKRuo2hZ003wZ7HhhayD9/lvSb+HPbTJv3f5sle56q3YXS/Jd3ZD7ErksNsfGk+m3Hnit1K6TouWukUWNrue74sAK5Kv5qH+5sMaIuuGD4Prt6uksSrfRc9r7yWm2jj+tTNvDfLOnmDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649669; c=relaxed/simple;
	bh=dSQdlU0LOmbU+fcPoU3/ZxgUI4C/bUhV4gcpCYNZsKM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pgFQZ/PxFimpKOB3HDwQNabPSKvcNzRgnCNlu1EKeHM+WKCbyoDDeyK0C9kKYAIA1WyObgg8rxWgQMKkidQfZov+38+3CBAHTE6jzHQzJLbqY3wBJdUJTWvYvkHJwoVb1TCL+NUUdZKx2vs7Z+zmsc+nAP+e2y2WTN1gqoAQNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DZ3kthM3; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DZ3kthM3"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711649662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8u+8hVR/DEM0rUTJ/DkCR8c/pU4/+uJnBuoEiFKduRw=;
	b=DZ3kthM3U8FG9+pbaV343DU0tEj8TTrcHK/9PiSYymH8RWDVVnFCUEHMnv4Xo6EvIo91Sd
	3I0jT6yVy/DBxIQtVjEnvI5hntjywS1KL6JGb+W9K9POxUfoURzqnwG22FCr/L9MTxV540
	Z3cxt4mMOKmaJcPSPtnsmocdgUinstFPPQ/wEpyRCPdrnr7damupZNzKKEOXeZ5sZGLfEc
	wyhoGxkXw6tKeedNmVwJUc8bumg6ed1TR742TAsNDkiah1rxz1YTvextd4WL+xqPrsrSOM
	r7kZJCAuvDCT03izdtmIFCfk47xr8w+RWqUMv4EvMaZiQkm3g7SkCWNF3ejshA==
Date: Thu, 28 Mar 2024 19:14:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eugenio Bargiacchi <svalorzen@gmail.com>, git@vger.kernel.org
Subject: Re: Better visual separation of hunks in `git add -p`
In-Reply-To: <xmqqo7ayuwpi.fsf@gitster.g>
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
 <xmqqo7ayuwpi.fsf@gitster.g>
Message-ID: <a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-28 17:50, Junio C Hamano wrote:
> Eugenio Bargiacchi <svalorzen@gmail.com> writes:
> 
>> I'm looking for a way to print some sort of separator between hunks
>> when running `git add -p`, as I have a bit of trouble detecting when
>> the previous hunk begins and the current one starts. Being able to
>> print an empty line or a couple lines filled with "=======" would
>> really help me out.
> 
> Hmph, my hope when I designed that particular UI was that the
> command prompt for the previous interaction followed by the hunk
> header of the current hunk would give us clear enough separation.
> 
> For example, after answering "n" to the prompt for the previous
> hunk, we'd see
> 
>     ...
>     +   (merge bff85a338c bl/doc-key-val-sep-fix later to maint).
>     +
>       * Other code cleanup, docfix, build fix, etc.
>         (merge f0e578c69c rs/use-xstrncmpz later to maint).
>         (merge 83e6eb7d7a ba/credential-test-clean-fix later to maint).
>     (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? n
>     @@ -233,3 +245,6 @@ Fixes since v2.44
>         (merge 781fb7b4c2 as/option-names-in-messages later to maint).
>         (merge 51d41dc243 jk/doc-remote-helpers-markup-fix later to 
> maint).
>         (merge e1aaf309db pb/ci-win-artifact-names-fix later to maint).
>     +   (merge ad538c61da jc/index-pack-fsck-levels later to maint).
>     +   (merge 67471bc704 ja/doc-formatting-fix later to maint).
>     ...
>     (2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]?
> 
> The '@' (the first character of the hunk header line for the current
> hunk) and "(1/2" are surrounded by lines that begin with a space,
> and the hope was that it was sufficient "separator" already.
> 
> These days (long after I stopped mucking with the interactive add
> code actively), the prompt line is painted in prompt_color (you can
> tweak it with the color.interactive.prompt configuration variable,
> it defaults to BOLD BLUE) while the first part of the hunk header
> line is painted in the fraginfo color (default CYAN), which should
> give you even more visual distinction.
> 
> Perhaps
> 
>     [color "interactive"]
> 	prompt = bold red reverse
> 
> would be sufficient?  I dunno.

Here's a possible solution, or better said a new configuration option,
which I've been thinking about for a while...  When running "add -p",
displayed chunks can sometimes become confusing or a bit hard on the
eyes, but simply clearing the screen _before_ displaying any new step
(i.e. a new chunk, interactive help, etc.) could make it much easier
on the eyes.  It would be a new option, of course.

Thoughts?
