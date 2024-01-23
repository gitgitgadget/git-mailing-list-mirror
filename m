Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84A5CAF
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034864; cv=none; b=YTfTdBH6aJ8GutkOI+sw1Jhdgnldzjn2w5D0aHX8eJ3dPM3p8npjSwbBedrxvir8w19hhE7zPXpqci8Po2fh/htUG5SfnZLywKc/yDyLeBk1p/WFSpzRKSzbis4uDzz9wPw1Vdm4T2s+gSBIJpKpMIuSqhzo1Atf0f+2MJLUWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034864; c=relaxed/simple;
	bh=ne1Hwm0Fnt0RGdklWeDAuXlvssODXrXakRKY3svhV1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X9/Kz7ncaFI86FDDoG6qRyoZl1lmFd6Ek4WFoaxF42cIZdqYm8ZqT/Z/4UoddJmskzJX/DjCFO+nBWXnaA+XS8/GgP0JyCgmMj5wqgc+r71mr577DodMkCEb6ZM+YTny9BM0DlCuKyGPus/u2pob//Kjqf8uNyomZEQ+GR6ViZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EIJcOrvx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EIJcOrvx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D843C1DBCE8;
	Tue, 23 Jan 2024 13:34:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ne1Hwm0Fnt0RGdklWeDAuXlvssODXrXakRKY3s
	vhV1Q=; b=EIJcOrvxZV44veWCQPdQSM+7duZ/5Kflz4UHmyLjYKqraXwknYvXNk
	VdJEZqyd3HeVtdRH6t+GeS7m3TXF5IcXWXzUDLrhvy779WanUC1/dlFEJwOS22XY
	t4Kp3ZA7vRbUFcaq2QN+RD+eO9qXBS98cDIqLN6OC0Z9m5h5j91nI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF4C21DBCE7;
	Tue, 23 Jan 2024 13:34:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 398111DBCE6;
	Tue, 23 Jan 2024 13:34:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
In-Reply-To: <87a5ow9jb4.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
	23 Jan 2024 18:10:55 +0300")
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru>
Date: Tue, 23 Jan 2024 10:34:20 -0800
Message-ID: <xmqqsf2nnbkj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 064C865E-BA1E-11EE-B4C5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Sergey Organov <sorganov@gmail.com> writes:

> Then how does one figure what "git clean -f -f" will do without actually
> doing it?

I think whoever came up with the bright idea of forcing twice
somehow does a totally different thing from forcing once should be
shot, twice ;-)  It does not mesh well with the idea behind the
clean.requireForce setting to make you explicitly choose either '-f'
or '-n' to express your intent.

I wonder how feasible is it to deprecate that misfeature introduced
with a0f4afbe (clean: require double -f options to nuke nested git
repository and work tree, 2009-06-30) and migrate its users (which
is marked as "This is rarely what the user wants") to a new option,
say, --nested-repo-too so that the "dry-run" version of the
invocations become

    git clean -n
    git clean -n --nested-repo-too

and you can substitute "-n" with "-f" to actually perform it?

Anybody care to come up with a sensible migration plan?

Thanks.
