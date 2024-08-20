Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E2190671
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171167; cv=none; b=g6wdL/Cd3XPkli+MOvoWek3MJaO+7gO3N99NDN087WzwhX7vamH89Grb9RjpiC8sKo0dL8zhkSegvYw1d2PMgsuvxL+id4yVZPxBsFjl9S2Y0I7kOw2GEAQOAUJaplrm8uoTT8dyTm4bOGQFTOIPNRKldsd+AHCc8pMs5bcmNiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171167; c=relaxed/simple;
	bh=rdsFRibwpK2sBFa4Xx4BrqQCLI6J1SRhN+NkAUd3ZQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ly57zxWLu26IMH6P8h6+557kAjuzPn0+9H/zpeVASfDxopNBlr5QfJvHPwwxcioiGFEVGmwhnLQF+2gC6JD2D9TKM3CW4CzOVXmLN7cJ0zqCQcst8n2yv7LEA2iqXpmu+pjnLSL7GjixRFKyq2uPiAvM0h7wnEy8fzw9vcKNqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aOtsaDXT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aOtsaDXT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14C672C42D;
	Tue, 20 Aug 2024 12:25:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rdsFRibwpK2sBFa4Xx4BrqQCLI6J1SRhN+NkAU
	d3ZQ8=; b=aOtsaDXTdevj9o6wv8qmfo2LA/On2v9sxRUxQea9T7whWTvsN+gBcJ
	pAvzRuAoz3lCZToKSXbVUug/Rkqc97lKl3SFtBF0+HHfyTGULI/4nkFQbFAcFRVs
	OrBkJgEoLXIZfJg2ORriCer5j1Ko6/uzdp6JMmo6FjD7pLKbquthw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09AE22C42C;
	Tue, 20 Aug 2024 12:25:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B03E2C42B;
	Tue, 20 Aug 2024 12:25:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v1 1/4] fsck: introduce "FSCK_REF_REPORT_DEFAULT" macro
In-Reply-To: <ZsIM0L72bei9Fudt@ArchLinux> (shejialuo@gmail.com's message of
	"Sun, 18 Aug 2024 23:01:36 +0800")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <ZsIM0L72bei9Fudt@ArchLinux>
Date: Tue, 20 Aug 2024 09:25:56 -0700
Message-ID: <xmqq4j7fb1pn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E11B8C5C-5F10-11EF-B8D0-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> In "fsck.c::fsck_refs_error_function", we need to tell whether "oid" and
> "referent" is NULL. So, we need to always initialize these parameters to
> NULL instead of letting them point to anywhere when creating a new
> "fsck_ref_report" structure.

The above is correct, but ...

>  	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
> -		struct fsck_ref_report report = { .path = NULL };
> +		struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;

... the code without this patch is already doing so.

When designated initializers are used to initialize a struct, all
members that are not initialized explicitly are implicitly
initialized the same as for objects that have static storage
duration (meaning: pointers are initialized to NULL, arithmetics are
initialized to zero).

So I do not quite see why this change is needed.  By hiding the fact
that the "report" structure is zero-initialized behind the macro, it
makes it less obvious that we are clearing everything.

If the patch were to rewrite the above like so:

		struct fsck_ref_report report = { 0 }

it would make it even more clear that everything is zero
initialized, and also makes it obvious that .path member is not any
special.

Thanks.
