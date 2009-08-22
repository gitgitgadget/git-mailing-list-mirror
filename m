From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 03/14] Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual 
	C++
Date: Sat, 22 Aug 2009 13:32:36 +0200
Message-ID: <18cd41840908220432me657c17gfe1b79b73d25592b@mail.gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
	 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
	 <7vr5v4dgz0.fsf@alter.siamese.dyndns.org>
	 <200908212341.37531.j6t@kdbg.org>
	 <7vfxbkbyvw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Aug 22 13:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeorU-0007Ba-Ph
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 13:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268AbZHVLch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 07:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933248AbZHVLch
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 07:32:37 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:19854 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933163AbZHVLcg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 07:32:36 -0400
Received: by ey-out-2122.google.com with SMTP id 22so334587eye.37
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:cc:content-type
         :content-transfer-encoding;
        bh=kAObtFOIYF8wYu5iy5fRcpEuDb1nW9NK7hxsCIUOwOE=;
        b=Xc7iCKOW9Na+t4CYXrzwaqz8b4Pbif27sfVOPORtD17p7DH83xdwqHLkMR6oPtWG7m
         29bnuZfLReAa6Y4npieaYbcYJJ77Dqw3D67uUGS7RiZM8anrNMXBee1+jZSrJ1lWxtbf
         D2OezcyjR3hhMMy38NrEAX3GgVFWMP7/RFM0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type:content-transfer-encoding;
        b=VPzh0E0BP+UZpOrNVZq4CHijhE93ske7a+6kZwSkneD4LGdvA99m5EJfNMcOOcSqGf
         WsuBhR/ADy+gZe5qp1t4E8FNVe6QnsN58Txkf+w3dGhHJjEfVpWNKkccsDt+nsXzWr8b
         uTvJfkRpDnBIfl1sCzAoauSrbDGannK69ONJs=
Received: by 10.216.26.82 with SMTP id b60mr439446wea.177.1250940757563; Sat, 
	22 Aug 2009 04:32:37 -0700 (PDT)
In-Reply-To: <7vfxbkbyvw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126807>

[Resending to list since gmail web interface was setup to do HTML
mails by default. Grrr
Get plain text, reply with plain text. Obvious, isn't it Google? Sorry guys..]

On Sat, Aug 22, 2009 at 12:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > Not quite. The parameter *is* the size of the buffer and vsnprintf does not
> > write beyond the buffer. However, it has the awkward behavior that if the
> > buffer is too short by exactly one byte...
>
> Thanks; I was fooled by the leading comment.  How about ...
>
>  compat/snprintf.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/compat/snprintf.c b/compat/snprintf.c
> index 6c0fb05..4d07087 100644
> --- a/compat/snprintf.c
> +++ b/compat/snprintf.c
> @@ -3,7 +3,8 @@
>  /*
>  * The size parameter specifies the available space, i.e. includes
>  * the trailing NUL byte; but Windows's vsnprintf expects the
> - * number of characters to write without the trailing NUL.
> + * number of characters to write, and does not necessarily write the
> + * trailing NUL.
>  */
>  #ifndef SNPRINTF_SIZE_CORR
>  #if defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4

Agreed. If you'd like, I'll squash that into the change, and make the
commit msg more clear.

--
.marius
