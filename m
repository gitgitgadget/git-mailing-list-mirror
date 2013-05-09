From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] cherry-pick: make sure all input objects are commits
Date: Thu, 09 May 2013 12:47:33 -0700
Message-ID: <7vy5bo7x62.fsf@alter.siamese.dyndns.org>
References: <20130403092704.GC21520@suse.cz>
	<7v38v1yn8o.fsf@alter.siamese.dyndns.org>
	<20130411092638.GA12770@suse.cz>
	<CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
	<20130411110324.GD12770@suse.cz>
	<CALkWK0kb+2KZLvRJDJb_VrNNs1k4grsfyFv0HfYv0Kr9v4sChQ@mail.gmail.com>
	<20130411130652.GG12770@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 09 21:47:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaWoZ-0004eC-Dr
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 21:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643Ab3EITrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 15:47:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452Ab3EITrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 15:47:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E7D91D39D;
	Thu,  9 May 2013 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Oo7GjcRfEJoJ/51JKviywGeDLQ=; b=oc+MOH
	fbHMrvAlcrADz9sTIjYrF1aOLmciHFkaywgM3+f5ZbT6Uv9bn+063UoFeiZlI4dg
	gbyGhzxsi7ElBAsOlB/JyvLqYHC4hu5Y1HDIteavI8o//RSFFYNtkE2xicYjJ93e
	VzaODBnyLX2Kxb9Tjyky4waY+2uHEyXhmIfAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C4APlVn+nzYxTQJoa+U97kY/u29/zsIr
	Q5xEx1QkESsocPC1auv3X4JyMRavqrh3IePijiaw1UY/mOttvG1LIxBEN63DgoZI
	KVrmlhEUgQjc27OmU31XZO5X9jhvCaPwnGWnFujGAdUCBLp2jmxKMt6ygCGTa1vx
	55DVziw/aG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1368D1D39C;
	Thu,  9 May 2013 19:47:36 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F1431D39A;
	Thu,  9 May 2013 19:47:35 +0000 (UTC)
In-Reply-To: <20130411130652.GG12770@suse.cz> (Miklos Vajna's message of "Thu,
	11 Apr 2013 15:06:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BD5B0FA-B8E1-11E2-8863-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223775>

Miklos Vajna <vmiklos@suse.cz> writes:

> When a single argument was a non-commit, the error message used to be:
>
> 	fatal: BUG: expected exactly one commit from walk
>
> For multiple arguments, when none of the arguments was a commit, the error was:
>
> 	fatal: empty commit set passed
>
> Finally, when some of the arguments were non-commits, we ignored those
> arguments.  Fix this bug and make sure all arguments are commits, and
> for the first non-commit, error out with:
>
> 	fatal: <name>: Can't cherry-pick a <type>
>
> Signed-off-by: Miklos Vajna <vmiklos@suse.cz>

This turns out to be an irritatingly stupid change.  While I am
rebuilding a privately tagged tip of 'maint', I am seeing:

	fatal: v1.8.2.3: Can't cherry-pick a tag

You would want to reject non committish, not non commit.

>  sequencer.c                         | 18 ++++++++++++++++++
>  t/t3508-cherry-pick-many-commits.sh |  6 ++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index baa0310..61fdb68 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1047,6 +1047,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  {
>  	struct commit_list *todo_list = NULL;
>  	unsigned char sha1[20];
> +	int i;
>  
>  	if (opts->subcommand == REPLAY_NONE)
>  		assert(opts->revs);
> @@ -1067,6 +1068,23 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  	if (opts->subcommand == REPLAY_CONTINUE)
>  		return sequencer_continue(opts);
>  
> +	for (i = 0; i < opts->revs->pending.nr; i++) {
> +		unsigned char sha1[20];
> +		const char *name = opts->revs->pending.objects[i].name;
> +
> +		/* This happens when using --stdin. */
> +		if (!strlen(name))
> +			continue;
> +
> +		if (!get_sha1(name, sha1)) {
> +			enum object_type type = sha1_object_info(sha1, NULL);
> +
> +			if (type > 0 && type != OBJ_COMMIT)
> +				die(_("%s: can't cherry-pick a %s"), name, typename(type));
> +		} else
> +			die(_("%s: bad revision"), name);
> +	}
> +
>  	/*
>  	 * If we were called as "git cherry-pick <commit>", just
>  	 * cherry-pick/revert it, set CHERRY_PICK_HEAD /
> diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
> index 4e7136b..19c99d7 100755
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -55,6 +55,12 @@ one
>  two"
>  '
>  
> +test_expect_success 'cherry-pick three one two: fails' '
> +	git checkout -f master &&
> +	git reset --hard first &&
> +	test_must_fail git cherry-pick three one two:
> +'
> +
>  test_expect_success 'output to keep user entertained during multi-pick' '
>  	cat <<-\EOF >expected &&
>  	[master OBJID] second
