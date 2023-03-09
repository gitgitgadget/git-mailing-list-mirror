Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0953EC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 18:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCISGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 13:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCISGO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 13:06:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3579FFAD68
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 10:06:00 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y2so2860700pjg.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678385159;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjkRSY92xbtckr5YqhT7+TsKhNungFU7JUZX3ID8X2Q=;
        b=JGUYljeTNHta3IB3TzYZ2rFljS/qJEXOUQ1GimAiWrN/p9hLU63NUUreRCiFcQKwkX
         pG/1WBfIMSkoWiYKS0y0cGoIkbbltlXtZntwprdG9+B4QiVinITkpoPwj9wYHo8lUr7g
         GRBF43TrXTjgbalsTv5HWtqjJHPhG+nqdU/6MBILz+IcfKPyrimDZg3JMHtBeOsSY1Wp
         +cE/WQl9KJVQ16sRsmAson+XvYIU9q45REIqg1Wr3WKrRZljMTKf6VjHlWIdZqXFdQAc
         6nyeNYaaYLAtlcQ7X5jR7WMZuiJyq1CJYmfD+BteQwkddhWWvswultudP+uM19OBmWs9
         Sgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678385159;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bjkRSY92xbtckr5YqhT7+TsKhNungFU7JUZX3ID8X2Q=;
        b=LKzBSxQsLV0Ab+2cM9ZphUbdzBYVQZGoRcwDpI/1Ktx4CBJLviGk6kFNi/Ex7l5LyY
         euihlMOSzxXPQk7u2S7j8FN65VaKQJhcjlxtLITH6hwzMv/9rXlhXU+RWWrZYEhhzfPP
         b0c6H7v/R3xljsypwMWlhU4N1JJZqIlCU3z5o06j9stbIBn7628MQB2vpgSsqwzgbd9F
         fUtE++Q3RSxw+hZjRDOaf5kfuoU5Rbx6HYok5KVhvQRFCEosaoRTay4kv/NeHur1oDcy
         GU5TsnmM8Bj/y4wzzrv9yeVaC+yXI+MlgG6DOUI3Dip51y/dlewVe+Oes8MTGQyAmvjO
         Gi1Q==
X-Gm-Message-State: AO0yUKXgUhvPOG3Abhpj7MDMNURluJvrN3Z3xN5OxbKgOmweIxZqOnGh
        6skI8BkHmIX8EpHAtl/XtYU=
X-Google-Smtp-Source: AK7set9Rq1dhwxhwResCKeQJLoCYl0DGPplKcyE1R1zjH4xEUN4FtVYaGZQir7yppuCzX1BzANhjIw==
X-Received: by 2002:a17:90b:3b4f:b0:237:5dc6:ce14 with SMTP id ot15-20020a17090b3b4f00b002375dc6ce14mr23018155pjb.7.1678385159518;
        Thu, 09 Mar 2023 10:05:59 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id i21-20020a17090adc1500b00233790759cesm217032pjv.47.2023.03.09.10.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 10:05:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] add-patch: handle "* Unmerged path" lines
References: <xmqqy1o8wdgi.fsf@gitster.g>
        <bff58f23-6188-9b1e-b23a-fc3d94e9f72f@gmail.com>
        <ZAmfqC9WMl3XeyEr@coredump.intra.peff.net>
Date:   Thu, 09 Mar 2023 10:05:58 -0800
In-Reply-To: <ZAmfqC9WMl3XeyEr@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Mar 2023 03:58:16 -0500")
Message-ID: <xmqqcz5hby0p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So let's handle these lines as a noop. There's not really anything
> useful to do with a conflicted merge in this case, and that's what we do
> for other cases like "add -p". There we get a "diff --cc" line, which we
> accept as starting a new file, but we refuse to use any of its hunks
> (their headers start with "@@@" and not "@@ ", so we silently ignore
> them).
>
> It seems like simply recognizing the line and continuing in our parsing
> loop would work. But we actually need to run the rest of the loop body
> to handle matching up our colored/filtered output. But that code assumes
> that we have some active file_diff we're working on. So instead, we'll
> just insert a dummy entry into our array. This ends up the same as if we
> saw a "diff --cc" line (a file with no hunks).

