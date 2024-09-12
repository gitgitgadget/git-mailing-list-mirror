Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12759481C0
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726178265; cv=none; b=EGBEuzX7ViSJSEhA3yi7XJnL3lFZ9TZcsVdGPFG+oGNkpmGdiAsv67HqNsjxJ76S0c/UuA7tsy/MrsJkr37ERbz0WqMHEAxPRxZi9rrsArL/ocUJsHelCJ9DrRmKlbLi2qMzujrXuYgZrFvuVFXhNzV+AqjZV1BIbAdNua6wTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726178265; c=relaxed/simple;
	bh=BcSJjR93iYFiK9M6hyycm1eaJ5UquhtoAprSW3EZ7zQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QWYll9BadCZ107HEjcYhEPrWQoiSXJqGwTHYG8B2+7ddqYL4IMqvi+3XVsLI4cpi5G12b26TKO/wVZj1fZ+1dbo7Ku4Kcx+MlnFcgIjct6Ut32GSoDKBhcYIRLDUSDCX6qqUxPEdsjab/HHatAB6plpCLEcsS+GbGgngjGTe4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dV1/yY93; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dV1/yY93"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA67C31619;
	Thu, 12 Sep 2024 17:57:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BcSJjR93iYFiK9M6hyycm1eaJ5UquhtoAprSW3
	EZ7zQ=; b=dV1/yY93FDBQ0VzC/GAeIGBc7FZ1YwGsqwZZZfT0erSyNhPf9QnlQ3
	4smsLMc3L8rHwKs5VyvfSd42P4epjfSdAvKTV/b8pZ2wApQp3HDUdI7tulb6T+Xb
	TEDl71gALDKpp7NSEGyS/boZS/yuShyekT1Nt5rE3AR7QEQaafYkg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B223631618;
	Thu, 12 Sep 2024 17:57:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2124C31617;
	Thu, 12 Sep 2024 17:57:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Simplify "commented" API functions
In-Reply-To: <20240912205301.1809355-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Thu, 12 Sep 2024 13:52:59 -0700")
References: <20240912205301.1809355-1-gitster@pobox.com>
Date: Thu, 12 Sep 2024 14:57:40 -0700
Message-ID: <xmqq8qvw357v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08DA0388-7152-11EF-A035-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> [earlier] https://lore.kernel.org/git/xmqq7cn4g3nx.fsf@gitster.g/
>
> Junio C Hamano (2):
>   strbuf: retire strbuf_commented_addf()
>   strbuf: retire strbuf_commented_lines()

This of course has a semantic conflict with the change that hides
not just "the_repository" and functions that implicitly use that
variable but other unrelated globals from environment.h behind a
compatibility macro.

A trivial merge-fix to be used to annotate the merge to make it an
evil merge whose result compiles looks like this:

    merge-fix/jc/strbuf-commented-something

diff --git a/strbuf.c b/strbuf.c
index 05a6dc944b..cb972b07f7 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -7,6 +7,14 @@
 #include "utf8.h"
 #include "date.h"
 
+/*
+ * We do not need the_repository at all, but the comment_line_str is
+ * hidden behind USE_THE_REPOSITORY_VARIABLE CPP macro.  We could
+ * #define it before including "envirnoment.h".  Or we can make an
+ * external declaration ourselves here.
+ */
+extern const char *comment_line_str;
+
 int starts_with(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
