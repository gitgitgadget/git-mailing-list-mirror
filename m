Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005941B86F0
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035308; cv=none; b=ovZvNe4gchVniNKM2VRqGWTVUdBxVrD5xWhkiEHSCxWfad5jQiRJQIlZCDbsh+0pKnxJcCE30HD+5B36jbO4t77D3CbZAbIr1Rht+TxAh31ONyf+Iexnjm6qbZPkCSl4yBQaIW8SZlZKr3qd2nDAS9RurI4kbQ8lbDPRES+M8gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035308; c=relaxed/simple;
	bh=AlwTy3AU37e1FjDsOWkypWGOObOiDfMhp66OIXWm4DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F7vUbIHMLHYquzh/g5HqGUXQTqECei887bdFT5qu8+PKynuOJHtR018sroD4PAVGY1IKKbzTOcG4x43m136OuyZfSfJOTfpEKwF2DgFJ/riGHsUiZiDC9UU/HQF0e+t/R5WEYuXIskECNZkwG7SbkKSQip1joVhbLWTOkNxSKUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GJREcCq/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GJREcCq/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD9591F449;
	Fri, 30 Aug 2024 12:28:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AlwTy3AU37e1FjDsOWkypWGOObOiDfMhp66OIX
	Wm4DQ=; b=GJREcCq/2tbFRjOomjIQ9Rb/fBLf5xNLnXgt6tCYf2T8dnatJ6ERmw
	+ZCmmO+XmwRF96WRYnSdfW7Jj0UC73LAQXfta9JDm8sTcyS90LDOgNTVKnB4Dt00
	/+i194auVrg3Oa6lfHJFFEZvF98Zy+gNKBFvjAgm1KAKuEdKKptGQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A37331F448;
	Fri, 30 Aug 2024 12:28:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 136251F447;
	Fri, 30 Aug 2024 12:28:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Roman Sandu <r.sandu@gaijin.team>,  git@vger.kernel.org
Subject: Re: Committing crimes with NTFS-3G
In-Reply-To: <b282c83c-2fa2-4e8e-b8bf-d42f28c17439@kdbg.org> (Johannes Sixt's
	message of "Fri, 30 Aug 2024 06:58:20 +0200")
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
	<b282c83c-2fa2-4e8e-b8bf-d42f28c17439@kdbg.org>
Date: Fri, 30 Aug 2024 09:28:17 -0700
Message-ID: <xmqq1q26t1pa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DDC7D720-66EC-11EF-8590-9B0F950A682E-77302942!pb-smtp2.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> Am 29.08.24 um 22:43 schrieb Roman Sandu:
>> To diagnose the problem, I ran git status with GIT_TRACE_PERFORMANCE
>> enabled, and what I see is that the "refresh index" region is taking up
>> 99% of the time.
>
> Of course. The stat information that Git on Linux caches in the index is
> vastly different from that that Git for Windows caches. So every time
> you switch OS, all files appear modified to Git.
>
> I suggest that you don't switch OS on a whim and take the 8 seconds
> delay once when you have to.

I somehow got an impression that the hit is not just that we need to
adjust cached lstat information in the index file once to the new
filesystem implementation after an OS switch, but every time (as if
we are forced to be extra careful and rehash every time until the
things improve, somewhat like how we handle the racy-Git situation).
Timestamps given by these OSes are not consistent and the clock
appears to have rewound, or something?

Timestamps of files in the working tree ordinarily should match
timestamps in the cached lstat information of these paths in the
index, and timestamp of the index file itself should be newer than
any of the above, or the recy-Git prevention code may tell us to
play safe.

I do not do Windows and/or NTFS, but I have to wonder if the smudge
filters (including the EOL conversion) play a role in this situation
as the working tree is getting switched between LF-native and
CRLF-native systems.  May there be situations where the system must
spend time only to realize that there is nothing it needs to do to
canonicalize the file contents and there is no modifications between
the HEAD commit, the index, and the working tree files, or something
silly like that?

Thanks.

