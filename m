From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] mergetools: Simplify how we handle "vim" and "defaults"
Date: Sat, 26 Jan 2013 20:54:34 +0000
Message-ID: <20130126205434.GL7498@serenity.lan>
References: <1359183058-51835-1-git-send-email-davvid@gmail.com>
 <20130126121202.GH7498@serenity.lan>
 <CAJDDKr5UMyJOthSOPuChx7BCpcGwtmYcnVMh83q9kgCWSxDp4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 21:55:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzCmY-0003tI-LS
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 21:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab3AZUyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 15:54:46 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:47071 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450Ab3AZUym (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 15:54:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4F589CDA587;
	Sat, 26 Jan 2013 20:54:42 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yzYie8GrzE1Y; Sat, 26 Jan 2013 20:54:41 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id B6266CDA57C;
	Sat, 26 Jan 2013 20:54:41 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 942FC161E52B;
	Sat, 26 Jan 2013 20:54:41 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nenjVPsNxuiE; Sat, 26 Jan 2013 20:54:41 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id DB241161E115;
	Sat, 26 Jan 2013 20:54:36 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr5UMyJOthSOPuChx7BCpcGwtmYcnVMh83q9kgCWSxDp4w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214636>

On Sat, Jan 26, 2013 at 12:40:23PM -0800, David Aguilar wrote:
> On Sat, Jan 26, 2013 at 4:12 AM, John Keeping <john@keeping.me.uk> wrote:
> > On Fri, Jan 25, 2013 at 10:50:58PM -0800, David Aguilar wrote:
> >> diff --git a/Makefile b/Makefile
> >> index f69979e..3bc6eb5 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -2724,7 +2724,7 @@ install: all
> >>       $(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
> >>       $(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
> >>       $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
> >> -     $(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
> >> +     cp -R mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
> >
> > Shouldn't this be more like this?
> >
> >         $(INSTALL) -m 644 $(subst include,,$(wildcard mergetools/*)) \
> >                 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
> >         $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)/include'
> >         $(INSTALL) -m 644 mergetools/include/* \
> >                 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)/include'
> >
> > I'm not sure creating an 'include' directory actually buys us much over
> > declaring that 'vimdiff' is the real script and the others just source
> > it.  Either way there is a single special entry in the mergetools
> > directory.
>
> Thanks (and thanks for the Makefile hint.. I knew it was wrong! ;-).

I think that version's still not right actually, the first line should
probably use filter-out not subst:

	$(INSTALL) -m 644 $(filter-out include,$(wildcard mergetools/*)) \
		'$(DESTDIR_SQ)$(mergetools_instdir_SQ)'


John
