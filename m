From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/11] Fix memory leak in traverse_commit_list
Date: Fri, 9 Nov 2007 23:51:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711092350440.4362@racer.site>
References: <20071109110610.GA19368@spearce.org> <7vmytnqbu2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:51:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqddj-00013D-Jw
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759951AbXKIXvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759774AbXKIXvW
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:51:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:47439 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755663AbXKIXvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:51:22 -0500
Received: (qmail invoked by alias); 09 Nov 2007 23:51:19 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp056) with SMTP; 10 Nov 2007 00:51:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+d9V4nAvqdxUSsUlZwarHRBl7X/VfxUVymwtQafG
	9Lo9ZFmYILdDsp
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmytnqbu2.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64284>

Hi,

On Fri, 9 Nov 2007, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > diff --git a/list-objects.c b/list-objects.c
> > index e5c88c2..713bef9 100644
> > --- a/list-objects.c
> > +++ b/list-objects.c
> > @@ -170,4 +170,11 @@ void traverse_commit_list(struct rev_info *revs,
> >  	}
> >  	for (i = 0; i < objects.nr; i++)
> >  		show_object(&objects.objects[i]);
> > +	free(objects.objects);
> > +	if (revs->pending.nr) {
> > +		revs->pending.nr = 0;
> > +		revs->pending.alloc = 0;
> > +		revs->pending.objects = NULL;
> > +		free(revs->pending.objects);

Umm. Isn't this the wrong way around?  Should you not free() first, and 
then set to NULL?

Ciao,
Dscho
