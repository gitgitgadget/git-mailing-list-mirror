From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 11:07:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606141104050.15578@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1150269478.20536.150.camel@neko.keithp.com> <20060614072923.GB13886@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 11:08:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqRM0-0007AF-3I
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 11:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWFNJH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 05:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWFNJH5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 05:07:57 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63403 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751278AbWFNJH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 05:07:56 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 5D9CF141E;
	Wed, 14 Jun 2006 11:07:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 51667DE2;
	Wed, 14 Jun 2006 11:07:55 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id CCD8CE48;
	Wed, 14 Jun 2006 11:07:52 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060614072923.GB13886@spearce.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21834>

Hi,

On Wed, 14 Jun 2006, Shawn Pearce wrote:

> Keith Packard <keithp@keithp.com> wrote:
> > parsecvs scans every ,v file and creates a blob for every revision of
> > every file right up front. Once these are created, it discards the
> > actual file contents and deals solely with the hash values.
> > 
> > The problem is that while this is going on, the repository consists
> > solely of disconnected objects, and I can't make git-repack put those
> > into pack objects. This leaves the directories bloated, and operations
> > within the tree quite sluggish. I'm importing a project with 30000 files
> > and 30000 revisions (the CVS repository is about 700MB), and after
> > scanning the files, and constructing (in memory) a complete revision
> > history, the actual construction of the commits is happening at about 2
> > per second, and about 70% of that time is in the kernel, presumably
> > playing around in the repository.
> > 
> > I'm assuming that if I could get these disconnected blobs all neatly
> > tucked into a pack object, things might go a bit faster.
> 
> What about running git-update-index using .git/objects as the
> current working directory and adding all files in ??/* into the
> index, then git-write-tree that index and git-commit-tree the tree.
> 
> When you are done you have a bunch of orphan trees and a commit
> but these shouldn't be very big and I'd guess would prune out with
> a repack if you don't hold a ref to the orphan commit.

Alternatively, you could construct fake trees like this:

README/1.1.1.1
README/1.2
README/1.3
...

i.e. every file becomes a directory -- containing all the versions of that 
file -- in the (virtual) tree, which you can point to by a temporary ref.

Ciao,
Dscho
