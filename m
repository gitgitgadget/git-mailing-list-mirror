Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932771B299
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335921; cv=none; b=ARt/1gp5fuZEWsM0QiYumG/EV0YhHsYkHwcsxID3deba27W9mFLVY67KUHYm4BrUWUF+bhig+r4aCdkVqJjRSix8QQHZ7Dr9u4yrYoK5WOfepP00UTJA9u6A0o3NyzK4V1F7iJLEQHxa5a3R0q6peTkG5mHlxZ/MQE4cb8aL/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335921; c=relaxed/simple;
	bh=EzHSSvVyZg+xgrolwNgfPb3KEOjaq1OisBdFzhYyiZE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cWzb6uyrsyGpyOruXxbjQpyVSC/5yUrJKQ2ZJGzJAlK05I7CDVFst2yw0y/y/zOkcYBvHib5++FOU9Xra3emVTl1TOAe7vCAdpTmcqmVa21u6zWjC39EGnoyBN698q4saSIT2wBWO/jxQUFUIPX9QliO0MKV6SAnDjfRLLlO3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=v3tygryX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="v3tygryX"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712335915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr9LGO2w9QYGalatdCa78O3xiJSN9qhZ9oJw17t7u0Q=;
	b=v3tygryXxkZulNPGOY7PquySHwzB+3WDYwygsrwI/rKFlH1VfZkygtW9Bc2ywukWHjXPKt
	3m4TrZbK6jUmxk6AbFqYdODwQEtX7PF6swmcy0kwQR2aYf4xozuIhZWSwKRUXlan7ARQtv
	hbXYDV5TeHOfD8IWn/kS0RQKEuePcvjv9ht4a76+UsNv7RQHOkOk/yFLDrkhssY4dw27bH
	gtfwfSVT/XtH/xfpjhsU6aRV8ohig5avBDfnJETL/1uvnEo1EjHkkv+/7vqWP0fnVr3vEC
	cPNJhEClaF8loR86TnoLWgAiUF/vXZXsLiB7xgB4cNJWCtakTqtUVCCXiCaNAA==
Date: Fri, 05 Apr 2024 18:51:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <xmqqjzlbwyhr.fsf@gitster.g>
References: <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
 <xmqqzfu8yc40.fsf@gitster.g> <8d47bd687f2ad80bbc1e1c86ae337327@manjaro.org>
 <xmqqjzlbwyhr.fsf@gitster.g>
Message-ID: <fa91b134e6cb18578d9c499f584ae3c5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-04-05 18:44, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Well, I actually wasn't lazy, but instead I wanted to give this patch
>> better chances to be accepted, by introducing as a small amount of
>> changes to the code as possible.  This was a lesson not to take that
>> route, but to do "the right thing" instead.
> 
> The lesson you should be taking is a bit different here, though.
> 
> As we discussed, doing the separator correctly is harder and doing
> the terminator correctly is much easier and less error prone.  So if
> we chose to do terminator semantics and punt on doing separator
> semantics, the right thing could have been to adjust the existing
> tests to make sure that the new output with unnecessary trailing
> blank line is expected.
> 
> Either that, or we should fix the code not to break the current
> expectation.  Doing neither of these is not quite acceptable---
> that is the lesson from this episode, I would think.

Of course, it was my mistake not to either ensure that the tests
still pass after the introduced changes, or to adjust the test(s)
accordingly.

However, making the vertical whitespace a separator also follows
the Git's general approach of not wasting the vertical screen
space whenever possible, so taking the separator route is actually
better, if you agree.
