From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Work around curl-gnutls not liking to be reinitialized
Date: Fri, 8 Feb 2008 23:09:41 +0100
Organization: glandium.org
Message-ID: <20080208220941.GA22199@glandium.org>
References: <20080208073456.GA17791@glandium.org> <1202501335-28205-1-git-send-email-mh@glandium.org> <20080208213148.GA2823@glandium.org> <7vlk5vi0k9.fsf@gitster.siamese.dyndns.org> <20080208215140.GA21362@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:10:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNbQ4-00050F-5w
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 23:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbYBHWJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 17:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbYBHWJM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 17:09:12 -0500
Received: from vuizook.err.no ([85.19.215.103]:56342 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759736AbYBHWJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 17:09:11 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNbQ3-0006uu-00; Fri, 08 Feb 2008 23:10:09 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNbPh-0005pS-5h; Fri, 08 Feb 2008 23:09:41 +0100
Content-Disposition: inline
In-Reply-To: <20080208215140.GA21362@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73161>

On Fri, Feb 08, 2008 at 10:51:40PM +0100, Mike Hommey wrote:
> On Fri, Feb 08, 2008 at 01:46:14PM -0800, Junio C Hamano wrote:
> > Mike Hommey <mh@glandium.org> writes:
> > 
> > >>  In the end, it was a bit of git's fault, but either curl or gnutls is the
> > >>  actual culprit. I've not looked into either code to find out who's
> > >>  responsible, but a very simplified testcase is as follows:
> > >> ...
> > >
> > > And the winner is... curl !
> > > The bug was introduced in this commit:
> > > http://cool.haxx.se/cvs.cgi/curl/lib/gtls.c.diff?r1=1.26&r2=1.27
> > > Note how gtls_inited is not set back to FALSE in cleanup.
> > >
> > > This ended up released in 7.16.3. I'm filing a bug.
> > 
> > Good detetive work.  Thanks.
> > 
> > I guess we need to ship with a known leak to work this around.
> > Sigh...
> 
> We can probably add a test on curl versions to avoid leaking on every
> install. Something like #if LIBCURL_VERSION_NUM < 0x071003. And then add
> || LIBCURL_VERSION_NUM > .... whenever this is fixed in curl...

... and 22 minutes after filing the bug, it's fixed in CVS
http://cool.haxx.se/cvs.cgi/curl/lib/gtls.c.diff?r1=1.36&r2=1.37

which means it will be fixed in version 7.18.1.

Mike
