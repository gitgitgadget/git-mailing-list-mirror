Received: from mta0.migadu.com (out-133.mta0.migadu.com [91.218.175.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD343C055
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125282; cv=none; b=H07818fJWSOO/AGoJMi/m1zDD/Yfb+imUM9RjR79xyWLxVyxaQATkNvf4LndzBjyPkDMWzQtcWpYsFptgy+j5XXnRON+vBdzT7S2ksiDrgOEtrzH3SCYxj5BMKuboEZ2q3o3cWVq3rvFsu2XfWrVLTmpw9g4Xh8xjHpMHXFrS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125282; c=relaxed/simple;
	bh=hJv55uNrClELnm/zd415uCELO5QJ9yVxM82CF9eOwr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EJrxK9bnvdSb1ptOxN5XiW8ek5wfTjcfGqdu92nk8sU0g/WMO6Qt67KI5nVK8VNSr332uBudQ5pPN30I9lnO+bFtA/ebV4+s02d/qWGl0SsXBDhW3w8pGCyTcerAyCVk99Z9hIn7a00IwTBYvlM6vLYDZyOj0HItjprSHgcHfKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nOKnqdLy; arc=none smtp.client-ip=91.218.175.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nOKnqdLy"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hJv55uNrClELnm/zd415uCELO5QJ9yVxM82CF9eOwr4=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789125277; v=1; x=1789730077;
 b=nOKnqdLyiwZwjaF/rMa1Vm/fMAsWXln9F57svmzWEZUIQpNfGXs8h0HVRhF6NzIqlA12jx12
 DiUT8lN/kqp36K9czjB2bzMrC+CDB/wx2oVXOu+IJ2HLXIHT7otp8kSVJaNcfkdelASHGTTL84C
 L47/npIltz8Laefo6M9UBSFM=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 42ccd05028863d8a;
	Fri, 11 Sep 2026 11:14:37 +0000
X-Mizu-Trace-ID: 42ccd05028863d8a
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/10] builtin/fsck: move reverse index verification
 into the packed source
In-Reply-To: <20260831-pks-odb-source-fsck-v2-7-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
 <20260831-pks-odb-source-fsck-v2-7-f9b16ef4957b@pks.im>
Date: Fri, 11 Sep 2026 13:14:34 +0200
Message-ID: <878q58nip1.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The checks for reverse indexes live in `check_pack_rev_indexes()`, which
> is hosted in "builtin/fsck.c". These checks are obviously specific to
> the "packed" backend.
>
> Move the logic into `odb_source_packed_fsck()`. As in the preceding
> commit, drop the dedicated `ERROR_PACK_REV_INDEX` bit and instead use
> the generic `ERROR_OBJECT` bit.

It wasn't immediately obvious to me, but the check is moved to
odb_source_packed_fsck() which is the callback for `.fsck` which is
called by odb_fsck() in odb/odb.c. In builtin/fsck.c a negative return
value is converted to ERROR_OBJECT.

Because it's part of the ODB, that makes sense to me.

-- 
Laters,
Toon
