Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7714B815
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638247; cv=none; b=uJtGXt3KTf1s4xlWcfxJMpAZVQCcqnPT++o71vuLp5A35hmOQh/+6qYt3JthaCSDbhxnKRn+QvXU0A7F2dBSQ57bn3lpc4oiuTBleFqkjOKI8yF6bwZggbLx4k2KBM0rXtJrKxYj4eCnRXqOa2fXPH3dQhkGjWS5gEaYbUucdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638247; c=relaxed/simple;
	bh=NL+JHYxrmQmTWG+KMVZ0Gj1Io03/s9n1YdTDEXcopos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LJeThz8gFwj7aHDyvvNnIn55KwBrBaD68x+SLXTRVVnYbYXXz7tbsJyqE9ICn4d8gAlv2ZiBqA/Jkb9/W8d51o1XZ5jTzXnfV0es8VrYjZuXwjD9EVq05/FdM9nb4/uU6fWd4eOq3tghLFIHj4v1bBCk/wzNB1rikdML9HDbgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xgFOn3Pr; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xgFOn3Pr"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B4781F9A5;
	Thu, 22 Feb 2024 16:44:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NL+JHYxrmQmTWG+KMVZ0Gj1Io03/s9n1YdTDEX
	copos=; b=xgFOn3PrWZkTvGC1wPDst82fTsemKbIXCTqNFEzUQeYkrUVODWTgUF
	nSIHgaCH53s7obHwsRO0ol70EPK/zFrZNa71+IjBd9M3zwl0T+VU4ZejebsdhaKi
	p8ry/oCymN2FVNdxHeqtNxyf/hmjHuBQqrRf0721vgoj6DVtOJqso=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 73C9D1F9A4;
	Thu, 22 Feb 2024 16:44:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 00F521F9A1;
	Thu, 22 Feb 2024 16:44:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  Jonathan Tan <jonathantanmy@google.com>,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
In-Reply-To: <20240222175033.1489723-2-calvinwan@google.com> (Calvin Wan's
	message of "Thu, 22 Feb 2024 17:50:31 +0000")
References: <cover.1696021277.git.jonathantanmy@google.com>
	<20240222175033.1489723-2-calvinwan@google.com>
Date: Thu, 22 Feb 2024 13:43:59 -0800
Message-ID: <xmqqh6i0cgyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7D8FC608-D1CB-11EE-ACC0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Calvin Wan <calvinwan@google.com> writes:

> From: Jonathan Tan <jonathantanmy@google.com>
>
> pager.h uses uintmax_t but does not include stdint.h. Therefore, add
> this include statement.
>
> This was discovered when writing a stub pager.c file.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  pager.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/pager.h b/pager.h
> index b77433026d..015bca95e3 100644
> --- a/pager.h
> +++ b/pager.h
> @@ -1,6 +1,8 @@
>  #ifndef PAGER_H
>  #define PAGER_H
>  
> +#include <stdint.h>
> +
>  struct child_process;
>  
>  const char *git_pager(int stdout_is_tty);

This is not going in a sensible direction from our portability
standard's point of view.

The reason why we do not include these system headers directly to
our source files, and instead make it a rule to include
<git-compat-util.h> as the first header instead, is exactly because
there are curiosities in various platforms that Git wants to run on
which system include headers give us the declarations for types and
functions we rely on, in what order they must be included, and after
what feature macros (the ones that give adjustment to what the
system headers do, like _POSIX_C_SOURCE) are defined, etc.

Given that in <git-compat-util.h>, inclusion of <stdint.h> is
conditional behind some #ifdef's, it does not look like a sensible
change.  It is not very likely for <inttypes.h> and <stdint.h> to
declare uintmax_t in an incompatible way, but on a platform where
<git-compat-util.h> decides to include <inttypes.h> and use its
definition of what uintmax_t is, we should follow the same choice
and be consistent.

If there is a feature macro that affects sizes of the integer on a
platform, this patch will break it even more badly.  Perhaps there
is a platform whose C-library header requires you to define a
feature macro to use 64-bit, and we may define that feature macro
in <git-compat-util.h> before including either <inttypes.h> or
<stdint.h>, but by including <stdint.h> directly like the above
patch does, only this file and the sources that include only this
file, refusing to include <git-compat-util.h> as everybody in the
Git source tree should, will end up using different notion of what
the integral type with maximum width is from everybody else.

What this patch _wants_ to do is of course sympathizable, and we
have "make hdr-check" rule to enforce "a header must include the
headers that declare what it uses", except that it lets the header
files being tested assume that the things made available by
including <git-compat-util.h> are always available.

I think a sensible direction to go for libification purposes is to
also make sure that sources that are compiled into gitstdlib.a, and
the headers that makes what is in gitstdlib.a available, include the
<git-compat-util.h> header file.  There may be things declared in
the <git-compat-util.h> header that are _too_ specific to what ought
to be linked into the final "git" binary and unwanted by library
clients that are not "git" binary, and the right way to deal with it
is to split <git-compat-util.h> into two parts, i.e. what makes
system services available like its conditional inclusion of
<stdint.h> vs <inttypes.h>, definition of feature macros, order in
which the current <git-compat-util.h> includes system headers, etc.,
excluding those that made you write this patch to avoid assuming
that the client code would have included <git-compat-util.h> before
<pager.h>, would be the new <git-compat-core.h>.  And everything
else will remain in <git-compat-util.h>, which will include the
<git-compat-core.h>.  The <pager.h> header for library clients would
include <git-compat-core.h> instead, to still allow them to use the
same types as "git" binary itself that way.





