Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E41448FB
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608608; cv=none; b=c/1K8vTFB9gW703JoogwrWUJBzbGVyqlKTtyoimCTQITTbWPFib8UyhEk3GcwwJFG4pPUi6TT6QMgKa4jg8/5vPczLQ2NGrsNe7l8jv/cW9TU9weDZEj3A5NUevTV9P5qwVvOBnB8fUXRfZ3sNcn60fASsYdflitry2JDoD564Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608608; c=relaxed/simple;
	bh=4HHUos4OOEgI/Ph2HhkhJDlYUlUouXYFXIpQfohj//s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RzyxBqLmLI96t12ijyJGYVujEVklTX0YEhkLKJH5W9KQYc1icByA1101wilwp51LZmboArbZu3NsQ58J42NkYLyROFnzeApBKOn+JBtNHrxngy9LEzaUx+FHUPECrU9Y3TQtDvpdQHeIuqIl5+GI1xTolBJXlqC76R5XA73AJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ATBVPPnd; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ATBVPPnd"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F0E083AA93;
	Mon,  8 Apr 2024 16:36:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4HHUos4OOEgI/Ph2HhkhJDlYUlUouXYFXIpQfo
	hj//s=; b=ATBVPPndSwtV1ehgJj+wtM/pRTDf2kfpCMZOwkape6PFNttCFaR3oZ
	9gSfhjx2/qJl2X1IeVzkY+VHc0oCeCdx7TyqsjlsEAQ+TcGKkb1eVzDxkVQTac37
	WehwI8NcM2LE0Z9+bpuER5QHxJQ/HyG0TQqT4vK5dIxna0hpTfhOA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E8ECA3AA92;
	Mon,  8 Apr 2024 16:36:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 784EE3AA8F;
	Mon,  8 Apr 2024 16:36:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  nasamuffin@google.com
Subject: Re: [PATCH] reftable: use xmalloc() and xrealloc()
In-Reply-To: <CAOw_e7Z9dGeVU399D6o37L3am0abnYUrZnNQEFKhyUv=A2=j8g@mail.gmail.com>
	(Han-Wen Nienhuys's message of "Mon, 8 Apr 2024 19:50:47 +0200")
References: <963961ee-0f1d-42b8-8dda-5838e7a2ed94@web.de>
	<ZhOETox9FTIOAShN@tanuki>
	<CAOw_e7Z9dGeVU399D6o37L3am0abnYUrZnNQEFKhyUv=A2=j8g@mail.gmail.com>
Date: Mon, 08 Apr 2024 13:36:40 -0700
Message-ID: <xmqqzfu3a8x3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B56C5790-F5E7-11EE-93DA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Han-Wen Nienhuys <hanwenn@gmail.com> writes:

> However, it is probably pointless as long as strbuf_* functions do not
> signal OOM gracefully. There was some talk of libifying strbuf. Did
> that work include returning OOM error codes in case malloc returns
> null? A quick look at strbuf.h suggests not.

I would expect not.

The "libified" strbuf (aka "strbuf API in the Git std lib") will
have to be different from what we internally use from <strbuf.h>.
<gitstdlib/strbuf.h> will export gitstdlib_strbuf_addstr(), which is
"properly" libified and signals an allocation failure to its caller.

When that happens, I would expect that strbuf_addstr() would be a
thin wrapper around gitstdlib_strbuf_addstr(), and still just dies
with "we ran out of memory", i.e.

	/* strbuf.h */
	#include <strbuf.h>
	#include <gitstdlib/strbuf.h>

	void strbuf_addstr(struct strbuf *sb, const char *s)
	{
		int err = gitstdlib_strbuf_addstr(sb, s);
                if (!err)
			return; /* happy */
		switch (err) {
		case GITLIB_OOM: /* there may be others */
			die("Out of memory");
			...
		}
	}

which would keep the damage to Git codebase to the minimum when we
become the first client of the "Git std lib".
