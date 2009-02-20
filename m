From: Jeff King <peff@peff.net>
Subject: Re: Shallow clones (git clone --depth) are broken?
Date: Thu, 19 Feb 2009 21:49:49 -0500
Message-ID: <20090220024948.GA22419@coredump.intra.peff.net>
References: <20090219145524.32ca3915@vrm378-02.vrm378.am.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jim Ramsay <i.am@jimramsay.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 03:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaLU1-0006wI-EC
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 03:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbZBTCtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 21:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbZBTCtx
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 21:49:53 -0500
Received: from peff.net ([208.65.91.99]:42573 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbZBTCtw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 21:49:52 -0500
Received: (qmail 30974 invoked by uid 107); 20 Feb 2009 02:50:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Feb 2009 21:50:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 21:49:49 -0500
Content-Disposition: inline
In-Reply-To: <20090219145524.32ca3915@vrm378-02.vrm378.am.mot.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110781>

On Thu, Feb 19, 2009 at 02:55:24PM -0500, Jim Ramsay wrote:

> I've been trying to experiment with shallow clones, however I can't
> seem to actually create one.  Here's what I've tried, for example:
> 
> git clone --depth 1 git://git.fluxbox.org/fluxbox.git
> 
> However, this gets me everything, and takes quite a while.  After it
> completes, running gitk shows me the entire history, and the size of
> the .git directory is the same as a full clone I've done previously.
> 
> I've tried this with both 1.6.0.2 and 1.6.1.3, to the same effect.
> 
> Can anyone out there verify that this --depth option actually does
> anything?  Or could it potentially be the version of git on the
> server?

Sorry, I can't reproduce (using 1.6.0.2):

  $ git clone git://git.fluxbox.org/fluxbox.git full
  Initialized empty Git repository in /home/peff/full/.git/
  remote: Counting objects: 31521, done.
  remote: Compressing objects: 100% (8013/8013), done.
  remote: Total 31521 (delta 24321), reused 30542 (delta 23462)
  Receiving objects: 100% (31521/31521), 8.08 MiB | 499 KiB/s, done.
  Resolving deltas: 100% (24321/24321), done.
  $ du -sh full/.git
  9.2M    full/.git

  $ git clone --depth 1 git://git.fluxbox.org/fluxbox.git shallow
  Initialized empty Git repository in /home/peff/shallow/.git/
  remote: Counting objects: 5402, done.
  remote: Compressing objects: 100% (3310/3310), done.
  remote: Total 5402 (delta 4148), reused 2969 (delta 2057)
  Receiving objects: 100% (5402/5402), 3.07 MiB | 408 KiB/s, done.
  Resolving deltas: 100% (4148/4148), done.
  $ du -sh shallow/.git
  3.5M    shallow/.git

There is some server support required for shallow clone; I didn't check,
but I assume that the client would degrade gracefully to a full clone.
In which case, is it possible that fluxbox.org upgraded since you
tested? Can you try again?

-Peff
