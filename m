Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43648002E
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412847; cv=none; b=jjdaEYZ+oXDOvkzdgeEyIhEWcnhFOBRbUcmVvOgP/NzvOJEpi3Qxzm6of2fE6oaGygea0DzXhzdof2+BZbJhHw7oC6gEdsht/wwSUz4yXw81iAN37zmjlM7nuiljh2OzNxJjtb1zaYZnPKYix9jLzYPi4hUDx0/AHerFhi6Lwuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412847; c=relaxed/simple;
	bh=M67pGqJwtAYporbso3nBv4SPUzeteKHZxzs6baG45W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kCMI+QSn0GA0ZQzynlxooprGxOmPbzPrINGuoOB9PSpczqtqjCv1hSNvQ4ksOpkzQHjEHtsGzn5yGDnAMlexOEpH4t7+e2tHt94QWIEgsQWyZpchP9nTAsPSY+7HRF93hIT+aU+BQasUeD1ihoLqKBQeZuoU+u+jKuvhDZELSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Da+1VAdz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Da+1VAdz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DA6C71E1622;
	Thu,  8 Feb 2024 12:20:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M67pGqJwtAYporbso3nBv4SPUzeteKHZxzs6ba
	G45W4=; b=Da+1VAdzGykQ7dWRzEPmMTuPdIt+vqVr1Nxv+YRiAaHAcxyFGB0aZk
	tnk0XRadQjSaAgd1V7o1lrlgAznDxd7FRJpuQeKeyRQ5585WcXg9SGQt1RaFQRPM
	cvqUX6BrBB95TKe5a2l5+nVmDoDk88neADAR6FGdyHIxDeRL7njVk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D0A711E1621;
	Thu,  8 Feb 2024 12:20:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34A9E1E161F;
	Thu,  8 Feb 2024 12:20:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Vegard Nossum <vegard.nossum@oracle.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,
  Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
In-Reply-To: <eaf511ff-f9e0-47ac-ae2e-3de0efa928dd@gmail.com> (Phillip Wood's
	message of "Thu, 8 Feb 2024 14:26:11 +0000")
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
	<20240205141335.762947-1-vegard.nossum@oracle.com>
	<ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
	<xmqqy1bymru0.fsf@gitster.g>
	<b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
	<xmqqcytal01i.fsf@gitster.g>
	<4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com>
	<xmqq8r3wcjq2.fsf@gitster.g>
	<ae8d96b7-93b0-4460-b7ed-ffebaddd6f97@oracle.com>
	<eaf511ff-f9e0-47ac-ae2e-3de0efa928dd@gmail.com>
Date: Thu, 08 Feb 2024 09:20:40 -0800
Message-ID: <xmqqv86yoot3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 62F84278-C6A6-11EE-BDC9-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think that typically for small suggestions like that we just add a
> Helped-by: trailer but feel free to add my SOB if you want.

Thanks, both.  Here is what I assembled from the pieces.

----- >8 --------- >8 --------- >8 --------- >8 -----
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Fri, 2 Feb 2024 10:18:50 +0100
Subject: [PATCH] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec' commands

Running "git cherry-pick" as an x-command in the rebase plan loses
the original authorship information.

To fix this, unset GIT_CHERRY_PICK_HELP for 'exec' commands.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c                   |  1 +
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index d584cac8ed..ed30ceaf8b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3647,6 +3647,7 @@ static int do_exec(struct repository *r, const char *command_line)
 	fprintf(stderr, _("Executing: %s\n"), command_line);
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command_line);
+	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
 	status = run_command(&cmd);
 
 	/* force re-reading of the cache */
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c5f30554c6..84a92d6da0 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -153,6 +153,18 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 	git rebase --continue
 '
 
+test_expect_success 'cherry-pick works with rebase --exec' '
+	test_when_finished "git cherry-pick --abort; \
+			    git rebase --abort; \
+			    git checkout primary" &&
+	echo "exec git cherry-pick G" >todo &&
+	(
+		set_replace_editor todo &&
+		test_must_fail git rebase -i D D
+	) &&
+	test_cmp_rev G CHERRY_PICK_HEAD
+'
+
 test_expect_success 'rebase -x with empty command fails' '
 	test_when_finished "git rebase --abort ||:" &&
 	test_must_fail env git rebase -x "" @ 2>actual &&
-- 
2.43.0-561-g235986be82

