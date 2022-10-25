Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14A3C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 23:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiJYXuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiJYXun (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 19:50:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F4877E9E
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:50:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e129so13133987pgc.9
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW8W3yZgHDmv03Sdb9ROSPSroBCaXc9Ww3mD/6V36gA=;
        b=QVmjA04jJLgqFR1ohpAQG71w0pvxFe2KgroOON2cQWkTubKygMhWaObhdVyMIu71KO
         P/KN2dC5MDkbZX1FGTxcUSEaDrHO2hH0KqplKdSg0FmfYxvKDJTEL9wdNK1YwpIJ+5a1
         iLq7deBX4jjd9EsPFxfYYkQUaYo8liyURk6Q0ajyO+6PHYOYkzqO5LGlLO72RGAOfqvD
         s7e/VB4Fh8WeHRpWpQaI85GIsX4h7ry8DymNch9FbmJXDu9EY8d9OmxvBvTXUFInCyCn
         PZWZMNTWS31+1KCpWEztGZ5ZDH9Z1XfrZUKmgK22fxJy5zZwViDMCLZ3QTBsEp9x0OCr
         OciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW8W3yZgHDmv03Sdb9ROSPSroBCaXc9Ww3mD/6V36gA=;
        b=m5t3Rycw+QrnfOw3cEOlLxGrUD9pqoIHGA1+Nin2+fHFImcOx3pskabHYZ88wvpf2F
         xK+ndkPLYS26ON1TIeAuXpAMS2EI797m1CEpZV07qdbynHTFIV5Ker/7MflbXtMoAXBD
         2nULO9+T5jedYtuoMNHjl1BEUjYV4dmNLF+BLe7WI+CcxZ5V+o5off8XadisiXd/gPit
         mNeRaSn4Z63HQ7C0aDhcC2LLmWOOv1SOVOTOWH5QDpngfxNVxyFEq82AtNTU8K/Bo7Iv
         nKRziBnNse+YmZKJHTDWrzfGsOdpvCpoNNS8ELsH00ZTSROZt1AOvgBAtAyGRuo4rZZA
         qhNw==
X-Gm-Message-State: ACrzQf06/okBYdASoW0kN5HL6kYHLQtZPAwy8O5h5g6uYuRjcRkJLG1T
        Qf88zmUiQiZ2PA2OGhyD8ow=
X-Google-Smtp-Source: AMsMyM4iE3xId4e9YrcKkqg1imvv2+nnpEZ5rgZfgNWaH55ci3MWMs1kJOtC5saoB626KRBOHT9/9Q==
X-Received: by 2002:a63:1a45:0:b0:439:49b4:9672 with SMTP id a5-20020a631a45000000b0043949b49672mr34704111pgm.551.1666741842051;
        Tue, 25 Oct 2022 16:50:42 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x7-20020a626307000000b0056bb06ce1cfsm1958955pfb.97.2022.10.25.16.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:50:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: error copying or renaming a detached HEAD
References: <0ac8cd48-08d7-9bdd-b074-c8d5ded522f6@gmail.com>
Date:   Tue, 25 Oct 2022 16:50:41 -0700
In-Reply-To: <0ac8cd48-08d7-9bdd-b074-c8d5ded522f6@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Wed, 26 Oct 2022 01:01:29 +0200")
Message-ID: <xmqqmt9jmpim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Let's remove the condition in copy_or_rename_branch() (the current
> function name) and check for HEAD before calling it, dying with the
> original intended error if we're in a detached HEAD.

Makes sense.

> @@ -827,24 +820,19 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		strbuf_release(&buf);
>  
>  		return ret;
> -	} else if (copy) {
> -		if (!argc)
> -			die(_("branch name required"));
> -		else if (argc == 1)
> -			copy_or_rename_branch(head, argv[0], 1, copy > 1);
> -		else if (argc == 2)
> -			copy_or_rename_branch(argv[0], argv[1], 1, copy > 1);
> -		else
> -			die(_("too many branches for a copy operation"));
> -	} else if (rename) {
> +	} else if (copy || rename) {
>  		if (!argc)
>  			die(_("branch name required"));
> +		else if ((argc == 1) && filter.detached)
> +			die(copy? _("cannot copy the current branch while not on any.")
> +				: _("cannot rename the current branch while not on any."));

Missing " " before "?".

>  		else if (argc == 1)
> -			copy_or_rename_branch(head, argv[0], 0, rename > 1);
> +			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);

The third argument being 'copy' makes sense (as the original has 1
for copy and 0 for rename).  As we reject if rename and copy are
both set, here we have either copy > 0 or rename > 0 but not both,
so the fourth argument makes sense, too.

>  		else if (argc == 2)
> -			copy_or_rename_branch(argv[0], argv[1], 0, rename > 1);
> +			copy_or_rename_branch(argv[0], argv[1], copy, copy + rename > 1);
>  		else
> -			die(_("too many arguments for a rename operation"));
> +			die(copy? _("too many branches for a copy operation")
> +				: _("too many arguments for a rename operation"));

Ditto.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 7d8edff9c3..38c57de71b 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -268,6 +268,17 @@ test_expect_success 'git branch -M topic topic should work when main is checked
>  	git branch -M topic topic
>  '
>  
> +test_expect_success 'git branch -M and -C fail on detached HEAD' '
> +	git checkout HEAD^{} &&
> +	test_when_finished git checkout - &&
> +	echo "fatal: cannot rename the current branch while not on any." >expect &&
> +	test_must_fail git branch -M must-fail 2>err &&
> +	test_cmp expect err &&
> +	echo "fatal: cannot copy the current branch while not on any." >expect &&
> +	test_must_fail git branch -C must-fail 2>err &&
> +	test_cmp expect err
> +'

Excellent.

I'll do the whitespace tweak while queueing, so there is no need to
resend only to fix them.

Thanks.
