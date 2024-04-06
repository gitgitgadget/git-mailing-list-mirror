Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CD134AC
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712397998; cv=none; b=Q/16cfmDfi9H79agREb/KwpK8TFh+1Bit9PhlXlZEs6hldGhl6bjrUShGQB75Ja7ShQHGfmAJUfnHF6iUMEp36/md/TlDY9aqdRgiOpRgqGRIcrdyiKVbBvluXB1l0sJ6yrFyUpxeatcQAYN9/Pf0rnOYhHhrAUnCFydk3yNWYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712397998; c=relaxed/simple;
	bh=Uj4MIBI1gVSmS6vORMDTr1iV3zjZZX+7gjwfwq8KosU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeVY3QOvGC34vuGoo7artYUv4THmatRRRXhcRtIueA8y62/xZPLQQnKIkKoO7x7wx7zxg/2M/qBesSfmKEi9JtiBXL0GB4f4rXNnEL+TsAB9RgRf+CQ5TS9lOU6X0X1HEps5UXT6jLgibCx/lKFlwmTPO7/rHi5RJ5s+61ffIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=u/n//hmY; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="u/n//hmY"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id BEAE91A17625;
	Sat,  6 Apr 2024 12:06:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1712397985; bh=Uj4MIBI1gVSmS6vORMDTr1iV3zjZZX+7gjwfwq8KosU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=u/n//hmY1Tgreyd/gbUtPcAQVAmpbE0fKBFM4bzpUCyXEqze4OqAXGkvl2zIoA/Qi
	 3VYNrz1DURNYcpgI3SIgf8qdEozTVyL41kxn8dnm7oBasHbO/eMfURaz2b5bYNyUvC
	 48pJIsTHH5v/6odx4N+A6K98kzpmbIAJv1pnrCm0=
Message-ID: <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
Date: Sat, 6 Apr 2024 12:06:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqqcyr3s3gj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06-04-2024 03:08, Junio C Hamano wrote:
> Olliver Schinagl <oliver@schinagl.nl> writes:
> 
>> Hey all,
>>
>> I've also got my work on a branch in my repo, if that helps to look at
>> things, https://gitlab.com/olliver/git/-/tree/skip_bisect
>>
>> Also included is a script to be used as an example. I opted to use
>> `git show`, which is nice because it works both on commits, but also
>> on notes.
>>
>> Anyway, any thoughts on the bellow before I send the full series?
>>
>> Olliver
> 
> I would not write get_skip_when() before studying the same file to
> see if there already is a helper to read the whole file used in the
> vicinity (like strbuf_read_file(), perhaps).

Fair enough. I'm a little worried about optimization vs readability. I 
think it makes it mre clear what the code does in its current form; but 
I'll investigate. Bisecting shouldn't be a computational often happening 
thing, so I'm not to worried about performance. But I'm not too familiar 
with the git code base, so I don't know either :p

> 
> I do not have enough concentration to follow changes to
> bisect_auto_next() is reasonable.  Especially I do not know why
> "bisect-skip_when" wants to exist and what it is trying to do,
> besides the fact that its name looks horrible ;-).
> 
naming things, sure. I can look into this absolutly :)

But in short, bisect_auto_next was returning just after checkout It 
seemed. So after checkout, running the script seemed sensible. But I 
look at it as a normal git user. So you checkout, test your commit, skip 
to the next one if applicable.


I'll think of your two comments, and see if I can address them as you 
regain your concentration :p

But seeing that these are your main concerns, I'm more confident I'm not 
completly on the wrong path here.

Olliver
