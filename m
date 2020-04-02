Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863BBC2D0F3
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 00:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566242077D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 00:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxnrBLIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbgDBAON (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:14:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46426 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbgDBAON (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 20:14:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id q3so837039pff.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 17:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V+zAlrJOQhNTPSIsj/uLknti17EHqxWrIM4LXFfo0kg=;
        b=OxnrBLIYsj0uiJUET3vshX93EkfnOPnJ2SDW6IttAdyALkAWaT+6n2tMy25GlnCwlN
         LUGjaQNuydYqMgCoxOWJxXyUp8a0WW/RAqk1lvqEy9dRbKRQ1HreRBO1BGEUZG5c7lCp
         VnXAn/FzYL88Fl0ylxrxZizrgXa3yNt3bNEg6JkzKpvFJFJmYyn7wvFWAu/1ear9fHKW
         3rxyaBvXBw+onFad2u42ctCtrgIKvxBBNPI+A9OMDn42EhOtRV6qcBb7wcccnOSOqPUj
         /GnEvb2JsSyrIx6K1njAk5uOiKT8aRc1QsxL5Du+3ImzVFYGtX9RNScEeuxVCiwoeVu3
         84RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V+zAlrJOQhNTPSIsj/uLknti17EHqxWrIM4LXFfo0kg=;
        b=FSEnz8jsUYpffEVTZptWgyKDkpKWKk8HcysddrGugf+gIHGSJi1IrDV2GW1/qsZjH5
         K/WS8l+0O9HRY5nnBu8Isfe5jpqNwex3ExEFKe5ZT2EmiJMmec35lbrqs64R6eMlf7Cl
         l4vhMkpYwfZ9GidqZDMeUtp58Cg+V5STDndFT4Jmf1MxWZ3oUJr+zSwZ6NccF3oNSAh7
         IaCizsk3Bt0Qprgh7UjjpjwDqvvoMHC6lI9m1ecG9zWM9Xvy3R7hZJ6gI6PjhDRKf7jR
         RV/dyWiJfyOIO8ZVoAAvph6goxc2Un9D7YUgeaTIe4gODwxU0qnu48TCnu8u3tJhlAVc
         Hbrw==
X-Gm-Message-State: AGi0PuZSszMOlw5EIyS8u0kDWM4y9y1U/z7sp2u6cmXhMrHou6dgnb8/
        kiJ8ZHRD4wYhR7PQuxQ2N78=
X-Google-Smtp-Source: APiQypK60EdRO2OcYTAB0Wtb6Wi6fICsg66lGI2vrqaEy2tP+Yk1tsKeZ/7qsSsyIthPcavbMnJMTw==
X-Received: by 2002:aa7:96f8:: with SMTP id i24mr343996pfq.321.1585786451831;
        Wed, 01 Apr 2020 17:14:11 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id z63sm2245106pgd.12.2020.04.01.17.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 17:14:10 -0700 (PDT)
Date:   Thu, 2 Apr 2020 07:14:08 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] ci: replace our Azure Pipeline by GitHub Actions
Message-ID: <20200402001408.GA2764@danh.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1585756350.git.congdanhqx@gmail.com>
 <xmqq7dyy6gui.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7dyy6gui.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-01 14:23:01-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > This series is based on work started by Dscho,
> > I started to work with this series since there're merge conflicts
> > with my series at dd/ci-musl-lib, and Dscho said he was busy for a while.
> >
> > Changes frome Dscho's version:
> > * Based on dd/ci-musl-libc
> > * Move artifact extraction out of Test phase of windows-test
> > * Move ci/print-test-failures.sh out of build-and-test phase
> > * set TERM environment variable if not exist
> > * add linux-musl job
> > * v1 doesn't report failure on linux32, fixed
> > * run linux32 directly inside container
> > * install development file of curl in documentation job because "curl-config"
> >   will be called in pu's Makefile
> >   + Other approach could be call make CURL_CONFIG=: in test-documentation.sh
> >
> > Sample run:
> > * of this series: https://github.com/sgn/git/actions/runs/68291472
> > * pretend compile failure: https://github.com/sgn/git/actions/runs/68292112
> > * pretend test failure: https://github.com/sgn/git/actions/runs/68293056
> > * merged to pu: https://github.com/sgn/git/actions/runs/68301122
> 
> When I look at
> 
>     https://github.com/git/git/actions
> 
> it appears that every time I push[*1*], we are running _two_ sets of
> the same tests, one says "Pu nu bu?" and the other says "CI/PR".
> 
> In addition, the former refers to "Pull request #nnn synchronize by
> gitster", with #nnn part made clickable, but clicking on it results
> in 404 page, as there is no such pull request.
> 
> Does this series need some help from me (i.e. changing my workflow)
> to make the CI tests run more smoothly?

I suspect there is a github Pull Request #738 (merging pu to master) in
private mode because it's what reported by Github actions.

It seems like the last 2 pushes to pu doesn't trigger it anymore?

If the problem still persists,
I think either you or Dscho can login to github and see what is there.


-- 
Danh
