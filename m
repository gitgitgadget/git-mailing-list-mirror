From: Simon Hausmann <simon@lst.de>
Subject: Re: git fsck segmentation fault
Date: Thu, 27 Nov 2008 20:21:55 +0100
Message-ID: <200811272021.56108.simon@lst.de>
References: <200811271814.06941.simon@lst.de> <alpine.LFD.2.00.0811271243250.14328@xanadu.home> <200811272010.20891.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 27 20:23:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5mSK-0001VR-Lo
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 20:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbYK0TWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 14:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbYK0TV7
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 14:21:59 -0500
Received: from hoat.troll.no ([62.70.27.150]:42098 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376AbYK0TV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 14:21:59 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 550D120EB4;
	Thu, 27 Nov 2008 20:21:58 +0100 (CET)
Received: from rani.localnet (unknown [172.20.1.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 3619F20E7B;
	Thu, 27 Nov 2008 20:21:58 +0100 (CET)
User-Agent: KMail/1.10.1 (Linux/2.6.27-7-generic; KDE/4.1.2; i686; ; )
In-Reply-To: <200811272010.20891.simon@lst.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101822>

On Thursday 27 November 2008 20:10:20 Simon Hausmann wrote:
> On Thursday 27 November 2008 18:47:41 Nicolas Pitre wrote:
> > On Thu, 27 Nov 2008, Simon Hausmann wrote:
> > > Hi,
> > >
> > > when running git fsck --full -v (version 1.6.0.4.26.g7c30c) on a medium
> > > sized
> >
> > That version doesn't exist in the git repo.
>
> Ah, oops, it was a merge commit, corresponding to maint as of 5aa3bd.
>
> > > (930M) repository I get a segfault.
> > >
> > > The backtrace indicates an infinite recursion. Here's the output from
> > > the last few lines:
> >
> > [...]
> >
> > Could you try with latest master branch please?  It is more robust
> > against some kind of pack corruptions that could send the code into
> > infinite loops.
>
> Same problem with git version 1.6.0.4.790.gaa14a

Forgot to paste the changed line numbers of the recursion:

#54 0x0000000000493c6d in parse_tree (item=0x20d0178) at tree.c:224
#55 0x0000000000424ca2 in mark_object (obj=0x20d0178, type=2, data=<value 
optimized out>) at builtin-fsck.c:102
#56 0x0000000000468d1c in fsck_walk (obj=<value optimized out>, walk=0x424af0 
<mark_object>, data=0x20d0128) at fsck.c:26
#57 0x0000000000424cba in mark_object (obj=0x20d0128, type=2, data=<value 
optimized out>) at builtin-fsck.c:105
#58 0x0000000000468d1c in fsck_walk (obj=<value optimized out>, walk=0x424af0 
<mark_object>, data=0x1edb448) at fsck.c:26
#59 0x0000000000424cba in mark_object (obj=0x1edb448, type=2, data=<value 
optimized out>) at builtin-fsck.c:105
#60 0x0000000000468d1c in fsck_walk (obj=<value optimized out>, walk=0x424af0 
<mark_object>, data=0x1edb420) at fsck.c:26
#61 0x0000000000424cba in mark_object (obj=0x1edb420, type=2, data=<value 
optimized out>) at builtin-fsck.c:105
#62 0x0000000000468bf9 in fsck_walk (obj=0x241a750, walk=0x424af0 
<mark_object>, data=0x241a750) at fsck.c:50
#63 0x0000000000424b7d in mark_object (obj=0x241a750, type=1, data=<value 
optimized out>) at builtin-fsck.c:105
#64 0x0000000000468c31 in fsck_walk (obj=<value optimized out>, walk=0x424af0 
<mark_object>, data=0x241a708) at fsck.c:57
#65 0x0000000000424b7d in mark_object (obj=0x241a708, type=1, data=<value 
optimized out>) at builtin-fsck.c:105
#66 0x0000000000468c31 in fsck_walk (obj=<value optimized out>, walk=0x424af0 
<mark_object>, data=0x4dea0b0) at fsck.c:57
#67 0x0000000000424b7d in mark_object (obj=0x4dea0b0, type=1, data=<value 
optimized out>) at builtin-fsck.c:105
#68 0x0000000000468c31 in fsck_walk (obj=<value optimized out>, walk=0x424af0 
<mark_object>, data=0x488ff78) at fsck.c:57
#69 0x0000000000424b7d in mark_object (obj=0x488ff78, type=1, data=<value 
optimized out>) at builtin-fsck.c:105
#70 0x0000000000468c31 in fsck_walk (obj=<value optimized out>, walk=0x424af0 
<mark_object>, data=0x488bd18) at fsck.c:57
#71 0x0000000000424b7d in mark_object (obj=0x488bd18, type=1, data=<value 
optimized out>) at builtin-fsck.c:105
#72 0x0000000000468c31 in fsck_walk (obj=<value optimized out>, walk=0x424af0 
<mark_object>, data=0x313c0b0) at fsck.c:57
#73 0x0000000000424b7d in mark_object (obj=0x313c0b0, type=1, data=<value 
optimized out>) at builtin-fsck.c:105
[recursion between line 105 and 57]

Simon
