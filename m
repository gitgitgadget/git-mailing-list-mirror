Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D312EBEC
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457675; cv=none; b=Tt7mZqZP7UTjXC7uORt/KqYIAgQjChkfLZtZAPFW33g2rugkEex/klibFYrPp64hOHDeJgWb6S+MFpb8ZmoX7Zjo3TrwCh2QAL2pdqWCj4PAd8KZYSRZ4B3AMxIlx/KP51EePTV8y8z1EgWkAS3bX+hPUp/LKysRnFUo5kgFq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457675; c=relaxed/simple;
	bh=RJQihOIOUpKYSYCdxx3ZlxLu5XkVbzAYF45neR5YzyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fzZNEud27k81wydNxR0dnjCZNfzJYd9OgJFiyfeAG3F2n9lQaBvpNiaT2P0SIQsymkfr95bU2Mm8VM8SHRGVjXfmrvqFOMoD61wMuVHfWICaWU54sKS6+uEd4+Kfx/6NiUqp++GA9cbMKAas2Rk6vOVhntfAEki14Ad3Iqpdnv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WlYXYVpI; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WlYXYVpI"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F4B81DBA0F;
	Tue, 20 Feb 2024 14:34:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RJQihOIOUpKYSYCdxx3ZlxLu5XkVbzAYF45neR
	5YzyM=; b=WlYXYVpIganefNxzA6+ROelFeD+jOQ8f8XaP1ounOR5t+oZehibowQ
	swrYTDrBDt/rm0VL9dUO7Qiur8JI0PH0Ke0E6tseT4kvrA0Iaw9ZvKT/pWe6FdD1
	A8gM/J3C9DXs7OL+971JDmyKcepfGxv8odQKi2lcOtgVblPWVvHMY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 151551DBA0E;
	Tue, 20 Feb 2024 14:34:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AC891DBA0D;
	Tue, 20 Feb 2024 14:34:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff Hostetler <git@jeffhostetler.com>
Cc: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 02/12] name-hash: add index_dir_exists2()
In-Reply-To: <1913ed1b-a145-e641-6601-d8a55a2a8fec@jeffhostetler.com> (Jeff
	Hostetler's message of "Tue, 20 Feb 2024 12:38:26 -0500")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<3464545fe3feceb08408618c77a70cc95745bfe9.1707857541.git.gitgitgadget@gmail.com>
	<xmqqeddg2g7j.fsf@gitster.g>
	<1913ed1b-a145-e641-6601-d8a55a2a8fec@jeffhostetler.com>
Date: Tue, 20 Feb 2024 11:34:25 -0800
Message-ID: <xmqqedd7nd4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0EBBDB40-D027-11EE-8668-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff Hostetler <git@jeffhostetler.com> writes:

> I'm always a little hesitant to change the signature of an existing
> function and chasing all of the callers in the middle of another
> task.  It can sometimes be distracting to reviewers.

Of course we all should be hesitant.  In addition to reviewers,
there are topics in flight and topics people are cooking but not
posted that will be affected.  So it is perfectly fine to introduce
an enhanced version as needed under different name (but let's not
give it a meaningless name like "foo2" where it is totally unclear
and unexplained what its difference from "foo" is from the name),
but if it is meant as an enhanced version, we should aim to share
the code and rewrite the original in terms of the enhanced one,
instead of simply duplicating to risk unnecessary divergence of the
two functions in the future.

Thanks.
