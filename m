Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93573C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 10:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A42206E9
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 10:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3v5sGRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD0KRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726504AbgD0KRY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 06:17:24 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0DC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 03:17:24 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id w18so8218189qvs.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JlVT5mX+471qGMJav7YmuuB6MofBGwak9I61SJgcG/w=;
        b=L3v5sGRlu5nYy8unWeqHzkIoJykW3usMheJVEE8Aox2qLsDpm+C2IlDerJqKiHfYgK
         zqxHIdHl+gSJCyR0ANGM28c0WNEZpZ7zWq8IJS3ysXXr7FuMbGuYxIgPnwu7Fj5XxXk3
         SnybjY85DdV9bCXuwLF0tGm/KAkMfvyG3HZrdDd6/Qrf9kDT8VgSe8Rgg8O/Uf9GZ/ZK
         iuOytACXYg5GPXYQSSHujycxTWI9K0XkcbtIvLX+fcpXj3mLxpD9I9Ls4GL/RdXQ/LTB
         HLaULeP4Hr3wIORPTJI65J0Wm3R39BaAF0vzUvuKASznXJW+Cv07A5OiWc9SpKlZvxQ4
         yohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JlVT5mX+471qGMJav7YmuuB6MofBGwak9I61SJgcG/w=;
        b=CcDkT5hrkUZ7uRdhBttDv4tujLdxkQZEiCX5vknzfOg7fQYCv3fwKeVaNctv+LWvt4
         L8ZMrLyunMfBqaWVlR1zfobn6rzuMpVz98ZjRhlxmrJps68eHuRMlRQZlyaMG9cw1yeh
         a5NIQdwQ9VS1TmR7sYMgNgmpy/loUbfhizIwLp1yP4xIzu9Ox9Mr/CQrA1RapU2OPjDN
         VJ3zbRyRVzgy9cuB6TZHFNDCTE+uJ9Y90IrF+BL786paciwGWlDQZ63m1wyqtkCUKxwg
         dh9RDH6wvMyZ27/0XLpcjS4a70HJuxn0W6e8qV3eoEzD3xs7k8/CX3kVxi1eSwE6dK9R
         tFNQ==
X-Gm-Message-State: AGi0PuYpou2cml42N3ptVst7v1mM1rH066yKqbT5cGxwfOcI2zRnATu0
        2IsEf5Hf9igmmVGWHTX/tWqosdGT
X-Google-Smtp-Source: APiQypLoKVWegbfCE1uHVhMjjWkC7bxX8XXVKokajmgbOL+UlFgEI4AdTmqZ8dBC9BaJy0BtVLrfWQ==
X-Received: by 2002:ad4:450d:: with SMTP id k13mr22063519qvu.138.1587982642807;
        Mon, 27 Apr 2020 03:17:22 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o43sm9757162qtc.23.2020.04.27.03.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 03:17:22 -0700 (PDT)
Date:   Mon, 27 Apr 2020 06:17:20 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [RFC][PATCH 0/2] submodule: port 'set-url' from shell to C
Message-ID: <20200427101720.GA649724@generichostname>
References: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
 <20200420081902.GA202848@generichostname>
 <20200427071920.GA23846@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427071920.GA23846@konoha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Mon, Apr 27, 2020 at 12:49:20PM +0530, Shourya Shukla wrote:
> On 20/04 04:19, Denton Liu wrote:
> > > 1. The patch fails test #2 in t7420, i.e., the test to verify the working of 'set-url'
> > >    subcommand.
> > 
> > The 'set-url' command implicitly runs sync once it is changed. I would
> > go further than what Christian suggests and just call sync_submodule()
> > (in C) at the end of module_set_url().
> 
> I have implemented this, yet running the test still gives an error. The
> function 'init_pathspec_item' in 'pathspec.c' tends to fail. Going
> further deep, the function 'prefix_path_gently' fails. I think this is
> happening because of the relative path outside the superproject for
> '../newsubmodule' and hence it throws a problem with prefixing.

I can't think of a reason why Git should be trying to do anything with
the path `../newsubmodule`. The set-url part should only write that
string into the `.gitmodules` and the sync part should only write into
`.git/config`. Neither of these steps should actually access the
submodule repo in any way.

> The exact function responsible here is 'normalize_path_copy' in
> 'path.c'.
> 
> On doing '-i -v' while running the test. The problem comes down to:
> 
> fatal: ../newsubmodule: '../newsubmodule' is outside repository at '<path>/git/t/trash directory.t7420-submodule-set-url/super'

Perhaps it's failing at the `git submodule update --remote` part? It's
hard to tell without more information. One thing you can do is try
running the test with `-x` which would enable shell tracing. This gives
even more information on the test that's running, including exactly
which command is failing.

> What exactly is wrong here and how should this problem
> and similar ones (if encountered) be approached? Do we follow
> certain procedures when debugging problems at such an intricate level?

I can't tell exactly what's wrong from the information you've provided.
Do you have link to the code you're working on? Alternatively, it might
be a good idea to post a RFC patch onto this list for wider discussion.

Some general debugging techniques that I've found helpful include

	* debug prints using fprintf(stderr, ...)

	* `-x` for test scripts (as mentioned above)

	* `debug` in test scripts (which launches GDB)

	* using `GIT_DEBUGGER=1 ./bin-wrappers/git <subcommand>` (which
	  also launches GDB)

although I'm not quite sure how applicable they are to your case. Maybe
it would be helpful for you to grab a stack trace of where the die() is
being called in GDB to understand the cause of the problem?

-Denton

> Regards,
> Shourya Shukla
