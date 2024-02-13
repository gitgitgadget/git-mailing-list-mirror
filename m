Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E45FB97
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843026; cv=none; b=FrcMCAeAzaCNIWTurFKLzMWlz+31G27z0S8ISnLrsHsfNo/2LYBKyPkSdeUZ7pEVCB8TColxvcq0JeEFpP+UMvoD80kEu8hfkQHmgaFgvI38DvJevSJaDurkaEbd9PFF/jDIaRUHOvm1I6U4RTrPmSPssNc9oJu5QdjX9Y1Cq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843026; c=relaxed/simple;
	bh=bRwCaD1tcZSmxO1pdd8cpgHpez8CDRws0tJT2kx/hAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HImC+UPNg4IKJpGIXs/5RYfjT5GnBMQm2jvHv7eFEgs6BRItJMqzr+PAZskQ3fiaPcFRxefTiR/X7WZci7ybK0iwFEwedzg32h/2uaTzBr4staGUbfqTh2nrUGHNPPwjnnx02UeQJ0flPmMf2Rqlln940Hi14SnBJWx7FaPyYQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IypebZoa; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IypebZoa"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3ADE31C4F27;
	Tue, 13 Feb 2024 11:50:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bRwCaD1tcZSmxO1pdd8cpgHpez8CDRws0tJT2k
	x/hAY=; b=IypebZoaGUCqGFPoKTWJjapIADuxPAjQGai2ffluytMjwJeSTt+KQP
	ZWRbO+M7CA+1pFxoJu7T9UDBxfcGX4GoaM80EjFjKTLL9R3Jflx79rLE7Q7Ykze1
	/URLnCqoivice0IttJ5lEv8indzshpVfHCwS6a2+++AEV32qVPhMQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 322891C4F25;
	Tue, 13 Feb 2024 11:50:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92EC01C4F24;
	Tue, 13 Feb 2024 11:50:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: libification: how to avoid symbol collisions?
In-Reply-To: <CAO_smVizKLL2NHFBpszJn+ieJhCEZyvvOT-BWv6Oz5pGiafPVg@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 12 Feb 2024 18:48:26 -0800")
References: <CAO_smVji5aGjx1V-EGbumRRpOuGY0SkXZUn9g4LxKmMO3aw=Sg@mail.gmail.com>
	<xmqqil2ximxq.fsf@gitster.g>
	<CAO_smVizKLL2NHFBpszJn+ieJhCEZyvvOT-BWv6Oz5pGiafPVg@mail.gmail.com>
Date: Tue, 13 Feb 2024 08:50:15 -0800
Message-ID: <xmqqr0hg8g1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6E1A0E6-CA8F-11EE-B955-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> struct/enum/typedef/union names. That's going to be quite annoying to
> maintain; even if we don't end up having to do all 3,500 symbols, for
> the files that are part of some public library, we'd add maintenance
> burden because we'd need to remember to either make every new function
> be static, or add it to this list. I assume we could create a test
> that would enforce this ("static, named with <prefix>, or added to
> <list>"), so the issue is catchable, but it will be exceedingly
> annoying every time one encounters this.

No matter how we do this, we'd need to maintain that list, so the
choices are between "#define" and "objcopy --redefine-sym" if we
limit ourselves to static linking, I think.  The former may be more
portable but makes me feel dirty.  The debuggers will not see the
names we want to use, for one thing.  "rename selected symbols in *.o
files" approach, if it can be done on platforms we want the lib thing
on, would be more preferable.

We also should be able to create a single linkable object (e.g., Z.o
out of X.o and Y.o from the previous example---it could be Z.so that
is dynamically linked at runtime) to resolve the symbols that need
to be shared only among the object files (like "foo" that is defined
in X.o whose address is needed in Y.o) and after such a linking is
done, these "internal" symbols can be stripped away from the
resulting object file.  For that, we'd also need to maintain that
list of internal symbols that are needed in order to link our
objects together.
