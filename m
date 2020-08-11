Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5E8C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76352078E
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="g/N4fs5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgHKP2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgHKP2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 11:28:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033EBC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:28:35 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n129so6329352qkd.6
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MT15X7zyQv9hJSoLg0EfV8U5c6w+H5d5y8/jHNNMYrY=;
        b=g/N4fs5X+L2K1P3gql28hDT6CoEgqph3I7xnEcAGg/1iJpAcGFBNY8wctD2FJmNN0s
         FfKJaeXpsuc2Ft9XEMSd8rJn0K2Sy+0Btz2MnpalDvWjO69mG424g4kcJ1QCVrQhIdUc
         0/LTIWQ06lH/T0iKi1jIhh9dC6ggWePQyqrO2EjtPpKXFXApEurffc/Rai448Rr9bK87
         czKyNAj0ktp3sgwNlaO2djMfub1CZnO9p3hIqXY2szXybWMFqEK4+Ry1nWqgmkaqZe+w
         2WylpiDU1snTKoFyXkrt8y6rz/OF0ORVmSlGIDfBDv9Hnf3rg8cfnuStSYnLKtpslqos
         MLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MT15X7zyQv9hJSoLg0EfV8U5c6w+H5d5y8/jHNNMYrY=;
        b=QOosmHnN9GJcD8L+rwjElNPKEyjCOVe3f25d4/OKJfTe/yU4241SHq2HCXdLV/RffB
         NgliWx/uepNOheUHtnyMN+y8lEryz/jw+wRJ10MgOl/+ZdJ7yqE/ukFuU9yIVSiY8eIC
         tuEj6535hYC3EFZik6RRGFksSKuiQFN+L42Zb1ATAL9ukmQELJ8V2Uyrgt6cP5VIb+OW
         qWw+NgIZROh6Oryqo+wzQZBc36l8lE5xieQtdAu+dSLZeb8tylUB+vp60Y0SgirAghw7
         UtOTE4wTtHirZ26GoRVC/LOP4e9lTmPHzfLtNHlrYlwDvc5O+A9uMJYXtOvNahLFLSRw
         Kneg==
X-Gm-Message-State: AOAM53056m/Cc2SQYjurfv5B819ibR5u0xOL3pMQbd1DaT5OFT3cHYLz
        C/CVvK3C7PsCc/b/Hwwe9iRdqQ==
X-Google-Smtp-Source: ABdhPJwwXz3aMhNb+2VlVI6PfZhPNx2OUiYBYEUPmtoQee/2+UOLYXjjHy212Yz/Cfc1h2QFk8L6zQ==
X-Received: by 2002:a05:620a:c88:: with SMTP id q8mr1659050qki.49.1597159714762;
        Tue, 11 Aug 2020 08:28:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id y14sm20215997qtc.84.2020.08.11.08.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:28:33 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:28:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>
Cc:     git@vger.kernel.org,
        Jussi =?utf-8?Q?Ker=C3=A4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
Message-ID: <20200811152832.GC19871@syl.lan>
References: <20200811131313.3349582-1-detegr@rbx.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811131313.3349582-1-detegr@rbx.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antti,

Thanks for working on this. I have a few thoughts below, but I think
that this is on the right track.

On Tue, Aug 10, 2020 at 04:13:15PM +0300, Antti Keränen wrote:
> 'todo_list_write_to_file' may overwrite the static buffer, originating
> from 'find_unique_abbrev', that was used to store the short commit hash
> 'c' for "# Rebase a..b onto c" message in the todo editor.

It would be great to know the commit that regressed, or if this has
always been the case. I'm not sure if you'll have a ton of luck
bisecting, since you indicate that this overwrite *may* occur (that
makes me think that it doesn't always happen, so your efforts to bisect
the change may be noisy).

> Fix by duplicating the string before usage, so subsequent calls to
> 'find_unique_abbrev' or other functions calling 'hash_to_hex_algop_r'
> can't overwrite the buffer.
>
> Found-by: Jussi Keränen <jussike@gmail.com>
> Signed-off-by: Antti Keränen <detegr@rbx.email>

> ---
>  sequencer.c                   |  7 ++++---
>  t/t3404-rebase-interactive.sh | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index fd7701c88a..0679adb639 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5178,13 +5178,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>  		    struct string_list *commands, unsigned autosquash,
>  		    struct todo_list *todo_list)
>  {
> -	const char *shortonto, *todo_file = rebase_path_todo();
> +	const char *todo_file = rebase_path_todo();
>  	struct todo_list new_todo = TODO_LIST_INIT;
>  	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
>  	struct object_id oid = onto->object.oid;
>  	int res;
> -
> -	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
> +	char *shortonto;

A minor nit is that you could probably move this line up to below the
'const char *' declaration (it makes sense why you have to drop the
const qualifier, though).

>
>  	if (buf->len == 0) {
>  		struct todo_item *item = append_new_todo(todo_list);
> @@ -5206,8 +5205,10 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>  		return error(_("nothing to do"));
>  	}
>
> +	shortonto = xstrdup(find_unique_abbrev(&oid, DEFAULT_ABBREV));
>  	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
>  			     shortonto, flags);
> +	free(shortonto);

OK. I think of two things here:

  1. Why are we calling 'find_unique_abbrev()' instead of
     'short_commit_name()'? We already have a commit pointer, so I don't
     see any reason that we should be reimplementing that function (even
     though it is a one-liner).

  2. If we should indeed be calling 'short_commit_name()', are there
     other callers that need to do the same duplication? In other words:
     could you say a little bit more about what makes
     'complete_action()' special in this regard?

>  	if (res == -1)
>  		return -1;
>  	else if (res == -2) {
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 4a7d21f898..09af16753c 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1760,6 +1760,19 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>  	test_i18ngrep "middle of a rebase -- cannot amend." err
>  '
>
> +test_expect_success 'todo has correct onto hash' '
> +	write_script dump-raw.sh <<-\EOF &&
> +		cat "$1"
> +	EOF

It's too bad that you have to write your own script here, since we
already have 'set_cat_todo_editor()', but it makes sense since you want
to retain the comments (something which set_cat_todo_editor explicitly
does not do).

So, this makes sense.

> +	git checkout branch1 &&
> +	(
> +		test_set_editor "$(pwd)/dump-raw.sh" &&
> +		git rebase -i HEAD~5 >actual
> +	) &&
> +	onto=$(git rev-parse --short HEAD~5) &&
> +	test_i18ngrep "^# Rebase ..* onto $onto .*" actual
> +'
> +

This all makes sense, too, and it leaves the below test as the last one
in the file, which is the right thing to do.

>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>  	test_editor_unchanged
> --
> 2.28.0

Thanks,
Taylor
