Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D938889D
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346822; cv=none; b=ZyUTvc09tl/vMFkkDLHlA48Y01TJZW6WhjfW3TD7S88fPNrkowQP7oZwa/7XdbZKYRa5hn5gsI8/jSAEC54lbmrJ4u3j6qcKWAROvKYFC3xINk1Q0737OssftYCDHnh0yfBEFI46/rhvfUiDUsKPF+2u/EAOQwLmA4+4YBg5ayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346822; c=relaxed/simple;
	bh=3u9MYFFOIOpD6StsNDpneUtzynqQhIsP0bYy2JNr/8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1ir7cF2VqEZdBYT9fwGazNfNM0iRdnhg6uG1ksXLd4QW8fcEHWM5VtdGWBiQPnuqFI8aFAM+yT0AqtqW5qsZgYS7cDlnACr9YA16rDOAr7CaEkmzjdNmWVz6DTRxYYjpcb0ceoZkxrxalpCLGJuR0nXSDRj4svtorCsC5L3EfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=U9obBZuz; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="U9obBZuz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202608070029; t=1786346816;
	bh=3u9MYFFOIOpD6StsNDpneUtzynqQhIsP0bYy2JNr/8M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=U9obBZuzqsBxtE+Dp6YNoVq2H1E8CyTVW7bCCZCDazhIOHU3B3g5BDbVoE7Rucs4V
	 BNWCh7RmyPDm1uOhvHz88n6Hg+QGaYhZ6FVWHR/yi7XBIqoFJ63C6ZE/G7YwVIt61l
	 MWBSrarsii5nhkBNPJiAQXXI5K0zNPqVbxkGbWAR4s2yahyDgJK1sZb54GdN8rgZ0v
	 VM6zG8DV7R7UEQ1uLbLaDCTr044JXnVD9eyzUiXR42yr4+SlxCUngTtDfexsQ0o84v
	 kzwwpelQS/Fwf57FN8K2W8wf07Ztg+2q3gwyIfZ6vUh7tf5DZIz/kawCLEJP1mUHWH
	 5xy2gNw24WZCQ==
Received: from [192.168.42.64] (66-97-142-46.pool.kielnet.net [46.142.97.66])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 02F233C3662;
	Mon, 10 Aug 2026 09:26:55 +0200 (CEST)
Message-ID: <26c2f7e0-03ef-4c45-8175-adcc2e0395ac@haller-berlin.de>
Date: Mon, 10 Aug 2026 09:26:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can we do better than "git checkout/add -p"
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>,
 "schacon@gmail.com" <schacon@gmail.com>
References: <xmqq8q6ih924.fsf@gitster.g>
 <CALnO6CBu8ZBDk9YwLW2jVJtBUk1=pvai5QHiLN6XLOOL-3KA=g@mail.gmail.com>
 <xmqqfr0qexps.fsf@gitster.g> <anlpmNSjBUJ8p9RL@pks.im>
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <anlpmNSjBUJ8p9RL@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +

On 10.08.26 08:03, Patrick Steinhardt wrote:
> I've been playing around with the thought of introducing ncurses-based
> interfaces into Git. I've been mostly thinking about git-history(1) here
> so that you can just move commits around, squash them together, drop
> them and so on. But I think fancy stuff like TUIs can also be applied to
> other parts of Git, as well, to make things a bit more visual to our
> users and, as a consequence, easier to use.

That sounds a whole lot like lazygit to me [1]; it does all those things
in a rather intuitive way, including Junio's original use case of
selecting a hunk and staging or discarding it.

Is it really worth adding such functionality to core git? I like the
idea of tools specializing on what they do well; core git on providing
the core functionality, GUI tools on presenting it in a UI.

[1] https://github.com/jesseduffield/lazygit
