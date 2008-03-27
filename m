From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9600-cvsimport.sh: set HOME before checking for cvsps
	availability
Date: Wed, 26 Mar 2008 23:28:34 -0400
Message-ID: <20080327032834.GA5417@coredump.intra.peff.net>
References: <20080326173420.16383.qmail@4b0e1e5c705f62.315fe32.mid.smarden.org> <7v8x05e5fa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 04:29:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jeinn-0006P6-LO
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 04:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813AbYC0D2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 23:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbYC0D2i
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 23:28:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4232 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbYC0D2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 23:28:37 -0400
Received: (qmail 414 invoked by uid 111); 27 Mar 2008 03:28:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Mar 2008 23:28:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2008 23:28:34 -0400
Content-Disposition: inline
In-Reply-To: <7v8x05e5fa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78326>

On Wed, Mar 26, 2008 at 10:55:21AM -0700, Junio C Hamano wrote:

> In the longer run, we probably would want to do something similar for all
> tests to ensure a stable testing environment, don't we?  $HOME/.gitconfig
> may affect the way tested programs behave otherwise.

We used to, as per a patch from Gerrit long ago:

  2eb10ac... Set $HOME for selftests

but it was removed during Dscho's config fix:

  8565d2d... Make tests independent of global config files

which used GIT_CONFIG instead. But that had some problems, which I fixed
in:

  8bfa6bd... fix config reading in tests

and that patch explicitly suppresses lookup in the ~/.gitconfig and
/etc/gitconfig files (implemented by ab88c363).

So I think all is correct with .gitconfig files. However, I still think
setting HOME is a good idea, because it eliminates one more variable in
test runs. In particular, I know I have gotten cvsps into a funny state
that was resolved by removing the ~/.cvsps cache. So it's probably worth
doing as a preventative measure, even if it doesn't fix a specific bug.

-Peff
