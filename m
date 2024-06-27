Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0F249F9
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524632; cv=none; b=F9mhl4PUkbhDCk5AlaAdsdEh8NS5RdHza6Jd94MHggru4i3wknjLL/1N66YxQldzMjsGc9722jzrVeEZ2JkYg98n2Yxfh2cUW3CkFE3bFPncCnDspWQccEZzw+QbL97fO3i5CH5kszI5xBPF8ogyYhFvEg+sgHoq7ZF264tHXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524632; c=relaxed/simple;
	bh=0WeCMkoj2/OVWMB3rUKKliwJOjvHpByKA5Dicbcw3vE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMtWWNtMc7xH1LGXqfuC/D57QV2OHgiWwmYFyMSiXx1LNBteIrWG6Ly7cS75Slo/vLGNYigi2G7xWc9Y0Cqnb/zmb2Ot/ldY9GPsa3fnlc8quNZWTouaph2t2m1yVM7CAhaaB7njJOUZnqC9RQZAc7VLUrgNBwQcyypnyi3g7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nzPl/4U+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nzPl/4U+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 797012D50D;
	Thu, 27 Jun 2024 17:43:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0WeCMkoj2/OVWMB3rUKKliwJOjvHpByKA5Dicb
	cw3vE=; b=nzPl/4U+bQ9ZADspk0xK7hVxb/mqnqWsoHSkkp0N8LMI0AlOvxJbeU
	EJmjzAAq0uVAZY4mewYNTbGyJyaisUdR0XbsC6smeWUjM1VVmsKdgNzr4QpznI94
	dOsONam9gHW3qVEEdp1Py5PHY4l8kmsYxke0BcRLgjTTQAy2X1b0Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E7572D50C;
	Thu, 27 Jun 2024 17:43:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B307A2D50B;
	Thu, 27 Jun 2024 17:43:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v5 02/12] fsck: use "fsck_configs" to set up configs
In-Reply-To: <Zn2BgEw0geZwvr3_@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 27 Jun 2024 23:13:04 +0800")
References: <Zn2Ah3WDhtOmzrzn@ArchLinux> <Zn2BgEw0geZwvr3_@ArchLinux>
Date: Thu, 27 Jun 2024 14:43:47 -0700
Message-ID: <xmqqzfr6qcx8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 564BC2CA-34CE-11EF-8613-965B910A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> Some fields such as "msg_type" and "skiplist" in "fsck_objects_options"
> are not options, these fields are related to "git-config(1)" which are
> initialized using "git_fsck_config" function.  Create a static variable
> named "fsck_configs" in "fsck.c" which aims at handling configs. Thus we
> don't need to reply on the "fsck_objects_options" to set up the fsck
> error message severity.

reply???

As configuration often is used to prepopulate options, I need a lot
stonger justification to split these into a different structure than
"'config' is a noun that is different from a noun 'option'".  

If we intend to have many "option" instances but what these two
members store will be the same across these "option" instances, for
example, that would be a lot better reason why we may want to
separate these two members out of it, but I have a suspicion that if
we were to use the "union with tags" approach, these two would
become members of the common part shared between "objects' and
"refs", i.e. the overall data structure might look more like this:

	struct fsck_options {
		enum fsck_msg_type *msg_type;
		struct oidset oid_skiplist;
		enum fsck_what_check { O, R } tag;
		union {
			struct fsck_object_options o;
			struct fsck_ref_options r;
		} u;
	};

by moving these two members out of fsck_object_options and moving
them to the shared part.

I dunno.  It is unclear what the real reason is for these two things
to be extracted out and made to appear totally independent from the
"options" thing to begin with, and I am not sure if I agree with the
reason when it is known.
