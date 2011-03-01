From: Jeff King <peff@peff.net>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 15:08:06 -0500
Message-ID: <20110301200805.GA18587@sigill.intra.peff.net>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
 <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
 <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
 <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
 <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
 <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
 <20110301194428.GD10082@sigill.intra.peff.net>
 <AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Computer Druid <computerdruid@gmail.com>, git@vger.kernel.org
To: Chad Joan <chadjoan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:08:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVrY-0000NI-BS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185Ab1CAUH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 15:07:58 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52377 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756459Ab1CAUH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 15:07:58 -0500
Received: (qmail 9875 invoked by uid 111); 1 Mar 2011 20:07:56 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 20:07:56 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 15:08:06 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168251>

On Tue, Mar 01, 2011 at 02:57:19PM -0500, Chad Joan wrote:

> > Exactly. Rather than spend time figuring out if the directory is
> > removable (which would not be atomic, anyway), we just rmdir and ignore
> > the error condition.
> >
> > I would argue that your filesystem is broken. Even if we implemented a
> > workaround to opendir() and check for files, it would still have a race
> > condition that could cause this situation to occur.
> 
> Ouch.
> 
> Would it work to do something like alias rmdir to a script or program
> that would call /bin/rmdir and then fix up the permissions?

Well, we're using the rmdir system call, so you would need a patch to
git either way. If that was something we wanted to support (with a
config option, of course), we could do the permissions check-and-restore
ourselves.

But it just seems horribly broken to me. This is CIFS to an OpenVMS
machine you said? Do the broken permissions appear to other clients or
across a remount (i.e., is it broken state in your CIFS client, or has
the server actually munged permissions)? If so, have you tried reporting
the issue to whoever writes CIFS server on OpenVMS (is it just samba)?

-Peff
