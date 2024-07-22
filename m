Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4541C6A8
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683550; cv=none; b=AGunX9YZkQOb/PJBnTAowGtxmYuAlFgNPxxOISvkPY2FasYUIwtv+fSzWzn2pJp1DleXAj9mALKfZtlrg6bIfyGHN3zB9jwnEStuGIhq/DDgPhF0ajzRC7smW1KHlnRrf4q/b29J5nFro+0+N+42XEAiakDxW3pgVOBnc6Fi4xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683550; c=relaxed/simple;
	bh=9dU8QNOav11WSAZLt56RqjAXS4WlR0vER7d2Exkb7/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hDd6HpQ+rLkHYEZvQBgpc9EMjvbFiSxkjnhV1cFkmB4+6/lNtUxagXblghIwOFSgacNtHyVPlxRhf5+UAuYCphwHGWGxWgvk334+Hek3AAteCUL0tvkGEURx9nc0q0CWb6PuveEKvGhmxUrJTr3LatpwiTRPL+T5+an1Pg93Oig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QrXG5Hjp; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QrXG5Hjp"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A94FC3A2F6;
	Mon, 22 Jul 2024 17:25:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9dU8QNOav11W
	SAZLt56RqjAXS4WlR0vER7d2Exkb7/8=; b=QrXG5HjpnuGRY4uTaI30a47eiFEJ
	LQ3QDJg9tZcVZK5mgXNUtPqyTQT7RCEoT6xP1GKd+uonaA1GU3G3Puoz0uZF7fkO
	R8umQAio1NnYugbNRA4Zvj/r7UmaDiDzzE9ghkM297kJjvOQGbnGUo2CUFJIlZnp
	VSzNSeVdOWCe2ic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F4EF3A2F5;
	Mon, 22 Jul 2024 17:25:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 059E23A2F4;
	Mon, 22 Jul 2024 17:25:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
In-Reply-To: <079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 22 Jul 2024 21:06:02 +0200")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
	<a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
	<xmqqv80xcpe5.fsf@gitster.g>
	<079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com>
Date: Mon, 22 Jul 2024 14:25:45 -0700
Message-ID: <xmqq7cdd9l0m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F5E05958-4870-11EF-8AB8-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> To fix the test, as already said, we need this:
>
> 	test_write_lines P q |
> 	(
> 		GIT_PAGER=3D"head -n 1" &&
> 		export GIT_PAGER &&
> 		test_terminal git add -p >actual
> 	)

This took sufficiently large amount of collective braincycles, and
it would be worth documenting as a separate patch, I would suspect.

Something along the following lines, but please take the authorship
*and* give it a better explanation.

Thanks.

--- >8 ---
Subject: [PATCH] t3701: avoid one-shot export for shell functions

The common construct

    VAR=3DVAL command args

to temporarily set and export environment variable VAR only while
"command args" is running is handy, but one of our CI jobs on GitHub
Actions uses Ubuntu 20.04 running dash 0.5.10.2-6 failed with the
construct, making only a temporary assignment without exporting the
variable, when command is *not* an external (in this case, a shell
function).

The "git add -p" being tested did not get our custom GIT_PAGER,
which broke the test.

Work it around by explicitly exporting the variable in a subshell.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3701-add-interactive.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index c60589cb94..1b8617e0c1 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -616,7 +616,11 @@ test_expect_success TTY 'P handles SIGPIPE when writ=
ing to pager' '
 	test_when_finished "rm -f huge_file; git reset" &&
 	printf "\n%2500000s" Y >huge_file &&
 	git add -N huge_file &&
-	test_write_lines P q | GIT_PAGER=3D"head -n 1" test_terminal git add -p
+	test_write_lines P q | (
+		GIT_PAGER=3D"head -n 1" &&
+		export GIT_PAGER &&
+		test_terminal git add -p
+	)
 '
=20
 test_expect_success 'split hunk "add -p (edit)"' '
--=20
2.46.0-rc1-48-g0900f1888e

