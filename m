From: Jason <git@lakedaemon.net>
Subject: rsync a *bunch* of git repos
Date: Tue, 10 Jan 2012 16:15:48 -0500
Message-ID: <20120110211548.GD10255@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 22:16:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkj31-0005M3-3i
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 22:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837Ab2AJVPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 16:15:52 -0500
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43033 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab2AJVPv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 16:15:51 -0500
Received: from pool-108-39-66-94.nrflva.fios.verizon.net ([108.39.66.94] helo=titan)
	by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <git@lakedaemon.net>)
	id 1Rkj2s-0003fY-TL
	for git@vger.kernel.org; Tue, 10 Jan 2012 21:15:50 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
	by titan (Postfix) with ESMTP id B02862F3032
	for <git@vger.kernel.org>; Tue, 10 Jan 2012 16:15:48 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 108.39.66.94
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/ragFMIUlKeIMgfS+IB7VQ1IJ0c/Y2BC4=
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188291>

All,

I have a home directory with a lot of git repos in it.  Possibly over a
hundred.  This is a good thing.  :-)  However, I'm in the process of
changing OS's and need to move my home directory out of my root
partition into its own partition.

The nuts and bolts of this aren't difficult, the problem is I don't have
a complete understanding of how git stores data.  I've heard in the
past that it uses a lot of hardlinks and softlinks.  I need to make
sure, that once I transfer the data, and reboot the machine with the new
partition mounted under /home, that all my git repos will be okay.

Going through the git repos one by one would be long and prone to
errors, so I'm looking at alternatives.  Does this look ok?

## From single user mode, or live cd
$ su -
# mkfs.ext4 /dev/sda3
# mount /dev/sda3 /mnt/home
# rsync --progress -avu /home/ /mnt/home/
# umount /mnt/home
# mv /home /home.orig
# mkdir /home

### Sanity check?
# mount /dev/sda3 /home
# rsync -avun /home.orig/ /home/

That'll check that rsync thinks things are ok, but what about git?  Is
there a git sanity check I could run to detect that three hardlinks
still point to the same inode?

One alternative may be to boot to a live CD, delete everything from the
root partition except /home, then mv /home/* -> / .  Basically, use my
current root partition as the new /home partition.

thx,

Jason.
