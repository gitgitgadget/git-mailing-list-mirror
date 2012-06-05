From: Jeff King <peff@peff.net>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to
 remote-helper.
Date: Tue, 5 Jun 2012 05:07:02 -0400
Message-ID: <20120605090702.GA27376@sigill.intra.peff.net>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <20120605065628.GA25809@sigill.intra.peff.net>
 <4FCDC894.7000905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:07:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbpjM-0005NK-D9
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 11:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab2FEJHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 05:07:06 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43164
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab2FEJHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 05:07:05 -0400
Received: (qmail 15536 invoked by uid 107); 5 Jun 2012 09:07:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 05:07:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 05:07:02 -0400
Content-Disposition: inline
In-Reply-To: <4FCDC894.7000905@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199221>

On Tue, Jun 05, 2012 at 10:51:32AM +0200, Johannes Sixt wrote:

> > Note that preexec_cb does not work at all on Windows, as it assumes a
> [... a very nice explanation of the pipe issues ...]
> 
> IOW: Everything that uses --cat-blob-fd or a similar facility cannot work
> on Windows without considerable additional effort.

Thanks, Johannes, that makes sense to me.

Florian, does that mean that making the svn helper start to use
--cat-blob-fd at all is a potential regression for Windows?  The
fast-import documentation says that the cat-blob output will go to
stdout now. Does it even work at all now? I don't really know or
understand all of the reasons for cat-blob-fd to exist in the first
place.

I expect one answer might be "well, the svn remote helper does not work
at all on Windows already, so there's no regression". But this affects
_all_ fast-import calls that git's transport-helper makes. Are there
other ones that use import, and would they be affected by this? 

For that matter, isn't this a backwards-incompatible change for other
third-party helpers? Won't they need to respect the new
GIT_REPORT_FILENO environment variable? Do we need the helper to specify
"yes, I am ready to handle cat-blob-fd" in its capabilities list?

-Peff
