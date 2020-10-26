Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29D1C2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CCF1205ED
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603730208;
	bh=mXQJ3aKboNxpMKWsuKN+foavvTHgOCQCgAtAAHkibFc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=usWhQYEqSXibx+jVEitsz2G+190Gs52WL9juvl18aDplBOSYtZMLzWftRu+EeH1Z8
	 hF/cZGDXF5X3BXOBjW7xWHhcbF22hs5NBqfqQWCK8MaBug50Jx4txJf/jqGRYvF13u
	 dhL8rycDU/FxZ96jpm8UnLsFGUkojmhJGN6NUgpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786136AbgJZQgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:36:47 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:46444 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786134AbgJZQgr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:36:47 -0400
Received: by mail-qt1-f174.google.com with SMTP id r8so7143914qtp.13
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=LJVTnURX4UK1fTn+MjmnFvrkrEEHiQRGt7zmBSZYswA=;
        b=ZUew+fPgOT+4AIxdCslz4s8nSy7K0uqGqF8mBdj8RqFySII3FF6REMFjs1jWVgYonq
         3wA4bsQpjgn7pry2bggneRgADRrCeXJuvMKk6grGl0jgb0DVdSZzTp9zmH1zgTjH4u6U
         /5wNpZRfO8jA8lzgkJ8YllwLKHmVzJ36IFFWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=LJVTnURX4UK1fTn+MjmnFvrkrEEHiQRGt7zmBSZYswA=;
        b=gRJbQNyjbqUfyZM95rDjpl2LnEtRHZXJDfgjaAqlzF71zR9CEu4CTcEvnfLeqa4XAy
         Wd/lw1RqK+Ht8EHUfmGOXAngCw+HoYXM9OLb3uer2KbrfxTscxIPKxHNEkdWMsW44yTG
         Y3TH+W7k0eeuP3DeK5J0XJ3Qri7FpDwOeMGYhBi+Pc4fW3mSKr3evKS8HnbpMXnBZ45R
         /UwDHchh0BRbQ38Uo2UudpyaLn2ClLLkCy9pcUgWAaYk2XmCFHQewanr1ZB9cLQCpN6A
         TlpOsfjtnwUzDBLc0Tr+q4HiTjEudlH/QmmizcotFyVD2GnTVMqHt/0aHf/vW1Gqgg8k
         /mYg==
X-Gm-Message-State: AOAM531tWZnFVKs55SbZvM1qZ5ExLlpavUe3MEPTbVl4NdKpyekS2LvK
        mOOKJDZ7YesGjze7xcPQBCFvl+d66N0BBObO
X-Google-Smtp-Source: ABdhPJwmqEcPE/mMTh0tnWM9EhAhWOiULYX4rSZioTs3g2kehAwPaxSbkKeYub2mi6ocnPhJrmwFlw==
X-Received: by 2002:ac8:5a82:: with SMTP id c2mr18619753qtc.378.1603730205925;
        Mon, 26 Oct 2020 09:36:45 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id d7sm6887311qkg.29.2020.10.26.09.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:36:44 -0700 (PDT)
Date:   Mon, 26 Oct 2020 12:36:43 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Do porcelain command require lock management?
Message-ID: <20201026163643.6cp4jwj5lqkg6vns@chatter.i7.local>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20201024144637.cvwa22f2y4tvfn4z@chatter.i7.local>
 <20201025230203.GH860779@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025230203.GH860779@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 11:02:03PM +0000, brian m. carlson wrote:
> > A script I'm writing performs a succession of porcelain commands to
> > create a commit in a bare git repository:
> > 
> > git hash-object
> > git mktree
> > git commit-tree
> > git update-ref
> > 
> > Do I need to manage external locking around these commands to avoid any
> > concurrency problems, or will git take care of that?
> 
> I'm almost certain that Git will do the same locking and object creation
> semantics that it does in porcelain commands as in the plumbing commands
> you're using.  For example, I happen to know that all loose object
> creation goes through one function, which should gracefully handle
> concurrent accesses.  Git is in general safe against concurrent accesses
> and is designed not to lose or corrupt data in this case.
> 
> However, I will point out that ref updates may conflict and if so, Git
> will fail instead of waiting.  So while your repository will remain
> consistent and won't experience corruption, that doesn't mean that all
> operations will complete successfully.  Some sort of retry mechanism or
> other error handling will probably be warranted.

Thanks for your advice. I think in this case it's easier to just use 
simple locking to make sure that concurrent processes don't step on 
each-other's toes.

Best regards,
-K
