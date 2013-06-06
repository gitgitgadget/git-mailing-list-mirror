From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/9] cherry-pick: add --skip-empty option
Date: Thu, 06 Jun 2013 11:30:38 -0700
Message-ID: <7vbo7jytv5.fsf@alter.siamese.dyndns.org>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
	<1370509144-31974-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 20:30:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkexS-0005e7-Tp
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 20:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab3FFSan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 14:30:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab3FFSam (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 14:30:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C7E122714;
	Thu,  6 Jun 2013 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CH8gGqcWS7CwiZAyv/oj6Qsi+G4=; b=ir2eCS
	MngsGklyx27fTBuASrBZfcZQqQ3nHK8eko3Y81+fc9VLPvkL0z9DphQVNPytRQYF
	DjWPah+3wVvGiB1+iwSDDxbTbEEESE4fFPFbZ8I8YVSHtcVvbAEfG3CoF3Ujgrdl
	QWYUbQss+M9x+xXqZ9EHYSReRvgp7lG8ku6G4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wMVyMleSIj20UrTZA2jqrwXhmaO4xB/1
	18mEaTARsTPxDGuMn4umjEIsl82XPtClxPR5jlA9cXhne0pSIc7NtrzBeFKzXgMt
	oDXfTn6b7/CT15uC0P0tzUaDf9BFZpK9IhGGN9nhV/U9Tan/HngAfOOlkaXencMh
	RjKWcl//5vU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FFA822711;
	Thu,  6 Jun 2013 18:30:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 871BF2270A;
	Thu,  6 Jun 2013 18:30:39 +0000 (UTC)
In-Reply-To: <1370509144-31974-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 6 Jun 2013 03:58:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3025D32E-CED7-11E2-B9A1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226524>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Pretty much what it says on the tin.

And a bit more, isn't it?

The --keep-redundant-commits option implies the --allow-empty option
and it was perfectly acceptable to give both.  By making sure that
only at most one of -k-r-d, -a-e or -s-e is given, this forbids that
usage.

"It is implied so there is no *need* to give it redundantly" is
different from "It is implied so you shouldn't give it redundantly".

Like 7 and 8 that adds --quiet/--skip, don't we want this also for
revert?

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-cherry-pick.txt   |  3 +++
>  builtin/revert.c                    |  8 ++++++++
>  sequencer.c                         |  6 ++++++
>  sequencer.h                         |  1 +
>  t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
>  5 files changed, 31 insertions(+)
>
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index c205d23..fccd936 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -129,6 +129,9 @@ effect to your index in a row.
>  	redundant commits are ignored.  This option overrides that behavior and
>  	creates an empty commit object.  Implies `--allow-empty`.
>  
> +--skip-empty::
> +	Instead of failing, skip commits that are or become empty.
> +
>  --strategy=<strategy>::
>  	Use the given merge strategy.  Should only be used once.
>  	See the MERGE STRATEGIES section in linkgit:git-merge[1]
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 0401fdb..5a8453d 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -118,6 +118,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  		OPT_END(),
>  		OPT_END(),
>  		OPT_END(),
> +		OPT_END(),
>  	};
>  
>  	if (opts->action == REPLAY_PICK) {
> @@ -127,6 +128,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
>  			OPT_BOOLEAN(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
>  			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
> +			OPT_BOOLEAN(0, "skip-empty", &opts->skip_empty, N_("skip empty commits")),
>  			OPT_END(),
>  		};
>  		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
> @@ -144,6 +146,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  				"--abort", rollback,
>  				NULL);
>  
> +	verify_opt_mutually_compatible(me,
> +				"--allow-empty", opts->allow_empty,
> +				"--skip-empty", opts->skip_empty,
> +				"--keep-redundant-commits", opts->keep_redundant_commits,
> +				NULL);
> +
>  	/* implies allow_empty */
>  	if (opts->keep_redundant_commits)
>  		opts->allow_empty = 1;
> diff --git a/sequencer.c b/sequencer.c
> index f7be7d8..d3c7d72 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -627,6 +627,12 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		goto leave;
>  	}
>  
> +	if (opts->skip_empty && is_index_unchanged() == 1) {
> +		warning(_("skipping %s... %s"),
> +			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
> +			msg.subject);
> +		goto leave;
> +	}
>  	allow = allow_empty(opts, commit);
>  	if (allow < 0) {
>  		res = allow;
> diff --git a/sequencer.h b/sequencer.h
> index 1fc22dc..3b04844 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -34,6 +34,7 @@ struct replay_opts {
>  	int allow_empty;
>  	int allow_empty_message;
>  	int keep_redundant_commits;
> +	int skip_empty;
>  
>  	int mainline;
>  
> diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
> index 19c99d7..3dc19c6 100755
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -187,4 +187,17 @@ test_expect_success 'cherry-pick --stdin works' '
>  	check_head_differs_from fourth
>  '
>  
> +test_expect_success 'cherry-pick skip empty' '
> +	git clean -fxd &&
> +	git checkout -b empty fourth &&
> +	git commit --allow-empty -m empty &&
> +	test_commit ontop &&
> +	git checkout -f master &&
> +	git reset --hard fourth &&
> +	git cherry-pick --skip-empty fourth..empty &&
> +	echo ontop > expected &&
> +	git log --format=%s fourth..HEAD > actual
> +	test_cmp expected actual
> +'
> +
>  test_done
