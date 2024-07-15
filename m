Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CE18F2C5
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055914; cv=none; b=KxWWhp9GRUVCDGaefKAYZC0jG6NyInc/LibshojgIpBmQuBlqUdaeq9AitP3XpZPjcDYUtVmBUECmiup5mwnR4Ez75yJUKxipgCSpdUqSHqtkK72wRvmSATvui01b/1A3UjrQkhWTPvuzktbFUOOlbEpmDPquovkU/YJW049nYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055914; c=relaxed/simple;
	bh=rJtILh14uj4Y+ES4kP+A/X5DLafE3QxaxCj621El3GE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GVSqsrNz2weehvnIYUuGH7NqKMmJei29VcaciKkQPghE+PlSz0gVGRB2reH/k9UXxQXa5QOG8eYO3C/2kKLhK1lzuBy+DTNWAtTowldq6VRpN26/eC/uSJQG9Wit8AOufhxO5KThjzxG4M++de6XzO0sA7rrJ0mMt9n28NWSDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NAkE71RL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NAkE71RL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 50F60215A8;
	Mon, 15 Jul 2024 11:05:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rJtILh14uj4Y+ES4kP+A/X5DLafE3QxaxCj621
	El3GE=; b=NAkE71RLYuTWz/4/L+pAnKVnIpwEpk4D+5+olFPPVYoIF/qQ/V3BKM
	lhyPkWc8m1qKbAzeCl6WLjpXcL+EvXv+I+woljtN+RwgLHj1Vn1egoYAsoPGOeBQ
	hsTAfNiph48rBfwlBgrmaCDTGQxFvgMXZgkZdk/NmVe/59XiDRATk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 49C42215A7;
	Mon, 15 Jul 2024 11:05:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 93ED7215A2;
	Mon, 15 Jul 2024 11:05:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
In-Reply-To: <ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 14 Jul 2024 18:15:31 +0000")
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
	<xmqq8qy4adl4.fsf@gitster.g>
	<001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>
	<xmqqttgr9aeb.fsf@gitster.g>
	<ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>
Date: Mon, 15 Jul 2024 08:05:00 -0700
Message-ID: <xmqq1q3u8zmr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9CA5DC42-42BB-11EF-87D7-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't think this is the right approach.  Every version of ksh
> _except_ AT&T ksh works just fine here. ... AT&T ksh is
> considering adding local in a newer version for this reason.

Thanks.  That is nice to know, though unfortunately I didn't see
signs of them making much progress.

Let's not make or change any policy but just document what we found
to help the next person.

------ >8 ----------- >8 ----------- >8 ------
Subject: [PATCH] doc: note that AT&T ksh does not work with our test suite

The scripted Porcelain commands do not allow use of "local" because
it is not universally supported, but we use it liberally in our test
scripts, which means some POSIX compliant shells (like "ksh93") can
not be used to run our tests.

Document the status quo, to help the next person who gets perplexed
seeing our tests fail.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1d92b2da03..94ca5cf7c0 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -185,8 +185,8 @@ For shell scripts specifically (not exhaustive):
 
  - Even though "local" is not part of POSIX, we make heavy use of it
    in our test suite.  We do not use it in scripted Porcelains, and
-   hopefully nobody starts using "local" before they are reimplemented
-   in C ;-)
+   hopefully nobody starts using "local" before all shells that matter
+   support it (notably, ksh from AT&T Research does not support it yet).
 
  - Some versions of shell do not understand "export variable=value",
    so we write "variable=value" and then "export variable" on two
-- 
2.46.0-rc0-140-g824782812f

