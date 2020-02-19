Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D23C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D94721D56
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Dca2LRe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBST60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:58:26 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:39747 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBST6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 14:58:25 -0500
Received: by mail-pg1-f180.google.com with SMTP id j15so630170pgm.6
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 11:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pkato+ee1up1hBvcN3s+qMDoqh733JP8dWs+ecaWaO4=;
        b=Dca2LRe3yyqsNcVdyIlRIXfGhzEjCC1Q0hskaDnvgF7Crt8jnbhV+PZJep5k3eI73Y
         YR9QvVXUzmEjk/wNGmFUcTWqw78pxNg+mmUOTlgO8XJM/FO5Nexek6i6W7cltonqSkJv
         Got2eIbno7Cx4+IwIod+Wr80IYzcMlimkRmeEfvdbslqwLiA+yZFZUPGFI9SDHbG6cCd
         MYyHV/KXmByST1zJYCXTa42QmqqcBcV0VMrlrZ3Bnj4OIv9Hxbe2+UBQkzoJ69zaNM1+
         KdK4J848YEgvK7u36+i/kfzRuMDMOgTnITOsh6mKOwSjABOsZd7VQEJL+RpkpXRMmYPc
         naog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pkato+ee1up1hBvcN3s+qMDoqh733JP8dWs+ecaWaO4=;
        b=ole8h31o9uIuNWFJoUntOnxXbGnmpeag6j4e3iBcuwnu0PyZrVN4dMXPeihMkBNWAu
         RskVO+U4GIQU0ZgjncWcvdlw67Z+aVF4wawY2EBAExSVSisqMOL8dKlRVK8rPI1/ZGUX
         1LxXyg8NbSgeZikEnLzr8YlWAD/st4ibKzWkCdM2sbP9BP4QxiSpkOnIAaS56nAPCF9w
         fGJvwUg0DMU+b3EHtUbqjwi6PXQ+rAkjh9tCux4G+4oyMvXxwMJBVFmpFTiejA+MdsyQ
         iwmo+K2o9aMEopOusdBv0OUMGVXApxbxpbd2fCxuTcoJE0iWGD9RBGAhdtcQp8h1ARLF
         Aoag==
X-Gm-Message-State: APjAAAUwGry3EyfxfPP4p7jbYzkSjWW4B/i+UIn7oHXmiULzs2zy5/gw
        hH4OiVPf4z3Mp5Wwigb0nVyWUA==
X-Google-Smtp-Source: APXvYqwM5jGZ6+tK643LrA5GOv/GbIQsyi8Qe9fOdIOfuxK/fpFP7i6YPXR8xZ/sba9BYPQXLxp6MQ==
X-Received: by 2002:a62:7c96:: with SMTP id x144mr29367524pfc.7.1582142304270;
        Wed, 19 Feb 2020 11:58:24 -0800 (PST)
Received: from localhost ([205.175.106.52])
        by smtp.gmail.com with ESMTPSA id x21sm422899pfn.164.2020.02.19.11.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:58:23 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:58:22 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2020, #04; Mon, 17)
Message-ID: <20200219195822.GA5101@syl.local>
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 02:08:38PM -0800, Junio C Hamano wrote:

> * tb/commit-graph-split-merge (2020-02-12) 3 commits
>  - builtin/commit-graph.c: support '--input=none'
>  - builtin/commit-graph.c: introduce '--input=<source>'
>  - builtin/commit-graph.c: support '--split[=<strategy>]'
>
>  The code to write out the commit-graph has been taught a few
>  options to control if the resulting graph chains should be merged
>  or a single new incremental graph is created.
>
>  Waiting for the discussion to settle.
>  cf. <20200212205028.GE4364@syl.local>

I think that this discussion is still "settling", although the thread
hasn't had any activity for a few days now.

I wanted to get feedback from my response to Eric Sunshine before saying
that we have consensus, but otherwise I think this is moving along.

Thanks,
Taylor
