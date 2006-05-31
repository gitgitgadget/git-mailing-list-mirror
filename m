From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] format-patch --signoff
Date: Wed, 31 May 2006 16:16:12 -0700
Message-ID: <7vlkshyedf.fsf@assigned-by-dhcp.cox.net>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
	<93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
	<20060531112803.GB3877@spinlock.ch> <m2mzcycn4f.fsf@ziti.fhcrc.org>
	<7vejyayq46.fsf@assigned-by-dhcp.cox.net>
	<7v4pz5zvtc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606010032410.21774@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoff Russell <geoffrey.russell@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org,
	Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 01 01:17:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlZw5-0007ad-L6
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 01:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbWEaXQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 19:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWEaXQR
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 19:16:17 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58327 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965251AbWEaXQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 19:16:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060531231615.TNIV19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 May 2006 19:16:15 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606010032410.21774@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 1 Jun 2006 00:42:06 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21098>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I don't know, but it may be a good idea to make this more general: Why not 
> build the sign-off line here, so that you could also add more than one 
> sign-off lines ('--signoff="The great committer <ter@mit.com>"'), and 
> maybe even Acked-by's?

Perhaps.

> Okay, this would be a little harder with multiple sign-offs. But the check 
> could be easier, i.e. if we say
>
> 	rev.add_signoff = xmalloc(enough_room);
> 	strcpy(rev.add_signoff, "\nSigned-off-by: ");
> 	strcat(rev.add_signoff, committer_ident);
> 	strcat(rev.add_signoff, "\n");
>
> then a simple
>
> 	p = strstr(commit_buffer, rev.add_signoff);
> 	if (p)
> 		return (int)(p - commit_buffer);
>
> would do the trick.

Do you mean, by "multiple sign-offs", something like this?

	for (so_list = rev.add_signoff; so_list; so_list = so_list->next) {
		if (strstr(commit_buffer, so_list->item))
                	continue;
                append_to_commit_buffer(so_list->item);
	}
	return tail - commit_buffer;

> And shouldn't we error out if there is not enough room for a sign-off?

I do not think we error out if the commit message is too long
either, so...
