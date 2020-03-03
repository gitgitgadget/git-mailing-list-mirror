Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD456C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA51B20CC7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj8vFNEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgCCRg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:36:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40500 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgCCRg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:36:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id e26so3738076wme.5
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CYSJr+vj7Fb5HjEW5Uj1zZueYoRXkrVumOQo5+VlFoE=;
        b=fj8vFNEmMgvy0iyoIyk14/+Ya9Ed7Gj/CoeSZgRBrzf2iirVJVNlRnlnHc5u37mUDd
         OVz+nisTL2aUvLoDM2UOSHHwHooUzeuRDNmqIQCHJNAy6HK04emUWNixQH1bwPl0EHhG
         4nzc4ZhZvCYKcrM25QmtCU0kOxdaii0C0HDf38BW7k5cJw+PkeoARXUIxjyHwKPHfcVl
         9GT8EkfWWBCCu4lrihfhxPGl/x4Vp7l7Xs0czLqff2RoiqPhiCr2LRIOYwmAYOnjP5bb
         uSDOWGVvvDTypySUfR+P7u3vrS8rFjogRs7jAaR7Q0OV4dDimsiN91mK8QRdpKvLjUJe
         cf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CYSJr+vj7Fb5HjEW5Uj1zZueYoRXkrVumOQo5+VlFoE=;
        b=JAO5DSyI03mp2udDVJn28qkFT8SXtp2B9k1ooyqrwB2rpA/6Mx3bwqIgHrRSd1njfs
         eSRpCy3keCqj4wtE79YSsKxc7b5UeE2GJAQuMDNZxauQ1vizeMUV4yahArFfsuT020Zj
         5dVt6PLxMNcBn1j6uiD9Z2uKy+OToou727dm4/LiMiY0ECe2j5WkXER1tPUl3RAgW6LE
         13qdknUdONhzRItMqRwQZchHL20o9d2XYrejuyh0rNxRU/B8NoIu/EaS9KO4pNgUXKnl
         L8JprF+0vs6WqUndyXj8PibOTBEg0iLjvLdLVV//XxcpxpIu1lSUdcnQQjbFqaZmIfze
         IbEQ==
X-Gm-Message-State: ANhLgQ0vvHAFOuP35gLdVdKzkXgxguLYQa0PyONebBewSGE7eJk4k/2o
        Iu8w9NyqEulUghNFhY8hiVU=
X-Google-Smtp-Source: ADFU+vuumT9o+kq9SK36rnCuOptqPOtHnjH69RbVnu1d1OT3b+wtGZsQlAI3Sd+vkY5kIG5PCWPyAw==
X-Received: by 2002:a1c:ba87:: with SMTP id k129mr5341064wmf.102.1583256986740;
        Tue, 03 Mar 2020 09:36:26 -0800 (PST)
Received: from localhost ([2.28.70.205])
        by smtp.gmail.com with ESMTPSA id o16sm19949095wrj.5.2020.03.03.09.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 09:36:25 -0800 (PST)
Date:   Tue, 3 Mar 2020 17:36:25 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <son.luong@booking.com>, git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH 2/2] stash: remove the stash.useBuiltin setting
Message-ID: <20200303173625.GC1571684@cat>
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com>
 <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com>
 <20200302181832.GA1571684@cat>
 <20200302181924.GB1571684@cat>
 <nycvar.QRO.7.76.6.2003031430180.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003031430180.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Mon, 2 Mar 2020, Thomas Gummerer wrote:
> 
> > Remove the stash.useBuiltin setting which was added as an escape hatch
> > to disable the builtin version of stash first released with Git 2.22.
> 
> Great!
> 
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index f371db270c..5f4bd693df 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -1558,22 +1540,18 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
> >  		OPT_END()
> >  	};
> >
> > -	if (!use_builtin_stash()) {
> > -		const char *path = mkpath("%s/git-legacy-stash",
> > -					  git_exec_path());
> > -
> > -		if (sane_execvp(path, (char **)argv) < 0)
> > -			die_errno(_("could not exec %s"), path);
> > -		else
> > -			BUG("sane_execvp() returned???");
> > -	}
> > -
> >  	prefix = setup_git_directory();
> >  	trace_repo_setup(prefix);
> >  	setup_work_tree();
> 
> However, this is only needed because we did not change `git.c` at the same
> time (as I had done for `rebase` in 80dfc9242eb (git: mark cmd_rebase as
> requiring a worktree, 2019-07-24)). In other words, I think we will also
> want to address this part of `git.c`:
> 
>         /*
>          * NEEDSWORK: Until the builtin stash is thoroughly robust and no
>          * longer needs redirection to the stash shell script this is kept as
>          * is, then should be changed to RUN_SETUP | NEED_WORK_TREE
>          */
>         { "stash", cmd_stash },
> 
> Other than that, I think your patch pair is good to go!

Ah I had completely missed that, thanks for catching it!  Will send
the updated patches shortly.
