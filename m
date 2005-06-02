From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Thu, 2 Jun 2005 09:14:53 +0200
Message-ID: <20050602071453.GA16616@kiste.smurf.noris.de>
References: <Pine.LNX.4.58.0506011951150.1876@ppc970.osdl.org> <Pine.LNX.4.21.0506020223570.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Nicolas Pitre <nico@cam.org>, Tony Lindgren <tony@atomide.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 09:17:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdjwF-0003Bq-26
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 09:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVFBHTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 03:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVFBHTT
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 03:19:19 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:51669 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261487AbVFBHTO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 03:19:14 -0400
Received: from server.smurf.noris.de (run.smurf.noris.de [192.109.102.41])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j527JAj1013234
	for <git@vger.kernel.org>; Thu, 2 Jun 2005 00:19:12 -0700
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Ddjun-0006Pp-Qp; Thu, 02 Jun 2005 09:15:17 +0200
Received: (nullmailer pid 25670 invoked by uid 501);
	Thu, 02 Jun 2005 07:14:53 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0506020223570.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Daniel Barkalow:
> If the lock is only to protect against someone else modifying HEAD after
> we've checked that it is our starting point and before we modify it,
> there's no reason not to hold the lock while pushing; it wouldn't block
> anything other than someone doing a quick push in the middle of our long
> one, and thereby causing us to dump a lot of useless objects on the
> server (which will become obsolete as we will need to do the merge and
> push a different version).
> 
The objects we push aren't going to be obsolete. The server needs them
anyway, because our HEAD refers to them.

What if the connection dies in the middle of a push? You then sit there
waiting for it, and the lock, to time out. OTOH, an atomic cmpxchg on
the server can't block and can't timeout.

> you want to have the
> client watch for the resolution of the other transfer one way or the
> other, since you're in the current state precisely because you lost on
> getting the lock and now definitely need the next version.
> 
I disagree. Given that you need to wait for the upload to finish anyway
(whether you know it or not ;-) it makes sense to spend the time
actually uploading -- upload speed is frequently lower than download
for individuals.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Who was that masked man?
