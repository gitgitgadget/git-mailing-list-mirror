Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FRnenV8D"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26DA124
	for <git@vger.kernel.org>; Sun, 26 Nov 2023 16:58:57 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8924B36F47;
	Sun, 26 Nov 2023 19:58:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zD0H9jDomL6W3txgaxC5eVen27Aoqe/RZIC7DT
	dN+lQ=; b=FRnenV8DN9WrPis4NUYI4JNjpRs8joCuLZLgldzP1vmzIhMak8WSqy
	b/6FEjleQefsO8pTfuKX54vlPMvYEEhdkvtBUWgCCvFeYgbExrSf+unrPmc/NeQ4
	lfFfE5XnVKidb/aMYDKNnQrCGVUmaJdBrZ40YPNEeL/5HZMz2qh7M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 81A7436F46;
	Sun, 26 Nov 2023 19:58:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24A9036F45;
	Sun, 26 Nov 2023 19:58:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "H.Merijn Brand" <linux@tux.freedom.nl>
Cc: git@vger.kernel.org
Subject: Re: Fix git-send-email.perl w.r.t. recent Getopt::Long update
In-Reply-To: <20231124103932.31ca7688@pc09> (H. Merijn Brand's message of
	"Fri, 24 Nov 2023 10:39:32 +0100")
References: <20231124103932.31ca7688@pc09>
Date: Mon, 27 Nov 2023 09:58:52 +0900
Message-ID: <xmqqzfz03tbn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 22DE5FDA-8CC0-11EE-929B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"H.Merijn Brand" <linux@tux.freedom.nl> writes:

> From the Getopt::Long changes:
> ```
> Changes in version 2.55
> -----------------------
> * Fix long standing bug that duplicate options were not detected when
>   the options differ in case while ignore_case is in effect.
>   This will now yield a warning and become a fatal error in a future
>   release.
> ```
>
> Current version is 2.57

This patch looks like duplicate of

  https://lore.kernel.org/git/20231116193014.470420-1-tmz@pobox.com/

perhaps independently discovered and worked on.  Thanks for caring.

One downside of unconditional upgrade of the call is, of course,
that it would no longer work for those with older Getopt::Long that
did not support the "!" suffix.  Fortunately, Getopt::Long 2.33
started shipping with Perl 5.8.1 that is more than 20 years old, so
with the series we accepted, we also have a change to bump the
required version of Perl from 5.8.0 to 5.8.1 to make it clear that
it is deliberate that we drop the support for anything older at the
same time.

