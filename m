Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC9C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 10:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EEB206E9
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 10:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfTptY1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgCOK6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 06:58:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51150 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgCOK6J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 06:58:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id a5so14500089wmb.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3X7mdTjY1vFF4Ve852iC3EJvFaWIge/z8ox6G7GMk9o=;
        b=mfTptY1eMD3RY5yvUHqwlA3tvvb38DUdL0kkT0ijBm5DcGUQZS+dnflUMBQ476ZT8e
         VAzL8AltrInaPqnIk2rwEhihyMyVIHa3CdDRJsWEndFX51ffAmy7iaFqLo/gbO+I3Jfu
         0x/4VFX9l5RHAhvSZA/MWPmdj68I8pUzttYRmWBhXfyWqibfS4bBHndrFYtIyVZuGSxN
         mwi/ztWK4ziNQRLi33IlpUKvNuq4+tEw8uu8sXC3JkyBbHOgM1in/KCfD5KTBnaEiK5U
         SxNEO2p4BdPEjM2UzQZnBW/PV1o2FCMkmPUYqsrjHanBNbIYWJkQVh5fy/rbHgdGDyJ3
         cqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3X7mdTjY1vFF4Ve852iC3EJvFaWIge/z8ox6G7GMk9o=;
        b=RosadCMAQYs5PWxBC0Lq0Lb/Be1frfR3YWiqGKe04D7jJHddYVBw3rvCvJF0SGuYHL
         pD6LXxCnLtLQnjJu9ZopHOV6dB09f7EQq/1scMYlrQVCl2EXzzq65bFQ1SXD5htxDFDo
         dEikoDg727oz/bGonQ+9r1gQuFsmy2ZTy8QUPu2IKSGGSxIG0Ztai9Xxvsa86d6LljMa
         PX4o23jNVmAV+ZnoSYLiFwAAAqh2+3PhZG7nOmw6Wg3M3ikBgu3ng89y/LaHbw4Mn8D2
         Jyu4vf7zzG1vqOg1wrgdDurfCYUiQ7b2xA89bwl05ORpsDTjcFSnZgk8tCUEDWUO2Q1m
         uyAg==
X-Gm-Message-State: ANhLgQ0dalqdTr58tX97QuENb/Q6mbfSZmRfCsvhgj8cdbh6PdEXEK9E
        rR0FrvfISZfI31dVO8wCPZg=
X-Google-Smtp-Source: ADFU+vuSydfq0xyei1ZGpA+YwicuVTIxt3qCM+vYs3nL8IKyrpTRaIXpZW/5pOdAecwmL03cXFvvBw==
X-Received: by 2002:a1c:8108:: with SMTP id c8mr21385450wmd.50.1584269885961;
        Sun, 15 Mar 2020 03:58:05 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id n6sm14209997wmn.13.2020.03.15.03.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 03:58:05 -0700 (PDT)
Date:   Sun, 15 Mar 2020 11:58:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Regression in v2.26.0-rc0 and Magit
Message-ID: <20200315105803.GJ3122@szeder.dev>
References: <3091652.KAqcNXvZJ4@cayenne>
 <20200312233504.GH120942@google.com>
 <xmqqk13pdsw1.fsf@gitster.c.googlers.com>
 <xmqq36accdpt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36accdpt.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 11:27:26AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jonathan Nieder <jrnieder@gmail.com> writes:
> >
> >> Junio, can you fast-track that fix to "master"?  Emily, can you add a
> >> test?
> >
> > Thanks, indeed it has been waiting for tests.  We have a few more
> > business days before -rc2, so...
> >
> > * es/outside-repo-errmsg-hints (2020-03-03) 1 commit
> >  - prefix_path: show gitdir if worktree unavailable
> >
> >  An earlier update to show the location of working tree in the error
> >  message did not consider the possibility that a git command may be
> >  run in a bare repository, which has been corrected.
> >
> >  May want a test or two.
> 
> If nobody complains in the coming 4 hours or so, I'll squash this in
> to e6c57b49 ("prefix_path: show gitdir if worktree unavailable",
> 2020-03-02) and mark the topic as "ready for 'next'".
> 
> Thanks.
> 
>  t/t6136-pathspec-in-bare.sh | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/t/t6136-pathspec-in-bare.sh b/t/t6136-pathspec-in-bare.sh
> new file mode 100755
> index 0000000000..d9e03132b7
> --- /dev/null
> +++ b/t/t6136-pathspec-in-bare.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +
> +test_description='diagnosing out-of-scope pathspec'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup a bare and non-bare repository' '
> +	test_commit file1 &&
> +	git clone --bare . bare
> +'
> +
> +test_expect_success 'log and ls-files in a bare repository' '
> +	(
> +		cd bare &&
> +		test_must_fail git log -- .. &&
> +		test_must_fail git ls-files -- ..
> +	) >out 2>err &&
> +	test_i18ngrep "outside repository" err

I think it would be better to write this test as:

  (
        cd bare &&
        test_must_fail git log -- .. 2>err &&
	test_i18ngrep "outside repository" err &&
        test_must_fail git ls-files -- .. 2>err &&
	test_i18ngrep "outside repository" err
  )

because this way we make sure that both commands fail with the error
we expect.

> +'
> +
> +test_expect_success 'log and ls-files in .git directory' '
> +	(
> +		cd .git &&
> +		test_must_fail git log -- .. &&
> +		test_must_fail git ls-files -- ..
> +	) >out 2>err &&
> +	test_i18ngrep "outside repository" err
> +'
> +
> +test_done
