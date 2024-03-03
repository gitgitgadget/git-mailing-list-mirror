Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3F8F40
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709487926; cv=none; b=FXi3fGjToKG+lC5fYu16AolQA+/jMc7OHGUVxHL2SR9j/8HenHjVE1kn4NI/22vPvy4lTmgig171XzN9Ac1ow9xLrd3Qufm9/7UCDiNzYl6fasYfVLJSWLqGpegYm1kzRhMYQtTY+hG8AW8sossNeE++JDrmj2wIeTjRXyBrL9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709487926; c=relaxed/simple;
	bh=nr+g0bwhmvtKHm4RMY5orvz1O55yfUp10xtLf8/j5W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AvftG6CTR4MIcDcvKokDadUiavq/xnCTH+6cMYEpRqIWNLo4YBOLJFzyqyZHF58HCzuC6ODNWDJiz+9UiygfmplC3aonJgtJ3mB19pJm0DdlSBV+0IL2Wxpoa1AFwGfjee+2t6AvMmQNtotDy+QUxLZG88GREOvEgam2Ef2CON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bbphk749; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bbphk749"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8ABDF2E099;
	Sun,  3 Mar 2024 12:45:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nr+g0bwhmvtKHm4RMY5orvz1O55yfUp10xtLf8
	/j5W4=; b=Bbphk749g8bwod17qkoTIuZUBg+jddm+TRF7esDFGgYsPmxdD+GJSE
	8BPm3cyCqxwxGI1J+Ocq7QjJjNt1K4p1UpvIeszNj/wrInhjorLLI5KeQMuWmqyO
	pVMwHwjGEyDzMHLg8uQZBG3xNmiUfWhqLCs/wYIuFhvDx/vijTIjE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 83CD92E098;
	Sun,  3 Mar 2024 12:45:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 24F462E096;
	Sun,  3 Mar 2024 12:45:15 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Karthik Nayak
 <karthik.188@gmail.com>,  oliver@schinagl.nl,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] Support diff.wordDiff config
In-Reply-To: <CAPx1GveaNR9ooWqE1VkAuFg5NO4Lwzx7bj-W1mWeHRg-rcg6+w@mail.gmail.com>
	(Chris Torek's message of "Sat, 2 Mar 2024 23:23:03 -0800")
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
	<20240302095751.123138-1-karthik.188@gmail.com>
	<xmqqedcszhty.fsf@gitster.g>
	<CAOLa=ZR6tN8eQhByaUobj3kS9wwYegsOQNT8cjZYA-YATJJt7w@mail.gmail.com>
	<34bb249d-4a4d-4cc7-b737-bb18398341d0@app.fastmail.com>
	<CAPx1GveaNR9ooWqE1VkAuFg5NO4Lwzx7bj-W1mWeHRg-rcg6+w@mail.gmail.com>
Date: Sun, 03 Mar 2024 09:45:13 -0800
Message-ID: <xmqqle6zw6om.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CAD16BA8-D985-11EE-B5C4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Chris Torek <chris.torek@gmail.com> writes:

> This tension is relieved somewhat when there *are* separate
> plumbing commands, such as `git diff-index` and `git diff-tree`
> and so on, or `git rev-list` vs `git log`. Unfortunately there
> are some commands, including `git log` itself, that have options
> that are missing from the roughly-equivalent plumbing command,
> and there are commands (such as `git stash` and `git status`)
> that either do not have, or at one time lacked, plumbing command
> equivalents or options.

Yup.  It is my pet peeve that more and more contributors got lazy
and tweaked only Porcelain commands, without bothering to improve
plumbing commands to match, while adding more features during the
last decade.  Unfortunately there is no easy remedy after such sins
have been committed.  Once people start using `git log` in their
scripts, it is way too late to tell them to update their scripts to
use `git log --porcelain`.  The fact that you need to tell them is
an admission that you already broke their scripts.

