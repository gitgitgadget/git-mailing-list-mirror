From: Jeff King <peff@peff.net>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 04:12:59 -0500
Message-ID: <20131128091258.GB11444@sigill.intra.peff.net>
References: <20131128013236.96eec638b311907e2368f42b42021fd8.17478ad17f.wbe@email02.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: zhifeng hu <zf@ancientrocklab.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Nov 28 10:13:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlxeq-0004zL-SG
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 10:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab3K1JNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 04:13:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:47088 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754031Ab3K1JNB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 04:13:01 -0500
Received: (qmail 21091 invoked by uid 102); 28 Nov 2013 09:13:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Nov 2013 03:13:01 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Nov 2013 04:12:59 -0500
Content-Disposition: inline
In-Reply-To: <20131128013236.96eec638b311907e2368f42b42021fd8.17478ad17f.wbe@email02.secureserver.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238484>

On Thu, Nov 28, 2013 at 01:32:36AM -0700, Max Kirillov wrote:

> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > 
> > I am in china. our bandwidth is very limitation. Less than 50Kb/s.
> 
> You could manually download big packed bundled from some http remote.
> For example http://repo.or.cz/r/linux.git
> 
> * create a new repository, add the remote there.
> 
> * download files with wget or whatever:
>  http://repo.or.cz/r/linux.git/objects/info/packs
> also files mentioned in the file. Currently they are:
>  http://repo.or.cz/r/linux.git/objects/pack/pack-3807b40fc5fd7556990ecbfe28a54af68964a5ce.idx
>  http://repo.or.cz/r/linux.git/objects/pack/pack-3807b40fc5fd7556990ecbfe28a54af68964a5ce.pack
> 
> and put them to the corresponding places.
> 
> * then run fetch of pull. I believe it should run fast then. Though I
> have not test it.

You would also need to set up local refs so that git knows you have
those objects. The simplest way to do it is to just fetch by dumb-http,
which can resume the pack transfer. I think that clone is also very
eager to clean up the partial transfer if the initial fetch fails. So
you would want to init manually:

  git init linux
  cd linux
  git remote add origin http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  GIT_SMART_HTTP=0 git fetch -vv

and then you can follow that up with regular smart fetches, which should
be much smaller.

It would be even simpler if you could fetch the whole thing as a bundle,
rather than over dumb-http. But that requires the server side (or some
third party who has fast access to the repo) cooperating and making a
bundle available.

-Peff
