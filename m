Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8B1993AE
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920883; cv=none; b=lN0iX8uf2j3WsrZMcsVCjhZRnJZkjcEvsraUyXqd7BRIr8HZ8iLPqHnN1jS/ZWrgsr0gNQQiRBmfJsi0zJ83qIGhwswnseHx2YODke3bqvdkfVEvNdzkA4sPkwwzL1n5YVrUXOpNsS02+zbZ590Brb4VepDpzBnXwkm9vULIfnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920883; c=relaxed/simple;
	bh=Jg9Xo4fJdE1IutoIa+68x4yHhTIXAxlR3zfgjRuioHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q4j1LZRuSNZWW2qp0EfSqtFEPgkUmR/KdUX/VQSgxeeU1xUeOjgXv3MrIHAUrH8609JH1M4dQ1vCly+1PXqEI4b7miUro/27Qa6E5xqux8moJu/1Abj7ULRUDF4Kv2n74iV53cdn8SDchccZp+d3V61EV97Rjd9um1v5joJ0O8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wKF5mReF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wKF5mReF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 594DC35810;
	Thu, 25 Jul 2024 11:21:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Jg9Xo4fJdE1IutoIa+68x4yHhTIXAxlR3zfgjR
	uioHc=; b=wKF5mReFdxm8QHQfOXliQwLduOsvDljjn4ldgtlK6KiJCHdI/hVTYn
	EUwdO5iZSI8iA/5/Q8RqhfNaHE2AmV2pgR7LFREn0nQQ0Z1ztEQGDK8jcymVGMh6
	2k2tvNmJjIZTj1ec1sCBxKggyo7RudX3V5PjNGlKETw4xPFZUj0dg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 519603580F;
	Thu, 25 Jul 2024 11:21:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE81D3580E;
	Thu, 25 Jul 2024 11:21:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,  Robert Coup
 <robert.coup@koordinates.com>,  git <git@vger.kernel.org>
Subject: Re: bug/defaults: COMMIT_EDITMSG not reused after a failed commit
In-Reply-To: <20240724210854.GB557365@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 24 Jul 2024 17:08:54 -0400")
References: <CAFLLRpJgpjJpNRC_UpZmUXF2626e0BiH8CkOkoMrX3zcrOp7YA@mail.gmail.com>
	<xmqq1q3iyceq.fsf@gitster.g>
	<20240724-cryptic-private-mustang-3f50aa@meerkat>
	<20240724210854.GB557365@coredump.intra.peff.net>
Date: Thu, 25 Jul 2024 08:21:18 -0700
Message-ID: <xmqqmsm5lcpd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8B2EE298-4A99-11EF-85C1-BAC1940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> It just told you about COMMIT_EDITMSG, making it your responsibility to
> recover it before running "git commit" again. Your (1) makes it a little
> nicer, in that you can run "git commit" and then pull the content from
> the other file into your editor. Or we could even provide an option to
> pre-populate the message with it.
>
> Junio was lukewarm on the original, so I'm not sure why I've been
> holding on to it all these years. But maybe it would help as a guide for
> anybody who wants to work on what you've proposed above.

I think it was only me being allergic of the use of atexit() for a
narrow single purpose, and perhaps I was hoping that we might be
able to come up with a bit more generalized interface, possibly
based on atexit(), to register common cleanup "hooks", as back then
we only had a handful of calls to atexit() in mid 2012, and I was
worried that we may add a lot more of them in an uncontrolled way.

> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Mon, 23 Jul 2012 14:52:18 -0400
> Subject: [PATCH] commit: give a hint when a commit message has been abandoned
>
> If we launch an editor for the user to create a commit
> message, they may put significant work into doing so.
> Typically we try to check common mistakes that could cause
> the commit to fail early, so that we die before the user
> goes to the trouble.
>
> We may still experience some errors afterwards, though; in
> this case, the user is given no hint that their commit
> message has been saved. Let's tell them where it is.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/commit.c                          | 15 +++++++++++++++
>  t/t7500-commit-template-squash-signoff.sh |  3 +--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index dec78dfb86..42fefaa0e3 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -160,6 +160,16 @@ static int opt_parse_porcelain(const struct option *opt, const char *arg, int un
>  	return 0;
>  }
>  
> +static int mention_abandoned_message;
> +static void maybe_mention_abandoned_message(void)
> +{
> +	if (!mention_abandoned_message)
> +		return;
> +	advise(_("Your commit message has been saved in '%s' and will be\n"
> +		 "overwritten by the next invocation of \"git commit\"."),
> +	       git_path_commit_editmsg());
> +}
> +
>  static int opt_parse_m(const struct option *opt, const char *arg, int unset)
>  {
>  	struct strbuf *buf = opt->value;
> @@ -1090,6 +1100,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  			exit(1);
>  		}
>  		strvec_clear(&env);
> +		atexit(maybe_mention_abandoned_message);
> +		mention_abandoned_message = 1;
>  	}
>  
>  	if (!no_verify &&
> @@ -1813,11 +1825,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
>  		rollback_index_files();
>  		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
> +		mention_abandoned_message = 0;
>  		exit(1);
>  	}
>  	if (template_untouched(&sb, template_file, cleanup_mode) && !allow_empty_message) {
>  		rollback_index_files();
>  		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
> +		mention_abandoned_message = 0;
>  		exit(1);
>  	}
>  
> @@ -1855,6 +1869,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		die("%s", err.buf);
>  	}
>  
> +	mention_abandoned_message = 0;
>  	sequencer_post_commit_cleanup(the_repository, 0);
>  	unlink(git_path_merge_head(the_repository));
>  	unlink(git_path_merge_msg(the_repository));
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 4dca8d97a7..c476a26235 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -396,13 +396,12 @@ test_expect_success 'consecutive amend! commits remove amend! line from commit m
>  
>  test_expect_success 'deny to create amend! commit if its commit msg body is empty' '
>  	commit_for_rebase_autosquash_setup &&
> -	echo "Aborting commit due to empty commit message body." >expected &&
>  	(
>  		set_fake_editor &&
>  		test_must_fail env FAKE_COMMIT_MESSAGE="amend! target message subject line" \
>  			git commit --fixup=amend:HEAD~ 2>actual
>  	) &&
> -	test_cmp expected actual
> +	grep "Aborting commit due to empty commit message body" actual
>  '
>  
>  test_expect_success 'amend! commit allows empty commit msg body with --allow-empty-message' '
