From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Wed, 5 Mar 2014 13:31:51 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140305093151.GA3994@tugrik.mns.mnsspb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
 <CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
 <CABPQNSadTGfiue6G+6x7_o10Ri1E7D5vZFU=Cp8rAha+j9jwSA@mail.gmail.com>
 <20140228170012.GA5247@tugrik.mns.mnsspb.ru>
 <CABPQNSYnDjhxjpyZQkNP_qwect_tnPvJ_nEfGSq9qnYFMpehWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 10:30:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL89m-0004uD-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 10:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbaCEJaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 04:30:24 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:51011 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbaCEJaV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 04:30:21 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WL89U-0000yc-VA; Wed, 05 Mar 2014 13:30:13 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WL8B5-00012p-Kx; Wed, 05 Mar 2014 13:31:51 +0400
Content-Disposition: inline
In-Reply-To: <CABPQNSYnDjhxjpyZQkNP_qwect_tnPvJ_nEfGSq9qnYFMpehWg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243430>

On Fri, Feb 28, 2014 at 06:19:58PM +0100, Erik Faye-Lund wrote:
> On Fri, Feb 28, 2014 at 6:00 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > On Fri, Feb 28, 2014 at 02:50:04PM +0100, Erik Faye-Lund wrote:
> >> On Fri, Feb 28, 2014 at 2:44 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> >> > On Mon, Feb 24, 2014 at 5:21 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> >> >> diff --git a/Makefile b/Makefile
> >> >> index dddaf4f..0334806 100644
> >> >> --- a/Makefile
> >> >> +++ b/Makefile
> >> >> @@ -316,6 +321,7 @@ endif
> >> >>  ifeq ($(uname_S),Windows)
> >> >>         GIT_VERSION := $(GIT_VERSION).MSVC
> >> >>         pathsep = ;
> >> >> +       HAVE_ALLOCA_H = YesPlease
> >> >>         NO_PREAD = YesPlease
> >> >>         NEEDS_CRYPTO_WITH_SSL = YesPlease
> >> >>         NO_LIBGEN_H = YesPlease
> >> >
> >> > In MSVC, alloca is defined in in malloc.h, not alloca.h:
> >> >
> >> > http://msdn.microsoft.com/en-us/library/wb1s57t5.aspx
> >> >
> >> > In fact, it has no alloca.h at all. But we don't have malloca.h in
> >> > mingw either, so creating a compat/win32/alloca.h that includes
> >> > malloc.h is probably sufficient.
> >>
> >> "But we don't have alloca.h in mingw either", sorry.
> >
> > Don't we have that for MSVC already in
> >
> >     compat/vcbuild/include/alloca.h
> >
> > and
> >
> >     ifeq ($(uname_S),Windows)
> >         ...
> >         BASIC_CFLAGS = ... -Icompat/vcbuild/include ...
> >
> >
> > in config.mak.uname ?
> 
> Ah, of course. Thanks for setting me straight!
> 
> > And as I've not touched MINGW part in config.mak.uname the patch stays
> > valid as it is :) and we can incrementally update what platforms have
> > working alloca with follow-up patches.
> >
> > In fact that would be maybe preferred, for maintainers to enable alloca
> > with knowledge and testing, as one person can't have them all at hand.
> 
> Yeah, you're probably right.

Erik, the patch has been merged into pu today. Would you please
follow-up with tested MINGW change?

Thanks beforehand,
Kirill
