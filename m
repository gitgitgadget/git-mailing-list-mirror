Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D221FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 12:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbcLSM35 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 07:29:57 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:44595 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754774AbcLSM3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 07:29:55 -0500
X-Greylist: delayed 2111 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Dec 2016 07:29:55 EST
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1cIwWh-0002kg-Qv; Mon, 19 Dec 2016 11:54:43 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22615.51843.744027.398293@chiark.greenend.org.uk>
Date:   Mon, 19 Dec 2016 11:54:43 +0000
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] check-ref-format: Refactor to make --branch code more
 common
In-Reply-To: <e93ee78a-aa5e-27f6-9703-6efa385f487b@alum.mit.edu>
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
        <20161104191358.28812-3-ijackson@chiark.greenend.org.uk>
        <e93ee78a-aa5e-27f6-9703-6efa385f487b@alum.mit.edu>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty writes ("Re: [PATCH 2/5] check-ref-format: Refactor to make --branch code more common"):
> On 11/04/2016 08:13 PM, Ian Jackson wrote:
> >  static int normalize = 0;
> > +static int check_branch = 0;
> >  static int flags = 0;
> >  
> >  static int check_one_ref_format(const char *refname)
> >  {
> > +	int got;
> 
> `got` is an unusual name for this variable, and I don't really
> understand what the word means in this context. Is there a reason not to
> use the more usual `err`?

I have no real opinion about the name of this variable.  `err' is a
fine name too.

> > +	if (check_branch && (flags || normalize))
> 
> Is there a reason not to allow `--normalize` with `--branch`?
> (Currently, `git check-ref-format --branch` *does* allow input like
> `refs/heads/foo`.)

It was like that when I found it :-).  I wasn't sure why this
restriction was there so I left it alone.

Looking at it again: AFAICT from the documentation --branch is a
completely different mode.  The effect of --normalize is not to do
additional work, but simply to produce additional output.  It really
means --print-normalized.  --branch already prints output, but AFAICT
it does not collapse slashes.  This seems like a confusing collection
of options.  But, sorting that out is beyond the scope of what I was
trying to do.

In my series I have at least managed not to make any of this any
worse, I think: the --stdin option I introduce applies to both modes
equally, and doesn't make future improvements to the conflict between
--branch and --normalize any harder.

(In _this_ patch, certainly, allowing --normalize with --branch would
be wrong, since _this_ patch is just refactoring.)

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
