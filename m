Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192111B599
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174763; cv=none; b=ZBf4pvfiTZh2dy1sL261P0HhCMTmV5FpIBUy3KJU23iAZWs1Q6iiK6Y3tj1H9djWp8DcAl2ltl8m0NB4SCCIjKDoghoB367Zu+0sQed1B5qT3jGP8Rc8mUmiEnxiI6ORzhxpClg0Z1e+G8hQRHRpo/vVQqsmN+IWghIVuEuooW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174763; c=relaxed/simple;
	bh=aKIQhiJeGFknMXH/tGqBSBYom0IykcAD9fWmDkCGbCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dXP3MYsOIyOjwHHwkPOL0LkiXAlo0JcxT2y0Vkn80RVDiyMrFQvmqIlLHOBzfO5daT9qNBo+mNDrxAYEXpE/QbGlBX4izsq/UB+fDcz3v3/xCUhlzsr6tVNjMBzY+S9Icjb6xE3qaUmYZi7yyK0YAsbgreRY78Bs4+hC+rUO5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kbVvVV5l; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kbVvVV5l"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 75FC41ED650;
	Mon, 11 Mar 2024 12:32:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aKIQhiJeGFknMXH/tGqBSBYom0IykcAD9fWmDk
	CGbCE=; b=kbVvVV5l1+6pphsYaN+aSBwmicsAWOs53Wx2m2RFdlDtjPqAQsIzxx
	ryfmb8DlwEuvvGJ9tJovwxf+aqcoUJaPCOUsZmNTnQ8DPEXXWCLULzBK+NMFo7uC
	fIle5jxMSjuKa45oApTSAFj8PM3Mka8h5s1IV0MdqyIufr6IV+2hw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C0411ED64F;
	Mon, 11 Mar 2024 12:32:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2FA21ED64E;
	Mon, 11 Mar 2024 12:32:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSOC][PATCH v4 1/1] t7301: use test_path_is_(missing|file)
In-Reply-To: <20240310114311.598681-2-vincenzo.mezzela@gmail.com> (Vincenzo
	Mezzela's message of "Sun, 10 Mar 2024 12:43:11 +0100")
References: <20240304171732.64457-1-vincenzo.mezzela@gmail.com>
	<20240310114311.598681-1-vincenzo.mezzela@gmail.com>
	<20240310114311.598681-2-vincenzo.mezzela@gmail.com>
Date: Mon, 11 Mar 2024 09:32:33 -0700
Message-ID: <xmqqr0ggu3tq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F730BCFE-DFC4-11EE-9CC7-25B3960A682E-77302942!pb-smtp2.pobox.com

Vincenzo Mezzela <vincenzo.mezzela@gmail.com> writes:

> Replace use of 'test -f' with 'test_path_is_file' helper functions from

Before "helper functions", we'd need another pair, e.g.

    and 'test ! -f' with 'test_path_is_missing'

otherwise the plurals in the remainder of the paragraph would not
make much sense.

> test-lib-functions.sh. These functions perform identical operations
> while enhancing debugging capabilities in case of test failures.



>
> In the context of this file, 'test ! -f' is meant to check if the file
> has been correctly cleaned, so it should be 'test ! -e'.
> Thus its usage is replaced with 'test_path_is_missing' instead of 
> '! test_path_is_file'.

Even if the test meant not to complain when there is something not a
regular file (e.g. a directory), "! test_path_is_file" is not the
right way to express it, so the way this paragraph is written is
somewhat misleading.  Something like

    The original used `test ! -f` but it did not mean that the tests
    are happy if a directory exists there.  It should have used
    `test ! -e`, and using test_path_is_missing matches the intent.

perhaps.

