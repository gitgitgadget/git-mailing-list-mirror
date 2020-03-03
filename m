Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D119CC3F2CD
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 02:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9895C21D56
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 02:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KGyLluZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgCCCTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:19:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44501 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgCCCTb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 21:19:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id y5so643746pfb.11
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 18:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QALt8TaYHM+yxFdEEEFMzRGU9IRGaLXxXp1VwnS//yM=;
        b=KGyLluZ0eUKtRNZiS3PSw/8J6HTlQq8AG+EQ6XTfYtEFk+mgm83HeH+XmckyOP3ZBM
         QrQqgz7DJ0Xom6rKCKnCfvHyBje1FO1V3V3c+MNGNpHJvDcBIFEqjZxk0c/1kjSkR6W3
         W/OEE/9S5pPt+p6pHLaJPf4iwm9U8HKWRKxo3GZUxTQJzvXHx9FMBqVh8ZB0202BaEj7
         nku9dwqCEeAHH8XJBfhHVg0WPoAcmydznCWXtLU5QdEApmNut6BZfD933e++e+erfdwU
         1iKnXzzXxgNQ09n9W0QH2v/w2Lz6EiO2yQ8rXfrbApMEEbeiB1i1PRllbpv2zDkKn5vv
         Ixlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QALt8TaYHM+yxFdEEEFMzRGU9IRGaLXxXp1VwnS//yM=;
        b=N5WPfsuKU058BzwwluknvfJnoLy5r2quSRQbizFIV2MMPH6oyGxn+vlXiOvtuEOGoF
         7ez8+jq/MgfxvyvDqGlFyAMsbZGA9TbgDV2CXeoXu969FvIp1tRaos4e0AnP1l4PxyXW
         ngz3Cg26Rs1BHeGiqVU0vIZ/gNO/L00AT0ilCpla0hlFghUhI0xOgnQYjWhiICHf/y8L
         cUzgT2aRfmzy6qq7kAg8o1qIQ5xrZt4uxFJcinKBNBtjCmP2gVxbR888CLpQmcSsfLpg
         MyfkM3DkEAV4eMUPykIG9pPE6UzYGz3xYnL0T9LVTldZ2KuIpM/tZN6RFowDroUm/YTX
         KCgg==
X-Gm-Message-State: ANhLgQ1m4W2BgQBE1mr3phO1TIr//OeRwTDw5aLopebeTqJ144VqC+4i
        XwAXimq8J9rryxhmNqzh9Wafdm0LwUQXtw==
X-Google-Smtp-Source: ADFU+vs7O/ggmIvCi1/DuQaCX1Kym/gzDl6eBTaxOZDUu4e4DPBDOjHcdeeoYn9Q1cQFQ8B3rPUcuw==
X-Received: by 2002:a05:6a00:2ba:: with SMTP id q26mr1894128pfs.249.1583201969808;
        Mon, 02 Mar 2020 18:19:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a71sm6755830pfa.117.2020.03.02.18.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 18:19:29 -0800 (PST)
Date:   Mon, 2 Mar 2020 18:19:24 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC PATCH v2] prefix_path: show gitdir when arg is outside repo
Message-ID: <20200303021924.GJ212281@google.com>
References: <20200214232933.243520-1-emilyshaffer@google.com>
 <20200215010013.190528-1-emilyshaffer@google.com>
 <20200228195805.GA190372@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228195805.GA190372@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 11:58:05AM -0800, Jonathan Nieder wrote:
> Hi,
> 
> Emily Shaffer wrote:
> 
> > When developing a script, it can be painful to understand why Git thinks
> > something is outside the current repo, if the current repo isn't what
> > the user thinks it is. Since this can be tricky to diagnose, especially
> > in cases like submodules or nested worktrees, let's give the user a hint
> > about which repository is offended about that path.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  pathspec.c | 3 ++-
> >  setup.c    | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/pathspec.c b/pathspec.c
> > index 128f27fcb7..166d255642 100644
> > --- a/pathspec.c
> > +++ b/pathspec.c
> > @@ -439,7 +439,8 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
> >  		match = prefix_path_gently(prefix, prefixlen,
> >  					   &prefixlen, copyfrom);
> >  		if (!match)
> > -			die(_("%s: '%s' is outside repository"), elt, copyfrom);
> > +			die(_("%s: '%s' is outside repository at '%s'"), elt,
> > +			    copyfrom, absolute_path(get_git_work_tree()));
> 
> This is producing segfaults when run by magit.  Reproduction recipe:
> 
> 	cd .git
> 	git ls-files ..
> 
> Expected result:
> 
> 	fatal: ..: '..' is outside repository
> 
> Actual result:
> 
> 	Segmentation fault
> 
> Does this need an extra case to handle when there is no work tree?

Ah, I see it. You're right.

In that case I'll fall back on the git dir.

Will hopefully have a patch along today. Thanks for reporting it.

 - Emily

