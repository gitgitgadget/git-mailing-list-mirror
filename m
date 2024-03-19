Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179240840
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710824979; cv=none; b=Z+AQoT+arN+FfdTT2FJJhwzt2CEClZrD/NN8OfyYz1UQYUcO1wEtTCsCC02fDozu7xj/8quv5YW4CUMlg7AOwqirof/1Ev1/QaPmLLCHOIOKH6ctIWsz1NAw5cs5fZmGkEVxLFkFWOvqE3H8Yxn+0JMX92Lb9yH++WqivS4xQao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710824979; c=relaxed/simple;
	bh=L8P/LRzSb9SgsG3ZzXObEDAo8MmO3zrSlN8KQbitP4w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=E34xnK35kNWvIGEFswPZugrKWrZ0eo5dLkNA5j4ZdIr6qqz6XWRItqCCgTT+Pnnve1p3Z9dpCbtpladydWEYJPWccJ/Mt9Vd/KJtJUoGQbNVIlcggtmrcqcILeqZqDRtW/cpFfvFnlCtetjwU4RXQzavRlpYGMOxlPNdL1PKBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=X4kPMAHd; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="X4kPMAHd"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710824974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBUNoc3k6aE6A1+InnOGsxRZqxCU0I9S6lSErhGPVYQ=;
	b=X4kPMAHdWzXp9B4s/iomKTrtG5o7sHAweNyaCdcu68FHhETuMVlVQF2pFoltxAdRwV57T8
	Z4wDdYJErBar/ssPwRA6f7cNNK8AsAOBAg/++WN+SDpjYs5IglKKKwiL2bXS6I9/3F7iN5
	Op8DOcIU7Un/M4Nw+JACRrewkG74TAth3y0br97v3SgSz0tvrT5EB8UKg0vdnJkMMk80r2
	NrT+2M1QQEkYMBFGfdRue8nKu1tVmkafl6MJpi1woMNwt5fQ0t+xFE2ZrJuApUlw/wxXZV
	YKV0okntBVDTngK+rbTyxsgVh8/ORoLZdcrG7TlVEbjHDpCFKc3yTMQsb0ahqQ==
Date: Tue, 19 Mar 2024 06:09:34 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] New config option for git-grep to include untracked
 files
In-Reply-To: <xmqqwmpzt6jk.fsf@gitster.g>
References: <cover.1710781235.git.dsimic@manjaro.org>
 <xmqqwmpzt6jk.fsf@gitster.g>
Message-ID: <c68a6d94bb02e5d9aa2f81bee022baa8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-03-19 01:21, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> This patch series introduces new config option grep.includeUntracked,
>> which makes the untracked files also searched by default when 
>> git-grep(1)
>> is invoked, in addition to searching the tracked files.
> 
> Hmph.  I am moderately negative on any configuration that screws
> with the default haystack from which needle is sought for.
> 
> I may often do "git grep --cached" but that does not mean I would
> welcome an configuration option to make "git grep" search in the
> index even when the request by the user does not have "--cached".
> 
> Inclusion of untracked sources in a sense is even worse, especially
> when an unsuspecting "git grep" user (or a script) fully expects
> that any paths found in the output are to be found in "git ls-files
> -s" output but when you stray into a repository with the
> configuration set, that expectation suddelnly gets broken.

Hmm...  Those are valid concerns.  For example, I'd also be against
another configuration option that would make it possible to enable
--cached by default, for example, because it could easily mess the
things up really bad.

However, I think that the usability of this new configuration option
outweighs the possible issues it could cause to some users.  For
example, I quite often find myself in need to specify --untracked
while running git-grep(1), to see what's found in the code changes
I haven't staged yet, so I find this new configuration very useful.

Of course, I already have a few aliases defined for grep operations,
but defining another one for "grep --untracked" simply doesn't fit
into my alias scheme.  Obviously, that's why I implemented this new
option, :) hoping that it would be usable to other people, too.

I'm not sure how many users could be affected by the possible negative
effects of this configuration option, by using a specific mix of git
operations, but I think it would be quite useful.
