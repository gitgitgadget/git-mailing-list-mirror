From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sat, 30 Aug 2008 14:39:50 -0400
Message-ID: <20080830183949.GA16415@coredump.intra.peff.net>
References: <20080830173947.GF7185@schiele.dyndns.org> <20080830180022.GA14552@coredump.intra.peff.net> <7vwshygyy9.fsf@gitster.siamese.dyndns.org> <20080830183413.GG7185@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lea Wiemann <lewiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 20:41:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZVNZ-0003Bo-Dz
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 20:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbYH3Sjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 14:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbYH3Sjw
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 14:39:52 -0400
Received: from peff.net ([208.65.91.99]:1851 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569AbYH3Sjw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 14:39:52 -0400
Received: (qmail 24738 invoked by uid 111); 30 Aug 2008 18:39:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 30 Aug 2008 14:39:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Aug 2008 14:39:50 -0400
Content-Disposition: inline
In-Reply-To: <20080830183413.GG7185@schiele.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94403>

On Sat, Aug 30, 2008 at 08:34:13PM +0200, Robert Schiele wrote:

> If there are problems with that change I recommend just using my
> initial patch changing the documentation to require Perl 5.8 since my
> interest in Perl 5.6 support is not big enough to mess around with
> quoting all that stuff.  If someone really needs this he or she can
> still do it --- it should be not too difficult.

I think it is as simple as:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index da768ee..4ee6f89 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -61,7 +61,7 @@ sub run_cmd_pipe {
 		return qx{@args};
 	} else {
 		my $fh = undef;
-		open($fh, '-|', @_) or die;
+		open($fh, '-|', join(' ', map { quotemeta($_) } @_)) or die;
 		return <$fh>;
 	}
 }

But I didn't do any testing beyond checking that "git add -i 'file with
spaces'" which was broken by your patch now works at all.

-Peff
