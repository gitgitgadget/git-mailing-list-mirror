From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 03/14] Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual C++
Date: Fri, 21 Aug 2009 23:41:37 +0200
Message-ID: <200908212341.37531.j6t@kdbg.org>
References: <cover.1250860247.git.mstormo@gmail.com> <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com> <7vr5v4dgz0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <mstormo@gmail.com>,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:44:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mebu8-0008RI-OC
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbZHUVlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 17:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755017AbZHUVlj
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:41:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:25089 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458AbZHUVli (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 17:41:38 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1F843A7EB0;
	Fri, 21 Aug 2009 23:41:37 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9D0C545597;
	Fri, 21 Aug 2009 23:41:37 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vr5v4dgz0.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126761>

On Freitag, 21. August 2009, Junio C Hamano wrote:
> Marius Storm-Olsen <mstormo@gmail.com> writes:
> > From: Frank Li <lznuaa@gmail.com>
> >
> > The Microsoft C runtime's vsnprintf function does not add NUL at
> > the end of the buffer.
>
> This contradicts the way I read the comment in compat/snprintf.c from
> f4626df (Add target architecture MinGW., 2007-12-01).
>
> As far as I can see, the correction is about the meaning of the size
> parameter to the function, namely, that a broken implementation may
> mistakenly think that it was told the maximum length of the meat of the
> string to write, and it is allowed to append a NUL beyond the limit, when
> the caller actually is telling it the size of the buffer.

Not quite. The parameter *is* the size of the buffer and vsnprintf does not 
write beyond the buffer. However, it has the awkward behavior that if the 
buffer is too short by exactly one byte, i.e. there is room for the complete 
string, but not for the terminating NUL, then vsnprintf does not report an 
error!

Therefore, we tell vsnprintf that the buffer is shorter by one byte and always 
write NUL in the last position so that we get a correctly terminated string 
even in this case.

-- Hannes
