From: Thorkil Naur <naur@post11.tele.dk>
Subject: How do I investigate apparently random git clone reports of "error: File ... has bad hash"?
Date: Sun, 11 Sep 2011 19:03:03 +0000 (UTC)
Message-ID: <loom.20110911T210035-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 21:10:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2pQ1-0002vE-M2
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 21:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760346Ab1IKTKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:10:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:35378 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760337Ab1IKTKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 15:10:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R2pPp-0002rO-8e
	for git@vger.kernel.org; Sun, 11 Sep 2011 21:10:05 +0200
Received: from 0x573a343a.cpe.ge-1-1-0-1101.odnqu1.customer.tele.dk ([87.58.52.58])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 21:10:05 +0200
Received: from naur by 0x573a343a.cpe.ge-1-1-0-1101.odnqu1.customer.tele.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 21:10:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.58.52.58 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.20) Gecko/20110805 Ubuntu/10.04 (lucid) Firefox/3.6.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181180>

Hello,

On a Mac OS X 10.5.8 with

> $ uname -a
> Darwin thorkil-naurs-intel-mac-mini.local 9.8.0 Darwin Kernel Version 9.8.0:
Wed Jul 15 16:55:01 PDT 2009; root:xnu-1228.15.4~1/RELEASE_I386 i386
> $ git --version
> git version 1.7.4.1
> $ 

that I use as a so-called buildbot slave (http://trac.buildbot.net/) for GHC
(http://www.haskell.org/ghc/), git clone is used repeatedly to fetch the main
repository and several other (library) repositories on which the main repository
depends. In recent months, I have experienced apparently random failures in
which git clone reports, for example:

> $ git clone http://darcs.haskell.org/ghc.git/ build8
> Cloning into build8...
> error: File 42988feeeb76f5cb92b541e9dac277e073bcb3ef has bad hash
> error: Unable to find 42988feeeb76f5cb92b541e9dac277e073bcb3ef under
http://darcs.haskell.org/ghc.git
> Cannot obtain needed blob 42988feeeb76f5cb92b541e9dac277e073bcb3ef
> while processing commit ffb2e81c03a01e74825b3a0223e214df59241fab.
> error: Fetch failed.

There are variations of this, such as

> $ git clone http://darcs.haskell.org/ghc.git/ build6
> Cloning into build6...
> error: inflate: data stream error (incorrect header check)
> error: inflate: data stream error (incorrect header check)
> error: inflate: data stream error (incorrect header check)
> error: inflate: data stream error (incorrect header check)
> error: inflate: data stream error (incorrect header check)
> error: File 280db842d43e7e68c09bf01695434fc0f8fff796
(http://darcs.haskell.org/ghc.git/objects/c8/ba6e77a6202e7df588c3b1fa3ada5142482036)
corrupt
> error: Unable to find c8ba6e77a6202e7df588c3b1fa3ada5142482036 under
http://darcs.haskell.org/ghc.git
> Cannot obtain needed blob c8ba6e77a6202e7df588c3b1fa3ada5142482036
> while processing commit ffb2e81c03a01e74825b3a0223e214df59241fab.
> error: Fetch failed.

In most cases, the git clone succeeds, but failure nevertheless happens
sufficiently often to break most builds. See, for example
http://darcs.haskell.org/ghcBuilder/builders/tn23/437/3.html.

I tried the clone of the main repository on my Ubuntu Linux machine that says

> $ uname -a
> Linux tn24 2.6.32-33-generic #72-Ubuntu SMP Fri Jul 29 21:08:37 UTC 2011 i686
GNU/Linux
> $ git --version
> git version 1.7.0.4
> $ 

(which is connected to the same network as the Mac) and was not able to
reproduce the error.

I have looked for git options (debug, verbosity) for increasing the amount of
information reported, but have not managed to find anything that seemed useful
in this situation. The apparent randomness of the failures points to some kind
of network problem, but I have not noticed other indications that my network
connection is unstable.

I am not a git expert at all, I am not using git for anything but GHC building.
I would very much appreciate some indication of how I might investigate this
problem.

Best regards
Thorkil
