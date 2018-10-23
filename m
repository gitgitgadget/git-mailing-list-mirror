Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A57D1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeJXDoq (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 23:44:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38763 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDoq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 23:44:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id p3-v6so1606447qkb.5
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 12:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSrRD5QU5o/MdCsxy5LGiz3P+HNYWnK7p3GlAw4nJ94=;
        b=FnG+2ul43/wazmP4bEOASk7JBSkGr8YkPk68LvI+jXiOLmSyBBNTIL1nFq4+LzxoDx
         Esbg1W7lDFLSsL8shIMkxE0HzB4vFh5bGZith4ueyMC3yZAbeI2dk5t4LCmanI4me41z
         Las1UUe9vp0Fdr/3j4YzW08HzZocqSJ25zStk4ZnBHQWS1LAALy/2rB08LlPtEEhw0bL
         /XkgJvrxmbaXkY1e8xuh59CPPfPWNZiMrI8CRjh9sqsh5kBy4ZWNhHiu9w4QvMHoMfAa
         QtLfwAGd+svh7pWn42vJyj0svtfsvRffKCyoIUWaXHzK3iB5lW7eHiWABrwaDwSXrFE6
         Ix5w==
X-Gm-Message-State: AGRZ1gKwBZpogXDm91wxy+DiKtYrgClby6FdrJzEcJNTW7jGRkiwt2Ws
        /9W0iAH3p1I0z1pHJwmBPrcl2mYQAO1/kZNUL9Q=
X-Google-Smtp-Source: AJdET5ebZyGjTU7/AIRIAoLworRMt29C4qptB/C9UfIF/b+bVMRW0hF2ldQ7oPJO10OB0typ5SQWMYTZDHkc5Wp+kUM=
X-Received: by 2002:a37:8bc4:: with SMTP id n187-v6mr13474579qkd.220.1540322401806;
 Tue, 23 Oct 2018 12:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181023162941.3840-1-slawica92@hotmail.com>
In-Reply-To: <20181023162941.3840-1-slawica92@hotmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Oct 2018 15:19:49 -0400
Message-ID: <CAPig+cSeWhdKXBdwm6C5XTY0wjGsxBX9GUvPv5nWNZEQRirDUA@mail.gmail.com>
Subject: Re: [PATCH 1/3] [Outreachy] t3903-stash: test without configured user name
To:     slavicadj.ip2018@gmail.com
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        slawica92@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 12:31 PM Slavica <slavicadj.ip2018@gmail.com> wrote:
> This is part of enhancement request that ask for `git stash` to work even if `user.name` is not configured.
> The issue is discussed here: https://public-inbox.org/git/87o9debty4.fsf@evledraar.gmail.com/T/#u.

As Christian mentioned already, it's best to try to describe the issue
succinctly in the commit message so readers can understand it without
chasing a link. For this simple case, it should be sufficient to
explain that, due to an implementation detail, git-stash undesirably
requires 'user.name' and 'user.email' to be set, but shouldn't.

> Signed-off-by: Slavica <slawica92@hotmail.com>
> ---
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> @@ -1156,4 +1156,21 @@ test_expect_success 'stash -- <subdir> works with binary files' '
> +test_expect_failure 'stash with HOME as non-existing directory' '

The purpose of this test is to demonstrate that git-stash has an
undesirable requirement that 'user.name' and 'user.email' be set. The
test title should reflect that. So, instead of talking about
non-existent HOME (which is just an implementation detail of the
test), a better test title would be something like "stash works when
user.name and user.email are not set".

> +    test_commit 1 &&
> +    test_config user.useconfigonly true &&
> +    test_config stash.usebuiltin true &&
> +    (
> +        HOME=$(pwd)/none &&
> +        export HOME &&
> +        unset GIT_AUTHOR_NAME &&

Use sane_unset() for all of these rather than bare 'unset'.

> +        unset GIT_AUTHOR_EMAIL &&
> +        unset GIT_COMMITTER_NAME &&
> +        unset GIT_COMMITTER_EMAIL &&
> +        test_must_fail git config user.email &&
> +        echo changed >1.t &&
> +               git stash

Christian already mentioned the odd indentation.

> +    )
> +'
