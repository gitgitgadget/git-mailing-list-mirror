Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC7190
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BeLvi2jJ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C83C9E
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 17:26:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C20E61AD927;
	Sun, 29 Oct 2023 20:26:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FaHpdSMV7IajeX1sj+o4nW4Bdf+FFInrxHs76I
	YO6e8=; b=BeLvi2jJYTu+U/hNpoObWD/SHa24voMgMOY55A2mCRuHZewd8PKYj5
	hJJ+N1o6OoeyDpwYtULEv2GtONxv0jzF2WLrn8Lc1LGCsWALQ71CW1Z+/Q8hNECT
	c4PKIhr7zpwZsxLsBWdpSyL2KTy8T2po//sPLam595Y/e4IZfjJuI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B91081AD926;
	Sun, 29 Oct 2023 20:26:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EE571AD924;
	Sun, 29 Oct 2023 20:26:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  emilyshaffer@google.com,
  git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Sheik
 <sahibzone@gmail.com>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3] bugreport: reject positional arguments
In-Reply-To: <3e15f266-c790-4b71-84b6-1328339425c1@gmail.com> (Phillip Wood's
	message of "Fri, 27 Oct 2023 15:41:44 +0100")
References: <20231026005542.872301-1-nasamuffin@google.com>
	<20231026155459.2234929-1-nasamuffin@google.com>
	<CAPig+cTmYtWR=QN3LeN9yw3HmsKEmD2fUiRjKf=eJHhAZyT-yA@mail.gmail.com>
	<3e15f266-c790-4b71-84b6-1328339425c1@gmail.com>
Date: Mon, 30 Oct 2023 09:26:31 +0900
Message-ID: <xmqqv8apez0o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F9CF0EC0-76BA-11EE-A42A-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> It is rather unfortunate that test_i18ngrep was deprecated without
> providing an alternative that offers the same debugging
> experience.

The primary thing test_i18ngrep did was to _SKIP_ certain test that
looked for an expected string in "C" locale from the output when the
tests were run under a tainted localization mode.  The tests that
looked for strings in messages that are *not* to be localized used
"grep".  Tests that (unfortunately) had to match human-readable
messages had to work around the tainted localization test to use
test_i18ngrep.

> When test_i18ngrep fails it prints a message with the
> pattern and text that failed to match so it is easy to see where the
> test failed. If grep fails there is no output and so unless the test
> is run with "-x" it can be hard to see which command caused the test
> to fail.

We could rename test_i18ngrep to test_grep (and make test_i18ngrep
into a thin wrapper with warnings).

	test_grep -e must-exist file &&
	test_grep ! -e must-not-exist file

