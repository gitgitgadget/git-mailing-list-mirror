Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7212C7FD
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964530; cv=none; b=sB+cFJbRjz2v/Z7DOJHXZ7HK/+Al9cHBXDrarksT+INXyzTZhCZdKBcvE40QCGWjKHKWNdv8wrgBjZQwFyNLjAeBwUs8fkDDRXo1ihAthPY+9GLph6qh7vcriBBk6cv06gGhNvBC2i48cHWcd7WJl0k8zVMWF/JHePCuLpuyHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964530; c=relaxed/simple;
	bh=0W+D08Gw0QTHyRaNf7x5QWi4GroT82kXZ9YEBEuHbW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2C7Ywfda2PFAsIIz9zcDS7KIrKnXu8U99on6588GlTZhXtkT2lhzUUD4TKqsgazIcvX1Jv7zad1VavU6wPnHSw5GPeLXoxySunMcAWyqL3clIeOvYMNYdYy0tMUqjrqI+aWsBsAGrEB+fcsD2Q7dgffj6WcObrJX8jz+3f4/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kBb47KoG; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kBb47KoG"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 780CF1D70F;
	Mon, 26 Feb 2024 11:22:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0W+D08Gw0QTHyRaNf7x5QWi4GroT82kXZ9YEBE
	uHbW4=; b=kBb47KoG/z/v8iHCH8oNbFIMbXaYp3gKxvMOTzrqmI7MgImmxopMTG
	QkTALGzxL6CVJeanUVnAylg2bTxRvjPuz2yAxPjQWkvdNLd4KeDyF0l+iDbfIctA
	qMAf9KOH8ZtR1qpCnRStJMo1EVFDDoE7gQU6UI2O5UBdXYarvMxiU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FC091D70E;
	Mon, 26 Feb 2024 11:22:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0C4921D70D;
	Mon, 26 Feb 2024 11:22:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Glen Choo
 <glencbz@gmail.com>,  Elijah Newren <newren@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  Philippe Blain
 <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2] merge-ort: turn submodule conflict suggestions into
 an advice
In-Reply-To: <pull.1661.v2.git.git.1708954048301.gitgitgadget@gmail.com>
	(Philippe Blain via GitGitGadget's message of "Mon, 26 Feb 2024
	13:27:28 +0000")
References: <pull.1661.git.git.1706534968589.gitgitgadget@gmail.com>
	<pull.1661.v2.git.git.1708954048301.gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 08:22:03 -0800
Message-ID: <xmqqh6hvfb6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E023440-D4C3-11EE-B2B5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Add a new advice type 'submoduleMergeConflict' for the error message
> shown when a non-trivial submodule conflict is encountered, which was
> added in 4057523a40 (submodule merge: update conflict error message,
> 2022-08-04). That commit mentions making this message an advice as
> possible future work. Only show the advice if it is enabled.

When specifically called out like this, it makes it sound as if this
one is disabled by default, while everybody else is enabled unless it
is disabled.

> Update the tests as the expected message now appears on stderr instead
> of stdout.

Makes sense.

Thanks.
