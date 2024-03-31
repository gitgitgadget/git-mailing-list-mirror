Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF808144D19
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711925915; cv=none; b=WtI/zq3qGKUwaRZfmDsuNRiRP5XKrka+P3CiDuns2SDeE3/fMe+yZbxONN+/OxTJINJH69W1DV4RrbNRQ23J9otyheaqyOskgLE1ciZgTds+rPw3uArMc24VdMhIFw5JLl+WqUXDObsfaZUpy3SnL+Qbu+VBj1bzTWxq5XRMykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711925915; c=relaxed/simple;
	bh=+5PPvpOpc3iZyGEFtEyrkLUrtOE/fsVMo84SV+XtRN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r/QWTTdGFQuG+HVqaPbg3ua113KK5389wbkdiJU3UTPRB0A4fomi9cT7WPmY6iU2ZqJWR5dLikULQqLCQpKZXO+GvTw4k6gY0qNwyUkIIRNdnAS6U78Xad1St5J+kQoUsW/FS9Ka2dtkh8povN/8xRwuMUyRRdtCmMdptJhYzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EAo3oR2z; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EAo3oR2z"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F1A6C37750;
	Sun, 31 Mar 2024 18:58:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+5PPvpOpc3iZyGEFtEyrkLUrtOE/fsVMo84SV+
	XtRN0=; b=EAo3oR2zffkkvjcuNHsnLY0noiaCB/ShFKRMDPprf6wvVIRqyxlFOD
	Iad8cwzEQWFhxne+GXXnN+lKGzryo2sj5TYFrHagplw4fTMI7PA2whTJ0LioyRRE
	9hhMLVNtKaFmWDqc5h0H5VTpf9wT3cKZ4Yci2XcXDBBi6U0bvB584=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EA91E3774F;
	Sun, 31 Mar 2024 18:58:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7AE7E3774E;
	Sun, 31 Mar 2024 18:58:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Krefting <peter@softwolves.pp.se>
Cc: git@vger.kernel.org,
    "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>,
    Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] bisect: Honor log.date
In-Reply-To: <5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se> (Peter
	Krefting's message of "Sun, 31 Mar 2024 18:10:32 +0100 (CET)")
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se>
	<xmqqh6gni1ur.fsf@gitster.g>
	<5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se>
Date: Sun, 31 Mar 2024 15:58:21 -0700
Message-ID: <xmqq7chif1pu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2D1DB9D2-EFB2-11EE-858F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Peter Krefting <peter@softwolves.pp.se> writes:

> There are a lot of parameters to show that I have haven't used in my
> 14+ years of using Git, --summary is one of them. That's why I didn't
> add it.

Yup, that is semi-understandable, but especially given that it is
one of the options used by the original "diff-tree"'s invocation,
and that we are trying to replace it with "show" from the same
family of commands, it is a bit of disappointment.

We know we used to drive "diff-tree" with a known set of options,
and we are replacing the command to use "show" with some other set
of options.  I expected it to be fairly straight-forward and natural
to feed randomly picked commits to the two commands and compare
their output while deciding what that "some other set of options"
should be.  It is exactly the reason why I mentioned v1.0.0^0 is a
good test case.

Again, the output from them do not have to be identical---we are
primarily after catching unintended loss of informatino in such a
comparison, while gaining more confidence that it is a better
approach to use "show" output to produce output for end-user
consumption.

We have changed the bisect output before, as recent as in 2019 with
b02be8b9 (bisect: make diff-tree output prettier, 2019-02-22), and
heard nobody complain, so once we get to a reasonable set of options
and land this patch, maybe we can try improving on it safely.

FYI, attached is a comparison between the diff-tree output and
output from show with my choice of options for "show" picked from
the top of my head.  I do not think I personally like the --stat
output applied to a merge (--stat and --summary do not work N-way
like --cc does for patch text), but I think these options are the
closest parallel to what we have been giving to "diff-tree".

Thanks.

---------------------- >8 ----------------------
$ git diff-tree --pretty --stat --summary --cc v1.0.0^0
commit c2f3bf071ee90b01f2d629921bb04c4f798f02fa
Merge: 1ed91937e5cd59fdbdfa5f15f6fac132d2b21ce0 41f93a2c903a45167b26c2dc93d45ffa9a9bbd49
Author: Junio C Hamano <junkio@cox.net>
Date:   Wed Dec 21 00:01:00 2005 -0800

    GIT 1.0.0
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

 .gitignore                                       |   1 -
 Documentation/diff-options.txt                   |   8 +
 ...
 tar-tree.c                                       |   4 +-
 unpack-objects.c                                 |  13 +-
 66 files changed, 778 insertions(+), 617 deletions(-)
 delete mode 100644 Documentation/git-octopus.txt
 ...
 mode change 100644 => 100755 t/t5500-fetch-pack.sh
 mode change 100644 => 100755 t/t6101-rev-parse-parents.sh

---------------------- >8 ----------------------
$ git show -s --stat --summary --first-parent v1.0.0^0
commit c2f3bf071ee90b01f2d629921bb04c4f798f02fa
Merge: 1ed91937e5 41f93a2c90
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Dec 21 00:01:00 2005 -0800

    GIT 1.0.0
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

 .gitignore                                       |   1 -
 Documentation/diff-options.txt                   |   8 +
 ...
 tar-tree.c                                       |   4 +-
 unpack-objects.c                                 |  13 +-
 66 files changed, 778 insertions(+), 617 deletions(-)
 delete mode 100644 Documentation/git-octopus.txt
 ...
 mode change 100644 => 100755 t/t5500-fetch-pack.sh
 mode change 100644 => 100755 t/t6101-rev-parse-parents.sh