OK.

> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This patch just fixes the immediate bug. There's some possible future
> work:
>
>   - we could print a warning that the path is ignored. We don't do that
>     for "diff --cc" entries, either, though often those involve an index
>     refresh that will print "my-conflict: needs merge" or similar.
>
>     Doing so would require parsing the path name from the line. We don't
>     seem to quote it in any way, though. So a name like "foo\nbar" would
>     probably produce confusing output (though this patch would do the
>     right thing; we'd have a dummy entry for "foo", and then just
>     tack the useless "bar" line onto it). We should decide what the diff
>     side should produce before we start trying to parse it here.

We should write a name like "foo\ndiff --git a/foo b/foo" off as "if
it hurts, don't do it" ;-).

>   - arguably we could shrink the list to only non-conflicted entries
>     beforehand. That's what the "patch" menu item does if you run a full
>     add--interactive. But it would be slower (you have to run an extra
>     diff now). On the other hand, that is what the perl version did (and
>     it consistently printed "ignoring unmerged: foo", and then said "No
>     changes".

We already lost scripted version so it is not a solace that it
worked correctly X-<.  I do not know what to think that it took this
long for people to hit this issue after 1fc18798 (Merge branch
'js/use-builtin-add-i', 2022-05-30).  The work to reimplement "add
-i" in C started at f83dff60 (Start to implement a built-in version
of `git add --interactive`, 2019-11-13) and looking at the output of 

    $ git log --format='%cI %h %s' --merges --grep="add-[ip]"

it seems that we have caught and fixed more bugs before we made it
the default than after, and all the more recent fixes are on the
smaller side, so I think we are in a good shape.

>   - it's a little weird that the interactive-patch parser will complain
>     if the first line of the diff is garbage, but not if it sees garbage
>     later on. If we were more strict, that would have triggered the BUG()
>     rather than tacking the unknown line to the hunk (and we _should_ be
>     able to recognize arbitrary hunk lines by their "[-+ ]" prefixes).

There is recount_edited_hunk() but I am not sure if it can be relied
upon (I've seen emacs's diff edit mode miscounting lines).

Another weird thing is that we do not complain if a patch does not
have any hunk, but I guess we are lucky---that is what this fix
takes advantage of ;-).

>     But there may be corner cases I'm not thinking of, so I left it for
>     now.
>
>  add-patch.c                |  3 ++-
>  t/t3701-add-interactive.sh | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index a86a92e1646..d7fc4f4cd21 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -483,7 +483,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  		if (!eol)
>  			eol = pend;
>  
> -		if (starts_with(p, "diff ")) {
> +		if (starts_with(p, "diff ") ||
> +		    starts_with(p, "* Unmerged path ")) {
>  			complete_file(marker, hunk);
>  			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
>  				   file_diff_alloc);
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 3a99837d9b1..e80e2b377c1 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -1075,4 +1075,25 @@ test_expect_success 'show help from add--helper' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'reset -p with unmerged files' '
> +	test_when_finished "git checkout --force main" &&
> +	test_commit one conflict &&
> +	git checkout -B side HEAD^ &&
> +	test_commit two conflict &&
> +	test_must_fail git merge one &&
> +
> +	# this is a noop with only an unmerged entry
> +	git reset -p &&
> +
> +	# add files that sort before and after unmerged entry
> +	echo a >a &&
> +	echo z >z &&
> +	git add a z &&
> +
> +	# confirm that we can reset those files
> +	printf "%s\n" y y | git reset -p &&
> +	git diff-index --cached --diff-filter=u HEAD >staged &&
> +	test_must_be_empty staged
> +'
> +
>  test_done
