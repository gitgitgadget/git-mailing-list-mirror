Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B0282FA
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720976417; cv=none; b=G+0CfdhYRvTbVZEOmVvnWftDdvQIUX36tiiCYeHLmZIncstid/gxWcdziHfeg/tj1vA9qB3xL4stisWWA4xlsL5F8bTz3l9eOCLfburOwgUf1zL/Syp/TmBnREPZ8t1gq0EgpH83YZKmuX8nsG8nvlXHwo2ZAlIsA5G4x+79CFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720976417; c=relaxed/simple;
	bh=wS+CXvtI2Tu01tluqu7jnV3MPoGnDM4adis9BKZC+mM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A58clEhtvgD4KHAa9LHMkz434pht8wi460qrrDd57KhQYfhKBRA1s6Ijgio6fHfnkawFBdRf62jqa3dJtIcH2OH8F9GbaQY6aGWgGx1MTgsf1UbKVQImxX7VwDQexJqZMx3B+NWcRtRD+aBNvnM4LuYBkTI0tpbhjm4JvfaHuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gFzPiKkO; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gFzPiKkO"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67E1527CF1;
	Sun, 14 Jul 2024 13:00:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wS+CXvtI2Tu01tluqu7jnV3MPoGnDM4adis9BK
	ZC+mM=; b=gFzPiKkOpf6A2GIRpjjNRgWh/0cyk8eB8663itYRT3l8gCH+ca43La
	x6HwY+Nu+7rHUM66LaIc430LfRV7miq6PMU4WE79J7AoWR7sxVUSzA3Kk2uoYg5t
	Dd7TKETFjH0M+do9mjQzmDzo+vICLZwPqaOKM3KUZ7aYmWlU1Tteg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C9E227CED;
	Sun, 14 Jul 2024 13:00:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 995C827CEA;
	Sun, 14 Jul 2024 13:00:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
In-Reply-To: <001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Sun, 14 Jul 2024 09:29:41
	-0400")
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
	<xmqq8qy4adl4.fsf@gitster.g>
	<001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>
Date: Sun, 14 Jul 2024 10:00:12 -0700
Message-ID: <xmqqttgr9aeb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8986D6F2-4202-11EF-B82E-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

<rsbecker@nexbridge.com> writes:

> This looks like a different between ksh and bash. Under bash, the test
> works. I can live with that but will have to force bash to be used as the
> shebang #!/bin/sh defaults to ksh on this box.

It turns out that the version of ksh I used in my description does
not seem to grok "local" at all. I vaguely recall that we've written
off various hobbist reimplementation of ksh as unusable enough, but
this one is ksh93 direct from AT&T Research.

I guess when we said "as long as we limit our use to a simple 'this
variable has visibility limited to the function and its children'
and nothing else, it is portable enough across practically everybody
we care about", we have written off the real ksh, too.

In the meantime, we may want to document this in a more prominent
way.  Perhaps like so:

-------- >8 --------------- >8 --------------- >8 --------
Subject: doc: guide to use of "local" shell language construct

The scripted Porcelain commands do not allow use of "local" because
it is not universally supported, but we use it liberally in our test
scripts, which means some POSIX compliant shells (like "ksh93") can
not be used to run our tests.

Document the status quo, and hint that we might want to change the
situation in the fiture.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 4 +++-
 t/README                       | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 1d92b2da03..68b7210f48 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -186,7 +186,9 @@ For shell scripts specifically (not exhaustive):
  - Even though "local" is not part of POSIX, we make heavy use of it
    in our test suite.  We do not use it in scripted Porcelains, and
    hopefully nobody starts using "local" before they are reimplemented
-   in C ;-)
+   in C ;-) Notably, ksh (not just reimplementations but the real one
+   from AT&T Research) does not support "local" and cannot be used,
+   which we might want to reconsider.
 
  - Some versions of shell do not understand "export variable=value",
    so we write "variable=value" and then "export variable" on two
diff --git c/t/README w/t/README
index d9e0e07506..1d39d8cfd5 100644
--- c/t/README
+++ w/t/README
@@ -850,6 +850,14 @@ And here are the "don'ts:"
    but the best indication is to just run the tests with prove(1),
    it'll complain if anything is amiss.
 
+ - Don't overuse "local"
+
+   Because strictly POSIX-compliant shells do not have to support
+   "local", we avoid using it in our scripted Porcelain scripts, but
+   we have allowed use of "local" in test scripts.  We may want to
+   reconsider this and rewrite our tests to also run on shells like
+   ksh93.  Do not add new use of "local" unnecessarily.
+
 
 Skipping tests
 --------------
