Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B07DF57
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CEyXSfSI"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 20400189C5;
	Thu, 11 Jan 2024 13:48:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WuOrz5I++ZgqOfVsMJP/415WOBAf9vdLQK1oBA
	S8vcs=; b=CEyXSfSIKnEBwCmhu7sSgjNNNKDx71+G6Vh9MbvIGmo3Egxt5/tPoB
	MXjtM3LzYpSZ++6XOiCwLiPK0KxQhDewGvN+OnWrV+6Q5mQEOrfnraVpBKdkEsua
	+7oLnA9SOPCOOTzCqF75RC2Tye+wFkWfSSBAK1uXOyiuu3h0ShuSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1854B189C4;
	Thu, 11 Jan 2024 13:48:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4AD1D189C1;
	Thu, 11 Jan 2024 13:48:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 2/2] t5541: generalize reference locking
In-Reply-To: <20240111072828.GD48154@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 11 Jan 2024 02:28:28 -0500")
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
	<11fd5091d61b54d8862ab2e316bbd25fff63ce0f.1704912750.git.gitgitgadget@gmail.com>
	<20240111072828.GD48154@coredump.intra.peff.net>
Date: Thu, 11 Jan 2024 10:47:59 -0800
Message-ID: <xmqqa5pbhfkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F2BCBAC0-B0B1-11EE-9872-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, Jan 10, 2024 at 06:52:30PM +0000, Justin Tobler via GitGitGadget wrote:
>
>> From: Justin Tobler <jltobler@gmail.com>
>> 
>> Some tests set up reference locks by directly creating the lockfile.
>> While this works for the files reference backend, reftable reference
>> locks operate differently and are incompatible with this approach.
>> Generalize reference locking by preparing a reference transaction.
>
> As with the first patch, I think we could use d/f conflicts to get the
> same effect. Perhaps something like this:

Thanks for a great alternative.  I agree that avoiding fifo indeed
is a better way to go.
