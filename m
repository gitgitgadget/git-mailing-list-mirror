Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A98C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 23:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiK1XHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 18:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiK1XHn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 18:07:43 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED2FD3C
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 15:07:41 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id z9so5805586ilu.10
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 15:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6fSaVCtfWryizB3stp2tjzoS4EgUuZDo+Ng/LachIo=;
        b=o8oA++Gj2QAjf+1O/eFt9JhcKlt/jTmdeasHbk3g+jNfksSqbxxTKFQvNh60rZ5aw9
         xfkMJbiNsiDyXFJpA/mhtrxVZL+ZwBhtbHnNNdYd6QeP+nTtir17g2wzVAd3CWBCTwUD
         wuKp9wGSECdWWMMvxWbmF7q2n5SItVSdtiovDaCBwK/zs9c3KXa9A5jw3v7knib5CZ1+
         I5uEJq//mxzChxJkxEs5hSso/imilP9GDdwpykNZCZcTfv/MlSq/apqdaRL4qJHz48TH
         dXMgzuL34ybewczEQ8Vq6Fx+7M9GTcJhSWOpkX5n+bSKZm4LCDlOBQZ19AMejBOzD35x
         tang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6fSaVCtfWryizB3stp2tjzoS4EgUuZDo+Ng/LachIo=;
        b=RKW0V3kzJXDbcrgd0ph3FARcEo+3tnDIIWkfTXSBegDk9WjlufNQKSErN5ZlYd97n6
         6815bnhtg2v05T4J7TuLTlGrfOFFaiIZUlxc2796D9Zfui7+/4MA/EzuSh2Di3yluct2
         vG8gEtWVwLA92nJUg73DtoGw9nAZwgBg4/mxX9y8y6YGTn8Jhg8um7ay3mqypwSzEBEh
         4LeXuHVKurYzyGFTr+DHpDJ758HqIUwYXiqyoD7PIY32o/+0KD4RI2alTv2zzKSAs2ty
         tNR853PqV/rDMfk2RjzKnZsWky5CKXD1BzSidnug/jHn7vTYG5JH6nVkH4ZnttHab5l6
         h2Ow==
X-Gm-Message-State: ANoB5pl15hbxkvO89l1iNrUNadcA/IeqN/KcPk1m5FsjIiEDxJlNy5YD
        +sltKrxhVOM7t00wL/6sCFffZQ==
X-Google-Smtp-Source: AA0mqf754tJCCpGkG+ogYvblz2vyGj+XOz3VqXEmSg2T6Y6THeJnoefCv4g3VFBpz+MZ4BDjIzZMKw==
X-Received: by 2002:a92:d707:0:b0:2f6:1a0a:9e2a with SMTP id m7-20020a92d707000000b002f61a0a9e2amr15381055iln.121.1669676860918;
        Mon, 28 Nov 2022 15:07:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n5-20020a02a185000000b00389eebd6798sm28463jah.122.2022.11.28.15.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:07:40 -0800 (PST)
Date:   Mon, 28 Nov 2022 18:07:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] am: Allow passing --no-verify flag
Message-ID: <Y4U/OhHSg85UV+5L@nand.local>
References: <20221128174825.1510407-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221128174825.1510407-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thierry,

This is looking pretty good. Thanks for pushing out a couple of new
rounds. I took a look at the discussion and have some thoughts below,
but they are minor.

This will likely not be in the upcoming v2.39.0, since Junio has already
cut and pushed the first release candidate tag. But you should feel free
to keep working on it in the meantime and we can revisit it post-2.39.

On Mon, Nov 28, 2022 at 06:48:25PM +0100, Thierry Reding wrote:
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 326276e51ce5..0c1dfb3c98b4 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
>  SYNOPSIS
>  --------
>  [verse]
> -'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
> +'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8] [--no-verify]

Spelling this as "[--no-verify]" and not "[--[no-]verify]" is right,
since the option itself is called "--no-verify" (and thus has the
OPT_NONEG flag bit set), and "--verify" does not exist. Good.

>  	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
>  	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
>  	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
> @@ -138,6 +138,12 @@ include::rerere-options.txt[]
>  --interactive::
>  	Run interactively.
>
> +-n::
> +--no-verify::
> +	By default, the pre-applypatch and applypatch-msg hooks are run.
> +	When any of `--no-verify` or `-n` is given, these are bypassed.

Should we be more explicit here, given the discussion in the earlier
rounds? IOW, instead of saying that they are "bypassed" (which might
lead the reader to believe that they are run and their output/exit code
ignored), should we say that they are "not run" and be clearer?

The (elided) implementation below looks good to me.

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index cdad4b688078..84e6bebeca7a 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -345,6 +345,16 @@ test_expect_success 'am with failing applypatch-msg hook' '
>  	test_cmp_rev first HEAD
>  '
>
> +test_expect_success 'am with failing applypatch-msg hook (no verify)' '
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	test_hook applypatch-msg <<-\EOF &&
> +	exit 1
> +	EOF
> +	git am --no-verify patch1

Should we verify that the patch was applied with the expected message?

> +'
> +
>  test_expect_success 'am with pre-applypatch hook' '
>  	rm -fr .git/rebase-apply &&
>  	git reset --hard &&
> @@ -374,6 +384,16 @@ test_expect_success 'am with failing pre-applypatch hook' '
>  	test_cmp_rev first HEAD
>  '
>
> +test_expect_success 'am with failing pre-applypatch hook (no verify)' '
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	test_hook pre-applypatch <<-\EOF &&
> +	exit 1
> +	EOF
> +	git am --no-verify patch1

Ditto here.

Thanks,
Taylor
