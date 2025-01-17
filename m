Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87281F8685
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115884; cv=none; b=aS9w4UjRl0tv5M8TIjYLVnIb79DaqCZMsvg/f/lmo0FtKd8DcQ+Z+r4x4+WU2Q3UJoEIACfW58VUmHCYfNHpulnv2Xgnvm0JYINcMeStoG8SblP5i660VlK4Rgski+xsTbOhjI6wEsdZDn8EfWHzbR02yq7su0YZnsJtmqq3HTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115884; c=relaxed/simple;
	bh=C8ZaZt5wYL8lDD6MzA4llmPBF9+ieXSsl9UE8W8pv40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO3b4YoEtAqp0W6s1voPu0W1iwPEgX7zI3+HfyhNpLL0/f6Yjhsb9J5cDiVULOWVb/9Puh5mRcb4vmkKOxMQq02/28FV7ABFaVmZxgEpDD56jBTVZ0CoXfj836XH/0fOUOknYllbuJ7bJBxXZ3NQYF0W6lPqqEDc9iPPqn1mSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WevcOF0v; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WevcOF0v"
Received: (qmail 21722 invoked by uid 109); 17 Jan 2025 12:11:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=C8ZaZt5wYL8lDD6MzA4llmPBF9+ieXSsl9UE8W8pv40=; b=WevcOF0v0GDlEdUbOebXasSUQgVBwGdycx1qcAk3SEwWzCkbMabC1qErWP0IuLQ0vpeDORpMV768B3WdGhQfvmRQphvaw89+6ZwcrIr1zKHK3/wIS2HO3/yMjHSerjh5BaG3ptVotEicy5RDMfv1JaK3qPhQb6RTW29JDIBli04XQvgl0G1cgJZ68EzqRWcaO4SU0mm9YO89psQUJRIySKXkygMjzYAEWpWPkyppP1QYft62VFfspONDgHHpgJF2c6ucKm1W67gBHRBnF9Xau/hCO5/i9qQEEPJkO1qWuJFhkPYR8LXlV7KTE8ljDJrLkqT9XiOq6neca4mJGHYIIQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jan 2025 12:11:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7747 invoked by uid 111); 17 Jan 2025 12:11:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2025 07:11:21 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jan 2025 07:11:21 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git crashes with a SIGBUS on sparc64 during pull
Message-ID: <20250117121121.GA2356599@coredump.intra.peff.net>
References: <xd6Mn7uXpDxaT8zF28BwOIdV98lnvm3S0rBgxmm97nuRW3z0GQSUi_KeYe0fUuRfz8rCgo6Uialw5rnraqp5tjzMFQkFH0MZV_n4fEQg8go=@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xd6Mn7uXpDxaT8zF28BwOIdV98lnvm3S0rBgxmm97nuRW3z0GQSUi_KeYe0fUuRfz8rCgo6Uialw5rnraqp5tjzMFQkFH0MZV_n4fEQg8go=@protonmail.com>

On Fri, Jan 17, 2025 at 03:30:09AM +0000, Koakuma wrote:

> re: unpack-objects, I don't know how to specifically trigger that code,
> but I know that once `unpack-objects` is triggered it will reliably crash
> with the error above.

Perhaps:

  git init repo
  cd repo
  git commit --allow-empty -m foo
  git repack -ad
  pack=$(ls .git/objects/pack/*.pack)
  dd if=$pack of=no-header.pack bs=1 skip=12
  # don't bother parsing the first 12 bytes; we know it is
  # a version 2 pack with 2 objects
  git unpack-objects --pack_header=2,2 <no-header.pack

would be a minimal reproduction?

> According to gdb, the crash happens on this line:
> #0  0x000001000019ca18 in cmd_unpack_objects (argc=<optimized out>, argv=0x1000063a4e0, prefix=<optimized out>, repo=<optimized out>) at builtin/unpack-objects.c:653
> 653					hdr->hdr_signature = htonl(PACK_SIGNATURE);
> 
> Overaligning the `buffer` declaration in the same file to try to get around
> possible alignment issues seems to be able to prevent the crash,
> but I don't know if it would be a proper fix for it.

Interesting. We are pretty cavalier about casting mmap'd buffers to
structs in order to read pack headers (since the format is designed to
be 4-byte aligned).

But in this case we are _writing_ into a buffer through the cast
structure (our caller has already parsed the header, so we are
reconstructing it). So we are relying on the alignment of a static
"unsigned char" in the data section.

Which certainly seems sketchy, though it is kind of interesting that it
has never been a problem before (and the code has been this way for
decades). At any rate, the fix is probably this (and we'd want the same
in index-pack, too, I'd think):

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2197d6d933..288cecf98f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -645,18 +645,20 @@ int cmd_unpack_objects(int argc,
 				continue;
 			}
 			if (starts_with(arg, "--pack_header=")) {
-				struct pack_header *hdr;
+				unsigned char *hdr = buffer;
 				char *c;
 
-				hdr = (struct pack_header *)buffer;
-				hdr->hdr_signature = htonl(PACK_SIGNATURE);
-				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));
+				put_be32(hdr, PACK_SIGNATURE);
+				hdr += 4;
+				put_be32(hdr, strtoul(arg + 14, &c, 10));
+				hdr += 4;
 				if (*c != ',')
 					die("bad %s", arg);
-				hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
+				put_be32(hdr, strtoul(c + 1, &c, 10));
+				hdr += 4;
 				if (*c)
 					die("bad %s", arg);
-				len = sizeof(*hdr);
+				len = hdr - buffer;
 				continue;
 			}
 			if (skip_prefix(arg, "--max-input-size=", &arg)) {
