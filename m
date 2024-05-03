Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F204AEE5
	for <git@vger.kernel.org>; Fri,  3 May 2024 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752073; cv=none; b=FJYbvz7poLwnHK1b9jejmgv+ATRQtQiJrXLp2ScwyM6QAwmBelRXdKs0IEuXdizManbYk5qHyb4MfLG/5KtiSq0pHEHYiUBcV0EBsArUals1UQzV1ZP7G1Ah2C0N1MQsz3QXpdASVP8stc8eziZJy47iT09eFPFIEWnpyeuzt8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752073; c=relaxed/simple;
	bh=aO3vVAVrOkHyI7XmXSZC9hhGFVtVl5XqKMZvOq48ORs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L8aPaxojJksrHMgExxWS2jp/E0vAbqVc2AjNdW9ZYzz7gknwGopgNOvz7e713JfZsoRmxziyldt36UGfRhJ/ORCljBp2DcoVgav8OpZ9kxUdBjNBSaqYnzpaVmsO/vNUttb2at9uLQGStnVdMZdo9trXnhZ+NjynMXYPfWFiy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kzMVo+QN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kzMVo+QN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 387BB25F8A;
	Fri,  3 May 2024 12:01:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aO3vVAVrOkHyI7XmXSZC9hhGFVtVl5XqKMZvOq
	48ORs=; b=kzMVo+QN2UUZ1eUZkPAWUO7I4UNzE7+YfHGkB6fGC4RH0OmZvqe2Lq
	vVSrnbEB79QmOoV9mV7+KXjihhIFwwUkoJmi+XFtV+xLwzcFjH5+7CsxWOI1P1Ze
	FqFSoFIXcycCbVqqjB9GNk7PSMSwIRDO+eYPEPUH5ahigtzSuEWjs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 27B8425F89;
	Fri,  3 May 2024 12:01:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55AA725F88;
	Fri,  3 May 2024 12:01:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Karthik Nayak'" <karthik.188@gmail.com>,  "'Patrick Steinhardt'"
 <ps@pks.im>,  <git@vger.kernel.org>,  "'Kristoffer Haugsbakk'"
 <code@khaugsbakk.name>,  "'Taylor Blau'" <me@ttaylorr.com>,  =?utf-8?Q?'J?=
 =?utf-8?Q?ean-No=C3=ABl_AVILA'?= <jn.avila@free.fr>,  "'Eric Sunshine'"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 07/14] builtin/config: introduce "list" subcommand
In-Reply-To: <015b01da9d5b$bbe59120$33b0b360$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 3 May 2024 09:13:42 -0400")
References: <cover.1709724089.git.ps@pks.im> <cover.1714730169.git.ps@pks.im>
	<b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>
	<CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
	<015b01da9d5b$bbe59120$33b0b360$@nexbridge.com>
Date: Fri, 03 May 2024 09:01:06 -0700
Message-ID: <xmqqjzkaanr1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5B3C3FAA-0966-11EF-BCAF-25B3960A682E-77302942!pb-smtp2.pobox.com

<rsbecker@nexbridge.com> writes:

>>> +DEPRECATED MODES
>>> +----------------
>>> +
>>> +The following modes have been deprecated in favor of subcommands. It
>>> +is recommended to migrate to the new syntax.
>>> +
>>> +-l::
>>> +--list::
>>> +	Replaced by `git config list`.

Can you trim quotes in your response that has no relevance to what
you are responding to?

> Removing the --list option is going to break backward
> compatibility for users who script the use of config for things
> like setup, clone automation, etc.

Yes, that is why this is merely a deprecation.

> Adding list as a sub-command could (but should not) cause
> ambiguities between a list and configuration value.

Because there is no sectionless variable, there exists no ambiguity.

In other words,

    $ git config list

cannot be asking for the value of the variable "list", because such
a variable cannot exist.  When you start your command with

    $ git config list ...

whatever other tokens follow that token "list" on the command line,
it is a "--list" subcommand.  A traditional and lazy "get a single
variable" without an explicit subcommand would look like

    $ git config section.variable

that is a short-hand to

    $ git config --get section.variable

and would become

    $ git config get section.variable

in the new world order.

Thanks.
