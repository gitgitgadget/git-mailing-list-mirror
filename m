From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Thu, 28 Jul 2011 10:47:58 -0600
Message-ID: <20110728164758.GA15931@sigill.intra.peff.net>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
 <1311012516-4836-5-git-send-email-kusmabite@gmail.com>
 <7vmxga7zb9.fsf@alter.siamese.dyndns.org>
 <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com>
 <20110728160845.GA14337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTl0-0007eV-7E
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467Ab1G1QsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:48:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37176
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906Ab1G1QsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:48:16 -0400
Received: (qmail 12941 invoked by uid 107); 28 Jul 2011 16:48:47 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Jul 2011 12:48:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2011 10:47:58 -0600
Content-Disposition: inline
In-Reply-To: <20110728160845.GA14337@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178079>

On Thu, Jul 28, 2011 at 10:08:45AM -0600, Jeff King wrote:

> > Thanks for the notice. And no, not at all :(
> > 
> > OK then. I'll probably have to rewrite this to use start_async +
> > dup-bonanza instead of start_command...
> 
> What's the issue? In my final version, I didn't think I changed
> run_upload_archive much at all. I would think there would be a trivial
> text conflict at the end of run_upload_archive, but the semantics should
> otherwise be the same.

Ah, nevermind. I see now; the command-line option interface to "git
archive" is not as rich as what you can pass via write_archive.

I think you can get around it by adding an option to "git archive" to
indicate that we are filling a remote request, which is the only
extra information that my series adds.

I do think the start_async approach is a little more natural, though. If
the dup() bits get too ugly, it would not be that hard to make the
archive code write to a specific descriptor.

-Peff
