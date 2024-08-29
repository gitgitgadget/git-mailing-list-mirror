Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8981B1513
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943631; cv=none; b=ppZfjh6TCW/gEuG0Occ2OSgzf8lGuX5M1peJzK/RcshEHKJC7Z/zuw62aKSp3DP+73/bEYt+p2fy62oLA67JxLigAaNu36duzS3j42jYcfgVrPhkFDwEKfX7uKNUl8qAbWl/Yd1AaaaKroxr35jciuBMVmgNruCHgtvB4K3Obzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943631; c=relaxed/simple;
	bh=PtAztH7OeAfCQpNB/t/14fZVBQUMaGq+RAG4Rv3sc5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rzIl6WDIyvpEtUzNiy0HYham0/UN0IbOfKAEvOq1pu4iaRWQ+gCwkS/Zyzf85IjQBnh0XCloh4cp+FhlV33/CpmMcMuEc0Ie809B3jcMyWKQbNyjEGkLfJ6M1BbcSo+cyKouoPvI7o/pgat2grHURu866q/exSou17xvqZ1/+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kvmo1FxR; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kvmo1FxR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19E38220DF;
	Thu, 29 Aug 2024 11:00:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PtAztH7OeAfCQpNB/t/14fZVBQUMaGq+RAG4Rv
	3sc5Y=; b=Kvmo1FxROjswI0onUImM+Jz5VFT1nxZwLwxNKY2qKeDMv1MdoNyHk6
	QzJtZ4ZwfsaqNzPi703R2kZTaDnzxgkW5NSFvYJaU6f9Lp2osOBulsIBsm4ryUO0
	AOqgPnzHAFlov5eXGFGU91xJnpoKiqvtq8TW1YtknV+xjDu5Gk5TA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C774B220DE;
	Thu, 29 Aug 2024 11:00:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AABE2220DD;
	Thu, 29 Aug 2024 11:00:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: [PATCH 8/6] CodingGuidelines: also mention MAYBE_UNUSED
In-Reply-To: <20240829040215.GA4054823@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 29 Aug 2024 00:02:15 -0400")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <Zs348uXMBdCuwF-2@ArchLinux>
	<xmqqbk1cz69c.fsf@gitster.g>
	<20240829040215.GA4054823@coredump.intra.peff.net>
Date: Thu, 29 Aug 2024 08:00:19 -0700
Message-ID: <xmqqseunxtks.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 69CEF6F8-6617-11EF-8DBC-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, Aug 28, 2024 at 02:28:47PM -0700, Junio C Hamano wrote:
>
>> By the way, Peff, do we have MAYBE_UNUSED that can be used in a case
>> like this one?  Platforms without symbolic links supported may well
>> define NO_SYMLINK_HEAD, which makes the incoming parameters unused.
>
> Yes, it would be fine to use MAYBE_UNUSED in a case like this.

It turns out that I was, without realizing it myself, making an
oblique reference to your patch 7/6 ;-)

Perhaps something along this line?

---- >8 ----
Subject: CodingGuidelines: also mention MAYBE_UNUSED

A function that uses a parameter in one build may lose all uses of
the parameter in another build, depending on the configuration.  A
workaround for such a case, MAYBE_UNUSED, should also be mentioned
when we recommend the use of UNUSED to our developers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines |  5 +++--
 git-compat-util.h              | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index d0fc7cfe60..3263245b03 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -262,8 +262,9 @@ For C programs:
    like "error: unused parameter 'foo' [-Werror=unused-parameter]",
    which indicates that a function ignores its argument. If the unused
    parameter can't be removed (e.g., because the function is used as a
-   callback and has to match a certain interface), you can annotate the
-   individual parameters with the UNUSED keyword, like "int foo UNUSED".
+   callback and has to match a certain interface), you can annotate
+   the individual parameters with the UNUSED (or MAYBE_UNUSED)
+   keyword, like "int foo UNUSED".
 
  - We try to support a wide range of C compilers to compile Git with,
    including old ones.  As of Git v2.35.0 Git requires C99 (we check
diff --git c/git-compat-util.h w/git-compat-util.h
index 71b4d23f03..23307ce780 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -195,6 +195,17 @@ struct strbuf;
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
+/*
+ * UNUSED marks a function parameter that is always unused.
+ *
+ * A callback interface may dictate that a function accepts a
+ * parameter at that position, but the implementation of the function
+ * may not need to use the parameter.  In such a case, mark the parameter
+ * with UNUSED.
+ *
+ * When a parameter may be used or unused, depending on conditional
+ * compilation, consider using MAYBE_UNUSED instead.
+ */
 #if GIT_GNUC_PREREQ(4, 5)
 #define UNUSED __attribute__((unused)) \
 	__attribute__((deprecated ("parameter declared as UNUSED")))
@@ -649,6 +660,16 @@ static inline int git_has_dir_sep(const char *path)
 #define RESULT_MUST_BE_USED
 #endif
 
+/*
+ * MAYBE_UNUSED marks a function parameter that may be unused, but
+ * whose use is not an error.
+ *
+ * Depending on a configuration, all uses of a function parameter may
+ * become #ifdef'ed away.  Marking such a parameter with UNUSED would
+ * give a warning in a compilation where the parameter is indeed used,
+ * and not marking such a parameter would give a warning in a
+ * compilation where the parameter is unused.
+ */
 #define MAYBE_UNUSED __attribute__((__unused__))
 
 #include "compat/bswap.h"
