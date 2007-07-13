From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] forgot to clear the depth value
Date: Thu, 12 Jul 2007 22:27:12 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707122221240.32552@xanadu.home>
References: <alpine.LFD.0.999.0707121703240.32552@xanadu.home>
 <20070713014228.GE19073@lavos.net> <20070713014502.GF19073@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>, Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Fri Jul 13 04:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9AsH-0000BQ-W3
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 04:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758452AbXGMC1O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 22:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758362AbXGMC1N
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 22:27:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31311 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757902AbXGMC1N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 22:27:13 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL300BBRITCA6D0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 22:27:12 -0400 (EDT)
In-reply-to: <20070713014502.GF19073@lavos.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52355>

Commit 5a235b5e was missing this little detail.  Otherwise your pack
will explode.

Problem noted by Brian Downing.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Thu, 12 Jul 2007, Brian Downing wrote:

> On Thu, Jul 12, 2007 at 08:42:28PM -0500, Brian Downing wrote:
> > This patch breaks pack-objects pretty horribly:
> > 
> > :; PATH=~/src/git:$PATH /usr/bin/time ~/src/git/git-repack -a -d -f
> 
> [that's Git I'm repacking here]
> 
> > :; ls -l .git/objects/pack
> > total 153916
> > -r--r--r-- 1 bdowning bdowning   1312136 2007-07-12 20:39 pack-9ac926ee1f5810c434707d3f816f5ad2cbd14668.idx
> > -r--r--r-- 1 bdowning bdowning 156130933 2007-07-12 20:39 pack-9ac926ee1f5810c434707d3f816f5ad2cbd14668.pack

Oooooops.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a43d604..5e9d1fd 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1431,6 +1431,7 @@ static void free_unpacked(struct unpacked *n)
 		window_memory_usage -= n->entry->size;
 	}
 	n->entry = NULL;
+	n->depth = 0;
 }
 
 static void find_deltas(struct object_entry **list, int window, int depth)
