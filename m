From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Restore umasks influence on the permissions of work tree
 created by clone
Date: Mon, 9 Jul 2012 18:58:29 -0400
Message-ID: <20120709225829.GA8397@sigill.intra.peff.net>
References: <alpine.LNX.2.00.1207061700060.2056@iabervon.org>
 <20120707215029.GA26819@blimp.dmz>
 <7vobnpn224.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 00:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoMub-0007Ud-Pc
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 00:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab2GIW6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 18:58:33 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:56241
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab2GIW6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 18:58:32 -0400
Received: (qmail 22390 invoked by uid 107); 9 Jul 2012 22:58:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jul 2012 18:58:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2012 18:58:29 -0400
Content-Disposition: inline
In-Reply-To: <7vobnpn224.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201231>

On Sun, Jul 08, 2012 at 06:41:39PM -0700, Junio C Hamano wrote:

> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > The original (shell coded) version of the git-clone just used mkdir(1)
> > to create the working directories. The builtin changed the mode argument
> > to mkdir(2) to 0755, which was a bit unfortunate, as there are use
> 
> A much more important reason why this is a good change (I think you
> could even say this is a bugfix) is because directories and files in
> the working tree are created with entry.c::create_directories() and
> entry.c::create_file(), and they do honour umask settings, and the
> top-level of the working tree should be handled the same way, no?

Does the mkdir of "rr-cache/*" in rerere.c make the same mistake? The
rr-cache root is made with 0777, and the files inside each subdirectory
are created with 0666.  So it is the only thing preventing users of
shared repos from using rerere.

-Peff
