From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Wed, 11 Oct 2006 14:17:29 -0400
Message-ID: <20061011181729.GB2897@coredump.intra.peff.net>
References: <20061010025627.19317.70511.stgit@rover> <egfndo$lg6$1@sea.gmane.org> <20061010104149.GP20017@pasky.or.cz> <200610111423.00656.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 20:18:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXie6-0007vR-33
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 20:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbWJKSRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 14:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161174AbWJKSRc
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 14:17:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4284 "HELO
	peff.net") by vger.kernel.org with SMTP id S1161112AbWJKSRb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 14:17:31 -0400
Received: (qmail 24123 invoked from network); 11 Oct 2006 14:17:29 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Oct 2006 14:17:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 14:17:29 -0400
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610111423.00656.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28736>

On Wed, Oct 11, 2006 at 02:23:00PM +0200, Jakub Narebski wrote:

> Can any Perl expert tell us how Perl truly solve this? What is the best
> way to dump whole [remaining] contents of file (from filehandle) to STDOUT?

The same you would in C: read fix-sized buffers and dump them. Reading
the whole file obviously has unbounded memory allocation. Reading lines
requires unnecessary parsing and may have unbounded memory allocation
(though in practice for text files I doubt either is a big deal).

You can loop like this:
while(1) {
  my $r = read(STDIN, my $buf, 4096);
  defined($r) or die "error: $!";
  $r or last;
  print STDOUT $buf;
}

Or you can use the File::Copy module, which is part of the standard
distribution (and I believe has been so for all perl5 versions, but I
could be wrong):
  use File::Copy qw(copy);
  copy(STDIN, STDOUT);

-Peff
