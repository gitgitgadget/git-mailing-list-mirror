Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA5525E
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998015; cv=none; b=dwvejLdFPimEiW0BtMz9LI5N5GiHs23vgi5+DPpCMzwPVguz7DjxxcJ3dLIFbbpVqbgjhYFZ07Tj5W6xJrvY+eCoh1Z50MPS5SUy8thoeHXWf0k6jkVaLlOgkm66P6Wo4q+eeCpPo1+TpvDw8dtbotvqe9qrO9P2bBGim7ft8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998015; c=relaxed/simple;
	bh=Pdfv0HVtQPdNdp9FqkxXIvxaHre175wa6MSSbabyf8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FAdlAzPSfHpsgrG3GAxLwbH+Uza/t8uiRUUmu+q7Z2zykysvh8ccvuvDq0+nhwUoOMZGM3OfYsqjAPIWIPFRzlP0NSGTNXomOnlM7tprInJy7jBUfdNs6q5/2PmvVaBQ8lmu7NteYUaiRXKbJm0X1bowP1L8xOTPf+NL29lWQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x1iu0/19; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x1iu0/19"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D1301E460;
	Mon, 26 Feb 2024 20:40:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Pdfv0HVtQPdNdp9FqkxXIvxaHre175wa6MSSba
	byf8g=; b=x1iu0/19LKNlksIedegrwpEXsXnFlAH0jqHy2tD7iKVWv3T1OCTFsC
	ZcU22qcl4WZ3WhdgQN1pFu1rBbRwFq+tg17xWCUCBfsKdfVH+8gZeyjDlw+bUMYp
	x4fYd7UWNpDcr8iNaev4uWNBC9eWfsWm1WLr4K5gbOLGxlFE2FBuM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 651301E45F;
	Mon, 26 Feb 2024 20:40:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6EDA1E45E;
	Mon, 26 Feb 2024 20:40:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff
 Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v3 00/14] FSMonitor edge cases on case-insensitive file
 systems
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com> (Jeff
	Hostetler via GitGitGadget's message of "Mon, 26 Feb 2024 21:39:11
	+0000")
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 17:40:07 -0800
Message-ID: <xmqqfrxeit1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 23F73B5A-D511-11EE-A9FC-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is version 3. I think I have addressed the remaining comments.
>
> I cleaned up the test code to use the test_expect_failure at the beginning
> and squashed in the test_expect_success version of tests into the final
> commit in the series.
>
> I moved the invalidate_ce_fsm() commit earlier in the series, so that the
> final commit actually uses all of the up-to-this-point changes to fix the
> problem.
>
> I converted a few "should not happens" to BUG()s.
>
> Thanks to everyone for their time and attention reviewing this. Jeff
>
> Jeff Hostetler (14):
>   name-hash: add index_dir_find()
>   t7527: add case-insensitve test for FSMonitor
>   fsmonitor: refactor refresh callback on directory events
>   fsmonitor: clarify handling of directory events in callback helper
>   fsmonitor: refactor refresh callback for non-directory events
>   dir: create untracked_cache_invalidate_trimmed_path()
>   fsmonitor: refactor untracked-cache invalidation
>   fsmonitor: move untracked-cache invalidation into helper functions
>   fsmonitor: return invalidated cache-entry count on directory event
>   fsmonitor: remove custom loop from non-directory path handler
>   fsmonitor: return invalided cache-entry count on non-directory event
>   fsmonitor: trace the new invalidated cache-entry count
>   fsmonitor: refactor bit invalidation in refresh callback
>   fsmonitor: support case-insensitive events
>
>  dir.c                        |  20 +++
>  dir.h                        |   7 +
>  fsmonitor.c                  | 312 +++++++++++++++++++++++++++++------
>  name-hash.c                  |   9 +-
>  name-hash.h                  |   7 +-
>  t/t7527-builtin-fsmonitor.sh | 223 +++++++++++++++++++++++++
>  6 files changed, 522 insertions(+), 56 deletions(-)

Much nicer.  Will queue.  Thanks.
