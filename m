Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57FC1B1D7A
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256061; cv=none; b=Mq6F4qX4C1Ny1gLW92JUcYGn7vaoYnZHAJZnL6z6bcO/V08Y0PUWb6q7l6nirgpRporcpdJVEDazYOKKCmX23zBk8rV9xOOrrofTJttzebTwikNFLoZCQDfUok4cm3yWZf6O/ejbkEGgay7WERC2DIh9CPi4qFHEsebS7khqfpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256061; c=relaxed/simple;
	bh=EIMU049ICtuCoY69WoTYK9wU3c3LFWU9ecKmQPaL3Pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GL/Hq4N0BIhkIRN7T/5y1bSCnPDg8wPnf3N4q3v7Lzrb96/Zw41J5V8SoNRc8mHOSJiRA8xfSKY2RP8CfFPDzBwufUkdWNHelB9x0yJDyip/QTNTz7UpKZvAekMFK1K9sPGnYDBoezeugOxfm69QeP2u8LI4w1KGPpmX5KEOClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L//+t5u2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L//+t5u2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FD5E36B2E;
	Wed, 21 Aug 2024 12:00:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EIMU049ICtuCoY69WoTYK9wU3c3LFWU9ecKmQP
	aL3Pw=; b=L//+t5u2SVO/4qKtlJorUx7nIQSCos5ihvzOlcmkuCKB8AbhaJNek/
	2BJGd0LSiIZ4XlV6ZDmeJs39emCCcQsNALE/+oAJlvtMzKCDF6VD7OENz1Ff679g
	e1f9tTPKt0pUmn4bw/V0g4XUl1Q4Kg6L8wHI6sl29SSrz8W7yegzs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75D1136B2D;
	Wed, 21 Aug 2024 12:00:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DEE9A36B2C;
	Wed, 21 Aug 2024 12:00:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matheus Tavares <matheus.tavb@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  newren@gmail.com,
  ps@pks.im,  phillip.wood123@gmail.com,  Lincoln Yuji
 <lincolnyuji@hotmail.com>,  Rodrigo Siqueira <siqueirajordao@riseup.net>
Subject: Re: [PATCH v3] rebase --exec: respect --quiet
In-Reply-To: <f105b34b8e6b33448f4d0ef07d51b7bbf4e71aaa.1724203912.git.matheus.tavb@gmail.com>
	(Matheus Tavares's message of "Tue, 20 Aug 2024 22:31:52 -0300")
References: <be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
	<f105b34b8e6b33448f4d0ef07d51b7bbf4e71aaa.1724203912.git.matheus.tavb@gmail.com>
Date: Wed, 21 Aug 2024 09:00:56 -0700
Message-ID: <xmqq7cc93lxj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8DDAFF0C-5FD6-11EF-8AF2-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Matheus Tavares <matheus.tavb@gmail.com> writes:

> rebase --exec doesn't obey --quiet and ends up printing messages about
> the command being executed:
> ...
> Changes in v3:
> - Skipped term_clean_line() when stderr is not a TTY.
> - Removed the !opts->quiet condition when calling term_clean_line().
> - Reworded commit message to better explain the proposed changes.

The updated title and log message, and the new approach to squelch
term_clear_line() when it is not needed.  Both look quite sensible.

Will replace.  Thanks.

