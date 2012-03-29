From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Thu, 29 Mar 2012 13:15:25 -0400
Message-ID: <20120329171525.GB12318@sigill.intra.peff.net>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <7v62dowpdu.fsf@alter.siamese.dyndns.org>
 <20120328194045.GC29019@sigill.intra.peff.net>
 <CAH6sp9Pw75x6YrmEyLmbsbvHrbs8r6xSp3YC2NP-jOed-zZ3+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 19:15:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDIwk-0004D2-3z
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 19:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759608Ab2C2RPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 13:15:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39469
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759174Ab2C2RPa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 13:15:30 -0400
Received: (qmail 3232 invoked by uid 107); 29 Mar 2012 17:15:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 13:15:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 13:15:25 -0400
Content-Disposition: inline
In-Reply-To: <CAH6sp9Pw75x6YrmEyLmbsbvHrbs8r6xSp3YC2NP-jOed-zZ3+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194272>

On Thu, Mar 29, 2012 at 01:16:47PM +0200, Frans Klaver wrote:

> > Yes, we can differentiate after the fact. Though I think it ends up
> > being almost the same code as just implementing execvp in the first
> > place.
> 
> It will, but doesn't stock execv*() also provide access to shell
> builtins? If that's the case then I wouldn't be bothered by the extra
> bit of code we need to understand what execvp has been doing. I think
> it would be sane to keep sane_execvp a wrapper instead of a
> reimplementation.

No, definitely not. Handling builtins is the responsibility of the
shell, not of execvp. It is responsible for falling back to "/bin/sh
$file" if execve returns ENOEXEC.

Anyway, I think the last round I posted is good enough. It is
approaching execvp in complexity, but it is still a little bit simpler.
And because it's on the error code path, if we are incompatible the
worst thing we can screw up is the error message, not the actual exec.

-Peff
