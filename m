Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42B33D5
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713708061; cv=none; b=DM/Xhozh9oTDiqtD6+JCgm1jh1e36+F9oJYzU97cV42rEkREIop66QhfHrcx4oVZQLqG/kmsFKVSiaFpXyrkR/hXqU0e+r4lwv/lFdA3+dt5HNnbeRf00urPH1DXdg/ya2uYv0a+Il68N3rk15mFAgURN6vzp9QQ1HD0eG0bknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713708061; c=relaxed/simple;
	bh=kK1E20p5w8k6RN/f71xvpgitZHMv4r40UsiF4FxLUy4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gHeoZ6JDy6HLXDf/rOC6ALpSmlRSwmVjDaB1fuyy9H0IrByHNEHxtMy1tV+IhnKzBD2ZSL81+ClhlNjCjxNpEMPN8O+3+TQkUPfIckDYFG68jZrE2Y1SKZLsyZKcZGxQgV7k42ukN74rJzss6G9+x/JphOnQ9iCh7IAxN6eHbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bNSaiE57; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bNSaiE57"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713708057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmSdk3Ck0S57mdSwAJBZVA6/JksC2ko6VrIoBNpKs5I=;
	b=bNSaiE57e0NO+CxqmBEy6ABUeTcv+HxspqGGqFVntJY9gpuaIbZptJ0CohQ1GQqHoM8u2Q
	uRKnM4bVUiBEASUP2/+ew232zEOKn9c2PLjPjvSf/MBYpqvuwd1nxP5HNBcXLIRdn6kjBs
	n4m8Fv7ZfDs8rPyYC39cj/lG/dKTLXgRdvu2D9PSg+kWjih52e3cp2O4/bsLT8iod2XfD+
	jWdQtzpGyEzB09x6k6u928PdQMZUdji+QzdQcK9BfLiWXtI3l5q87II7ay2WLOluQk2KFx
	3cw9HIlpXu2FUZIvylUL6ISl9x7UZNbAQDCxStPsnGSNbm1mX+B7KkFkhkIqhQ==
Date: Sun, 21 Apr 2024 16:00:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, Eric Sunshine
 <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, git@vger.kernel.org, Drew DeVault <sir@cmpwn.com>
Subject: Re: [PATCH] format-patch: ensure that --rfc and -k are mutually
 exclusive
In-Reply-To: <xmqqo7a5mk8f.fsf@gitster.g>
References: <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>
 <0d584b86-0b48-4e7f-b81c-fdb672dac98b@app.fastmail.com>
 <xmqqo7a5mk8f.fsf@gitster.g>
Message-ID: <1d7ee11f801f2754529256bbf4570fd3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-19 17:43, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
> 
>> On Fri, Apr 19, 2024, at 03:05, Dragan Simic wrote:
>>> Fix a bug that allows the "--rfc" and "-k" options to be specified 
>>> together
>>> when "git format-patch" is executed, which was introduced in the 
>>> commit
>>> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix 
>>> sets").
>>> 
>>> Add a couple of additional tests to t4014, to cover additional cases 
>>> of
>>> the mutual exclusivity between different "git format-patch" options.
>>> 
>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> 
>> Looks good to me FWIW. Also very good description of the changes from
>> the previous version to this one.
> 
> Yup, very easy to follow what changed and how.
> 
> Will queue, thanks all.

Thank you!
