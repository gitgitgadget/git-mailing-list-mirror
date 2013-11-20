From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7507-*.sh: Fix test #8 (could not run '"$FAKE_EDITOR"')
Date: Wed, 20 Nov 2013 13:54:20 -0500
Message-ID: <20131120185420.GA11404@sigill.intra.peff.net>
References: <528CE716.8060307@ramsay1.demon.co.uk>
 <xmqqsiur6l9k.fsf@gitster.dls.corp.google.com>
 <20131120174226.GA16453@sigill.intra.peff.net>
 <xmqqhab67wjr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Jens.Lehmann@web.de,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 19:54:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjCv4-0005NR-9o
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 19:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab3KTSy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 13:54:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:42742 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754550Ab3KTSyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 13:54:23 -0500
Received: (qmail 29486 invoked by uid 102); 20 Nov 2013 18:54:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Nov 2013 12:54:22 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Nov 2013 13:54:20 -0500
Content-Disposition: inline
In-Reply-To: <xmqqhab67wjr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238091>

On Wed, Nov 20, 2013 at 10:33:28AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Am I misremembering the issues with one-shot variables and functions?
> 
> I think there are two problems involved.

OK, I was misremembering. I recalled the "does not unset afterwards"
part, but not the "does not export" part. I think because:

> test_must_fail () {
> 	(
> 		env | sed -n -e '/EDITOR/s/^/>> /p'
> 	)
> }

...here we _do_ have GIT_EDITOR set properly in the function itself, but
not in the subprocess.

Previous discussion and links to POSIX are here:

  http://article.gmane.org/gmane.comp.version-control.git/137095

Not that they matter compared to the code you demonstrated, but I was
digging them up when you responded. :)

> Another is that EDITOR="$FAKE_EDITOR" that is set up earlier in the
> is having trouble launching (I have a feeling that it never was
> actually used because everybody uses "commit -F <file>").

I think it is used, as there are several "git commit --amend -v"
invocations. Which makes sense, as you should not be able to test "-v"
with "-F", I would think.

I'm not sure why the old $FAKE_EDITOR doesn't work there, though (not
that it would make the test pass anyway, as it does something different
than what the test wants, but I would not expect the shell to complain
of failure).

-Peff
