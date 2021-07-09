Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D903C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 19:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64D8613C5
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 19:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGITQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 15:16:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64017 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGITQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 15:16:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDBF9148A37;
        Fri,  9 Jul 2021 15:14:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7jmJvTKuJUQbseXkJYy+C9cE+DRQhtIbbsl0dG
        09vI8=; b=NwqBym2oeXvUr8KTS+xJdeQVFEnt1IYCNr8zFQ6jNLmtZTrNDChGCe
        QoJeHj+qTucjxsdml9gcHa236S3LKgtoFd5SgembkB5lUICdYIHlvUBLknHWbwb/
        I9OjjI76c0HtZSKD+DTStMnFv3CBt1BemPrcLHFBI+itzhLPUoNcc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E620B148A36;
        Fri,  9 Jul 2021 15:14:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43589148A34;
        Fri,  9 Jul 2021 15:14:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hu Jialun <hujialun@comp.nus.edu.sg>
Cc:     git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] commit: remove irrelavent prompt on
 `--allow-empty-message`
References: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
        <20210709180732.2678818-2-hujialun@comp.nus.edu.sg>
Date:   Fri, 09 Jul 2021 12:14:09 -0700
In-Reply-To: <20210709180732.2678818-2-hujialun@comp.nus.edu.sg> (Hu Jialun's
        message of "Sat, 10 Jul 2021 02:07:32 +0800")
Message-ID: <xmqq7dhz711a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7870A52-E0E9-11EB-823A-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hu Jialun <hujialun@comp.nus.edu.sg> writes:

> Even when the `--allow-empty-message` option is given, "git commit"
> offers an interactive editor session with prefilled message that says
> the commit will be aborted if the buffer is emptied, which is wrong.
>
> Remove the "an empty message aborts" part from the message when the
> option is given to fix it.

The updated log message is much better than the old iteration, where
the "empty message aborts" was called "irrelevant" when it is actively
"wrong".  Now we call it "wrong".

Let's update the title of the commit to match, e.g.

    commit: tweak cleanup hint when --allow-empty-message is in effect

or something along that line.

> +		const char *hint_cleanup_all = allow_empty_message ?
> +			_("Please enter the commit message for your changes."
> +			  " Lines starting\nwith '%c' will be ignored.\n") :
> +			_("Please enter the commit message for your changes."
> +			  " Lines starting\nwith '%c' will be ignored, and an empty"
> +			  " message aborts the commit.\n");
> +		const char *hint_cleanup_space = allow_empty_message ?
> +			_("Please enter the commit message for your changes."
> +			  " Lines starting\n"
> +			  "with '%c' will be kept; you may remove them"
> +			  " yourself if you want to.\n") :
> +			_("Please enter the commit message for your changes."
> +			  " Lines starting\n"
> +			  "with '%c' will be kept; you may remove them"
> +			  " yourself if you want to.\n"
> +			  "An empty message aborts the commit.\n");

Local convention in this file seems to be that multi-line ?:
expressions are folded with ? and : operators at the beginning, not
at the end, of the lines, e.g. I see this construct in the same file.

			reflog_msg = is_from_cherry_pick(whence)
					? "commit (cherry-pick)"
					: is_from_rebase(whence)
					? "commit (rebase)"
					: "commit";

So, let's mimick and make the above more like this:

		const char *hint_cleanup_all = allow_empty_message
			? _("Please enter the commit message for your changes."
			    " Lines starting\nwith '%c' will be ignored.\n")
			: _("Please enter the commit message for your changes."
			    " Lines starting\nwith '%c' will be ignored, and an empty"
			    " message aborts the commit.\n");

> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 7d02f79c0d..54c2082acb 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -498,7 +498,7 @@ test_expect_success 'invalid message options when using --fixup' '
>  cat >expected-template <<EOF
>  
>  # Please enter the commit message for your changes. Lines starting
> -# with '#' will be ignored, and an empty message aborts the commit.
> +# with '#' will be ignored.
>  #
>  # Author:    A U Thor <author@example.com>
>  #

Perfect.
