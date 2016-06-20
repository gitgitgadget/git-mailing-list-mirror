Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F10D1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 19:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933218AbcFTTjm (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 15:39:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:57423 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933196AbcFTTjb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 15:39:31 -0400
Received: (qmail 5577 invoked by uid 102); 20 Jun 2016 19:39:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 15:39:31 -0400
Received: (qmail 17470 invoked by uid 107); 20 Jun 2016 19:39:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 15:39:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 15:39:28 -0400
Date:	Mon, 20 Jun 2016 15:39:28 -0400
From:	Jeff King <peff@peff.net>
To:	Norbert Kiesel <nkiesel@gmail.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: unable to pull from remote if commit date is in the future
Message-ID: <20160620193928.GA3631@sigill.intra.peff.net>
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
 <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
 <CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 12:05:07PM -0700, Norbert Kiesel wrote:

> Hmm.  On closer inspection that commit 23c07cc that github shows with
> date 2152-06-19 is already in my local branch.  I got confused because
> locally it is shown with a different date: `git log -1 --format='%ci'
> 23c07cc` shows "2106-02-07 06:28:56 -40643156" which is invalid.
> 
> My system is running Debian unstable 64bit.  Is git using the time
> rendering methods from the C library (glibc 2.22-12)?

No, git's time code is (mostly) internal routines. Can you show us the
output of:

    git cat-file commit 23c07cc | egrep '^author|committer'

Note also that some interfaces (like "git log", and GitHub) will show
the author date by default, which might be different than the committer
date. The "-40643156" timezone definitely looks suspicious, though. I'm
curious if it is bad handling in the time code, or if the commit has
corrupt ident lines.

-Peff
