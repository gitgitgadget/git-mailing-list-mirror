From: Jeff King <peff@peff.net>
Subject: Re: git-svn -- out of memory
Date: Mon, 16 Feb 2009 08:45:06 -0500
Message-ID: <20090216134506.GA20271@coredump.intra.peff.net>
References: <1234777061.090819.2512.nullmailer@beryx.hq.kred> <7vhc2ubssd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: ams@gnu.org, Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 14:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ3o7-0007w6-Bh
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 14:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828AbZBPNpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 08:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756394AbZBPNpK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 08:45:10 -0500
Received: from peff.net ([208.65.91.99]:53127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755368AbZBPNpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 08:45:08 -0500
Received: (qmail 16160 invoked by uid 107); 16 Feb 2009 13:45:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Feb 2009 08:45:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2009 08:45:06 -0500
Content-Disposition: inline
In-Reply-To: <7vhc2ubssd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110180>

On Mon, Feb 16, 2009 at 02:05:54AM -0800, Junio C Hamano wrote:

> "Alfred M\. Szmidt" <ams@gnu.org> writes:
> 
> >    > when doing a `git svn clone' on a subversion repository that contains
> >    > a large file (>1GiB), `git svn' dies with the following:
> >    > 
> >    > ams@trillian:~$ git svn clone REPO -T trunk -b branches -t tags
> >    > [...]
> >    > fatal: Out of memory? mmap failed: Cannot allocate memory
> >    > hash-object -w --stdin-paths: command returned error: 128
> 
> Ding...
> [...]
> The hash-object error message sounds like the issue that was fixed with
> 915308b (avoid 31-bit truncation in write_loose_object, 2009-01-29).  Does
> v1.6.2-rc1 help?

Hmm. The original problem I had with the 32-bit wrapping actually caused
malloc to fail, whereas this is an mmap failure. So it might not be the
same thing (but certainly testing with v1.6.2-rc1 will be a good data
point).

-Peff
