Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55F5C54E8A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38C1207DD
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2Qw5ns4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgEJQod (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729168AbgEJQoc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 12:44:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D746C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 09:44:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f15so2885508plr.3
        for <git@vger.kernel.org>; Sun, 10 May 2020 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=1X+NmprJ5i4gmG37aKRVYmh2fISYVQiU6MQ19yqzF90=;
        b=W2Qw5ns4wg9YJZIfjN25ryMAKo0zE8BkPUCP/17+PpZuI7tt1+BL5bX0gKcPzx7jj3
         3xhOf3zU9tDgjblzbcLsFp8vaUtwEbSCjRAvca1nyrrLhkKhgtbR/Wtyh/XN572qqZqU
         a1xMIZb05/L9CIYi6SOhz0GIFKC+/uz0cRLo3aqcUpYHAhc9PvtReXNxtUuD2Ch/f96+
         eg7jgFsFFkMRbKctYZDRD1K1N8IZ8jsHH4hnCqNkPIMUV3/b/0j0AGAwnRqAFEfzN/mW
         QzyVd+6CPqNcTn0IRi8c0Uvqixa53Ql4rtVlunroEYF89k5y1ggHjGVzTGj5XVkbJc4f
         XjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=1X+NmprJ5i4gmG37aKRVYmh2fISYVQiU6MQ19yqzF90=;
        b=TQF5X5z4gRUCulsoM/C4xNPmuwod3Xe/pRWGueZ3/l015MU1hKRLgd8JjDdcrcR8Yr
         ShL0/lT9bNPMwbfiKrWcZ/HOmOk+MsU9q9tSe2KQTrru+nShpd2ye0sHutjfWnClBad0
         hz7cc+Mcqb80BM6M22WO6xEIADB52WbfFnbCriTTy4RJS9LhtGT4VXPVhc+uc5GLjtg1
         Kfce/BADgmmOtxyWpxDyGEa90mc6hcInl9Pss1tWgNszlxuwMaTyaRCKOw9py9HrNslJ
         CJ23SiZCmZx6uWfCWzncPzIqK1f1Yzd6mACDIO7gVW9mjgLIY+7FuKQuqjtAgmafNnaL
         S/dA==
X-Gm-Message-State: AGi0PuZcmP1q0LYz7s0uPal+FeD16dFDH4FUwQ7WwRnOuBy+oOxY7QNr
        5+D0azFfgQhBI/e7+DWA57Y=
X-Google-Smtp-Source: APiQypJN2QigOWiGommTqoaz2KeJG27sscvGKHCatRDxMzheqJNw1zaVZ04oo+0y4cGNENiuI0kSZg==
X-Received: by 2002:a17:90a:30a5:: with SMTP id h34mr18058602pjb.171.1589129071563;
        Sun, 10 May 2020 09:44:31 -0700 (PDT)
Received: from konoha ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id q72sm7708659pjb.53.2020.05.10.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:44:30 -0700 (PDT)
Date:   Sun, 10 May 2020 22:14:24 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, guillaume.galeazzi@gmail.com
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
Message-ID: <20200510164424.GA11784@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Guillaume,

> On repository with some submodule not active, it could be needed to run
> a command only for active submodule. Today it can be achived with the
> command:

Spelling: achive -> achieve

Maybe we can keep the commit message a bit more imperative?
Something like:
-------------------------
On a repository with some submodules not active, one may need to run a
command only for an active submodule or vice-versa. To achieve this,
one may use:
git submodule foreach 'git -C $toplevel submodule--helper is-active \
$sm_path && pwd || :'

Simplify this expression to make it more readable and easy-to-use by
adding the flag `--is-active` to subcommand `foreach` of `git
submodule`. Thus, simplifying the above command to:
git submodule--helper foreach --is-active pwd
-------------------------
Yes, maybe renaming the flag to `--is-active` would make it a tad bit
simpler? This commit message may not be perfect but it seems like an
improvement over the previous one?

To me this option seems good. It may have some good utility in the
future. Similarly, we may change the struct to:
	struct foreach_cb {
 	const char *prefix;
 	int quiet;
 	int recursive;
	int is_active;
	 };

Therefore, the if-statement becomes:
	if (info->is_active && !is_submodule_active(the_repository, path))
		return;

BTW what do we return here, could you please be more specific?
Again, the change here as well:
		OPT_BOOL(0, "is-active", &info.is_active,

Here, too:
		N_("git submodule--helper foreach [--quiet] [--recursive] [--is-active] [--] <command>"),

And,
	test_expect_success 'test "submodule--helper foreach --is-active" usage' '

Finally,
	git submodule--helper foreach --is-active "echo \$toplevel-\$name-\$path-\$sha1" > ../actual

What do you think?

Regards,
Shourya Shukla
