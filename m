From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: only throw away data during memory pressure
Date: Tue, 12 Feb 2008 09:26:25 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802120910440.2732@xanadu.home>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at>
 <alpine.LFD.1.00.0802110942310.2732@xanadu.home>
 <20080212082211.GE27535@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 15:27:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOw6M-00032I-7t
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 15:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761164AbYBLO0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 09:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761047AbYBLO0k
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 09:26:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54361 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760977AbYBLO0j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 09:26:39 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW4005UWQS10K30@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Feb 2008 09:26:26 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080212082211.GE27535@lavos.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73663>

On Tue, 12 Feb 2008, Brian Downing wrote:

> On Mon, Feb 11, 2008 at 11:00:33AM -0500, Nicolas Pitre wrote:
> > On Mon, 11 Feb 2008, Martin Koegler wrote:
> > > If pack-objects hit the memory limit, it deletes objects from the
> > > delta window.
> > > 
> > > This patch make it only delete the data, which is recomputed, if
> > > needed again.
> > > 
> > > Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> > 
> > Looks fine.
> > 
> > Acked-by: Nicolas Pitre <nico@cam.org>
> 
> Unfortunately this patch (if I understand what it's doing correctly)
> basically defeats my intended use-case for which I wrote the memory
> limiter.  I have a repository with files of very mixed size.  I want the
> window to be very large for small files, for good archival repacking,
> but I don't want it to be very large for my 20+MB files with hundreds of
> revisions, because I want it to finish someday.
> 
> Also, I've gotten into the habit of just doing:
>     git repack --window=100000 --window-memory=256m
> for archival repacks and just letting the memory limit automatically
> size the window.  Basically, I don't really want to specify a window
> size, I just want it to use 512mb of RAM (and go at the speed that size
> of a window would entail.)  While this is slow, it tends to be a
> relatively constant speed, and it tends to find some very interesting
> deltas in my trees that I wouldn't have otherwise expected.
> 
> If this patch is accepted, I'd really like a way to maintain the old
> behavior as an option.

I think your use case has merits, but the previous behavior had 
semantics problems.  We always had constant window size with dynamic 
memory usage, and now we have constant window size with bounded memory 
usage.

If what you want is really to have a dynamic window size using a 
constant memory usage then it needs a different and coherent way to be 
specified.


Nicolas
