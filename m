From: Jeff King <peff@peff.net>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Wed, 12 Dec 2007 04:25:12 -0500
Message-ID: <20071212092512.GB20799@coredump.intra.peff.net>
References: <20071211200418.GA13815@mkl-desktop> <20071212083154.GB7676@coredump.intra.peff.net> <7vir348e0l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Klinik <markus.klinik@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 10:26:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Nqs-0007u8-Uk
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047AbXLLJZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 04:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758018AbXLLJZQ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:25:16 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4347 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757939AbXLLJZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 04:25:14 -0500
Received: (qmail 378 invoked by uid 111); 12 Dec 2007 09:25:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Dec 2007 04:25:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2007 04:25:12 -0500
Content-Disposition: inline
In-Reply-To: <7vir348e0l.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68022>

On Wed, Dec 12, 2007 at 01:21:14AM -0800, Junio C Hamano wrote:

> > +sub xargs_safe_pipe_capture {
> > +	my $MAX_ARG_LENGTH = 1024;
> > +	my $cmd = shift;
> > +	my @output;
> > +	while(@_) {
> > +		my @args;
> > +		my $length = 0;
> > +		while(@_ && $length < $MAX_ARG_LENGTH) {
> > +			push @args, shift;
> > +			$length += length($args[$#args]);
> > +		}
> > +		push @output, safe_pipe_capture(@$cmd, @args);
> > +	}
> > +	return @output;
> > +}
> > +
> 
> Makes me wonder why you are not spawning xargs by doing it by hand.  If

Because we are reading the output, and it is possible to get a pipe
deadlock. This could be avoided with a tempfile.

> the path at the beginning happens to be longer than 1024 then you will
> run path-less "cvs status"?

No, read the loop again. The length starts at 0, so we always go through
the loop body once.

-Peff
