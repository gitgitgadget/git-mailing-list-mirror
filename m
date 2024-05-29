Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18D158871
	for <git@vger.kernel.org>; Wed, 29 May 2024 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992697; cv=none; b=lphA1mgdG3OqjrjPIketpNq4gtshuqfHaCzHwA8Vv4ZOU+zuoJIFNQ4HAPvCohx5WGI2pRuEorn2JsF4fJh0C5xQ1MTsxy0yfwcTvB19Pgvat7JER/cLgKrsIPTWhfpURZOix/bKo6+WQDQwGZ4jxVawNCMDymm28SAnXZavibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992697; c=relaxed/simple;
	bh=VS5SpWFwiVl7KIr3idTp1ZIhqokA7H8czLnEg1hzm/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nkHf4muH9YPfZdTLxiqivihmSXsjA03657juUVFnlAlcp0A3Rz1qEOTgoOQZZwOkeRZMcBR3e7MF+XyOZmk+TC/lN25UFCl3j5Kv4RDcHIInwF01ARJXccoUSOXhGrpe1/w/ppf690QIU3yVIYmYYWcHIdnX6DxeGuXdWkIj81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RG36HhnX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RG36HhnX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA2EE31FCD;
	Wed, 29 May 2024 10:24:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VS5SpWFwiVl7KIr3idTp1ZIhqokA7H8czLnEg1
	hzm/4=; b=RG36HhnXMRpl8VKeifM5ASzMZgP066RY8q1iIzkDZ8jDHSPI9gl/RR
	ifmehXrOQ9dn/6hPL3JGSlRqS0y/0ylY1MXpDrhhaBZvpYX6nvszKixmaJVxCnbj
	9i6hU4lLf4/5x0lWPSZ2IS9PQYgWGb+abkwPL/rw5pGGqxs5Df2bI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C16DE31FCC;
	Wed, 29 May 2024 10:24:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 379D831FCB;
	Wed, 29 May 2024 10:24:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #12; Tue, 28)
In-Reply-To: <Zla7oBd7UZbPX7d8@tanuki> (Patrick Steinhardt's message of "Wed,
	29 May 2024 07:22:40 +0200")
References: <xmqqle3t36a6.fsf@gitster.g> <Zla7oBd7UZbPX7d8@tanuki>
Date: Wed, 29 May 2024 07:24:53 -0700
Message-ID: <xmqqv82w1yru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 37BAA1C8-1DC7-11EF-9AEA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 28, 2024 at 03:45:05PM -0700, Junio C Hamano wrote:
>> * ps/undecided-is-not-necessarily-sha1 (2024-05-06) 15 commits
>>   (merged to 'next' on 2024-05-08 at 9f8e894685)
>>  + repository: stop setting SHA1 as the default object hash
>>  + oss-fuzz/commit-graph: set up hash algorithm
>>  + builtin/shortlog: don't set up revisions without repo
>>  + builtin/diff: explicitly set hash algo when there is no repo
>>  + builtin/bundle: abort "verify" early when there is no repository
>>  + builtin/blame: don't access potentially unitialized `the_hash_algo`
>>  + builtin/rev-parse: allow shortening to more than 40 hex characters
>>  + remote-curl: fix parsing of detached SHA256 heads
>>  + attr: fix BUG() when parsing attrs outside of repo
>>  + attr: don't recompute default attribute source
>>  + parse-options-cb: only abbreviate hashes when hash algo is known
>>  + path: move `validate_headref()` to its only user
>>  + path: harden validation of HEAD with non-standard hashes
>>  + Merge branch 'ps/the-index-is-no-more' into ps/undecided-is-not-necessarily-sha1
>>  + Merge branch 'jc/no-default-attr-tree-in-bare' into ps/undecided-is-not-necessarily-sha1
>>  (this branch is used by jc/undecided-is-not-necessarily-sha1-fix.)
>> 
>>  Before discovering the repository details, We used to assume SHA-1
>>  as the "default" hash function, which has been corrected. Hopefully
>>  this will smoke out codepaths that rely on such an unwarranted
>>  assumptions.
>> 
>>  Will cook in 'next', as it has known breakage.
>>  source: <cover.1715057362.git.ps@pks.im>
>
> The follow-up patches in jc/undecided-is-not-necessarily-sha1-fix have
> landed by now, so there are no more known breakages at the current
> point, right? Do we want to merge this down now, or is there something
> you'd like me to do in this context?

I think "known breakage" is gone, but I had this on back-burner as
I wanted to forcus on cleaning up the 2.45.1 mess first X-<.

Let's unblock the topic by lifting "Will cook" mark.  Thanks.
