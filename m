From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Mon, 03 Jun 2013 11:40:19 -0700
Message-ID: <7vr4gjdomk.fsf@alter.siamese.dyndns.org>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:40:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZgB-0003Cy-TS
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126Ab3FCSkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 14:40:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51892 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756882Ab3FCSkW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:40:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11ACC25E52;
	Mon,  3 Jun 2013 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ueq9F/GGtwG4t9dxUf86oXAZ8Qk=; b=wCijK6
	1M19sjFJ5vsZTIx2MqiKEgrd6sEbyeRSfk/bM3mRKLWjKvKXl56XCb6pqJ6AUL6o
	e7MDTAsgXo2ukhMUHxdPKJZOdKGt7g3Rk9UZ+gFo84Dq4Fvk6ThTOEe7ZVaomMzD
	8B+QZNLJg6TU2vW0qFxCi0/6zV7GbiokQ4nQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U0BRl0xChKtizjnPUWB9oFAMlufDYRAT
	Py/8gqMsV71LoWTSa3Zw/LCe5UmjnBkS5ZMhYMSJ/U47f3h27843O5mouIUHORnn
	OVZl9pA1UCxjFlmGyyb4KRvHAKlnlUclg3+uafpdClAOs1aBvWQrmusNZ5IWO56y
	23fb97RwPUQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05DD825E51;
	Mon,  3 Jun 2013 18:40:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BF6925E50;
	Mon,  3 Jun 2013 18:40:21 +0000 (UTC)
In-Reply-To: <1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 28 May 2013 22:56:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B963C4E-CC7D-11E2-B3AD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226261>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Pretty much what it says on the tin.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-cherry-pick.txt   |  3 +++
>  builtin/revert.c                    |  2 ++
>  sequencer.c                         |  6 ++++++
>  sequencer.h                         |  1 +
>  t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
>  5 files changed, 25 insertions(+)
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

Not quite sure.  Is this "instead of recording an empty commit,"
(which may or may not fail depending on the allow-empty settings)?

If that is what this patch is meant to do, I think the change makes
sense.

>  --strategy=<strategy>::
>  	Use the given merge strategy.  Should only be used once.
>  	See the MERGE STRATEGIES section in linkgit:git-merge[1]
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 0401fdb..0e5ce71 100644
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
