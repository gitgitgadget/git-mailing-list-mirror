Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626127D41C
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652492; cv=none; b=u28eq7OY4byCRlQY1OvL5C3pIRzUWtIcF7jsiaMF6Imtb00X6/P4G2jBYL398jXjrbnf7mVq6bRcymNDqVltjO7w6iBxUleNBwhvSuaUnBitd1djiJZYqEN25u84r3IU6RFSxy71AtXiksnuqMmYjS9aPGZFOg8HMgEnADLOsBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652492; c=relaxed/simple;
	bh=PBEPx0k/QVPtHLpBpBaf2KL5+j7SxUvMMCL57XH98VM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NYEwE63plZVz3m28eScXqtM9IRo817TVtVJvIpU8UMZ98kbRS6/iTXKC3TJ2aWj2Ge+Tku/fh5Qv5meCgC3P7/l83dXVdw1l1DVgBIbVHkAZJTFbUfCeJIfKH9XrVp7fxP1UpSKB+drw+CftsT2ie2OsjP9tf1bWos0Dn23FrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=noLX5lyx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="noLX5lyx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 01DC81E274D;
	Tue, 30 Jan 2024 17:08:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PBEPx0k/QVPtHLpBpBaf2KL5+j7SxUvMMCL57X
	H98VM=; b=noLX5lyxCQ8QFa82reRoS191IQwMDjfz1nc/+tg4FUFJqJ4iJhaOCr
	q7KdPXMJITDzbGrnwhheWKHOJOxrVamiZGWRJBeD+8EIpFoAEiH/qU3MVgHWxWTi
	RN8G5baEAlZ3napMO7YwhvwBdHe8ycNbuFKTt7Hs3X5xahgP++s2c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDDD21E274C;
	Tue, 30 Jan 2024 17:08:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 386D61E274B;
	Tue, 30 Jan 2024 17:08:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 0/2] refs: introduce reftable backend
In-Reply-To: <cover.1706601199.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 30 Jan 2024 09:05:26 +0100")
References: <cover.1706601199.git.ps@pks.im>
Date: Tue, 30 Jan 2024 14:08:05 -0800
Message-ID: <xmqqil3aa30a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0CAE9ACA-BFBC-11EE-B6C2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Patrick Steinhardt (2):
>   refs: introduce reftable backend
>   ci: add jobs to test with the reftable backend

I haven't checked the code in refs/reftable-backend.c at all, but
judging from the fallout to other files, it issurprisingly cleanly
done.  I somehow expected that we would need more changes like
exposing the helper function to compute shared permission bits,
but I see that it was the only change needed.  Everything else done
to other files are natural requirement to plug the new thing as a
new ref backend to the system.  Very nicely done.

Thanks.


>  .github/workflows/main.yml                    |    9 +
>  .gitlab-ci.yml                                |    9 +
>  Documentation/ref-storage-format.txt          |    2 +
>  .../technical/repository-version.txt          |    5 +-
>  Makefile                                      |    1 +
>  ci/lib.sh                                     |    2 +-
>  ci/run-build-and-tests.sh                     |    3 +
>  contrib/workdir/git-new-workdir               |    2 +-
>  path.c                                        |    2 +-
>  path.h                                        |    1 +
>  refs.c                                        |    1 +
>  refs/refs-internal.h                          |    1 +
>  refs/reftable-backend.c                       | 2286 +++++++++++++++++
>  repository.h                                  |    5 +-
>  t/t0610-reftable-basics.sh                    |  887 +++++++
>  t/t0611-reftable-httpd.sh                     |   26 +
>  t/test-lib.sh                                 |    2 +
>  17 files changed, 3237 insertions(+), 7 deletions(-)
>  create mode 100644 refs/reftable-backend.c
>  create mode 100755 t/t0610-reftable-basics.sh
>  create mode 100755 t/t0611-reftable-httpd.sh
