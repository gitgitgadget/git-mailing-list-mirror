Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866617DE35
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209523; cv=none; b=s6fs8YxzDoeW9NvN2dQ3YgEwL6tV80kJwSoYmWDdU4w72TgvZywvOpV62JsP4R7fKht6BnPleoKICKMeUXtn05QB7BuzuPQyr8M6JV0uLOTqo46ZB9qfLCqnlEe6DYkn8QWoImLidwhxBB9ETtsHRnULMGi9/XhzQc7v21yyIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209523; c=relaxed/simple;
	bh=0Dqk+Lwfb1GySVSYaGw2murRgT4kGe3fcjUnz99D6O8=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FEO/88YbVC9LhW9x4ka5dbSZAxulx4hCxd5rXW63LSihf0WvaB+IsQcK7UdybILN8CfLVYc9bJ0Yn9jFww15Zlclu/VLxQ5/NejaJYZ186K5MgeF8XkRCc/lesi8eEDOp0hkcUDw4SBfAJU7+h5NoPQbJg2BEfGSmfsYEipap88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Oi5zg18a; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Oi5zg18a"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718209511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dITgBssv3ZRBw1C8MHRKEz3ZCjUQbMYWGSwvlWf+c5g=;
	b=Oi5zg18acecJz+8L61lvH0wsb5QwSsRkqVGuJ1NieqLeA3yuTfQB/rpyJpnL8qifGEqpgj
	diVeoYV1CYApQxBvhtdqgr/KQZZH6HnmakQUaT5MOL2ISizkH/D+Lh4/GtBN8MnWra2O/H
	djK+/qxWYS22tfNTgFgdPjuxJJ/AfR6NxD/7KTa00htfZD3iFTNV92zE2Jqb72p71ilE/S
	AtGr/HDvNnwsSyALmh/3jg1AtQ8Enfqw5jntzvS5L73U88UuZCjQ61ofiv5ykRfnqELf+K
	XsaA6ylwvqV/hyFfAWs8arYNfJ+Nw7PBrDy3PWTPUTsF8W1yIX+V+7Y67THFqA==
Date: Wed, 12 Jun 2024 18:25:11 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: git@vger.kernel.org
Subject: Re: [RFC] Avaiable disk space when automatic garbage collection kicks
 in
In-Reply-To: <950d4ad3bcee79df1424faee09eb6b00@manjaro.org>
References: <950d4ad3bcee79df1424faee09eb6b00@manjaro.org>
Message-ID: <164fc547afd66caf58019b6c614b5134@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

[Maybe this RFC deserves a "bump", so let me try.]

On 2024-04-08 18:29, Dragan Simic wrote:
> Hello all,
> 
> A few days ago I've noticed a rather unusual issue, but still
> a realistic one.  When automatic garbage collection kicks in,
> as a result of gc.auto >= 0, which is also the default, the
> local repository can be left in a rather strange state if there
> isn't enough free space available on the respective filesystem
> for writing the objects, etc.
> 
> It might be a good idea to estimate the required amount of free
> filesystem space before starting the garbage collection, be it
> automatic or manual, and refuse the operation if there isn't
> enough free space available.
> 
> As a note, the need_to_gc() function already does something a bit
> similar with the available system RAM.
> 
> Any thoughts?
