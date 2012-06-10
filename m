From: "Hallvard B Furuseth" <h.b.furuseth@usit.uio.no>
Subject: Re: Keeping unreachable objects in a separate pack instead of 
 loose?
Date: Mon, 11 Jun 2012 01:24:21 +0200
Message-ID: <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:42:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdrlr-0002jf-Oy
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 01:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386Ab2FJXlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 19:41:31 -0400
Received: from mail-out1.uio.no ([129.240.10.57]:47234 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888Ab2FJXla (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 19:41:30 -0400
X-Greylist: delayed 1028 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jun 2012 19:41:30 EDT
Received: from mail-mx5.uio.no ([129.240.10.46])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1SdrUb-0007wF-NN; Mon, 11 Jun 2012 01:24:21 +0200
Received: from w3prod-wm03.uio.no ([129.240.4.40] helo=webmail.uio.no)
	by mail-mx5.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1SdrUb-0000jF-4H; Mon, 11 Jun 2012 01:24:21 +0200
Received: from 195.1.106.118
        (SquirrelMail authenticated user hbf)
        by webmail.uio.no with HTTP;
        Mon, 11 Jun 2012 01:24:21 +0200
In-Reply-To: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
User-Agent: SquirrelMail/1.4.19
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 2 sum msgs/h 1 total rcpts 2457 max rcpts/h 20 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, FSL_RCVD_USER=0.001,T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 7236257A1C8B435DD3A1CDEA88B52958901232FB
X-UiO-SPAM-Test: remote_host: 129.240.4.40 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 7 total 1391294 max/h 475 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199628>

On Sun, June 10, 2012 14:31, Theodore Ts'o wrote:
> I recently noticed that after a git gc, I had a huge number of loose
> objects that were unreachable.  In fact, about 4.5 megabytes worth of
> objects.

I got gigabytes once, and a full disk.  See thread
"git gc == git garbage-create from removed branch", May 3 2012.

> When I packed them, via:
>
>    cd .git/objects ; find [0-9a-f][0-9a-f] -type f | git pack-objects pack
>
> the resulting pack file was 244k.
>
> Which got me thinking.... the whole point of leaving the objects loose
> is to make it easier to expire them, right?   But given how expensive it
> is to have loose objects lying around, why not:
>
> a)  Have git-pack-objects have an option which writes the unreachable
>     objects into a separate pack file, instead of kicking them loose?

I think this should be the default.  It's very unintuitive that
gc can eat up lots of disk space instead of saving space.

Until this is fixed, this behavior needs to be documented -
along with how to avoid it.

> b)  Have git-prune delete a pack only if *all* of the objects in the
>     pack meet the expiry deadline?
>
> What would be the downsides of pursueing such a strategy?  Is it worth
> trying to implement as proof-of-concept?

Hallvard
