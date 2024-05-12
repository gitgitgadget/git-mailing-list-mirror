Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC9DDC0
	for <git@vger.kernel.org>; Sun, 12 May 2024 04:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715486995; cv=none; b=mrLgcrO21rvy5UOhElHUO0wtbcxGhRy7UPNFvCePfcnZz7rQFNRuoJ9cSQO4k08HZ0UQKe0Rzs+Q0G0ypnoScK+iMhGfaX/Tool5qGtgTeMP5AjdxkW5MKBoMPrnioRwqfBcKkV31PNKRXIVyRZzTx0H9X0MmjPHRYzrfIslsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715486995; c=relaxed/simple;
	bh=dOdI78Xs8PM+5OQnwuxAUk2LZaeGNvRXZrglRNt3Uig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XY+PwCa2w2ikLdwwrRsk2N/PH0a3/mWBEXhXOdME73K/nVzFycmGKZVzrtz6wQKW9rxqm4wPqs3Y/UbiW+H5N8uQ84qfsn6dWwNi4tELRYQelpFNYJpASQGNdpN8zqJKMPA7BtGtyvYWERxIcgUdbhN7YOI2Te6SxJYaod4vEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yWC95N2+; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yWC95N2+"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E7C2124466;
	Sun, 12 May 2024 00:09:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dOdI78Xs8PM+5OQnwuxAUk2LZaeGNvRXZrglRN
	t3Uig=; b=yWC95N2+Mok/vSR5mwAC0w39kuan0QU18A8KJh5ZizANiorIf36s4K
	WQ68WLiYvVlAavPYKRycMikcN63OiyxD5SaCiCryjJixZ9Sp5bxWuP+TS7gJiEKv
	pM/Y54ZvDy20nzkrLbSOy/QplqNQSx2HM6qfvZXSPcd/vVdTcAi6E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E05E124464;
	Sun, 12 May 2024 00:09:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5D21D24462;
	Sun, 12 May 2024 00:09:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Bo Anderson <mail@boanderson.me>,  Jeff King
 <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>,  Koji
 Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v2 2/2] osxkeychain: state[] seen=1 to skip unnecessary
 store operations
In-Reply-To: <1f57718abff1d0e234c4145e833424da7be79311.1715428542.git.gitgitgadget@gmail.com>
	(Koji Nakamaru via GitGitGadget's message of "Sat, 11 May 2024
	11:55:42 +0000")
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
	<pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
	<1f57718abff1d0e234c4145e833424da7be79311.1715428542.git.gitgitgadget@gmail.com>
Date: Sat, 11 May 2024 21:09:46 -0700
Message-ID: <xmqqmsovisc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 791B2C06-1015-11EF-8854-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Koji Nakamaru <koji.nakamaru@gree.net>
>
> Records whether credentials come from get operations and skips
> unnecessary store operations by utilizing the state[] feature, as
> suggested by brian m. carlson.

This step has a problem description that is even sketchier than the
previous one.  Anticipate questions by the other developers who read
this commit 6 months after it is accepted in the mainline (e.g.,
What problem is there in the current system, why it is bad and worth
solving, and how is the patch trying to solve it?) and let your
proposed log message answer the questions, as you won't be always
sitting next to these developers.

Thanks.
