Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94DF81F461
	for <e@80x24.org>; Thu, 27 Jun 2019 18:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF0Scv (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 14:32:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56032 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0Scv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 14:32:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C8D57B959;
        Thu, 27 Jun 2019 14:32:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wUClJoj3wVpHotF9X8/JrV78hmw=; b=MO5uks
        L7wF9UqfSu4xoA4bUE0ji0tUDXSqtai6FPZKt7AN/kmOqDxihktY38VBH+VvaUQH
        MrpsD4evKv2QVV8WLcp/NbFFGoVG5yxW2qF65AlFsyQC484/RuqATEFjlFfXQE5u
        RHLR547SjSKwR1gKabA9gu8aERG53vOGjj2fE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UpZDvLGJRK2W/EwH7CwBA0MK7QQFzL6c
        7fWb9xDdCZzL0hjPvIT9PT0Ne7M6+sZ25sq87pWL8KteJZ8qy2LoUMt57g9UXfqx
        1qajkUO6ijQge5pO+gjMPMtiF7rad/Vd3QjWwqwtMNAjhyB5WFQg6RrVrdjlq8Wf
        7DmInSiA20w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9503F7B958;
        Thu, 27 Jun 2019 14:32:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A13B27B957;
        Thu, 27 Jun 2019 14:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Vas Sudanagunta <vas@commonkarma.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Let rebase.reschedulefailedexec only affect interactive rebases
References: <pull.253.git.gitgitgadget@gmail.com>
        <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com>
Date:   Thu, 27 Jun 2019 11:32:42 -0700
In-Reply-To: <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 27 Jun 2019
        01:12:49 -0700 (PDT)")
Message-ID: <xmqqzhm2ang5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F477C824-9909-11E9-B56C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It does not make sense to stop non-interactive rebases when that config
> setting is set to `true`.

The reader is assumed to know that that config setting is only about
interactive rebases, including "rebase -x", which probably is an OK
explanation.

The subject needs a bit more work, though.  

"rebase: ignore rebase.reschedulefailedexec unless interative"

or something like that, perhaps.

> @@ -929,7 +930,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "root", &options.root,
>  			 N_("rebase all reachable commits up to the root(s)")),
>  		OPT_BOOL(0, "reschedule-failed-exec",
> -			 &options.reschedule_failed_exec,
> +			 &reschedule_failed_exec,
>  			 N_("automatically re-schedule any `exec` that fails")),
>  		OPT_END(),
>  	};
> @@ -1227,8 +1228,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		break;
>  	}
>  
> -	if (options.reschedule_failed_exec && !is_interactive(&options))
> +	if (reschedule_failed_exec > 0 && !is_interactive(&options))

OK, it used to be that we got affected by what came from "options",
which was read from the configuration.  Now we only pay attention to
the command line, which makes sense.

At this point, we have already examined '-x' and called
imply_interative(), so this should trigger for '-x' (without '-i'),
right?

>  		die(_("--reschedule-failed-exec requires an interactive rebase"));

I wonder if users understand that '-x' is "an interctive rebase".
The documentation can read both ways, and one of these may want to
be clarified.

	-x <cmd>, --exec <cmd>
	...
	This uses the --interactive machinery internally, but it can
	be run without an explicit --interactive.

Is it saying that use of interactive machinery is an impelementation
detail the users should not concern themselves (in which case, the
message given to "die()" above is misleading---not a new problem
with this patch, though)?  Is it saying "-x" makes it plenty clear
that the user wants interactive behaviour, so the users do not need
to spell out --interactive in order to ask for it (in which case,
"die()" message is fine, but "... internally, but ..." is
misleading)?

> +	if (reschedule_failed_exec >= 0)
> +		options.reschedule_failed_exec = reschedule_failed_exec;

OK, here we recover the bit that is only stored in a local variable
and pass it into cmd_rebase__interactive() machinery via the options
structure, which lets the codepath after this point oblivious to
this change, which is good ;-).

>  	if (options.git_am_opts.argc) {
>  		/* all am options except -q are compatible only with --am */
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index bdaa511bb0..4eff14dae5 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -265,4 +265,12 @@ test_expect_success '--reschedule-failed-exec' '
>  	test_i18ngrep "has been rescheduled" err
>  '
>  
> +test_expect_success 'rebase.reschedulefailedexec only affects `rebase -i`' '
> +	test_config rebase.reschedulefailedexec true &&
> +	test_must_fail git rebase -x false HEAD^ &&

These three lines gives us a concise summary of this patch ;-)

 - The test title can serve as a starting point for a much better
   patch title.

 - We trigger for '-x' without requiring '-i'.

> +	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
> +	git rebase --abort &&
> +	git rebase HEAD^
> +'
> +
>  test_done
