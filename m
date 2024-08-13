Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7F955892
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568335; cv=none; b=Tf4l5WnAzDlnAuDsN4wQTrhHoLHjsx/pDtTUndHk0mSgAdxOTq5lsT8NOk8k70kUzb31znlWzh+LVrkUz9Q3r1u2M28e/zFJUy/CkNEbzLX8P/6qQvoi9WYY/YtiJbzhVR/Ynni1lv8Gps5Ff6g6DRyEZP0E6XDHQq9pAmOaSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568335; c=relaxed/simple;
	bh=/xa6eMycG5f8gYgrKQ5avNSDJ+Ku9MhCQcQugVx6ggk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gum8Hh/m8VX2F/lkDEb4+b3pGBjPK8N/dAxPbbNE/LZ71I5QRPBGoaW3qJYJ/hOSj+LMcOgs9j/90+tz0qXm8vxRw9pJ5ogG9VgTkP352zTAH4DtA/Kx68KppJromsz/k+lFCp9ap1fjzZqeIUajlE3IZtPtNGEhy6xgksKTSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fyIotj2n; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fyIotj2n"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68F4327FE5;
	Tue, 13 Aug 2024 12:58:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/xa6eMycG5f8gYgrKQ5avNSDJ+Ku9MhCQcQugV
	x6ggk=; b=fyIotj2nI0YgADUYcVHzECGB0edhyWXMEcdwWwsVHlSaPC0Xizz3uq
	l/rpdv/MNzvpTYSIRYfC7ou7vO9cZ93DB6XfzX2CM3gNkY1eF8CYuZsC2rRZYINp
	vynRNW16SAvh9yjoyLfyYN77CTi/t1SFFGtpLBZmAP8Y28EePdEtY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F54127FE3;
	Tue, 13 Aug 2024 12:58:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C677627FE2;
	Tue, 13 Aug 2024 12:58:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  James Liu <james@jamesliu.io>,  karthik nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 00/22] Memory leak fixes (pt.4)
In-Reply-To: <cover.1723540931.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 13 Aug 2024 11:31:02 +0200")
References: <cover.1722933642.git.ps@pks.im> <cover.1723540931.git.ps@pks.im>
Date: Tue, 13 Aug 2024 09:58:50 -0700
Message-ID: <xmqq5xs4741h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 512727C6-5995-11EF-A9C6-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Patrick Steinhardt (22):
>   remote: plug memory leak when aliasing URLs
>   git: fix leaking system paths
>   object-file: fix memory leak when reading corrupted headers
>   object-name: fix leaking symlink paths in object context
>   bulk-checkin: fix leaking state TODO
>   read-cache: fix leaking hashfile when writing index fails
>   submodule-config: fix leaking name entry when traversing submodules
>   config: fix leaking comment character config
>   builtin/rebase: fix leaking `commit.gpgsign` value
>   builtin/notes: fix leaking `struct notes_tree` when merging notes
>   builtin/fast-import: plug trivial memory leaks
>   builtin/fast-export: fix leaking diff options
>   builtin/fast-export: plug leaking tag names
>   merge-ort: unconditionally release attributes index
>   sequencer: release todo list on error paths
>   unpack-trees: clear index when not propagating it
>   diff: fix leak when parsing invalid ignore regex option
>   builtin/format-patch: fix various trivial memory leaks
>   userdiff: fix leaking memory for configured diff drivers
>   builtin/log: fix leak when showing converted blob contents
>   diff: free state populated via options
>   builtin/diff: free symmetric diff members

Thanks for a pleasant read.  I had a few minor comments but they
likely show more of my misreading of the patches than real problems
;-)

