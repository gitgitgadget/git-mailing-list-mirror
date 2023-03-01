Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F5FC7EE36
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 23:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCAXoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 18:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCAXoP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 18:44:15 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE7F742
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 15:43:42 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id l10-20020a17090270ca00b0019caa6e6bd1so7664369plt.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 15:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677714192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOKH7PGHgq8OmJmCbKWT+Ts8VVip/isMSSPRT8WAhE0=;
        b=NTKE23B9X7Lp86bBPtKGZuF2zbIZCJCcTUjjp46M1I0mfL+hu14e5EdqnIP9+nwAqn
         11c/KvxnsCgdRYJvPNub/RBQzQs36KbC0p27J0hN60KpF138qk2y8jQ4L1ay3fnmr0c0
         o3/0Z3rrogV98V6O4Kr+VdIQBMZ6tbgbBnLmOYLjKIN67b3DX6yytQjatXj4UJ55AiCY
         aDB3y0DgNHlfsOIh6uzX6+jEg8pkjyMGikbiMBUV6uMzC0jblaZ9bh+GJ9v+a5CwDFs9
         UhBzsoPIPOwX72/n8HzuwIUvE8Y48r0B5F4uNnuOMZ8I2b4+tIxn9Cn+R/gE8DLLZGP0
         lqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677714192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOKH7PGHgq8OmJmCbKWT+Ts8VVip/isMSSPRT8WAhE0=;
        b=bNi58ko9aYGwq5O7vNp3VTDUXwuAg8VOcf5eMIuK3cjPpGv8IGGksOy4RAmru6zPIK
         xzWUL7ykN0ojgXFeN9vZYUkVqFMm5ygFf5c/RRon5fZVmHIlZaLgse+8YlWkKy5gLZu4
         M7k6herRUhCV745FkBsdTwyFM8P5mEY/PwyhuC5aKa17ZQ7e/3o+0a5fSQifGN0CADWK
         r1+/pF8X460ZcuJeBaoNkVg18Rti24sGQlR+AFlkGf48kG0+Pja0zUIHaSpb9wF/eY10
         9i/1bSkNW6vjsULdq3g6zHvZ+TkQqmayYpZgSbTiN+/P/xCHOIkpq3NPoZZGW4YqzET8
         xUtQ==
X-Gm-Message-State: AO0yUKWUv/30G/In7ZWWdGmXXlpg/YG+/1w6qseWAdd1Hr4XoXkGowZV
        4giNLcaPR1iniGoMtIRSB0s6Xf3iqZVq8w==
X-Google-Smtp-Source: AK7set+4mFFKRD5mVF19YiDWAUKyRPqtzvRID+yCda+r1x5ctsrxUKibHtJnmIbUE4brLlVtVliQI3g0FGo/Ng==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:3247:b0:590:3183:60ea with SMTP
 id bn7-20020a056a00324700b00590318360eamr3020671pfb.2.1677714192251; Wed, 01
 Mar 2023 15:43:12 -0800 (PST)
Date:   Wed, 01 Mar 2023 15:43:10 -0800
In-Reply-To: <20230225180325.796624-4-alexhenrie24@gmail.com>
Mime-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com> <20230225180325.796624-4-alexhenrie24@gmail.com>
Message-ID: <kl6lpm9s3unl.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
From:   Glen Choo <chooglen@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> +rebase.merges::

As far as I can tell, when a config option is meant to be a stand in for
a CLI option, we have typically named it <subcommand>.<camelcase
option>, e.g. grep.fullName, log.diffMerges, push.followTags. This
probably matters more if we aren't specifying the subcommand that this
flag is more (like in this patch).

By this convention, the config option would be rebase.rebaseMerges,
which _does_ feel redundant and it's unlikely for "git rebase" to learn
a "--merges" flag, so I don't have a strong opinion either way. Though
as you mentioned in review club, this consistency might make it easier
for users to read custom configs that use the "rebase." section.

> +	Whether and how to set the `--rebase-merges` option by default. Can
> +	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
> +	true is equivalent to `--rebase-merges` without an argument, setting to
> +	`rebase-cousins` or `no-rebase-cousins` is equivalent to
> +	`--rebase-merges` with that value as its argument, and setting to false
> +	is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
> +	command line without an argument overrides a `rebase.merges=false`
> +	configuration but does not override other values of `rebase.merge`.

With the explanation here, I think having "--rebase-merges" _not_
override "rebase.merge=rebase-cousins" is quite confusing.

I think there are two possibilities forward:

- Be very consistent that "--rebase-merges" is just a synonym of
  "--rebase-merges=no-rebase-cousins". Then, have any value of
  "--rebase-merges" override any config value.

  I think this the easiest UX to understand, but I don't think we should
  be commiting to a default, especially since we may add a more sensible
  default (like rebasing 'evil merges') in the future.

- Keep the existing behavior, but reword the docs to indicate that the
  "no value" form means "I want the default but don't care what it is",
  and an explicit value means "I want to use a particular mode and the
  rules of config vs CLI specificity should apply". Perhaps something
  like:

    When rebasing merges, there are two modes: `no-rebase-cousins` and
    `rebase-cousins`. If no mode is specified in either the config or
    CLI, it defaults to `no-rebase-cousins`.

   which I think is clearer that "rebase.merges=some-val" will win out
   over "--rebase-merges". What's nice is that we don't commit to a
   default value, so we can change it without having to update much of
   the wording here.

The code looks good, no real comments there.
