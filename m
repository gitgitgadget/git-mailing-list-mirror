Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982DEC48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 04:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AF0613C2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 04:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhF0EO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 00:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhF0EO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 00:14:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE8C061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 21:12:34 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c19-20020a9d6c930000b0290464c2cdfe2bso3212861otr.9
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 21:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mq4cjyGxJYX4CaGnn9lsCxr1FJgh8iiYB2e5XkNEwhg=;
        b=Vjl1TW7dVDD+yXGSzoNS9WRumkxBpxicg0tGT7Yqd0pK4xkucmpi3I/SqgBdSvR7Uw
         d8G70FRMKgh3pnY19r7vyC0o4RmK1yfBC+oNiUt8mXIV8NDAwPrpGEPV8lXaa35hWkSN
         HVKu/rFFR2IMAx7J7CpK+xjrIl/eb9f/Cf8uZtOsyqsO96QB21+/ahNjPuH7Hj9sRyhR
         YDO+9LQKi7Kat20ls/yXOIIGmdQXSbTWJ4sqbNr5xWthhhLOofoQcQoZlq1ZPxCvmHIv
         ZnYyDl5T+9tloiPDWoieCXG+Y5MGQ49r3EQdd7hsm/YbonjBPlc7h3tJw1TUbXpEOX8F
         mA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mq4cjyGxJYX4CaGnn9lsCxr1FJgh8iiYB2e5XkNEwhg=;
        b=Jt+cdYM4jjG0ZhpNV1UY1Y1GgYCB7nOo87+hlgq3/liEJl37spQVmgMt6RgUeKbOx+
         DMtdpUtunw60LDAMCSZ4p8wSmLB4R5yKT9Bo9KDTqa9T/Qn1t00lEXHkr1h/I6014psC
         BoZSxhRHezHTUITnlofFrYBXtkjqG3SbGysvMYeg94UJzt1ojsQ47XD2qI+Wxw6IS+ti
         1tPiB5O8jSJb1joDgCczB9HUvJxmn/a+s09UGFr2BLKQxvR0BNJcFHUFAlyFrhh741oI
         EpacpMz6uFA0q5d1exNGkdWso9sZT02fvT+NHEZaFrLEMu6jazQtXVBdvRQYk3YJ8b+5
         ArVQ==
X-Gm-Message-State: AOAM531zJb5/EP3G9UgsioE02j3iYqZd0ikpcPS23vw9X5rcltcgrsm9
        jEmPu5OwStvBEJHCyyRe7yI=
X-Google-Smtp-Source: ABdhPJxh58vepc7IgnM0nvxPY2EIelcpi0IeaWfCn8i0y1BNpTZuHr+TL2q0QzeCh5zbcC+OUuB4Vg==
X-Received: by 2002:a05:6830:3155:: with SMTP id c21mr15821141ots.153.1624767153476;
        Sat, 26 Jun 2021 21:12:33 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id v3sm2191830oon.11.2021.06.26.21.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 21:12:32 -0700 (PDT)
Date:   Sat, 26 Jun 2021 23:12:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, felipe.contreras@gmail.com, newren@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Message-ID: <60d7faaf5311a_b8dfe208bd@natae.notmuch>
In-Reply-To: <20210627000855.530985-1-alexhenrie24@gmail.com>
References: <20210627000855.530985-1-alexhenrie24@gmail.com>
Subject: RE: [PATCH] pull: abort by default if fast-forwarding is impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> The behavior of warning but merging anyway is difficult to explain to
> users because it sends mixed signals. End the confusion by firmly
> requiring the user to specify whether they want a merge or a rebase.

When were users warned about this change? Generally before making such
big UI changes to core commands there needs to be a deprecation period
before pulling the trigger.

Second, supposing this was a proposal to add such warning, we would need
a configuration so the user can decide to retain the old behavior, or
move to the new one. What is that configuration?

How can a user choose to enable the new behavior in v2.32 (or any other
version)?

Also, a bunch of tests are broken after this change:

  t4013-diff-various.sh
  t5521-pull-options.sh
  t5524-pull-msg.sh
  t5520-pull.sh
  t5553-set-upstream.sh
  t5604-clone-reference.sh
  t6409-merge-subtree.sh
  t6402-merge-rename.sh
  t6417-merge-ours-theirs.sh
  t7601-merge-pull-config.sh
  t7603-merge-reduce-heads.sh

If you didn't mean this patch to be applied then perhaps add the RFC
prefix.

> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -16,13 +16,17 @@ DESCRIPTION
>  -----------
>  
>  Incorporates changes from a remote repository into the current
> -branch.  In its default mode, `git pull` is shorthand for
> -`git fetch` followed by `git merge FETCH_HEAD`.
> +branch.  `git pull` is shorthand for `git fetch` followed by
> +`git merge FETCH_HEAD` or `git rebase FETCH_HEAD`.

Is it?

If I have a pull.rebase=merges is `git pull` the same as doing `git
rebase FETCH_HEAD`?

>  More precisely, 'git pull' runs 'git fetch' with the given
> -parameters and calls 'git merge' to merge the retrieved branch
> -heads into the current branch.
> -With `--rebase`, it runs 'git rebase' instead of 'git merge'.
> +parameters and then, by default, attempts to fast-forward the
> +current branch to the remote branch head.

OK.

> +If fast-forwarding
> +is not possible because the local and remote branches have
> +diverged, the `--rebase` option causes 'git rebase' to be
> +called to rebase the local branch upon the remote branch,

Does --rebase only work when a fast-forward isn't possible.

> +and
> +the `--no-rebase` option causes 'git merge' to be called to
> +merge the retrieved branch heads into the current branch.

Isn't merge called when a fast-forward is possible?

> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -925,20 +925,20 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
>  	return ret;
>  }
>  
> -static void show_advice_pull_non_ff(void)
> +static void die_pull_non_ff(void)
>  {
> -	advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> -		 "discouraged. You can squelch this message by running one of the following\n"
> -		 "commands sometime before your next pull:\n"
> -		 "\n"
> -		 "  git config pull.rebase false  # merge (the default strategy)\n"
> -		 "  git config pull.rebase true   # rebase\n"
> -		 "  git config pull.ff only       # fast-forward only\n"
> -		 "\n"
> -		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
> -		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> -		 "or --ff-only on the command line to override the configured default per\n"
> -		 "invocation.\n"));
> +	die(_("Pulling without specifying how to reconcile divergent branches is not\n"
> +	      "possible. You can squelch this message by running one of the following\n"
> +	      "commands sometime before your next pull:\n"

Is squelching this message really what we are aming for?

> +	      "  git config pull.rebase false  # merge\n"
> +	      "  git config pull.rebase true   # rebase\n"
> +	      "  git config pull.ff only       # fast-forward only\n"

`git config pull.ff only` will get rid of this messge, but the pull
would still fail, only that it will be a different message:

  fatal: Not possible to fast-forward, aborting.

Doesn't seem very user-friendly.

> +	      "You can replace \"git config\" with \"git config --global\" to set a default\n"
> +	      "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> +	      "or --ff-only on the command line to override the configured default per\n"
> +	      "invocation.\n"));

Can I?

  git -c pull.rebase=true pull --ff-only

`--ff-only` doesn't seem to be overriding the configuration.


In addition to all the issues I've already pointed out, the message
seems rather big for a die().

I think this is close to the end-goal we should be aiming for, but
there's a lot that is missing before we should even consider flipping
the switch.

Cheers.

-- 
Felipe Contreras
