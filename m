From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [sshfs] inode problem when using git on a sshfs filesystem
Date: Thu, 17 Feb 2011 14:08:08 +0100
Message-ID: <E1Pq3aa-0006Nn-Cv@pomaz-ex.szeredi.hu>
References: <1297893854.4097.43.camel@dworkin.quest-ce.net>
    <E1Pq1LW-0005rc-Qy@pomaz-ex.szeredi.hu> <7f02c4cb5ca13dae6de7caa1b6f90cfe.squirrel@webmail.ocsa-data.net>
Cc: miklos@szeredi.hu, yann@droneaud.fr,
	fuse-sshfs@lists.sourceforge.net, fuse-devel@lists.sourceforge.net,
	git@vger.kernel.org
To: "Yann Droneaud" <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Thu Feb 17 14:08:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq3am-0002Cu-PN
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 14:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425Ab1BQNIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 08:08:16 -0500
Received: from fxip-0047f.externet.hu ([88.209.222.127]:57145 "EHLO
	pomaz-ex.szeredi.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab1BQNIP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 08:08:15 -0500
Received: from miko by pomaz-ex.szeredi.hu with local (Exim 4.69)
	(envelope-from <miklos@szeredi.hu>)
	id 1Pq3aa-0006Nn-Cv; Thu, 17 Feb 2011 14:08:08 +0100
In-reply-to: <7f02c4cb5ca13dae6de7caa1b6f90cfe.squirrel@webmail.ocsa-data.net>
	(yann@droneaud.fr)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167083>

On Thu, 17 Feb 2011, Yann Droneaud wrote:
> > On Wed, 16 Feb 2011, Yann Droneaud wrote:
> >> Hi,
> >>
> >> For some days, my usage of git is not as seamless as before.
> >>
> >> I'm using git along sshfs/fuse (don't blame me for that), and
> >> each time I try to rebase one of my branch, I have a conflict when
> >> applying
> >> the third commit. Doing the same operation on a local filesystem works
> >> without any problem.
> >
> > Yann, thanks for looking into this.
> >
> > Your findings are not surprising: unlike NFS, sshfs doesn't provide
> > inode numbers and the fuse library also doesn't guarantee stable inode
> > numbers by default.
> >
> 
> But why does it have such behavior when trying to rmdir() a non empty
> directory ?

The VFS (part of the linux kernel that implements the generic
filesystem logic) clears the directory entry from the cache prior to
actually trying to remove the directory.  This has the effect that any
children of the directory are also cleared from the cache, hence the
behavior you see in rmdir.

> 
> > Fuse version 2.8.x has a "noforget" option that should provide stable
> > inode numbers, at the cost of unbounded memory use.  Could you please
> > try if this option fixes these issues?
> >
> 
> Yes, this option seems to fix the problem.
> 
> I will try it for a while to see if this is stable enough for a full day
> of git working. (How can I check memory usage ?)
> 
> BTW, the [no]forget option did not appears in sshfs --help output.

Oh, that's an oversight on my part.  Will fix.

Thanks,
Miklos
