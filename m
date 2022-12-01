Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC35C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 00:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLAAwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 19:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiLAAwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 19:52:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7835B584
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 16:52:07 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so3655701pje.5
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 16:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XD3dRtrERLLSSYMJMw6u2At2yR9UiB+RSo1w+PJm5UA=;
        b=XzuaRWKR/F3/egz8pewtOFC1EtwenCMefRlwn41QvvcNqMvE85wwt6e/GuTWNepVXu
         OOL0VE2IZhZv1cYQJ/knMCnMfCu2H+NsoNXaFPmqlYMxWf2EhoadiFCNTk/GTXLLdSjr
         vx4pVNC9OnmYKHPMrYG26f+rWFC6IxMptRMrMPQp/u+VaNQwvA3jrCqXzliM+On/vrFI
         TvyPL7d2Lspn5gKA2MKbH//l4GYWTxK+qx3MC4YTzPaxncaCVIqBwucnZMtNFbLVjihv
         Wm5HVD8T6sK/TQD6E63SqMtQlg/WbCwm9PLQmd1I57NOCFB86PAar1qAWk5UIEp7LmbO
         53rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XD3dRtrERLLSSYMJMw6u2At2yR9UiB+RSo1w+PJm5UA=;
        b=YN8wd/XxUPr6BG1jnTt55WFjKK/5ydoRLkM1Iu2vkyeGRzfIvFULKVs2w8qPReo9aZ
         Um9oH8P0f4qg4OHXaQYpEKYk84rnBvLluXm52ppOjytAz5Z3VR2JbUAEuZxLna0sQWeS
         WdXDPrK++ic91eBXvxbl5SSx+AdHvQhITI/wajNJ0D0aKXp53kfAXLpxzLdzJwp8xR0j
         Z4d7OSK5ViN+oYPXRkym93pVzgEtJTZmXtT7/BOWIeSv8R4kFpEkFIW5RE4nJWx4Kxtc
         hHkHZ6M8/mu05CNM7f2VSSKKTTmJbuifTI8aeJwh1ViPMDGckMBdkJI1FosmFXRjpS+o
         qv0w==
X-Gm-Message-State: ANoB5pmtejURM+0PcUCsi3fcALnDLDX5ZkhMqhuLjCZc1vrysTe2oR+N
        pVxeORiCXqGvN0lVo2QcKX6fvW4jRuLWPg==
X-Google-Smtp-Source: AA0mqf4XjX7I0LrdtHM0eLhypvzKApZ0/thorMsJJbZXCMpLctZWdwINYO1bc4+jbi++wYgQj60p3w==
X-Received: by 2002:a17:902:e803:b0:189:b0ff:e317 with SMTP id u3-20020a170902e80300b00189b0ffe317mr1508277plg.40.1669855926577;
        Wed, 30 Nov 2022 16:52:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b0018968d1c6f3sm2098555plb.59.2022.11.30.16.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 16:52:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] am: Allow passing --no-verify flag
References: <20221130172833.2662751-1-thierry.reding@gmail.com>
Date:   Thu, 01 Dec 2022 09:51:46 +0900
In-Reply-To: <20221130172833.2662751-1-thierry.reding@gmail.com> (Thierry
        Reding's message of "Wed, 30 Nov 2022 18:28:33 +0100")
Message-ID: <xmqqr0xkt07x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> writes:

> +		OPT_BOOL('n', "no-verify", &state.no_verify,
> +			N_("bypass pre-applypatch and applypatch-msg hooks")),

I think parse_options machinery is smart enough to do the right to
allow "git am --no-verify --verify" a way to express "last one wins,
turn the .no_verify bit off to countermand an earlier --no-verify",
so this looks good.

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index cdad4b688078..d77c4dcefeb7 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -345,6 +345,22 @@ test_expect_success 'am with failing applypatch-msg hook' '
>  	test_cmp_rev first HEAD
>  '
>  
> +test_expect_success 'am with failing applypatch-msg hook (no verify)' '
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	test_hook applypatch-msg <<-\EOF &&
> +	echo hook-message >"$1"
> +	exit 1
> +	EOF
> +	git am --no-verify patch1 &&
> +	test_path_is_missing .git/rebase-apply &&
> +	git diff --exit-code second &&
> +	test_cmp_rev second HEAD &&

This somewhat raised my eyebrows, as the condition will not
generally hold.

I am guessing this was merely copied and pasted from the previous
test piece before this one, which uses "test_cmp_rev first HEAD" and
its use of test_cmp_rev is more sensible, as it is making sure that
"we started with 'first' commit at HEAD, 'am' should not have done
anything by failing, so expect HEAD is still at 'first'".

The reason to expect HEAD to be 'second' here is very different.  We
start from 'first', 'am' should have applied the patch as-is while
pretending that the wallclock is frozen (i.e. even the committer
timestamp should be the same as the original commit), so expect HEAD
is pointing at the exact same commit recreated by 'am'".  That is a
bit unrealistic expectation outside the context of the tests.

If we added test_commit or test_tick anywhere before this step in an
unrelated test, it likely will break this expectation; in other
words, I think the use of "test_cmp_rev second" here makes it
unnecessarily brittle.

> +	git log -1 --format=format:%B >actual &&
> +	test_cmp msg actual
> +'

Other than that, this test looks good.

> @@ -374,6 +390,22 @@ test_expect_success 'am with failing pre-applypatch hook' '
>  	test_cmp_rev first HEAD
>  '
>  
> +test_expect_success 'am with failing pre-applypatch hook (no verify)' '
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	touch empty-file &&
> +	test_hook pre-applypatch <<-\EOF &&
> +	rm empty-file
> +	exit 1
> +	EOF
> +	git am --no-verify patch1 &&
> +	test_path_is_missing .git/rebase-apply &&
> +	git diff --exit-code second &&
> +	test_cmp_rev second HEAD &&
> +	test_path_is_file empty-file
> +'

This "pre" stuff, unlike the other hook, does not affect the
resulting commit, so you invent an extra file "empty-file" as a
marker and remove it from the hook, so that the absense of the file
can be used as a signal that the hook did run.  We could do it the
other way around (i.e. make sure the marker file does not exist
before running "git am", arrange the marker to be created by running
the hook, and ensure that the marker does not exist after running
"git am"), and either way is fine.

The same comment as the previous one applies to "test_cmp_rev second"
check.  I think removing them would make the tests better.

Oh, also I keep forgetting but

> Subject: Re: [PATCH v4] am: Allow passing --no-verify flag

our convention is not capitalize "Allow" here.

Thanks.
