From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 14:34:07 -0400
Message-ID: <20050423183406.GD20410@delft.aura.cs.cmu.edu>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net> <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 20:30:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPPOD-00031S-3n
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 20:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVDWSeg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 14:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVDWSeb
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 14:34:31 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:35234 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261663AbVDWSeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 14:34:20 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DPPSB-0003KV-00; Sat, 23 Apr 2005 14:34:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2005 at 10:31:28AM -0700, Linus Torvalds wrote:
> In other words, I actually want to create "tag objects", the same way we 
> have "commit objects". A tag object points to a commit object, but in 
> addition it contains the tag name _and_ the digital signature of whoever 
> created the tag.

I see how we can use such a tag object to find a specific commit object
in the tree. But if you put the tag objects in the tree as well we now
have to figure out a way to find the tag objects.

Why not keep the tags object outside of the tree in the tags/ directory.
That way it is easy to find them, and simple to validate all tags or
update the signatures if you lost your key.

> properly. Oh, and make sure the above sounds sane (ie if somebody has a 
> better idea for how to more easily identify how to find the public key to 
> check against, please speak up).

Others already mentioned the gpg clearsign and verify options, to find a
public key that you haven't seen before it is probably easiest to use a
keyserver. If verify complains that it doesn't know a key it will print
a key-id that identifies it. That id can then be looked up as follows,

    gpg --keyserver wwwkeys.pgp.net --search-keys 0xA86B35C5
    gpg: searching for "0xA86B35C5" from hkp server wwwkeys.pgp.net
    (1)     Linus Torvalds <Linus.Torvalds@Helsinki.FI>
		1024 bit RSA key A86B35C5, created: 1996-06-08
    Keys 1-1 of 1 for "0xA86B35C5".  Enter number(s), N)ext, or Q)uit > q

Ofcourse trusting a key obtained this way is another thing altogether,
and would probably depend on who signed it and such.

Jan
