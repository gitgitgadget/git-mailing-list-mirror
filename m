From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] merge: make prepare_to_commit responsible for write_merge_state
Date: Fri, 10 Jan 2014 16:11:11 -0800
Message-ID: <xmqqlhyn74yo.fsf@gitster.dls.corp.google.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
	<1389228344-38813-1-git-send-email-ryan@yaauie.com>
	<1389228344-38813-4-git-send-email-ryan@yaauie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Ryan Biesemeyer <ryan@yaauie.com>
X-From: git-owner@vger.kernel.org Sat Jan 11 01:11:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1mAc-0003Zv-99
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 01:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbaAKALS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 19:11:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbaAKALR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 19:11:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8442A62D03;
	Fri, 10 Jan 2014 19:11:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YAqgIiiA4vVtIUR+frcG3S3JzUg=; b=Tebe90
	DpHBt3j2isLxVq0SAEqoMiH422lsOGgAkZKoQQeUhpfR9SejexwgsYQ6BrpMVvNs
	3wau93IVurplp5NR5WluVx2Ziyh8+SlbJht9HtqKXPCG2sKkDRbDCAQlWk+aRBfa
	NGf0BQl5U0IXXUAgj1gAu6xgNhSk7ur7k183s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kfDp1Wx5Wvxz7Jpan7whOO1O0n/yXqIl
	VFm1FpMFt4QgETXDY+/y2JX4y/bpU65hgwlGgbU07aeaFgjrsSZulWE8xi+EU650
	kwYrTZbyIOvk1Qz9kX7L0LKe3uV2ql1PCBMhRTH+w9ptNEYSz5FLpjXmWl8GSiV3
	IIag+nR71sU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B12962D02;
	Fri, 10 Jan 2014 19:11:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD7DB62D00;
	Fri, 10 Jan 2014 19:11:15 -0500 (EST)
In-Reply-To: <1389228344-38813-4-git-send-email-ryan@yaauie.com> (Ryan
	Biesemeyer's message of "Thu, 9 Jan 2014 00:45:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E319E8B6-7A54-11E3-AA17-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240323>

Ryan Biesemeyer <ryan@yaauie.com> writes:

> When merging, make the prepare-commit-msg hook have access to the merge
> state in order to make decisions about the commit message it is preparing.

What information is currently not available, and if available how
would that help the hook to formulate a better message?

	I am not asking you to answer the question to me in an
	e-mail response. The above is an example of a natural
	question a reader of the above statement would have and
	would wish the log message already answered when the reader
	read it.

> Since `abort_commit` is *only* called after `write_merge_state`, and a
> successful commit *always* calls `drop_save` to clear the saved state, this
> change effectively ensures that the merge state is also available to the
> prepare-commit-msg hook and while the message is being edited.
>
> Signed-off-by: Ryan Biesemeyer <ryan@yaauie.com>
> ---

OK.  The most important part is that this makes sure that these
intermediate state files never remains after the normal codepath
finishes what it does.

You seem to be only interested in prepare-commit-msg hook, but
because of your calling write_merge_state() early, these state files
will persist while we call finish() and they are also visible while
the post-merge hook is run.  While I think it may be a good thing
that the post-merge hook too can view that information, the log
message makes it sound as if it is an unintended side effect of the
change.

>  builtin/merge.c                    |  3 ++-
>  t/t7505-prepare-commit-msg-hook.sh | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 4941a6c..b7bfc9c 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -802,7 +802,6 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
>  		error("%s", err_msg);
>  	fprintf(stderr,
>  		_("Not committing merge; use 'git commit' to complete the merge.\n"));
> -	write_merge_state(remoteheads);
>  	exit(1);
>  }
>  
> @@ -816,6 +815,8 @@ N_("Please enter a commit message to explain why this merge is necessary,\n"
>  static void prepare_to_commit(struct commit_list *remoteheads)
>  {
>  	struct strbuf msg = STRBUF_INIT;
> +
> +	write_merge_state(remoteheads);
>  	strbuf_addbuf(&msg, &merge_msg);
>  	strbuf_addch(&msg, '\n');
>  	if (0 < option_edit)
> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
> index 697ecc0..7ccf870 100755
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -183,4 +183,25 @@ test_expect_success 'with failing hook (merge)' '
>    )
>  '
>  
> +test_expect_success 'should have MERGE_HEAD (merge)' '
> +
> +	git checkout -B other HEAD@{1} &&
> +	echo "more" >> file &&

Style: no SP between the redirection operator and its target, i.e.

	echo more >>file &&

> +	git add file &&
> +	rm -f "$HOOK" &&
> +	git commit -m other &&
> +	git checkout - &&
> +	write_script "$HOOK" <<-EOF &&
> +	if [ -s "$(git rev-parse --git-dir)/MERGE_HEAD" ]; then

Style: no [], and no semicolon to join two lines of control
statement into one, i.e.

	if test -s ...
	then

> +		exit 0
> +	else
> +		exit 1
> +	fi
> +	EOF
> +	git merge other &&
> +	test "`git log -1 --pretty=format:%s`" = "Merge branch '"'"'other'"'"'" &&

Style:

    - After "sh t7505-*.sh v -i" fails for whatever reason, being
      able to inspect the trash directory to see what actually was
      produced is much easier way to debug than having to re-run the
      command with "sh -x" to peek into what the "test" statement is
      getting.

    - $(...) is much easier to read than `...`, but you do not have
      to use either if you follow the above.

i.e.

	git log -1 --format=%s >actual &&
        echo "Merge branch '\''other'\''" >expect &&
        test_cmp expect actual &&

> +	test ! -s "$(git rev-parse --git-dir)/MERGE_HEAD"
> +
> +'
> +
>  test_done
