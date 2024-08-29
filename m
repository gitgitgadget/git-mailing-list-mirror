Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4314B086
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955492; cv=none; b=TuuC1DWxPrHRnw2nOj2/EyyOfaH1O/swPalsaP3mE25ZueKIgw9YGWS1sfpb8vZmbQane9RB4/z3R/kUOdP92LW6NRFD8NrX8v6MaE5X999MkR32ce9eB3WTWmd18YvbDzIepEGDHLbW0F1DWrbJyo+DKCz0r4DSRhrspdJRQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955492; c=relaxed/simple;
	bh=bf+nf+obNI2xRq0a+U4YwRES0cVoSpJbnXhuVPHIHnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f81j35w4Pj5Es7cXJLervc/0sVzEqp2TMpCQJqXgX3T/CbK34Y6/iNseQu1OosyxVTaq+4dhl269lETEj0v1u61YXV0e6smEfiVfznRVkMewNxM0kj2Qv6H2UKilLG514YJAUQ9q7sEK+mGDkcDLtySgWlMKl5SHhq7HW3UbWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VryQf6jK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VryQf6jK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 065542425B;
	Thu, 29 Aug 2024 14:18:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bf+nf+obNI2xRq0a+U4YwRES0cVoSpJbnXhuVP
	HIHnE=; b=VryQf6jKfLtsW/U66+bMl7Oidfn2+QXTFqZBu3OBnuBcfMqt6N3Q2L
	rainXvPiTaHeYLbMcOWgskVtbBBSy78wo0u2JG+2YWcOrnSXCK4SEQqtx36SGvJG
	yoZ5qR54oT7eHikCVtgy4BbwmG7ESgnlRzZjrEXvTKtvhASXqRPQE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D078A2425A;
	Thu, 29 Aug 2024 14:18:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40AEF24259;
	Thu, 29 Aug 2024 14:18:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: [PATCH v2] CodingGuidelines: also mention MAYBE_UNUSED
In-Reply-To: <xmqq8qwfw6e9.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	29 Aug 2024 11:06:22 -0700")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <Zs348uXMBdCuwF-2@ArchLinux>
	<xmqqbk1cz69c.fsf@gitster.g>
	<20240829040215.GA4054823@coredump.intra.peff.net>
	<xmqqseunxtks.fsf_-_@gitster.g>
	<20240829175215.GA415423@coredump.intra.peff.net>
	<xmqq8qwfw6e9.fsf@gitster.g>
Date: Thu, 29 Aug 2024 11:18:06 -0700
Message-ID: <xmqq4j73w5up.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0AD4C4FE-6633-11EF-B96C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

A function that uses a parameter in one build may lose all uses of
the parameter in another build, depending on the configuration.  A
workaround for such a case, MAYBE_UNUSED, should also be mentioned
when we recommend the use of UNUSED to our developers.

Keep the addition to the guideline short and document the criteria
to choose between UNUSED and MAYBE_UNUSED near their definition.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines |  5 +++--
 git-compat-util.h              | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index d0fc7cfe60..3263245b03 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
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
diff --git a/git-compat-util.h b/git-compat-util.h
index 71b4d23f03..e4a306dd56 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -195,6 +195,19 @@ struct strbuf;
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
+/*
+ * UNUSED marks a function parameter that is always unused.  It also
+ * can be used to annotate a function, a variable, or a type that is
+ * always unused.
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
@@ -649,6 +662,17 @@ static inline int git_has_dir_sep(const char *path)
 #define RESULT_MUST_BE_USED
 #endif
 
+/*
+ * MAYBE_UNUSED marks a function parameter that may be unused, but
+ * whose use is not an error.  It also can be used to annotate a
+ * function, a variable, or a type that may be unused.
+ *
+ * Depending on a configuration, all uses of such a thing may become
+ * #ifdef'ed away.  Marking it with UNUSED would give a warning in a
+ * compilation where it is indeed used, and not marking it at all
+ * would give a warning in a compilation where it is unused.  In such
+ * a case, MAYBE_UNUSED is the appropriate annotation to use.
+ */
 #define MAYBE_UNUSED __attribute__((__unused__))
 
 #include "compat/bswap.h"

Interdiff against v1:
  diff --git a/git-compat-util.h b/git-compat-util.h
  index 23307ce780..e4a306dd56 100644
  --- a/git-compat-util.h
  +++ b/git-compat-util.h
  @@ -196,7 +196,9 @@ struct strbuf;
   #define _SGI_SOURCE 1
   
   /*
  - * UNUSED marks a function parameter that is always unused.
  + * UNUSED marks a function parameter that is always unused.  It also
  + * can be used to annotate a function, a variable, or a type that is
  + * always unused.
    *
    * A callback interface may dictate that a function accepts a
    * parameter at that position, but the implementation of the function
  @@ -662,13 +664,14 @@ static inline int git_has_dir_sep(const char *path)
   
   /*
    * MAYBE_UNUSED marks a function parameter that may be unused, but
  - * whose use is not an error.
  + * whose use is not an error.  It also can be used to annotate a
  + * function, a variable, or a type that may be unused.
    *
  - * Depending on a configuration, all uses of a function parameter may
  - * become #ifdef'ed away.  Marking such a parameter with UNUSED would
  - * give a warning in a compilation where the parameter is indeed used,
  - * and not marking such a parameter would give a warning in a
  - * compilation where the parameter is unused.
  + * Depending on a configuration, all uses of such a thing may become
  + * #ifdef'ed away.  Marking it with UNUSED would give a warning in a
  + * compilation where it is indeed used, and not marking it at all
  + * would give a warning in a compilation where it is unused.  In such
  + * a case, MAYBE_UNUSED is the appropriate annotation to use.
    */
   #define MAYBE_UNUSED __attribute__((__unused__))
   
-- 
2.46.0-563-gaeb9b172ce

