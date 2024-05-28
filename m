Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19DB22089
	for <git@vger.kernel.org>; Tue, 28 May 2024 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940018; cv=none; b=PGv6c5RX/x9kBbT7RuTj+kZaqvlBB62SGi8qJgQtrrHw5aOVqxbfRbMiBm+sMZ4R8BQXIUBjNPMquVoJHUoyiqBO6XQf6I8lMjtjyO6PVattEHOzZ5UcuFFgZ1xZIfDwxuUCf3UEmAOh0Udz+Nep+8h4ayvJaJp6QT+tFKWKeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940018; c=relaxed/simple;
	bh=Ehge4mZhOFB0zXns1or+Fq8lvwPcDd4ZHN2yGzep4Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VAfX7d30dfwQR6I0Z4WozhJ/WioJB9dBsAVQ2PSB1yFOx9KLNsqP67FTfxLVIJdTSWfgX8bgoVJsQaqycZ8zT3bUlv7LbQiNfc9yLKF8SUGJgYuu23VtJ1Mpw38IziDfeFEaLJPJqnSOC9pzPSeEFVnlnJ4EQebf5TD4eAl/Ssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f3A4AKxd; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f3A4AKxd"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CF981D717;
	Tue, 28 May 2024 19:46:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ehge4mZhOFB0zXns1or+Fq8lvwPcDd4ZHN2yGz
	ep4Cs=; b=f3A4AKxdMfgPQ6jBqWttVU87HcAodpODXSue5SAVdXVJVX5PFdsvsJ
	oDpGwiIzCey6BMKfe74/WAdg89R5BjeNsdk05QD1/ivSUxU+ob5yAXguPV8Olbd2
	Xi8lz4pjMQS9JjpTgwuVGiRWUnV1SBWTDIG+vcCkixTMt9f88IrZk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2504A1D716;
	Tue, 28 May 2024 19:46:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 860A51D715;
	Tue, 28 May 2024 19:46:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Joey Hess <id@joeyh.name>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
In-Reply-To: <ZlZSZ1-0F2DEp9yV@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 28 May 2024 21:53:43 +0000")
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
	<0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de>
	<ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net>
	<Zk2_mJpE7tJgqxSp@kitenet.net>
	<fbb89826-0d83-d4f9-bab4-9fba69e0e22d@gmx.de>
	<ZlU94wcstaAHv_HZ@kitenet.net>
	<ZlZSZ1-0F2DEp9yV@tapette.crustytoothpaste.net>
Date: Tue, 28 May 2024 16:46:53 -0700
Message-ID: <xmqq7cfd33f6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9031BFC4-1D4C-11EF-918A-25B3960A682E-77302942!pb-smtp2.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2024-05-28 at 02:13:55, Joey Hess wrote:
>> Johannes Schindelin wrote:
>> Writing objects: 100% (3/3), 324 bytes | 324.00 KiB/s, done.
>> Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
>> remote: error: object ea461949b973a70f2163bb501b9d74652bde9e30: symlinkPointsToGitDir: symlink target points to git dir
>> remote: fatal: fsck error in pack objects
>> error: remote unpack failed: unpack-objects abnormal exit
>> To ../bar.git
>>  ! [remote rejected] master -> master (unpacker error)
>> error: failed to push some refs to '../bar.git'
>> 
>> So I guess that the WARN doesn't work like you expected it to in this case of
>> receive.fsckobjects checking.
>
> Then my guess is that this will affect most forges.

FWIW, it is detected as "error" according to the above.

In any case, a33fea08 (fsck: warn about symlink pointing inside a
gitdir, 2024-04-10) adds two ERRORs, in addition to two WARNs:

+	FUNC(SYMLINK_TARGET_MISSING, ERROR) \
+	FUNC(SYMLINK_TARGET_BLOB, ERROR) \
+	FUNC(SYMLINK_TARGET_LENGTH, WARN) \
+	FUNC(SYMLINK_POINTS_TO_GIT_DIR, WARN) \

so "they are only warnings and won't break" is not quite what I see
in the change, but what is causing the above error does look like
the one that is marked as WARN in the patch.

Thanks.

