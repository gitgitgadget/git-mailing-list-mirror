From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move stripspace() and launch_editor() to strbuf.c
Date: Sun, 11 Nov 2007 22:29:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711112227420.4362@racer.site>
References: <Pine.LNX.4.64.0711111728380.4362@racer.site>
 <7vtznsbgcc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrLJq-000423-KN
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbXKKW3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbXKKW3t
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:29:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:34423 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754749AbXKKW3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:29:47 -0500
Received: (qmail invoked by alias); 11 Nov 2007 22:29:46 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp030) with SMTP; 11 Nov 2007 23:29:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/v+mt/gWnvapT7uX18PWAt1rF9zRlqSzIuTvVg7V
	6JfCIBFWrKRfW9
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtznsbgcc.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64527>

Hi,

On Sun, 11 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > These functions are already declared in strbuf.h, so it is only
> > logical to move their implementations to the corresponding file.
> > Particularly, since strbuf.h is in LIB_H, but both functions
> > were missing from libgit.a.
> 
> I think this makes sense for stripspace(), but I have trouble
> with launch_editor().
> 
> I do not object to have a function in strbuf API that takes a
> buffer, allows the end user to interactively edit its content
> and returns the updated content.  The function was perfectly
> fine as a special purpose helper for git-commit and git-tag, but
> if you look at the current launch_editor(), it is not suitable
> as a generic strbuf library function:
> 
>  * "Launch" feels as if we are initiating an async operation and
>    returning from the function without waiting for its
>    completion, but this is not "launch" but "launch, wait and
>    return the resulting string".  Probably this should be called
>    edit_buffer() or something like that.
> 
>  * Instead of dying, it should return exit code and have the
>    caller choose to die or take any alternative action.  The
>    library function definitely should not say "if you are in an
>    environment where we cannot let you interactively edit, use
>    -F or -m option".

All valid points.  Will add to my TODO list and repost when done.

Maybe call_editor() instead of edit_buffer()?  Since we technically read 
the file specified by "path" into the buffer "buffer", after having called 
the editor.

Ciao,
Dscho
