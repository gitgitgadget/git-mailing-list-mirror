Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F9FC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECEF60E05
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhJMToL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJMToL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 15:44:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D2C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:42:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v20so2531410plo.7
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SJHvXYjBZR4is0tMw7dD1co9if/0pofcALWU8e3Qxa4=;
        b=Yig0PeZk4RokZioUP6M8MU5QFIwe1i1djm6+OZ8FbLxDTcXn7lGoP0FIsgOEG3nyGv
         J9fTQWtbSaHnaIiDkV0Yeo5RcuqliHG2lkQLdGXUr8ulNndavMAhCnvxBhRnGtUxM9cM
         u6glEeWgSwbRhfaMbN/slqLVHrwJpil0HrAEmONN9j8u0TXAKI+a4plrSdUe7YY1NJIS
         COuL0GhnUYf3LWOIgCyAF1hp/M+fYEqxAb6MJNZKDtO6uZ8EZcKB5tBuJpHzR3T7jdvJ
         i0u4fi5aVqJlvyILDcZqagm3s6hivoS51Y1qtJiFtd10Zn3kwkVW7bKcvjgsZlH8fpHH
         +YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SJHvXYjBZR4is0tMw7dD1co9if/0pofcALWU8e3Qxa4=;
        b=tKCPfaP57Zp2SzPlVr4MYbqow21Dp+YBp2TJYOG9iDARHvO4lYPzT+OKaLAabitgRo
         E70rjFnjXJ2evLZT8iTMiAoNcqwRQ5kbdwvBC0yMpMyD3oH2ynG2PvfjlArypWnuc82d
         Gs03kLnzcbimYM5gbLPwhXnywh8d6lSPFNN2dWIlkj+/9BWWCDOrdUjlrwmnClGu+RoE
         aptD8NJRhilnCaoeZppoJY8epovMRHMqx2ZG0u30ertX3UupsG08j889nITLxKZPBeG4
         I5YadWalPMyWoZ6Po7xxy9Qt31UREKH0D4+T4USjRFrK88F8cM166W0qKtJnbnZsEncz
         eBRw==
X-Gm-Message-State: AOAM532nkhkPzbkRLMHJDfUSHMoicVk2bqm5Wi+Q1Q9NN27SxDzU+B4a
        y1K60xE6n6ESzD39z7Lv2VemyhXWFkzNtQ==
X-Google-Smtp-Source: ABdhPJw3CFQEd0LK8cQRICwRugnjUfSwe2sOj429bRw0DPzu0TeVcDpBHrpi5mOI2YX8wLKtqfcHnA==
X-Received: by 2002:a17:90a:29a4:: with SMTP id h33mr1402046pjd.88.1634154126627;
        Wed, 13 Oct 2021 12:42:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3db2:597e:d036:ff3f])
        by smtp.gmail.com with ESMTPSA id i8sm285951pfo.117.2021.10.13.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:42:06 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:42:00 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] submodule: record superproject gitdir during
 absorbgitdirs
Message-ID: <YWc2iJ7FQJYCnQ7w@google.com>
References: <20210819200953.2105230-1-emilyshaffer@google.com>
 <20210819200953.2105230-4-emilyshaffer@google.com>
 <ecc6c43d-1415-125c-af53-31274a86f656@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc6c43d-1415-125c-af53-31274a86f656@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 08:50:27PM -0400, Derrick Stolee wrote:
> 
> On 8/19/2021 4:09 PM, Emily Shaffer wrote:
> > +	/* cache pointer to superproject's gitdir */
> > +	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
> > +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
> 
> Regarding this NEEDSWORK: you are specifying the config file that
> covers every worktree of this submodule, which seems to make sense
> to me. The submodule shouldn't have worktrees to itself, right? It
> might become a worktree if its superproject has a worktree.
> 
> But also: it's still correct to write to the local, non-worktree
> config file even if experimental.worktreeConfig is set. That
> config just means "we need to read the worktree config as well
> as the local config".
> 
> Or, am I misunderstanding something?
> 
> (I'm advocating for the removal of the NEEDSWORK, in case that
> wasn't clear.)

Yeah, I think by pointing from submodule gitdir to superproject gitdir
this point goes away, anyways. Regardless of which worktree is in use,
the gitdir->gitdir pointer will still be valid. I'll delete the
NEEDSWORK.

> 
> > +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
> > +			       relative_path(get_super_prefix_or_empty(),
> > +					     path, &sb));
> 
> Thanks,
> -Stolee
> 
