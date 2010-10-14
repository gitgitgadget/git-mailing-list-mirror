From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-list: handle %x00 NUL in user format
Date: Wed, 13 Oct 2010 20:38:54 -0400
Message-ID: <20101014003853.GA10708@coredump.intra.peff.net>
References: <20101007182542.GA20165@sigill.intra.peff.net>
 <7vtykpiwkv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 02:38:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6BqO-0004Hp-TC
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 02:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab0JNAiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 20:38:46 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44274 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524Ab0JNAip (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 20:38:45 -0400
Received: (qmail 3351 invoked by uid 111); 14 Oct 2010 00:38:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Thu, 14 Oct 2010 00:38:44 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 20:38:54 -0400
Content-Disposition: inline
In-Reply-To: <7vtykpiwkv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159008>

On Wed, Oct 13, 2010 at 02:58:40PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Erik mentioned a potential problem with fwrite() and the way we handle
> > ANSI emulation for Windows. I think if there is a problem, then the same
> > problem exists in the --graph code, and we should do this, and then fix
> > both on top.
> 
> I am quite sure that --graph codepath is used a lot less often than this
> codepath, and most users do not hit the problem you are fixing---that is
> why it took so long to get noticed.  I think this printf() has been there
> from the beginning, even though the possibility of placing a NUL in
> buf.buf may have come much later, like when %x00 was introduced).
> 
> Use of fwrite() here will affect all Windows users who use color (probably
> most of them), no?  It may be a deliberate regression, but it has a real
> cost associated with it; it will break more usual uses on Windows to help
> an obscure use case on POSIX.

Yeah, I don't want to regress Windows users in an actual release. I was
hoping for you to queue it on a side branch, and then have Windows
people apply the proper fix on top before getting it merged in.

-Peff
