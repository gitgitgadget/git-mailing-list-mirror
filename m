Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611715DBB2
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881490; cv=none; b=Se28byN1nyXi80VP+wbD0dD9vflnLvzqKSYFHpuWb/nnV81eCvntq9KHWcioyb5/R7Ujq5L23Vsg/Nsu/SV+MjUwjdjPqKJGuimkEXv4Qs1ym6ukZMCm9Ku01UhqwdW2BXqMZ2d+g0TqIXfQHEJWuBrpcFpfbfEv07VX2HnjXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881490; c=relaxed/simple;
	bh=cj3UugMNsrJHll25QNMC0qRLbJtHlfSOQ9oWb9qyfTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C1seoChdp+iiPatFRCgJ4RTEStE+rDzqhQo5939CXdqbAXMgS8WAyTx3lG2o7MTf1cjno7bYG8zPOU0x6GeRqJItS+VgPRWf270i+qh5xeY5wlX//2Sjt2EhC5TH9eC6qHvYRZoBZMFTSeoOsIkbM2Cp6UyA/fpGZ71XRkZmRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S3jvADpn; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S3jvADpn"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 316BF18EC9;
	Mon,  5 Aug 2024 14:11:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cj3UugMNsrJHll25QNMC0qRLbJtHlfSOQ9oWb9
	qyfTU=; b=S3jvADpnPZv6xvSUvt7cE+3h86PGsV9OFGzjnsoxEwYqN2kVuKUCh8
	fZGKUsNsAxOiW/0+ee25en5uXeAjS66ElnGeEeVCUawueHigfrYfPUvE+EkQ4JhB
	7VOZg3oBLSusc4mWxDXnL8yb6k2Ep8J3sj1VdKkoCLm1cUcnomjJg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 29B1D18EC8;
	Mon,  5 Aug 2024 14:11:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07DA118EC5;
	Mon,  5 Aug 2024 14:11:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify`
 child process
In-Reply-To: <ZrDtVJYoJJZDesB4@ArchLinux> (shejialuo@gmail.com's message of
	"Mon, 5 Aug 2024 23:18:44 +0800")
References: <ZqulmWVBaeyP4blf@ArchLinux> <ZqumdJz3-0mqh6Rc@ArchLinux>
	<ZrDMdEJR6DV5HyLD@tanuki> <ZrDtVJYoJJZDesB4@ArchLinux>
Date: Mon, 05 Aug 2024 11:11:22 -0700
Message-ID: <xmqq4j7y3kmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1FF9048E-5356-11EF-9BA5-E92ED1CD468F-77302942!pb-smtp21.pobox.com

shejialuo <shejialuo@gmail.com> writes:

>> > +static void fsck_refs(void)
>> > +{
>> > +	struct child_process refs_verify = CHILD_PROCESS_INIT;
>> > +	child_process_init(&refs_verify);
>> > +	refs_verify.git_cmd = 1;
>> > +	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
>> > +	if (verbose)
>> > +		strvec_push(&refs_verify.args, "--verbose");
>> > +	if (check_strict)
>> > +		strvec_push(&refs_verify.args, "--strict");
>> > +
>> > +	if (run_command(&refs_verify))
>> > +		errors_found |= ERROR_REFS;
>> > +}
>> 
>> Okay. I think that it's sensible to execute this as part of git-fsck(1).
>> But do we want to provide an option to disable this new check, as well?
>> 
>> It does feel a bit like opening a can of worms, though. None of the
>> other checks have trivial ways to disable them, and git-fsck(1) is
>> gaining more and more checks. So if we can disable ref checks, we may
>> also want to have options to disable checks for objects, connectivity,
>> reverse indices, indices, commit graphs and whatnot. In other words, in
>> my opinion we need to think a bit bigger and design a proper UI around
>> this.
>> 
>> But I don't think that should happen as part of this commit series, as
>> it is already big enough. So either we just accept this patch as-is. Or
>> we evict it from this series and handle it in the future together with
>> all the other taks that one may potentially want to disable.
>> 
>> I'd rather pick option two.
>> 
>
> After talking with Patrick offline, we decide to drop this patch. At
> current, we should put this change slowly for the user. Because many
> people use "git-fsck(1)", currently we don't have a way to disable ref
> checks by default. It's a little beyond this series.
>
> We may consider later.

Hmph, I am fine with the approach to take it slower.

BUT.

Here is what the diffstat for the whole thing in the updated round
v15 looked like.  Do most of these changes outside refs/ still
needed if we do not give any way to even optionally enable it via
"fsck" for those who feel adventurous?  Should we still be touching
fsck.[ch] and other fsck related infrastructure in the series?

 Documentation/fsck-msgids.txt |   6 ++
 Documentation/git-refs.txt    |  13 +++++
 builtin/fsck.c                |  17 +++---
 builtin/mktag.c               |   3 +-
 builtin/refs.c                |  34 +++++++++++
 fsck.c                        | 127 +++++++++++++++++++++++++++++++++---------
 fsck.h                        |  76 +++++++++++++++++++------
 object-file.c                 |   9 ++-
 refs.c                        |   5 ++
 refs.h                        |   8 +++
 refs/debug.c                  |  11 ++++
 refs/files-backend.c          | 116 +++++++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 +++
 refs/refs-internal.h          |   6 ++
 refs/reftable-backend.c       |   8 +++
 t/t0602-reffiles-fsck.sh      |  92 ++++++++++++++++++++++++++++++
 16 files changed, 480 insertions(+), 59 deletions(-)
