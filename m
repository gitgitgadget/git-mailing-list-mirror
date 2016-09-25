Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB891F935
	for <e@80x24.org>; Sun, 25 Sep 2016 03:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbcIYDNi (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 23:13:38 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35589 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbcIYDNh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 23:13:37 -0400
Received: by mail-pf0-f179.google.com with SMTP id s13so19767628pfd.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 20:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACz+4z36bjGEmstNEKhSgAQBoHdc0+6J8v8IjOJ1mPU=;
        b=WTw8/uMUFOa9HUuh8YjRU8GWiHIjMsh92Mg2hNUzDCj0m1QFs1tkU/+4NxX8uIXvK7
         +9g7wzEW77cQfXGbAsFbR7Xb8OUPEAcVHPm0TCxdHV9VjhFjWZU92sNf4oCBPs5RHIs0
         uAuqaDNiOASzl9gEj1eaBTWdIhDjVHE0rNlXLkB+G2hVzU2OIFp4v2CC/TuxkCmdgq9C
         3VUmXsKyMQV4GLRV91JiZEqkhIlDTOLO9vrFBGhBGK1YKNgRoXeSnZG5U5AJtx2+ibxc
         RXdTD57VPbNJLivX3UxqIO2lAEuzwk1xjnS4JG3qp2uxZ/wSSA7WMSPg063TOqcyOt6+
         r07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACz+4z36bjGEmstNEKhSgAQBoHdc0+6J8v8IjOJ1mPU=;
        b=UCfU+IjFu69lLu9FAua6Ezx/aGWcZgsg8iEDHenIv1cTiaOSJgwNJur10bTHfijd2r
         DSQ+1Teb7mHwRrntEQh0tP0leZFttMe9GwdY4dqmKe0KA6OXbOF2oGMcbMWkZx755zIY
         08DS8cgu5V9vpndk2NMOvPhkJ6HRcDFplnzLCrGn889+hN+7iB6+0phV5cbCc1HYVNBl
         kzA7dAVZ37IDH+odBhKj26JV49TXHcX+L7cs5xrPMR6NGCCRJEtDKdc03/lvbiMHlTVg
         2uyek60cGJ4w2p5vAol/HRzsnERLCIWHwwFevv9fpMyRDc0ESt5eJ1t+k5PUHsjo4pzt
         Q0SA==
X-Gm-Message-State: AE9vXwP2Ia5OVCQz/RzxBswUVcnQ4I9S5uwqluJfqv3igs80fmsScgEo++PNZE/gZF/17g==
X-Received: by 10.98.100.1 with SMTP id y1mr25817596pfb.169.1474773216472;
        Sat, 24 Sep 2016 20:13:36 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id q8sm21214694pac.32.2016.09.24.20.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 20:13:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Sep 2016 10:13:29 +0700
Date:   Sun, 25 Sep 2016 10:13:29 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com
Subject: Re: [PATCH v2 4/3] init: combine set_git_dir_init() and init_db()
 into one
Message-ID: <20160925031329.GA9124@ash>
References: <xmqqbmzf6e0r.fsf@gitster.mtv.corp.google.com>
 <20160923111206.8596-1-pclouds@gmail.com>
 <xmqqshsqz0s1.fsf@gitster.mtv.corp.google.com>
 <xmqq8tuhyvoa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tuhyvoa.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 24, 2016 at 11:55:33AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think this 4/3 is not quite enough to fix the damage to the code
> > caused by 2/3.
> > ...
> > after 4/3 is applied, we should be able to remove the global
> > variable 2/3 introduced, make init_db() receive that information as
> > the return value of set_git_dir_init(), and pass that as a parameter
> > to create_default_files().
> 
> That would look something like this squashed into 4/3, I think.  I
> am not sure if a commit that squashes 2/3, 3/3, 4/3 and this update
> together is harder to understand than keeping 2/3, 3/3 and a fixed
> 4/3 separate, though.  The end result looks much better structured
> than before 2/3 is applied to my quick scan-through of the code.
> ...

How about this?

  [1/5] init: correct re-initialization from a linked worktree
  [2/5] init: call set_git_dir_init() from within init_db()
  [3/5] init: kill set_git_dir_init()
  [4/5] init: do not set unnecessary core.worktree
  [5/5] init: kill git_link variable

I went a bit further, merging set_git_dir_init() back to init_db() so
I can kill "git_link" variable cleanly in 5/5. 3/5 does make init_db()
a bit longer, but not to the alarming level yet. By 4/5,
set_git_dir_init() is gone, so init_db() just needs to save and pass
original_git_dir down to needs_work_tree_config().
--
Duy
