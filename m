From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] path-list.c: always free strdup'ed paths
Date: Sat, 7 Jul 2007 21:27:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707072124550.4093@racer.site>
References: <468FEC54.307@lsrfire.ath.cx> <Pine.LNX.4.64.0707072036530.4093@racer.site>
 <468FF19E.8020406@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jul 07 22:35:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7H03-0008Ge-H5
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 22:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbXGGUfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 16:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbXGGUfK
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 16:35:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:37222 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751688AbXGGUfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 16:35:08 -0400
Received: (qmail invoked by alias); 07 Jul 2007 20:35:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 07 Jul 2007 22:35:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4j1tIoci417ypVUvKLl15fBntd4aRBkd6TzFczq
	jYdxfxjyxbCzth
X-X-Sender: gene099@racer.site
In-Reply-To: <468FF19E.8020406@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51841>

Hi,

On Sat, 7 Jul 2007, Ren? Scharfe wrote:

> Johannes Schindelin schrieb:
> > 
> > On Sat, 7 Jul 2007, Ren? Scharfe wrote:
> > 
> >> Always free .paths if .strdup_paths is set, no matter if the 
> >> parameter free_items is set or not, plugging a minor memory leak. 
> >> And to clarify the meaning of the flag, rename it to free_util, 
> >> since it now only affects the freeing of the .util field.
> > 
> > The rational was that it might very well be possible that the
> > pointers you hand to the path_list are already strdup()ed. So you do
> > not set strdup_paths, but you want them free()d.
> 
> The patch doesn't take that away, i.e. .path fields are not freed if
> .strdup_paths is not set, both before and after the patch.

Yeah, the old code was buggy.

> And the workaround used in builtin-shortlog.c, viz. setting 
> .strdup_paths just before calling path_list_clear(), still works.

Yeah, but it is ugly.

> > The .util field is in many cases something that is not trivially
> > free()d, but has to call a type-specific function, such as
> > path_list_clear() itself.
> 
> Indeed; this is a good reason to separate freeing of .util and .path, no?

Yes.

Ciao,
Dscho
