Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D61F03FF
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354426; cv=none; b=ljPpZH1gYVcXG9rWwsuWNEiqfNE0H5sw0qTNzXdSl3Bdy87/+6lAnaRdX2FcFcgXCkdFsYrp18+coeo2cz2YbBtv+lhRNkY6ZqM2vJq4Bh5GWyE5Ghi5mnGUWNZ//aazfDk0E6/rijSDtTKEl0A2ync6Aroj82gK09iPwdFeUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354426; c=relaxed/simple;
	bh=QxF2+CjD4jMo/zwEN0N3n/605xM1M3e09g3oefzcEIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV4grnl/sdJ7QgY6Ftoj80OaeoF3aatTQtmymsyiKiZPE7m3/FF9RyuWiMYwFIiTuX86sFeFlorrTvyW54VcnuFytstOk5glQFQ/akNnOg+13iK0YPMB9tiFC38VhfnHDENVC7D9en6tZZzk4b1HNuATLuzl3jtPgH+4LUC9Hps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MKNLJAPs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MKNLJAPs"
Received: (qmail 18650 invoked by uid 109); 4 Dec 2024 23:20:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QxF2+CjD4jMo/zwEN0N3n/605xM1M3e09g3oefzcEIs=; b=MKNLJAPsHaRDYlmPHKHblG2+OqaL7ceDibCkv5oAJwbD6dEjzKzWaO+8/hImCGQgGZF1BPHlN7A7xe5U5iT3A40KUyoAA51MKCRxO1WeBjdgjx+vsEmxqcXIlvOTpOyvh4lHO1ZgcBlfT0aDJxKH+2qBk26p/xi8Q49oSSaherGFsTukNb7c0Lw8JJ5vqymTiiQOM64kB5jDksBXHN2Y99Qp874rSoc01VKWBiIXDQTav3B6Q5JLuS/3o2q0hOE2nO1bjGqzrbCWnGYnVP+/entTaUXsl05n3dobwj0luCgSp9Lk1tqrK63wR/QxeSGi2GVmCk/KtyPxz9/p3whVIg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Dec 2024 23:20:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28078 invoked by uid 111); 4 Dec 2024 23:20:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Dec 2024 18:20:16 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Dec 2024 18:20:16 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Benno Evers <benno.martin.evers@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Benno Evers <benno@bmevers.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 0/4] perf improvements for git-describe with few tags
Message-ID: <20241204232016.GA1460459@coredump.intra.peff.net>
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
 <87bjz0k17c.fsf@prevas.dk>
 <20241031114210.GA593548@coredump.intra.peff.net>
 <20241031122456.GB593548@coredump.intra.peff.net>
 <20241031144351.GA1720940@coredump.intra.peff.net>
 <CAEQVFRFWT02QTL7PTf84p6AAferijHx8L_Tu6ON1H7U=iEdb3A@mail.gmail.com>
 <20241106192236.GC880133@coredump.intra.peff.net>
 <xmqqldx61t65.fsf@gitster.g>
 <fxbv4ihz4sgdfwtq4vkadntank2lzwkt6abgipuojhumjmuxjs@fegutv3kcamo>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fxbv4ihz4sgdfwtq4vkadntank2lzwkt6abgipuojhumjmuxjs@fegutv3kcamo>

On Wed, Dec 04, 2024 at 03:04:59PM -0800, Josh Steadmon wrote:

> This breaks the case of `git describe --always $SOME_HASH` (we hit the
> die at builtin/describe.c:340) when there are no tags in the repo. I can
> send a test case and a small fix shortly.

Yeah, this is easy to reproduce. I think it was always broken with:

  git describe --candidates=0 --always ...

since there is a line that skips the whole algorithm and bails early if
there are no candidates allowed. But that should surely not kick in if
"always" is set. I.e., I'd expect the fix to be something like:

diff --git a/builtin/describe.c b/builtin/describe.c
index d6c77a714f..d4c869e3d5 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -332,7 +332,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		return;
 	}
 
-	if (!max_candidates)
+	if (!max_candidates && !always)
 		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
 	if (debug)
 		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));

But I'll wait and see what your proposed fix looks like.

-Peff
