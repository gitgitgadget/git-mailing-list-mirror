From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fatal: cannot store pack file (git 1.6.0.2 + sshfs)
Date: Wed, 24 Sep 2008 09:34:00 -0700
Message-ID: <20080924163400.GU3669@spearce.org>
References: <87iqsmy8q7.fsf@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jhair Tocancipa Triana <jhair.tocancipa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 18:35:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiXKd-00043K-Fo
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 18:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbYIXQeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 12:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbYIXQeC
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 12:34:02 -0400
Received: from george.spearce.org ([209.20.77.23]:43126 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbYIXQeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 12:34:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5FBEF3835F; Wed, 24 Sep 2008 16:34:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87iqsmy8q7.fsf@sms.ed.ac.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96658>

Jhair Tocancipa Triana <jhair.tocancipa@gmail.com> wrote:
> I'm getting the following when running git on a partition mounted with
> sshfs:
> 
> $ git pull
...
> error: unable to write sha1 filename .git/objects/pack/pack-dc5c3614e795918f457a2f98a58f10134ebf246b.pack: Operation not permitted
> fatal: cannot store pack file
> fatal: index-pack failed
> 
> git pull worked fine in the same repository yesterday (new files where
> committed in the meantime).
> 
> I'm not sure if this is a problem in git or in sshfs (or somewhere
> else).

Its the size of the fetch.  The day before you probably had a smaller
number of objects downloaded (<100) so Git used unpack-objects
instead of index-pack.  Yesterday it was a larger download (>100),
so it used index-pack.

In 1.6.0.2 index-pack writes a temporary file to .git/objects but
later tries to rename it into .git/objects/pack.  That renaming
must not be working on sshfs.

Latest "master" has a change from Pasky (8b4eb6b6 "Do not perform
cross-directory renames") that should fix this issue.  Or just
don't use sshfs.  Or teach sshfs to rename across directories.

-- 
Shawn.
