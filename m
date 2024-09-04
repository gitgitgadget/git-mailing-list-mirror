Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05512146D7F
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725489381; cv=none; b=p6Xpc/th2t3i+NdogI/ifKsBiWLK7FCoTJeHWVlA1xTShCrxmlVF+2Kt32oIyEqMfJ+k34DnfbbPEU7rsEBS4d/VSp005cOenfT7tuiq13XjkR3wbxtwMeyzNNaHibAC61w4uYw3dPgsu4AyBH8/6GnWbPSuyfi1RU+CvTRm3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725489381; c=relaxed/simple;
	bh=UX0yZfdoWpySVJY7J/jg+YcI0HqLxFo5wA1HrVGRS40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4DywQm+Sbt44/MwawUeN1gMZhI5uiKWijdZugy9e8n4RhAdzpaNBmWjjDZbwME1hVCSulGZeMU/8uF5d8sDONifx+yAjPBLPxuBKTh1sthv6zIlRTnNrGY1LHR1aHMrVX+qc2s+4IxV2EO1Vqx/Sc9gPsCenjddLLYTGJIAnyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sp7bjW9D; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sp7bjW9D"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5BD01A71A;
	Wed,  4 Sep 2024 18:36:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UX0yZfdoWpySVJY7J/jg+YcI0HqLxFo5wA1HrV
	GRS40=; b=Sp7bjW9DcMar8LNJcLFiz0as1Xg7fCV44456cPpP8ImUT9j0ve9uZc
	/GEoP3ssngUq9x78QfMtz08dEcbP00Cwpdl4lMPM7eKF4dCAOYJtdk1YzYoDFQ5v
	pDAJTrSKVV7Xwcek42RfD2vheI/ndgYucZZjsu9utUWlw6wnWi6LA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE20F1A719;
	Wed,  4 Sep 2024 18:36:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 505951A718;
	Wed,  4 Sep 2024 18:36:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 18/22] builtin/grep: fix leaking object context
In-Reply-To: <0722cb38ea9d6b158a07da6f31ad0fe83424cb2e.1724656120.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Aug 2024 09:22:29 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<0722cb38ea9d6b158a07da6f31ad0fe83424cb2e.1724656120.git.ps@pks.im>
Date: Wed, 04 Sep 2024 15:36:17 -0700
Message-ID: <xmqqed5z6o7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A1B38FA-6B0E-11EF-B30E-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Even when `get_oid_with_context()` fails it may have allocated some data
> in tthe object context. But we do not release it in git-grep(1) when the

"tthe" -> "the".

> call fails, leading to a memory leak. Plug it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/grep.c                 | 1 +
>  t/t6132-pathspec-exclude.sh    | 1 +
>  t/t6135-pathspec-with-attrs.sh | 2 ++
>  3 files changed, 4 insertions(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index dfc3c3e8bd2..dda4582d646 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1133,6 +1133,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  					 &oid, &oc)) {
>  			if (seen_dashdash)
>  				die(_("unable to resolve revision: %s"), arg);
> +			object_context_release(&oc);
>  			break;
>  		}

OK.  This is the "oh, this is not a revision argument" codepath.  It
is perfectly normal for get_oid_with_context() to fail here, and we
should make sure we clear the context variable.

Thanks.
