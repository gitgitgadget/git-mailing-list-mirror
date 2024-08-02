Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6818F48
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558833; cv=none; b=pCL/oRkIzQ1fZdTtwINDyvdKFDdOdnDVc4SAz980ID0KbdJTkJIQVD646BLCkRUdmwdMil8EAE5AlTM2fT4tG17B1d7xoMZhiXe2tbywe6V3PwLkQ45YQ5+PqK9d3PWOjGfJ/+2sXV3uJZ5vdt5jrz3Eo5oHd6C/Qi17sPrVMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558833; c=relaxed/simple;
	bh=i4OXf1+ToWdpXBw00N+8XIi/habwPpmsK6WTrRUBtGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nmXua4DqCIQIBaT13nm+Bo6xCDCW1p6V+OEUyZ58KdIufdaHZI2M1nYYrA1gILkPyT4RABq7RNSFGyipRkVk6VqWcwd9V4tqM0Nz0EJHGcu7V7NVp8NVkTiG+V78I70ANUY5cqRhtpLZ7oTxwGJALbPrgHbHP8rOCHFQlnGFGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=a6wfFioi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a6wfFioi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87E9E2E86F;
	Thu,  1 Aug 2024 20:33:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i4OXf1+ToWdpXBw00N+8XIi/habwPpmsK6WTrR
	UBtGQ=; b=a6wfFioiXYEX3MRR3DtoVeGonfX2vSUkJ4sPYvmxp19bPxr2Q6LtX9
	7QMc0Bqf2E7hc0E41T220Op7kgLE56wsUFAUQzZnUXNFQwxROcGTB6SQEzysDx58
	kP9uDPN0QG9+IxZ4FlnhZ0B/eEGIsPzZbfUkLD1v/DuR8LdozFc3c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DB722E86E;
	Thu,  1 Aug 2024 20:33:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA4352E86C;
	Thu,  1 Aug 2024 20:33:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: git@vger.kernel.org
Subject: Re: quiltimport mode detection oddity
In-Reply-To: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
	(Andrew Morton's message of "Thu, 1 Aug 2024 15:57:02 -0700")
References: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
Date: Thu, 01 Aug 2024 17:33:48 -0700
Message-ID: <xmqqed77hifn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E31E6BCC-5066-11EF-B122-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Andrew Morton <akpm@linux-foundation.org> writes:

> hp2:/usr/src/mm> git quiltimport --series series
> tools-separate-out-shared-radix-tree-components.patch
> warning: tools/testing/radix-tree/generated/autoconf.h has type 100644, expected 100664
>
>
>
>
> That patch has
>
> diff --git a/tools/testing/radix-tree/generated/autoconf.h a/tools/testing/radix-tree/generated/autoconf.h
> deleted file mode 100664
> --- a/tools/testing/radix-tree/generated/autoconf.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#include "bit-length.h"
> -#define CONFIG_XARRAY_MULTI 1

So, the patch removes autoconf.h file from that directory.  The
"extended header" part between "diff --git" and "--- a/..." has
"deleted file mode 100664" and that is where the warning comes.

I do not quite recall at which point "git quiltimport" calls "git
apply", but the "has type 100644, expected 100664" does ring a bell.

> after quiltimport:
>
> hp2:/usr/src/mm> ls -l tools/testing/radix-tree/generated/autoconf.h
> ls: cannot access 'tools/testing/radix-tree/generated/autoconf.h': No such file or directory

That is to be expected, if that patch was successfully applied, no?
After all, the patch you quoted above seems to be a removal of
autoconf.h from that path.

> I can't figure what I've done to make quiltimport (git-apply?) think that the file
> had 100644 permissions.  Maybe the lack of an index line tripped it up.

You said "That patch has", and I take it to mean that the input
material before "git quiltimport" touched it already had the
extended header that records the removal of a file whose mode is
100664?  

And lack of the index line is probably a red herring.  EVen if there
were an index line, it would just have recorded the two object names
(the blob object name of the original contents before removal,
followed by a double-dot "..", followed by all-0 to signal removal).
We do not read mode bits out of that line.

> (btw, "has type" should be "has permissions" in that message, no?)

If leading prefix 100 did not exist, yes, permissions would be more
appropriate, but if the prefix changed from 100644 to say 120000,
that would be a type change from plain blob to a symlink.  So "type"
is not quite wrong, either.
