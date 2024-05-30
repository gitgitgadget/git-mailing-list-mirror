Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7741A94
	for <git@vger.kernel.org>; Thu, 30 May 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088986; cv=none; b=SQ71ZXupoPHeLcFDp+hqD//AvjNFPV8f3SKc8KWGTK+gcGErDv7AcvUSdL4phgENE/OFEI7fvtPj32mOnFcBQCsnI27OPggpzm1appqaAqSS0P9k7poXknp683byCaWiOOW3cKgIJO3o/TenasZ4VGaC46b4PEZHdLM57AQlomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088986; c=relaxed/simple;
	bh=eF+DrZQgmu9gt9ASWEmlD0kMhWpntA0lAQjKhXezIhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P0TLF1ODdC/sm+TtxcIcMO5KlG9dR/zmCJbexR7mxzaXMry059Ia0RsgK6sc300geJYXuI5aN2dGv0VF1F+9cvtGMxh2ua7HfGlS0kF+xY4cCT8qgCyzMSx5QjD1yP1ZvqfeiDL5UIxm60IIHmE+3v1KNtJ3nI1plLkqdIaFC7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GxWoX/gH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GxWoX/gH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30AC02C405;
	Thu, 30 May 2024 13:09:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eF+DrZQgmu9gt9ASWEmlD0kMhWpntA0lAQjKhX
	ezIhg=; b=GxWoX/gHGNvIuzM3pJoy+/yT4kso0v6ECx7X8Htkm/2sryK64v9tMn
	jkn9k17HFSA4Wz/w1da1umIa1scDJLylnSQ7cZCnDp2ejYs5dhFuqME2RIKv75wk
	/GZFKxrqccOQ5yjuf52fbhgtt3CFi7GHvqN4gLv5bCn7uC82PfAYU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 288CA2C404;
	Thu, 30 May 2024 13:09:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F9F22C403;
	Thu, 30 May 2024 13:09:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Stefan Haller <lists@haller-berlin.de>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/2] rebase -i: improve error message when picking merge
In-Reply-To: <pull.1672.v3.git.1717076630.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Thu, 30 May 2024 13:43:48 +0000")
References: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
	<pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>
Date: Thu, 30 May 2024 10:09:36 -0700
Message-ID: <xmqq7cfbp6pb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6516954C-1EA7-11EF-A44D-6488940A682E-77302942!pb-smtp2.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> If the user tries to pick a merge commit error out when parsing the todo
> list rather than complaining when trying to pick the commit.
>
> Sorry for the delay in re-rolling, thanks to Junio and Patrick for their
> comments on V2. I've rebased on to master to avoid a conflict with
> 'ps/the-index-is-no-more' and updated patch 2 to
>
>  * Add advice on how rebase a merge commit as suggested by Junio. To avoid
>    duplication between the error messages and the advice I've shortened the
>    error messages.
>
>  * Rework the control flow to make it easier to extend checks on merge
>    commits if new commands are added in the future as suggested by Junio
>
> Phillip Wood (2):
>   rebase -i: pass struct replay_opts to parse_insn_line()
>   rebase -i: improve error message when picking merge
>
>  Documentation/config/advice.txt |  2 +
>  advice.c                        |  1 +
>  advice.h                        |  1 +
>  builtin/rebase.c                | 17 ++++---
>  rebase-interactive.c            | 21 +++++----
>  rebase-interactive.h            |  9 ++--
>  sequencer.c                     | 83 ++++++++++++++++++++++++++++-----
>  sequencer.h                     |  4 +-
>  t/t3404-rebase-interactive.sh   | 45 ++++++++++++++++++
>  9 files changed, 153 insertions(+), 30 deletions(-)
>
>
> base-commit: 3a57aa566a21e7a510c64881bc6bdff7eb397988
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1672%2Fphillipwood%2Frebase-reject-merges-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1672/phillipwood/rebase-reject-merges-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1672
>
> Range-diff vs v2:
>
>  1:  1bcf92c6105 ! 1:  91c6f2f1b45 rebase -i: pass struct replay_opts to parse_insn_line()
>      @@ builtin/rebase.c: static int edit_todo_file(unsigned flags)
>       @@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>        		error(_("could not generate todo list"));
>        	else {
>      - 		discard_index(&the_index);
>      + 		discard_index(the_repository->index);
>       -		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
>       -						&todo_list))
>       +		if (todo_list_parse_insn_buffer(the_repository, &replay,

OK.  It would probably have been unnecessary to rebase only for this
update.

>      + ## Documentation/config/advice.txt ##
>      +@@ Documentation/config/advice.txt: advice.*::
>      + 		`pushNonFFCurrent`, `pushNonFFMatching`, `pushAlreadyExists`,
>      + 		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
>      + 		simultaneously.
>      ++	rebaseTodoError::
>      ++		Shown when there is an error after editing the rebase todo list.

This thing is new.  It is unclear to me if this description is clear
enough to readers that we are checking the edited todo list for
errors.  It is clear enough from the actual code change, and the
readers come to this list after advise_if_enabled() triggers and
reports that the rebaseTodoError knob allows them to squelch it, so
it probably is OK.

Thanks, will replace.  Let's see if we see comments from others and
then mark it for 'next' soonish.

