Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F93C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC7C611ED
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 17:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhIURvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhIURvs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 13:51:48 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259E7C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 10:50:20 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q205so5572601iod.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jOgbMuWNosqQy0cTPS2WwylfbrFsjHM4im3IHZTFvLw=;
        b=FY7YTRHBJldEruPgtnKTb+pxZxThBZwf+Rpgi7CYf77xG2Jv0nhNZCF9rpWA44Rjfx
         805hKQ8H/MW5RtbTbYf9Lwv9fL/S2vwgmthSwCl4HzqvlKcmcOqtpe7nI98an0KERmIW
         Ut1BUPtBldZxkr8G2uooCdt43SmgnFn+eAY9MqJ0ns4lp/HTPFChBnCZoDl6lOmY8Nrh
         MwaUZFoj/tyz7c2k8ccDreGv8Mh8hBH6ZNoluckOGn8ItXPmHGv/mDmJrhaT8GLOrGyW
         Em5NNB6v0q526WssJYdIF2ftdWYlUA/lFXq2zq3kO49BaqhsalVmaEcIb6olFvAfXtYI
         1CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jOgbMuWNosqQy0cTPS2WwylfbrFsjHM4im3IHZTFvLw=;
        b=NQOIEPrCAKFzlwH3eRcEJ8ssN6HqT2DrEcoxadgGy01j3MIyjtOexiavQ1c3+1Z8Gt
         2fbCAl3Lovf10KUsBlX0cpK2MobRJo54nq1wqAFPVZfnunNt8jWdSe04ZS7M8arpNqXw
         saGGICy1YVscWtx+tiMXq/qCQEIdcmlos+N+bzZ3kh47oxtY02ktBAZifaLYltUJDxP+
         W5qOIi4gw7h1PVM98lANLU+yA9UY/83q0U7cYk53P1Lco1qgCt9Cw+ASh6wDDmfP1IHi
         Eel5jHNoZDfr7j2bCe58lUgevpxnSXS9fnNWA2KDK7M6tZ+u49Jmd3jqJTo5+WneR9tC
         lsdg==
X-Gm-Message-State: AOAM533/xF7aiM6Ga7seFNLaEUavqjfnBI5Idp7MGc1ROBeY2a03lbnB
        lv6mQ+SOdldzOE2zwtrJegt98+0giNBUtA==
X-Google-Smtp-Source: ABdhPJzWbXVJwNPqXTA/DdP5nmipMcqE0whwKV6i2HPqxf6amjQq1oKWssGZIlrQotBtpl+hGlqbYQ==
X-Received: by 2002:a05:6602:2e0c:: with SMTP id o12mr1059070iow.59.1632246619457;
        Tue, 21 Sep 2021 10:50:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 12sm5388978ilq.23.2021.09.21.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:50:19 -0700 (PDT)
Date:   Tue, 21 Sep 2021 13:50:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        vdye@github.com, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t/perf/run: fix bin-wrappers computation
Message-ID: <YUobWlgSjZDGYSvK@nand.local>
References: <pull.1044.git.1632239172735.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1044.git.1632239172735.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 03:46:12PM +0000, Derrick Stolee via GitGitGadget wrote:
> This is critical to successfully computing performance of commands that
> execute subcommands. The bin-wrappers ensure that the --exec-path is set
> correctly.

Just sanity-checking everything you said: with this bug, we'll set
mydir_abs_wrappers to "/bin-wrappers", then realize that directory
doesn't exist, and fall back to GIT_TEST_INSTALLED=$mydir_abs. Putting
'set -x' at the top of t/perf/run, we can see the relevant section:

  + mydir=build/73cd7d9420bb7d75207e8149521db375c789a81c
  + cd build/73cd7d9420bb7d75207e8149521db375c789a81c
  + pwd
  + mydir_abs=/home/ttaylorr/src/git/t/perf/build/73cd7d9420bb7d75207e8149521db375c789a81c
  + mydir_abs_wrappers=/bin-wrappers
  + test -d /bin-wrappers
  + GIT_TEST_INSTALLED=/home/ttaylorr/src/git/t/perf/build/73cd7d9420bb7d75207e8149521db375c789a81c
  + export GIT_TEST_INSTALLED

OK. But the real problem is in t/test-lib.sh where we read
"$GIT_TEST_INSTALLED". There we ask for the `--exec-path`, which appears
to be wrong, at least in my setup. Printing out the $GIT_EXEC_PATH and
$GIT_TEST_INSTALLED, I get:

  /home/ttaylorr/local/git/ds.sparse-checkout/libexec/git-core,
  /home/ttaylorr/src/git/t/perf/build/73cd7d9420bb7d75207e8149521db375c789a81c

where the former is the branch I happen to have checked out, and the
latter is the revision that I asked to run performance tests on via
t/perf/run.

So I think we'll run the right top-level Git command since the latter
path ends up first in our $PATH, but the exec path is definitely wrong.

> diff --git a/t/perf/run b/t/perf/run
> index d19dec258a2..55219aa4056 100755
> --- a/t/perf/run
> +++ b/t/perf/run
> @@ -74,7 +74,7 @@ set_git_test_installed () {
>  	mydir=$1
>
>  	mydir_abs=$(cd $mydir && pwd)
> -	mydir_abs_wrappers="$mydir_abs_wrappers/bin-wrappers"
> +	mydir_abs_wrappers="$mydir_abs/bin-wrappers"

This fix looks obviously right to me (and gives me the expected output
from above when I apply it locally).

Thanks,
Taylor
