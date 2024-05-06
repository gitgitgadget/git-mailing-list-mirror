Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DA1581F6
	for <git@vger.kernel.org>; Mon,  6 May 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013643; cv=none; b=cGgGCW/IlygoqCZry2HdMQ7gxQWjScLvT/ilVDmCM3mJP9mjiTNQurCIwC35icA5N8SCHaHQgpqOU1IwX+Zqlvk+IsPiowYzmHlkx+4SCE99v0x3ayzwZz7BfZqiDk6nT8m/YFfOsB+OCU9EgAGdcQZZ7gKMw2NSJxbZqafSmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013643; c=relaxed/simple;
	bh=bWAatdR+q7cKw+QU+DXLtF9dUv2AkTo7Ox15y27UcAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mGiRc3jeNQU5rTNKiG1UTeHRdGsxcYwv5AhlHVfwCd3bsz/d6fj0lJ0liTzHcipdMaghDrcLM2EJTi2uZhjmhQG9zlbZstZfEPv+GnefVs0pLDqoVYP2SsArOjxX36/ng4Bxh7uTRjjIyVQkeBqtDvS0jLYe93FfpRN5EjlAaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WhXrbsNy; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WhXrbsNy"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 894DD2CF99;
	Mon,  6 May 2024 12:40:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bWAatdR+q7cK
	w+QU+DXLtF9dUv2AkTo7Ox15y27UcAc=; b=WhXrbsNyOAQ/XOh/dxYXEnGLcTv0
	1vS6jCbLLylwvXji2Hlad+dTnJROZCh27SML8/GP4jotuYB4TVKeIicU/pku75rn
	uyM6qhG3ObUCQSSEWd6V3mdv5Q86PEV7VhhN33B1yiUa7YnUGMh56mT6LuhHPdyU
	OvBXvj619rDKerQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 818552CF98;
	Mon,  6 May 2024 12:40:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E63632CF97;
	Mon,  6 May 2024 12:40:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Dragan Simic
 <dsimic@manjaro.org>,  James Liu <james@jamesliu.io>,  git@vger.kernel.org
Subject: Re* Re* [PATCH v4 0/3] advice: add "all" option to disable all hints
In-Reply-To: <34d77e4d-6edb-99d0-7fc5-fea5224654c7@gmx.de> (Johannes
	Schindelin's message of "Sun, 5 May 2024 13:03:35 +0200 (CEST)")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
	<ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org>
	<xmqqjzka7p2t.fsf_-_@gitster.g>
	<CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
	<xmqqbk5m65i8.fsf@gitster.g> <xmqq4jbe64l9.fsf@gitster.g>
	<CAPig+cT-xk13jGEUmpT5QmwVYTxKNUZsu9xJ=Ph3h4AzKHg6pA@mail.gmail.com>
	<34d77e4d-6edb-99d0-7fc5-fea5224654c7@gmx.de>
Date: Mon, 06 May 2024 09:40:31 -0700
Message-ID: <xmqqbk5i3ncw.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5B474B76-0BC7-11EF-B897-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That difference in certainty is the entire reason why I contend that
> `range-diff` and `format-patch --range-diff` need different defaults fo=
r
> the creation factor.
>
>> > A similar thread was raised more recently:
>> >
>> >  https://lore.kernel.org/git/rq6919s9-qspp-rn6o-n704-r0400q10747r@tz=
k.qr/
>>
>> I think I missed this thread.
>
> Heh. I had forgotten about it.

So what's the conclusion of this discussion (have we reached one
yet)?

to me it sounds like everybody is on board to raise the default used
for format-patch.  In the old thread I said "I use something
unreasonably high like 9999", but my "unreasonably high" number
these days is 999, which was used in the earlier weatherbaloon
patch.  The old thread ended with an academic "we know different
defaults are appropriate, but what is the right number then?" but
anything higher (like 999 or even 9999) is better than the default
for range-diff which is 60, I would think.

Here is the patch, this time with a bit of documentation stolen from
the old weather-balloon by =C3=86var.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] format-patch: run range-diff with larger creation-factor

We see too often that a range-diff added to format-patch output
shows too many "unmatched" patches.  This is because the default
value for creation-factor is set to a relatively low value.

It may be justified for other uses (like you have a yet-to-be-sent
new iteration of your series, and compare it against the 'seen'
branch that has an older iteration, probably with the '--left-only'
option, to pick out only your patches while ignoring the others) of
"range-diff" command, but when the command is run as part of the
format-patch, the user _knows_ and expects that the patches in the
old and the new iterations roughly correspond to each other, so we
can and should use a much higher default.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt | 5 +++++
 builtin/log.c                      | 2 +-
 range-diff.h                       | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-forma=
t-patch.txt
index 728bb3821c..b72f87b114 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -346,6 +346,11 @@ material (this may change in the future).
 	between the previous and current series of patches by adjusting the
 	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
 	for details.
++
+Defaults to 999 (the linkgit:git-range-diff[1] uses 60), as the use
+case is to show comparison with an older iteration of the same
+topic and the tool should find more correspondence between the two
+sets of patches.
=20
 --notes[=3D<ref>]::
 --no-notes::
diff --git a/builtin/log.c b/builtin/log.c
index c0a8bb95e9..73608ffef9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2274,7 +2274,7 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	}
=20
 	if (creation_factor < 0)
-		creation_factor =3D RANGE_DIFF_CREATION_FACTOR_DEFAULT;
+		creation_factor =3D CREATION_FACTOR_FOR_THE_SAME_SERIES;
 	else if (!rdiff_prev)
 		die(_("the option '%s' requires '%s'"), "--creation-factor", "--range-=
diff");
=20
diff --git a/range-diff.h b/range-diff.h
index 04ffe217be..2f69f6a434 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -6,6 +6,12 @@
=20
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
=20
+/*
+ * A much higher value than the default, when we KNOW we are comparing
+ * the same series (e.g., used when format-patch calls range-diff).
+ */
+#define CREATION_FACTOR_FOR_THE_SAME_SERIES 999
+
 struct range_diff_options {
 	int creation_factor;
 	unsigned dual_color:1;
--=20
2.45.0-31-gd4cc1ec35f

