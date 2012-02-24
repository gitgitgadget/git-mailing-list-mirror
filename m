From: Ian Kumlien <pomac@vapor.com>
Subject: Re: [FYI] very large text files and their problems.
Date: Fri, 24 Feb 2012 11:11:21 +0100
Message-ID: <20120224101121.GA9526@pomac.netswarm.net>
References: <20120222154926.GC11202@pomac.netswarm.net>
 <CACsJy8Bdbegs7QdztvsFnKPcpAX5UL7s7uc37wF3_nF4kJQjrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 11:11:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0s7q-0004EV-9X
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 11:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab2BXKLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 05:11:36 -0500
Received: from mail.vapor.com ([83.220.149.2]:56122 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab2BXKLe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 05:11:34 -0500
Received: from twilight.demius.net (c-387a71d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.122.56])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id D5C4140C4BB;
	Fri, 24 Feb 2012 11:11:21 +0100 (CET)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 5CD698E06C1; Fri, 24 Feb 2012 11:11:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACsJy8Bdbegs7QdztvsFnKPcpAX5UL7s7uc37wF3_nF4kJQjrQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191426>

I'm uncertain if you got my reply since i did it out of bounds - so i'll
repeat myself - sorry... =)

On Wed, Feb 22, 2012 at 11:18:19PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Wed, Feb 22, 2012 at 10:49 PM, Ian Kumlien <pomac@vapor.com> wrote:
> > Hi,
> >
> > We just saw a interesting issue, git compressed a ~3.4 gb project to ~57 mb.
> 
> How big are those files? How many of them? How often do they change?

This was the first check in, there is no deltas yet.

The file in question is ~3.3 gb in size - ie exactly: 3310214313 bytes
(as seen below in the malloc failure)

git show <blob sha1 id> |wc -c gives the same exact result.

> > But when we tried to clone it on a big machine we got:
> >
> > fatal: Out of memory, malloc failed (tried to allocate
> > 18446744072724798634 bytes)
> >
> > This is already fixed in the 1.7.10 mainline - but it also seems like
> 
> Does 1.7.9 have this problem?

Only tested 1.7.8 and 1.7.9.1 - works in mainline git (pre-1.7.10)

> > git needs to have atleast the same ammount of memory as the largest
> > file free... Couldn't this be worked around?
> >
> > On a (32 bit) machine with 4GB memory - results in:
> > fatal: Out of memory, malloc failed (tried to allocate 3310214313 bytes)
> >
> > (and i see how this could be a problem, but couldn't it be mitigated? or
> > is it bydesign and intended behaviour?)
> 
> I think that it's delta resolving that hogs all your memory. If your
> files are smaller than 512M, try lower core.bigFileThreshold. The
> topic jc/split-blob, which stores a big file are several smaller
> pieces, might solve your problem. Unfortunately the topic is not
> complete yet.

Well, in this case it's just stream unpacking gzip data to disk, i
understand if delta would be a problem... But wouldn't delta be a
problem in the sence of <size_of_change>+<size_of_subdata>+<result> ?

Ie, if the file is mmapped - it shouldn't have to be allocated, right?

> -- 
> Duy
