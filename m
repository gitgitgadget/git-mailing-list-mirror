From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Introduce commit notes
Date: Mon, 16 Jul 2007 17:26:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707161724110.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <200707160857.48725.andyparkins@gmail.com> <7vbqec4vk2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Alberto Bertogli <albertito@gmail.com>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 18:26:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IATPQ-00049F-BF
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 18:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759598AbXGPQ0t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 12:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759166AbXGPQ0t
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 12:26:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:39698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758823AbXGPQ0s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 12:26:48 -0400
Received: (qmail invoked by alias); 16 Jul 2007 16:26:46 -0000
Received: from R412d.r.pppool.de (EHLO noname) [89.54.65.45]
  by mail.gmx.net (mp034) with SMTP; 16 Jul 2007 18:26:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/79zdgXQ37J1F83m/yca0KiHYguQV4hL1EglqLML
	1WNCjMdGtJl0PS
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbqec4vk2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52683>

Hi,

On Mon, 16 Jul 2007, Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > On Monday 2007 July 16, Johannes Schindelin wrote:
> >
> >> The biggest obstacle was a thinko about the scalability.  Tree 
> >> objects take free form name entries, and therefore a binary search by 
> >> name is not possible.
> >
> > I might be misunderstanding, but in the case of the notes tree objects 
> > isn't it true that the name entries aren't free form, but are 
> > guaranteed to be of a fixed length form:
> >
> >   XX/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
> >
> > In which case you can binary search?
> 
> Hmph, you are right.  In this sequence:
> 
> 	hex = sha1_to_hex(commit->object.sha1);
> 	snprintf(name, sizeof(name), "%s:%.*s/%.*s",
> 			notes_ref_name, 2, hex, 38, hex + 2);
> 	if (get_sha1(name, sha1))
> 		return;
> 
> Instead, we could read the tree object by hand in the commit that is 
> referenced by notes_ref_name, which has uniform two letter names for 
> subtrees which can be binary searched, open the tree for that entry, 
> again by hand, and do another binary search because that tree has 
> uniform 38-letter names.  That certainly could be done.
> 
> Sounds like a "fun" project for some definition of the word.

I disagree.  One disadvantage to using tree objects is that it is much 
easier to have pilot errors.  You could even make a new working tree 
checking out refs/notes/commits and change/add/remove files.

Ciao,
Dscho
