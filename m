From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] pack-objects: only throw away data during memory pressure
Date: Tue, 12 Feb 2008 02:22:12 -0600
Message-ID: <20080212082211.GE27535@lavos.net>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at> <alpine.LFD.1.00.0802110942310.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 09:23:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOqQc-0003Qh-H9
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 09:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761517AbYBLIWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 03:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761481AbYBLIWP
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 03:22:15 -0500
Received: from mxsf02.insightbb.com ([74.128.0.63]:18324 "EHLO
	mxsf02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761439AbYBLIWN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 03:22:13 -0500
X-IronPort-AV: E=Sophos;i="4.25,339,1199682000"; 
   d="scan'208";a="214248714"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf02.insightbb.com with ESMTP; 12 Feb 2008 03:22:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAPjlsEdKhvkY/2dsb2JhbACBWaln
X-IronPort-AV: E=Sophos;i="4.25,339,1199682000"; 
   d="scan'208";a="202271070"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 12 Feb 2008 03:22:13 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 213B6309F21; Tue, 12 Feb 2008 02:22:12 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802110942310.2732@xanadu.home>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73639>

On Mon, Feb 11, 2008 at 11:00:33AM -0500, Nicolas Pitre wrote:
> On Mon, 11 Feb 2008, Martin Koegler wrote:
> > If pack-objects hit the memory limit, it deletes objects from the
> > delta window.
> > 
> > This patch make it only delete the data, which is recomputed, if
> > needed again.
> > 
> > Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> 
> Looks fine.
> 
> Acked-by: Nicolas Pitre <nico@cam.org>

Unfortunately this patch (if I understand what it's doing correctly)
basically defeats my intended use-case for which I wrote the memory
limiter.  I have a repository with files of very mixed size.  I want the
window to be very large for small files, for good archival repacking,
but I don't want it to be very large for my 20+MB files with hundreds of
revisions, because I want it to finish someday.

Also, I've gotten into the habit of just doing:
    git repack --window=100000 --window-memory=256m
for archival repacks and just letting the memory limit automatically
size the window.  Basically, I don't really want to specify a window
size, I just want it to use 512mb of RAM (and go at the speed that size
of a window would entail.)  While this is slow, it tends to be a
relatively constant speed, and it tends to find some very interesting
deltas in my trees that I wouldn't have otherwise expected.

If this patch is accepted, I'd really like a way to maintain the old
behavior as an option.

-bcd
