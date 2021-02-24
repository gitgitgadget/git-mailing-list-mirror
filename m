Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA77C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 07:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A1564EC8
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 07:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhBXHIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhBXHIb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 02:08:31 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A283DC06174A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 23:07:51 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id s6so1270585otk.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 23:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rso1YNC9+sHBjuCXSiB75Khf7LebsQfHGIkPZo689tg=;
        b=GOYdqzoyIioMnq6UrUcq2VJrLJLMBOq7voRwRH3Yfu+zSmdLiVsRk2+UsnPO5dBaiN
         +67IDNkK1aWlcJH3FU5J9LsOA20fGkdnGsyb/O2tKFXgu5D5sYRMqmtbwFPKqH8UqisZ
         z5/7HrnyL7vHTZwZuvOIZa5QN5/VPFMWTLXfbRdZMwCXDVFyw/eyE76YBQzk27/qF+Fi
         DEKTvvcLOJSIpinBjIElQABpEUiC7zzxVO2EC3TqQca4n+6jwqep/HxFEP+R75jhQlEl
         ADcKILTOjDFWEKytBFaeBNTHCRiOX7R2c2g/P8zxagT/nqFCXyEe88qc6jXWmw2VzDlY
         yuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rso1YNC9+sHBjuCXSiB75Khf7LebsQfHGIkPZo689tg=;
        b=pQdSbSYhgC56qg+ceY1vCpSZbLiCXw4PNZWVd/Rsi/5V4pPQmXYJp6BLVVOrPuuTOf
         8YmUvLP2DQKaLRykqE8CaqpslUVqe8xNtE5rIQNeLF5YFVIo4rOL5WPTVO7Eh1qXNmUp
         pclWCHATCiFhcitjtdGV4XS4H7vTklQ3gqMyr2xqZItPjrCOsADn6DAiipVE6M+/2tQ2
         /i/bMHD1cRLK2VSDEhSLmIq1F2wiWw0oXUZTzQOvDwn2J/6cGToMlUTdhBdasfR8f71q
         qeNX0f6zw6guC3QgjKAfbCk23JY0zs/NLbXrEB7RVkSPN57ZmWtBSm/H0GLxpO9dEKte
         cegg==
X-Gm-Message-State: AOAM53325Hv3ibXzQ9Ai0DP9OU9FCkpeQKOyh8iQSh9qj5nfw1EzvWxC
        O58ellMJ/9PgNICXj1s2AzoVFuvy28vKvIzHizI=
X-Google-Smtp-Source: ABdhPJxS3AYTX1mzZc6iOXB8KK1TC9LQdGkVkBt8LjxcqwI1xGx2+nv6tTVOW9FtK8HDklxSG37WuD8BzCmqsSYzh1E=
X-Received: by 2002:a05:6830:100c:: with SMTP id a12mr8249727otp.345.1614150471093;
 Tue, 23 Feb 2021 23:07:51 -0800 (PST)
MIME-Version: 1.0
References: <xmqq4ki21ioz.fsf@gitster.g>
In-Reply-To: <xmqq4ki21ioz.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 23:07:40 -0800
Message-ID: <CABPp-BGtFy+hE8A79me0v5SMkxAHMEKhvNLcEnJtr+gmua5g7Q@mail.gmail.com>
Subject: Re: [PATCH] push: do not turn --delete '' into a matching push
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Tilman Vogel <tilman.vogel@web.de>,
        =?UTF-8?Q?Jan_Kr=C3=BCg?= =?UTF-8?Q?er?= <jk@jk.gs>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 10:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> When we added a syntax sugar "git push remote --delete <ref>" to
> "git push" as a synonym to the canonical "git push remote :<ref>"
> syntax at f517f1f2 (builtin-push: add --delete as syntactic sugar
> for :foo, 2009-12-30), we weren't careful enough to make sure that
> <ref> is not empty.
>
> Blindly rewriting "--delete <ref>" to ":<ref>" means that an empty
> string <ref> results in refspec ":", which is the syntax to ask for
> "matching" push that does not delete anything.
>
> Worse yet, if there were matching refs that can be fast-forwarded,
> they would have been published prematurely, even if the user feels
> that they are not ready yet to be pushed out, which would be a real
> disaster.
>
> Noticed-by: Tilman Vogel <tilman.vogel@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * So this time with an obvious test.  It is somewhat surprising
>    that this has been left unnoticed for the past 10 years.
>
>  builtin/push.c        | 2 +-
>  t/t5516-fetch-push.sh | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 03adb58602..194967ed79 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -115,7 +115,7 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
>                         else
>                                 refspec_appendf(&rs, "refs/tags/%s", ref);
>                 } else if (deleterefs) {
> -                       if (strchr(ref, ':'))
> +                       if (strchr(ref, ':') || !*ref)
>                                 die(_("--delete only accepts plain target ref names"));
>                         refspec_appendf(&rs, ":%s", ref);
>                 } else if (!strchr(ref, ':')) {
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 3ed121d0ce..7eee4e782f 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -824,6 +824,11 @@ test_expect_success 'push --delete refuses src:dest refspecs' '
>         test_must_fail git push testrepo --delete master:foo
>  '
>
> +test_expect_success 'push --delete refuses empty string' '
> +       mk_test testrepo heads/master &&
> +       test_must_fail git push testrepo --delete ""
> +'
> +
>  test_expect_success 'warn on push to HEAD of non-bare repository' '
>         mk_test testrepo heads/master &&
>         (
> --
> 2.30.1-824-gddfeb442a8

Reviewed-by: Elijah Newren <newren@gmail.com>
