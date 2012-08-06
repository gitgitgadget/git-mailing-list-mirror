From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] add interface for /dev/tty interaction
Date: Mon, 6 Aug 2012 15:45:11 -0400
Message-ID: <20120806194511.GB10039@sigill.intra.peff.net>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-2-git-send-email-rctay89@gmail.com>
 <7vsjc12j5o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 21:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyTEw-0001rU-AF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 21:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531Ab2HFTpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 15:45:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53608 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932520Ab2HFTpO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 15:45:14 -0400
Received: (qmail 18021 invoked by uid 107); 6 Aug 2012 19:45:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 15:45:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 15:45:11 -0400
Content-Disposition: inline
In-Reply-To: <7vsjc12j5o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202978>

On Sun, Aug 05, 2012 at 01:11:47PM -0700, Junio C Hamano wrote:

> Tay Ray Chuan <rctay89@gmail.com> writes:
> 
> > Factor out the opening and closing of /dev/tty from
> > git_terminal_prompt(), so that callers may first test if a controlling
> > terminal is available before proceeding with prompting proper.
> >
> > When HAVE_DEV_TTY is not defined, terminal_open() falls back to checking
> > tty-ness of stdin and stderr, as getpass() uses them both.
> >
> > Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> > ---
> 
> This is not your fault but seeing term_t made me go "eek, yuck".

Agreed.

> As far as I can see, use of "FILE *" in existing compat/terminal.c
> is not buying us anything useful.  The stdio calls made on FILE *fh
> are only fopen(), fputs(), fflush() and fclose(), and everything
> else goes through fileno(fh).
> 
> So perhaps it is a saner approach to fix that function first before
> this patch so that it works on file descriptors.

Yeah, I think that is a good path. I think my original use of stdio
was mostly because I started by paring down glibc's implementation of
getpass.  Since we have niceties like write_in_full, I don't think
there's any reason not to just skip stdio.

-Peff
