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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B5C433E0
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 16:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFB2619A2
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 16:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVQqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhCVQq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 12:46:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6F2C061756
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 09:46:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ce10so22385972ejb.6
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 09:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bUvJ031Zyu2RWbzGVBUiYvIOJuazzm14OemXpnU8zGQ=;
        b=iKFKbCqBT1AYWKo//+OB5ZFaO3z5rsD7T7fZGxlW1y+fuuEAdsqI3B6H8XQLeDe8Dh
         yRec4EW8s2UcKvCc6enx36IZHtxP2dIpJ5OP0H4l8j4B/XtRkHqQFObRJSN1as6CCy9Q
         fL9rmjV9+u1xIYn0RnLQCIrHYNnUrTq0MGlZg3ykWr6AVR/hz2ARxnOXzNQ+xxaynZ1F
         HLco++L4vo1KzGD0/n/M6yKYNX3LTZnX6dI3enf0A6amXmfKWaHkGCoz/1+xDAI4lMuh
         e09s+6YY9I26oRI5hp6AgxOnVJVHhYSStW2xaY/HobuvQFeebQKvt4QZZjW3VeBLbWEt
         BvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bUvJ031Zyu2RWbzGVBUiYvIOJuazzm14OemXpnU8zGQ=;
        b=keLiemrd2IjIsphsbBpqdf+vgmywGtJowpuB7mx1DiBxlylzjptCdfSps4FmgpaHvo
         WF3m2CWp+8LKweDLljgaJ9P33PUceZEMNbXvotZeHTNz64Luxfpz6keIRcoxM6Tm/wfc
         8clLTX4MKwLzQA4iYCjklsmNP6tLZPo3Md40xtP0+EdZTNFLkmZ9K/cZf0th9szuHw9z
         w0nWpwB/1tCq9lYhXQ1lENmd1PKLfkhkCJE77pRF3vWAiP4ImzVWXhiWYwgU8R5XIZKF
         jfbxkXFzc4a+QLW2NbhANgx3R3WVpLkq8bMO2jkEmvXDDRscN75c2VpEq281UtxN1Uy2
         B7SA==
X-Gm-Message-State: AOAM5318e4XPxoajpz5FwEcQaNf6rF4/rckfI1631PWQW65eXPdHUo/e
        IrvEZUVlT6uoaeoPTh8ve06UfqZiteQ3ZA==
X-Google-Smtp-Source: ABdhPJwnFJ4qnje+x4svenlUrg8bdho71ozoBJMws5YxXYH85WJTnYyNn8fR9j+uo5N844elK9ixCQ==
X-Received: by 2002:a17:906:c0c8:: with SMTP id bn8mr662845ejb.445.1616431586619;
        Mon, 22 Mar 2021 09:46:26 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g7sm5545331ejw.51.2021.03.22.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:46:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Drew DeVault <sir@cmpwn.com>,
        Rafael Aquini <aquini@redhat.com>,
        Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH v1] git-send-email: Respect core.hooksPath setting
References: <20210322162008.468779-1-robert.foss@linaro.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210322162008.468779-1-robert.foss@linaro.org>
Date:   Mon, 22 Mar 2021 17:46:25 +0100
Message-ID: <875z1jqgpq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 22 2021, Robert Foss wrote:

> get-send-email currently makes the assumption that the
> 'sendemail-validate' hook exists inside of the repository.
>
> Since the introduction of `core.hooksPath` configuration option in
> v2.9, this is no longer true.
>
> Instead of assuming a hardcoded repo relative path, query
> git for the actual path of the hooks directory.
>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>
>
> This patch does not include a test for this bug fix.
> This is entirely due to me not being able to think up a way
> to test this. So I'm very much open to suggestions.

There's an "invoke hook" test in t9001-send-email.sh which should be
easy to tweak (or mostly copy/pasted to another test) to run the same
way once the hook is moved from .git/hooks to somedir/ and -c
core.hooksPath=somedir is set.

>  git-send-email.perl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 1f425c0809..3934dceb70 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1942,8 +1942,9 @@ sub validate_patch {
>  	my ($fn, $xfer_encoding) = @_;
>  
>  	if ($repo) {
> -		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
> -					    'sendemail-validate');
> +		my $hook_path = $repo->command('rev-parse', '--git-path', 'hooks');
> +		chomp($hook_path);
> +		my $validate_hook = catfile($hook_path, 'sendemail-validate');

This looks like it work, small nits:

1. This would be better in perl/Git.pm, it already has various accessors
   etc. for these rev-parse'd values. You could just pass a a new
   GetHooksPath => 1 to Git->repository() and if so populate this, then
   call that as $repo->git_path_hooks.

2. FWIW it's more idiomatic in perl to just do : chomp(my $x = y()); not
   my $x = y(); chomp $x. The chomp operator works in-place, but once
   you'd use the helpers in Git.pm for this they'd do all that for you.

>  		my $hook_error;
>  		if (-x $validate_hook) {
>  			my $target = abs_path($fn);

