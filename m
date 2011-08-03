From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Tue, 2 Aug 2011 23:49:58 -0600
Message-ID: <20110803054958.GA7547@sigill.intra.peff.net>
References: <20110801174603.GB10302@sigill.intra.peff.net>
 <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com>
 <20110801182516.GC10302@sigill.intra.peff.net>
 <4E371109.7050500@lsrfire.ath.cx>
 <4E3718B4.6090803@kdbg.org>
 <4E37202B.80208@lsrfire.ath.cx>
 <20110802040004.GC17494@sigill.intra.peff.net>
 <4E3829DC.8070802@lsrfire.ath.cx>
 <20110802181357.GA1861@sigill.intra.peff.net>
 <4E388A55.6080606@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 07:50:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoULV-00028f-I9
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 07:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab1HCFuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 01:50:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51763
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab1HCFuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 01:50:04 -0400
Received: (qmail 3253 invoked by uid 107); 3 Aug 2011 05:50:37 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 01:50:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Aug 2011 23:49:58 -0600
Content-Disposition: inline
In-Reply-To: <4E388A55.6080606@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178545>

On Wed, Aug 03, 2011 at 01:37:57AM +0200, Johannes Sixt wrote:

> Am 02.08.2011 20:13, schrieb Jeff King:
> > Hmm. So it's not _just_ the pipe vs file thing. What's different about
> > calling it from the shell, versus the way we call it from git-archive?
> 
> When the parent process of an MSYS process is itself an MSYS process,
> such as bash, then the child does not do its own
> binary-mode-vs.-text-mode detection, but just uses whatever it is told
> by the parent. This is achieved by MSYS's fork emulation.
> 
> But if the parent is a regular Windows program, such as git(-archive),
> then the autodection happens and file descriptors pointing to files are
> put into text mode.

Yuck. Well, I guess that's not really an option, then. The pipe trick
sounds like the sanest option (it would even be trivial to switch the
default value to "gzip -cn | cat" on Windows, but I assume "cat" has the
same problem).

Thanks for the explanation.

-Peff
