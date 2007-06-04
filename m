From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the installation targets a little less chatty
Date: Mon, 4 Jun 2007 16:00:05 +0200
Message-ID: <81b0412b0706040700s667afe5ap14a8343a9313ef60@mail.gmail.com>
References: <20070603010044.GA4507@spearce.org>
	 <20070603130745.GC2495@steel.home>
	 <7vvee4jh24.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 16:00:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvD6l-0006Xn-Sw
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 16:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbXFDOAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 10:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbXFDOAJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 10:00:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:32710 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbXFDOAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 10:00:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so760869ugf
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 07:00:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X1zS8ZLSO4yyDBGm1E8gcwyVHRddChdvYcQvLd9FLEiKm7HkaqGwFxhtB0I/c5qg41M3ZYFNhI10J+0WXra/b1fUTMBB26IS9cPNbUsWBN7wqIGiw5mbg8aCva1bul6hNnl2zRyPPCcJogluPqUiwGjVC/Qhek04YJ6/iGetrJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AhPpBw6J4ceqrZtXLZHiTXEmInI/YUS5rWFNJW4qbjV7QWfCoykO+IPjDr6dilV4EBdGzSwHrRE0bzpvNYrSk6R3fxaNO+Psw3W9CnqivHnjobUoYIx610jiLNh3wF0w78qYW6FwqU3qdKQc9q8qbpfTaERoGZOe4WZzBbBMLXE=
Received: by 10.78.138.6 with SMTP id l6mr2017764hud.1180965605319;
        Mon, 04 Jun 2007 07:00:05 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Mon, 4 Jun 2007 07:00:05 -0700 (PDT)
In-Reply-To: <7vvee4jh24.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49103>

On 6/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Updated. BTW, where does "no $(call) in Makefile" came from?
> > It could simplify the thing a lot
>
> Probably, but first let's make it "work right" while not
> introducing new stuff.
>

Just looked for the reasons, which appear to be there:
commit 39c015c556f285106931e0500f301de462b0e46e
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Sat Feb 18 12:40:22 2006 +0100

    Fixes for ancient versions of GNU make

    Some versions of GNU make do not understand $(call), and have problems to
    interpret rules like this:

    some_target: CFLAGS += -Dsome=defs

    [jc: simplified substitution a bit. ]

    Signed-off-by: Johannes E. Schindelin <Johannes.Schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

I trust Johannes to have such a make, never seen it myself, though.

> >  install: all
> >       $(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
> >       $(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
>
> I found Shawn's "DEST = $this_directory" quite decent.  Forgot
> to port it?
>

Race condition. Hit the send button before reading his patch and
the related discussion. Besides, now I find it is already too much
cruft just to print a directory. Didn't want to make it pretty, just
needed some readability on screen. Still think the errors of
(eventually) failing install would be enough.

Using $(call) would allow to generalize that, BTW.
