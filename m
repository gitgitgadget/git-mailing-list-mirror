From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] configure.ac: rework/fix the NEEDS_RESOLV and NEEDS_LIBGEN
 tests
Date: Wed, 22 Jul 2009 09:59:18 -0500
Message-ID: <Y0sTaUtyR0m1AxCoWzsTI2uclknZENRMzspLXWzGliyRILR9F2ffNg@cipher.nrlssc.navy.mil>
References: <qSl_KXgcJD_1H47Nrg3FwRdtL-WxwLP1_aueDE8gN-By3M0uJOpw1w@cipher.nrlssc.navy.mil> <N0R1rELOlDFDG8pOY2LYJHmWygM5WFD8q_fNZgfE1A2QOX1yg6OPCZW4RbX5i03hokq4Bx2zOjM@cipher.nrlssc.navy.mil> <7v3a8pdbdr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: nicolas.s.dev@gmx.fr, git@vger.kernel.org, j6t@kdbg.org,
	peff@peff.net, david@syzdek.net, jnareb@gmail.com, bonzini@gnu.org,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 16:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTdIS-0004nY-N8
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 16:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbZGVO7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 10:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbZGVO7q
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 10:59:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45948 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbZGVO7p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 10:59:45 -0400
Received: by mail.nrlssc.navy.mil id n6MExJZO013689; Wed, 22 Jul 2009 09:59:19 -0500
In-Reply-To: <7v3a8pdbdr.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 22 Jul 2009 14:59:19.0142 (UTC) FILETIME=[FD406860:01CA0ADC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123752>

Junio C Hamano wrote:

> Instead of saying that "hstrerror not in -lc means we do have -lresolv and
> the function will be found there" blindly, we may want to have a nested
> check.
> 
> 	AC_CHECK_LIB([c], [hstrerror], [NEEDS_RESOLV=],
>        	    AC_CHECK_LIB([resolv], [hstrerror], [NEEDS_RESOLV=YesPlease]))
> 
> But we do not have any provision for the case where -lc does not have it
> and -lresolv does not have it either (or -lresolv does not exist) anyway,
> so we might as well go with your patch.

Yeah, I understood how the NEEDS_SSL_WITH_CRYPTO test worked like this, but
I didn't make the tests for NEEDS_RESOLV and NEEDS_LIBGEN any more complex
for the same reason you state: we don't have any other provision...

> I take it that swapping [if-found][if-not-found] parameters is what the
> autoconf documentation warns against?  That is, both -lc and -lresolv may
> have it but -lresolv one may be a specialized one you would not normally
> want.

That's what I assume, and that's probably why AC_SEARCH_LIBS was invented which
attempts to link without using any of the specified libraries first.  It just
doesn't seem to fit our needs in this case.

-brandon
