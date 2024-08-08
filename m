Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC659150994
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154231; cv=none; b=H6+7GfVjjQrRjlww3VUYKIYR+9AtcZnP2q6UYyNXiYaqercmZ12QH74C0+eKkHlxRH0DlZA+HaJDK0eas284gvGjjZDREcdplHXJ3pSqTPtuLqf0eEcit/xLA0XgtfFYUuDfqVZ3tboeoMmOGcIW7mHc4bWjalXf5VEJyy2uexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154231; c=relaxed/simple;
	bh=/59hXmwoeLfpTmsPIKzeHP6jREKQEobJLj1pGONJDQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSbkndJh3d7yGoHCDH/ztcqAOruFr5x/tPMXwQXKPqSqrwtkBrD9AHpFAlxFTy4jM552uXb29OSXHvQoFnnEIb3/BP3KJnDXWO2IQZh3MLDTBxDpSs+EikoKUb6LebFHj+TOHbC3N3BoUQdvsIoLhquzwbVMqLvTuovjJgJMLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BvyO9KWl; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BvyO9KWl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E59732E76;
	Thu,  8 Aug 2024 17:57:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/59hXmwoeLfpTmsPIKzeHP6jREKQEobJLj1pGO
	NJDQI=; b=BvyO9KWl1GB//jQzoB0AjdoNqTiD6sWbxGknZcF6mTtdH3Q5Tjo3JJ
	vRwim+3zdqCae+c6mCfMCXKIrwN0n7HMidH1w5T/TOutMo7aoW9CNYqoRlN73a6W
	iOuy37irhY7w1ML5kFVblrTclw57zbbiEJe/WHdl9DEOCqwT3tB64=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E75DE32E75;
	Thu,  8 Aug 2024 17:57:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C0EC32E72;
	Thu,  8 Aug 2024 17:57:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 3/3] send-email: teach git send-email option to
 translate aliases
In-Reply-To: <20240808-jk-translate-alias-send-email-v1-3-10a03b3d6b06@gmail.com>
	(Jacob Keller's message of "Thu, 08 Aug 2024 14:10:00 -0700")
References: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
	<20240808-jk-translate-alias-send-email-v1-3-10a03b3d6b06@gmail.com>
Date: Thu, 08 Aug 2024 14:57:00 -0700
Message-ID: <xmqqttfufzkj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 248A22D0-55D1-11EF-9763-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Add a new "--translate-aliases" option to git send-email which allows

If you add a thing, it by definition is new, isn't it?

> Instead, skip calling GetOptions a second time of --translate-aliases is

"of"???  "if" perhaps?

> set. This has the effect that known options will instead be translated
> as aliases instead of producing a warning, but this seems like the best
> trade off of the available options.

Hmph, I do not quite get why you need such a hack (to be honest, I
do not quite understand why dump-aliases needs a similar hack,
either, even though I do understand why identity thing needs a
special caseing).

After GetOptions() returns, usuall we process everything remaining
on the command line as files that contain messages, right?  But
before that happens (i.e. anywhere before the while () loop that
processes elements in @ARGV), you can check if your new option was
given, and if so you can map contents of @ARGV using %aliases and
exit, and you are done, no?  Bonus point if you make sure that no
other options were given, but perhaps there are some strange folks
who want to use "--to=fu" as an e-mail alias, so instead of
complaining that "--translate" does not mix with any other options
when "git send-email --translate --to=fu" was run, giving alias
translation for "--to=fu" may be a better behaviour for those users
anyway ;-).

