Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F39B25605
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iq9W5Aat"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC51A1C3AA5;
	Fri, 12 Jan 2024 13:17:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+77ltJ7dvz4cQZhb3e5b1bQVsV8fM07yGFaWfX
	JCjNo=; b=iq9W5AatnsjUhrnbk75f3yTopTGlE0ukcsyYguANQYSptqaBsRB/jQ
	qHIVjNeJ8n1d3jfU87LnYasqRdW70mt01f5Ut44OgQePWqohQbec6omnV6dcFkKK
	fk8jwrp8ZFCCKR2SBVEe1XCt/GIeGx6IrL+GysEIIkRYB/FYqXKt0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3F5F1C3AA4;
	Fri, 12 Jan 2024 13:17:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43CC51C3AA3;
	Fri, 12 Jan 2024 13:17:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt
 <ps@pks.im>,  git@vger.kernel.org,  Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH 1/2] t9902: verify that completion does not print anything
In-Reply-To: <20240112151655.GA640039@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 12 Jan 2024 10:16:55 -0500")
References: <cover.1704969119.git.ps@pks.im>
	<73406ca9c8f38ac2ad8f0e32d6d81f1566a6b4d1.1704969119.git.ps@pks.im>
	<d978494d-6c48-5923-4745-c42a39e1187a@gmx.de>
	<ZaEZar9OTVgfkD9r@framework>
	<27edf445-d7fa-7aaf-7682-4ecc03366ef0@gmx.de>
	<20240112151655.GA640039@coredump.intra.peff.net>
Date: Fri, 12 Jan 2024 10:17:36 -0800
Message-ID: <xmqqedembem7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DD59AE0C-B176-11EE-A5DB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Fri, Jan 12, 2024 at 02:12:43PM +0100, Johannes Schindelin wrote:
>
>> But my main concern is: Why does this happen in the first place? If we are
>> running with Bash, why does `BASH_XTRACEFD` to work as intended here and
>> makes it necessary to filter out the traced commands?
>
> BASH_XTRACEFD was introduced in bash 4.1. macOS ships with the ancient
> bash 3.2.57, which is the last GPLv2 version.
>
> One simple solution is to mark the script with test_untraceable. See
> 5fc98e79fc (t: add means to disable '-x' tracing for individual test
> scripts, 2018-02-24) and 5827506928 (t1510-repo-setup: mark as
> untraceable with '-x', 2018-02-24).
>
> That will disable tracing entirely in the script for older versions of
> bash, which could make debugging harder. But it will still work as
> expected for people on reasonable versions of bash, and doesn't
> introduce any complicated code.

Thank you, all three of you, for digging through to the bottom
quickly.

I too suspected a version of bash that is ancient and found out
about the "untraceable" bit just before I started reading this
thread ;-)
