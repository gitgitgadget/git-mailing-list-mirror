Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBDFC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 00:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbiBCAS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 19:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiBCAS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 19:18:26 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B90C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 16:18:26 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id b9-20020a63e709000000b00362f44b02aeso500954pgi.17
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 16:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OPfzd83RCgF6pEVRZCMuljHWBCyPfn5VGJ5iSbmYPro=;
        b=bxEhrNywIm51KvGGsoQxL5Ub9p11eBzD8StLTAlAQpJ840ldpu3uEkLzN9m46npLdl
         yz/0y3bqDZAao8zANgA0P13d2XS3eYunAyBzOa9eMDrPlNx4zrhanLGHnnDbDdQbB0eq
         x7ixBtwOmAH9b9RneslqjmAK4I6zTjrPOcRARcSIbkmjvxfb2xL0VZMxCQ9NXIiLzl8P
         5+CK/wwsgmQskyK2uyg6aHeTHFFEQ3vdlnViRL/WVx1mCRM7qzRev83CrnfYz3wOrmnX
         guOF2wQGmdf14bT2B90FDWaJu51XOMOyZ/TLlbhyr2ZJ9GgRSrLo2iWCMkblKCP4fSX7
         Tkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OPfzd83RCgF6pEVRZCMuljHWBCyPfn5VGJ5iSbmYPro=;
        b=mIPv564e3w+npxG7h9YoIYwUE0/GZItdwbgWBUFn4ejFKCo0Y7PwszRETdzfxcOtDa
         2YtYNz3TgaXatasmJhuOdjS3ymgXPi0WCa/oubEfTuenezN2zag8dUco64rzcBKITVYw
         5kZiHF4/xe53z1WIaX9owOBcTr6whzphOtgUQul/t4Jhr6xkrDzL6m76potaOfCwiIBi
         I7VCcP5lS2futCqDAteCm5rs7D8wwrcXadunyeZBp6IpjZsMh72fB9bNfs2Tu9CY6IcW
         8H0i0oDkVrRPRLJSqOqeN5BsommlURzsd2MVvJS2IIYhKcsw8pAsQq+8Pi0939FEr0e3
         BYJA==
X-Gm-Message-State: AOAM5326it8q5qrtHG/QjNs00cdBFh+Drnf3cK0iUnQKHwc9DPjPn4mo
        VwNIF7cjj3JaHCJXlNlWoidjlVrYZaDeBw==
X-Google-Smtp-Source: ABdhPJw7KKFazES72ZbbMCxnKKHGGa/NdU/3b6ISi/wce7o7Rxq8gpNklcpmBM9CBNkgLP6jPeLCc1T96xwpkg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:f283:: with SMTP id
 fs3mr10997326pjb.173.1643847505576; Wed, 02 Feb 2022 16:18:25 -0800 (PST)
Date:   Wed, 02 Feb 2022 16:18:22 -0800
In-Reply-To: <patch-v5-9.9-e8e57606ee9-20220128T125206Z-avarab@gmail.com>
Message-Id: <kl6l4k5g246p.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
 <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <patch-v5-9.9-e8e57606ee9-20220128T125206Z-avarab@gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: move core cmd_update() logic to C
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I mentioned (out-of-mailing-list) that I was still looking at this, but
that the big sh -> c conversion is quite challenging for me to parse
personally. I'm still looking at it, but it will take some time..

I'm of the opinion that this patch would be a lot easier to review if it
were broken up into more patches, but it has always looked like this
[1]. The only real difference from [1] to this version is that this also
removes all of the dead code, which doesn't really hinder reviewability.

I don't think you have to go through the effort of splitting it up -
after all you were able to review [1], so given enough time I should
be able to read through this patch too :) That said, I wish that we
already had a split up patch for at least 2 other reasons:

- Junio pointed out that this conflicts with
  es/superproject-aware-submodules [2]. I'm not sure which should be
  based on which. If this does end up being based on
  es/superproject-aware-submodules, it would probably be easier to
  rebase as a series of smaller patches. Atharva noted that the
  conflicts are mild though, so maybe it's not so bad.

- Besides making sure that the sh -> c is faithful, a thorough review
  should hopefully catch unintentional mistakes. The size of this patch
  makes such mistakes difficult to spot. For instance, here's something
  I spotted only after trying to split the patch myself..

  > +static int module_update(int argc, const char **argv, const char *prefix)
  > +{
  > +	const char *update = NULL;
  > +	struct pathspec pathspec;
  > +	struct update_data opt = UPDATE_DATA_INIT;
  > +
  > +	struct option module_update_clone_options[] = {
  [...]
  > +	};
  > +
  > +	const char *const git_submodule_helper_usage[] = {
  > +		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
  > +		NULL
  > +	};
  > +
  > +	update_clone_config_from_gitmodules(&opt.max_jobs);
  > +	git_config(git_update_clone_config, &opt.max_jobs);

  Notice that we copy-pasted the option parsing from update-clone into
  module_update() but forgot to update the names.

My ideal patch organization would be something like:

- wrap some existing command in "git submodule--helper update" (probably
  run-update-procedure)
- absorb the surrounding sh code into "git submodule--helper
  update" one command at-a-time i.e. deprecating and removing the
  commands one at a time - instead of deprecating and removing them all
  at once (like this patch), or deprecating all at once and removing
  them one at a time (like v1).

I don't know if it's feasible or not; Atharva noted upthread that there
are some technical reasons why some things can be done in-process and
some cannot, but it might be a useful exercise.

Here's what I propose:

- If you think this alternative organization would be helpful for you
  too, I will attempt it. This will take a while, but by the end you and
  I will have effectively reviewed all of the code, so it should be easy
  to finish up the review.

- Otherwise e.g. maybe this is a huge waste of time, or you're already
  really confident in the correctness of the sh -> c when you reviewed
  the original patch, etc, I'll just review this patch as-is. I'd
  appreciate any tips and tricks that might help :)

- Orthogonal to patch organization, I'm still not sure if this will be
  rebased on es/superproject-aware-submodules or vice-versa, and I don't
  want either of us to sink too much effort before knowing the answer.

[1] https://lore.kernel.org/git/20210907115932.36068-7-raykar.ath@gmail.com/
[2] https://lore.kernel.org/git/YWiXL+plA7GHfuVv@google.com/

