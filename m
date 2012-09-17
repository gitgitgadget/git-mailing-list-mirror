From: Jeff King <peff@peff.net>
Subject: Re: Unable to clone GIT project
Date: Mon, 17 Sep 2012 16:21:24 -0400
Message-ID: <20120917202124.GC24888@sigill.intra.peff.net>
References: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFDB65@NOIX10HMNOI01.AMER.DELL.COM>
 <20120916104651.GF32381@localhost.localdomain>
 <CABPQNSbPF=_a7-+JnojM2DQAkkj7ZLhSnO+n-Ab=LSrHge1dnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Ankush_Aggarwal@dell.com, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDhp2-0002Yr-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122Ab2IQUV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:21:28 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46781 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089Ab2IQUV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:21:27 -0400
Received: (qmail 12281 invoked by uid 107); 17 Sep 2012 20:21:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 16:21:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 16:21:24 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSbPF=_a7-+JnojM2DQAkkj7ZLhSnO+n-Ab=LSrHge1dnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205737>

On Sun, Sep 16, 2012 at 09:48:43PM +0200, Erik Faye-Lund wrote:

> >> git-upload-pack: error while loading shared libraries: libiconv.so.2: cannot open shared object file: No such file or directory
> >> fatal: The remote end hung up unexpectedly
>
> [...]
>
> No. This is not a Git for Windows issue. The remote end is the one who
> isn't able to load libiconv, you can tell from the fact that it
> complains about "libiconv.so.2", not "libiconv-2.dll", and from the
> fact that the client informs us that the remote end hung up.

Yeah, it is definitely a problem on the remote system.

> Ankush: There's something wrong with the setup on your Linux machine;
> most likely something related to the library path set up. What
> protocol are you cloning over?

If I had to guess, I'd say it was ssh, the library is installed in a
non-standard place (e.g., because he built them as a regular user and
put them in his home directory), and LD_LIBRARY_PATH does not get set
properly by ssh for the incoming ssh session.

If that is the case, you can fix it with an entry in ~/.ssh/environment,
or by telling git that the remote side needs to do more than just run
git-upload-pack, like:

  git clone -u '. $HOME/.profile && git-upload-pack' ...

But I am just guessing. We need more information on how the remote
system is set up to really know.

-Peff
