From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] format-patch --signoff
Date: Thu, 1 Jun 2006 01:31:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606010131010.4002@wbgn013.biozentrum.uni-wuerzburg.de>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
 <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
 <20060531112803.GB3877@spinlock.ch> <m2mzcycn4f.fsf@ziti.fhcrc.org>
 <7vejyayq46.fsf@assigned-by-dhcp.cox.net> <7v4pz5zvtc.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606010032410.21774@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkshyedf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geoff Russell <geoffrey.russell@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org,
	Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 01 01:32:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlaAe-0000uD-W0
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 01:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbWEaXb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 19:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965262AbWEaXb7
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 19:31:59 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8120 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965263AbWEaXb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 19:31:58 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id B67502100;
	Thu,  1 Jun 2006 01:31:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id AA74A20E6;
	Thu,  1 Jun 2006 01:31:56 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 86ED620A1;
	Thu,  1 Jun 2006 01:31:56 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkshyedf.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21100>

Hi,

On Wed, 31 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I don't know, but it may be a good idea to make this more general: Why not 
> > build the sign-off line here, so that you could also add more than one 
> > sign-off lines ('--signoff="The great committer <ter@mit.com>"'), and 
> > maybe even Acked-by's?
> 
> Perhaps.
> 
> > Okay, this would be a little harder with multiple sign-offs. But the check 
> > could be easier, i.e. if we say
> >
> > 	rev.add_signoff = xmalloc(enough_room);
> > 	strcpy(rev.add_signoff, "\nSigned-off-by: ");
> > 	strcat(rev.add_signoff, committer_ident);
> > 	strcat(rev.add_signoff, "\n");
> >
> > then a simple
> >
> > 	p = strstr(commit_buffer, rev.add_signoff);
> > 	if (p)
> > 		return (int)(p - commit_buffer);
> >
> > would do the trick.
> 
> Do you mean, by "multiple sign-offs", something like this?
> 
> 	for (so_list = rev.add_signoff; so_list; so_list = so_list->next) {
> 		if (strstr(commit_buffer, so_list->item))
>                 	continue;
>                 append_to_commit_buffer(so_list->item);
> 	}
> 	return tail - commit_buffer;

Actually, I did not think of a linked list, but one buffer, but I like 
your solution better.

> > And shouldn't we error out if there is not enough room for a sign-off?
> 
> I do not think we error out if the commit message is too long
> either, so...

... so you could say that should be an error, too.

Ciao,
Dscho
