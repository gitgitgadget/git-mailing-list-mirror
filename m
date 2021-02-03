Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D9C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 22:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C78564F4D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 22:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhBCWv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 17:51:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58320 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhBCWv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 17:51:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17D7111BA19;
        Wed,  3 Feb 2021 17:51:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=da7B+lPAXM2SMGnbzA2QZIvsd/U=; b=p5syrn
        vxblOc3+68H0w3+Mwl3P7iREFroRz2ISSy2k3IDr0oV+UtKb498NSmiSWmVtuhik
        r4stxUQGtY9/6Mpw49GBQWrKPoDtmIp6aAZ1BoHcWEQQ3STkpy885L/70e1uLSWZ
        4oBeAhKYcTA2MXrgS9PpOPh0JsV66HY9qBVPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AhqKNYCVAjMa3MUGKh9hfmUJblNxtRP7
        x4U4If71bogXma3g7UPzdQqAy8Th3x1DYc/FUAwuKEGPr62kAZdHHj0M6LbP7thu
        1CPSyGWZVDjI0eFaoFaSY+ATs45feJFY2A/AL6MK3S56QWzNT88XM4LmsDy7wrKO
        POKnGr6PZzQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FDBB11BA17;
        Wed,  3 Feb 2021 17:51:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1CDE211BA15;
        Wed,  3 Feb 2021 17:51:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lance Ward via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Lance Ward <ljward10@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] status: fix verbose status coloring inconsistency
References: <pull.954.git.git.1612388043875.gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 14:51:09 -0800
In-Reply-To: <pull.954.git.git.1612388043875.gitgitgadget@gmail.com> (Lance
        Ward via GitGitGadget's message of "Wed, 03 Feb 2021 21:34:03 +0000")
Message-ID: <xmqqa6skbw9u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F849594-6672-11EB-8548-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lance Ward via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lance Ward <ljward10@gmail.com>
>
> Currently setting color.status=always results in a colored diff when

Our log message begins with the description of the current status,
so "Currently" is not something you need to say.

What command with what options?  "git status" does not even show
"diff" at least by default. 

    ... goes, experiments, and guesses what the poster means ...

Perhaps you meant something like this:

    status: honor color.status=always when sending diff output to non tty

    "git status --verbose" shows the patch in color by default (in
    addition to the list of added, modified, and/or deleted paths)
    when the output goes to a tty.  With color.status configuration
    set to 'always' and sending the output to a non-tty, the list of
    paths are colored as expected, but the patch output loses colors.

And then after the description of the current status, you give
orders to a patch monkey to fix the code "to be like so".

    This is because the code did not pass the settings read from the
    configuration and the command line to the underlying machinery
    that generates the patch output.  Fix it to do so.

> going stdout, but an uncolored diff when going to other files or piping
> to other commands such as less or more.  This patch fixes this and now
> color.status=always implies color.diff=always regardless of the output
> location.
>
> Signed-off-by: Lance Ward <ljward10@gmail.com>
> ---

Eric may deserve Helped-by: mention.

>  t/t7527-status-color-pipe.sh | 55 ++++++++++++++++++++++++++++++++++++

Don't we already have test that checks "status" output including its
coloring already? I'd rather see us adding to existing test script,
than allocating a new number for a small subset of features being
tested for a command.  After all, test numbers are limited resource.

> +test_expect_success setup '
> +	echo 1 >original &&
> +	git add .
> +'
> +
> +# Normal git status does not pipe colors

What does "pipe colors" mean?  "color its output on a non-tty", you mean?

> +test_expect_success 'git status' '
> +	git status >raw &&
> +	test_decode_color <raw >out &&
> +	grep "original$" out
> +'

Not "new file: *original$" or something less false-positive prone?

> +# Test color.status=never (expect same as above)
> +test_expect_success 'git -c color.status=never status' '
> +	git -c color.status=never status >raw &&
> +	test_decode_color <raw >out &&
> +	grep "original$" out
> +'
> +

Would it make sense to have tests for color.status=true, I wonder.
It requires tty to actually "see" the colors output but sending
the output to tty is the normal use case, so we should care...

> +# Test color.status=always
> +test_expect_success 'git -c color.status=always status' '
> +	git -c color.status=always status >raw &&
> +	test_decode_color <raw >out &&
> +	grep "original<RESET>$" out
> +'

OK.  I understand that this passes without the patch below.

> +# Test verbose (default)
> +test_expect_success 'git status -v' '
> +	git status -v >raw &&
> +	test_decode_color <raw >out &&
> +	grep "+1" out
> +'

I think you meant to catch the new contents "1" stored in the file
whose name is "original", but this will hit the hunk header, no?

    @@ -0,0 +1 @@
    +1

IOW, the grep patterns throughout this patch may be a bit too loose
and prone to false hits.

> +# Test verbose color.status=never
> +test_expect_success 'git -c color.status=never status -v' '
> +	git -c color.status=never status -v >raw &&
> +	test_decode_color <raw >out &&
> +	grep "+1" out
> +'
> +
> +# Test verbose color.status=always
> +test_expect_success 'git -c color.status=always status -v' '
> +	git -c color.status=always status -v >raw &&
> +	test_decode_color <raw >out &&
> +	grep "<CYAN>@@ -0,0 +1 @@<RESET>" out &&
> +	grep "GREEN>+<RESET><GREEN>1<RESET>" out
> +'

Is the missing open bra "<" before GREEN intended?

Are we forcing the standard palette?

> +test_done
> diff --git a/wt-status.c b/wt-status.c
> index 0c8287a023e..1e9c899a7b2 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1064,6 +1064,8 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
>  	if (s->fp != stdout) {
>  		rev.diffopt.use_color = 0;
>  		wt_status_add_cut_line(s->fp);
> +	} else {
> +		rev.diffopt.use_color = s->use_color;
>  	}
>  	if (s->verbose > 1 && s->committable) {
>  		/* print_updated() printed a header, so do we */
>
> base-commit: e6362826a0409539642a5738db61827e5978e2e4

Thanks.
