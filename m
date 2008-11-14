From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 14 Nov 2008 09:55:51 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811140945000.3468@nehalem.linux-foundation.org>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org> <20081107071231.GA4063@blimp.localdomain>
 <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org> <20081109102528.GA5463@blimp.localdomain> <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de> <81b0412b0811101224gcffc958o6dbfcdc45e022874@mail.gmail.com> <alpine.DEB.1.00.0811102230330.30769@pacific.mpi-cbg.de>
 <20081114050822.GA23963@foursquare.net> <alpine.LFD.2.00.0811140800540.3468@nehalem.linux-foundation.org> <7v1vxeb4il.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0811140936050.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Frey <cdfrey@foursquare.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 18:58:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L12vb-0003ut-2q
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 18:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbYKNR4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 12:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbYKNR4k
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 12:56:40 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51913 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753346AbYKNR4k (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 12:56:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAEHtqPu012929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Nov 2008 09:55:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAEHtpWt020105;
	Fri, 14 Nov 2008 09:55:51 -0800
In-Reply-To: <alpine.LFD.2.00.0811140936050.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.431 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100996>



On Fri, 14 Nov 2008, Linus Torvalds wrote:
> 
> but if you already do
> 
> 	gitk a..b
> 
> then you're _already_ doing a revision limiter and forcing the revision 
> walk to be synchronous, so there would be no interactivity downside 
> between 'a..b' and '{a..b}'.

Btw, the biggest problem (I think) is actually non-simple ranges and just 
the _syntax_ of these things.

It's entirely reasonable to want to group a more complex expression than 
just a single range. IOW, something like

	gitk {..origin/pu ^origin/next} {HEAD~5..HEAD~2}

to show a union of what is in 'pu' but not master or next, and the 
symmetrical difference of the current merge. It's a perfectly sensible 
thing to do. And we _can_ do it right now, just with a nasty syntax:

	gitk --no-walk $(git rev-list ..origin/pu ^origin/next) $(git rev-list HEAD~5..HEAD~2)

actually works. But look again at how nasty it is to parse the '{x}' 
version, because the '{..}' thing now spans multiple arguments. 

			Linus
