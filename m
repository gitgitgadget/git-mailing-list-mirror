From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: PATCH: allow ':/<oneline prefix>' notation to specify a specific
 file
Date: Thu, 3 Jul 2008 13:55:50 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031353250.9925@racer>
References: <279b37b20807030152g13492d5dxf21367ab17719993@mail.gmail.com> <7v7ic32ujy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Raible <raible@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 15:07:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEOVj-0001lY-CD
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 15:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758080AbYGCM5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758078AbYGCM5p
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:57:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:50651 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754720AbYGCM5o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:57:44 -0400
Received: (qmail invoked by alias); 03 Jul 2008 12:57:42 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp044) with SMTP; 03 Jul 2008 14:57:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18A37M93VcAv1ldy62vJDnhSxsZo19wcUTxekF4jy
	w/Kb8/DjFYPKvR
X-X-Sender: gene099@racer
In-Reply-To: <7v7ic32ujy.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87287>

Hi,

On Thu, 3 Jul 2008, Junio C Hamano wrote:

> "Eric Raible" <raible@gmail.com> writes:
> 
> > This patch allows git show ":/PATCH: allow":sha1_name.c to show the
> > change to the file changed by this patch.
> > ...
> > @@ -697,8 +698,18 @@ int get_sha1_with_mode(const char *name, unsigned
> > char *sha1, unsigned *mode)
> >  		int stage = 0;
> >  		struct cache_entry *ce;
> >  		int pos;
> > -		if (namelen > 2 && name[1] == '/')
> > -			return get_sha1_oneline(name + 2, sha1);
> > +		if (namelen > 2 && name[1] == '/') {
> > +			name += 2;
> > +			colon = strrchr(name, ':');
> > +			if (!get_sha1_oneline(name, sha1) || !colon)
> > +				return 0;
> 
> So when you have ":/A:B:C", you first try to look for string "A:B:C", and
> then when it fails try "A:B" and look for path C?  I think this fallback
> makes sense, especially because this cannot break existing use for
> positive lookup (it _can_ be called a regression if you are checking to
> see if you have a commit that has A:B:C and you want the lookup to fail if
> there is A:B that happens to have path C, but I do not think we would care
> about that usage).

However, if you specify ambiguous information, you can end up with a 
commit when you expect a file.

I do not like the direction this is going; in hindsight, I think 
":/<oneline>" was a serious mistake.

As I hinted in another mail, which should have been in the same mail 
thread, "log --grep" is so much more powerful and should supersede 
":/<oneline>".

Let's grant ":/<oneline>" a quick and painless death.

Ciao,
Dscho
