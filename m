From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid allocating 0 bytes, was Re: [PATCH 4/4]
 git-compat-util.h: dietlibc-friendly x{malloc,realloc,calloc}
Date: Wed, 28 Dec 2005 21:38:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512282134380.2236@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121454.GC3963@mail.yhbt.net>
 <7v3bkis631.fsf@assigned-by-dhcp.cox.net> <20051224211546.GG3963@mail.yhbt.net>
 <Pine.LNX.4.63.0512261916440.8435@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmmnisix.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512262134290.19331@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 21:38:41 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eri4F-0006tE-VP
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 21:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVL1Uii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 15:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVL1Uii
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 15:38:38 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:29076 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964905AbVL1Uih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2005 15:38:37 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 04E85E1077; Wed, 28 Dec 2005 21:38:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id ED17C2D48;
	Wed, 28 Dec 2005 21:38:33 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id D0A4D2750;
	Wed, 28 Dec 2005 21:38:33 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D7CCB1415C5; Wed, 28 Dec 2005 21:38:32 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0512262134290.19331@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14104>

Hi,

On Mon, 26 Dec 2005, Johannes Schindelin wrote:

> On Mon, 26 Dec 2005, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > diff --git a/csum-file.c b/csum-file.c
> > > index 5f9249a..2c0f097 100644
> > > --- a/csum-file.c
> > > +++ b/csum-file.c
> > > @@ -121,6 +121,9 @@ int sha1write_compressed(struct sha1file
> > >  	unsigned long maxsize;
> > >  	void *out;
> > >  
> > > +	if (size == 0)
> > > +		return 0;
> > > +
> > >  	memset(&stream, 0, sizeof(stream));
> > >  	deflateInit(&stream, Z_DEFAULT_COMPRESSION);
> > >  	maxsize = deflateBound(&stream, size);
> > 
> > I think this and the one in sha1_file.c::write_sha1_file() are
> > wrong; 0-size input would not result in 0-size output.  Have you
> > tested them by actually exercising the codepaths you touched?
> 
> No, I did not test them.

Now I did. To make a long story short: this patch is wrong, wrong, wrong. 
Further, I think it is safe to assume that deflateBound() returns > 0.

Ciao,
Dscho
