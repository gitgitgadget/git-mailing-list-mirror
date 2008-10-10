From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fix pread()'s short read in index-pack
Date: Fri, 10 Oct 2008 07:17:56 -0700
Message-ID: <20081010141756.GB8203@spearce.org>
References: <20081009195518.GA1497@blimp.localhost> <alpine.LFD.2.00.0810092140500.26244@xanadu.home> <81b0412b0810092352n2a9cb5d2m6a0550354af0b397@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 16:21:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoIpj-00084x-J0
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 16:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758110AbYJJOR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 10:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757333AbYJJOR6
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 10:17:58 -0400
Received: from george.spearce.org ([209.20.77.23]:52245 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756540AbYJJOR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 10:17:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 16AA538360; Fri, 10 Oct 2008 14:17:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <81b0412b0810092352n2a9cb5d2m6a0550354af0b397@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97934>

Alex Riesen <raa.lkml@gmail.com> wrote:
> 2008/10/10 Nicolas Pitre <nico@cam.org>:
> >
> > Since v1.6.0.2~13^2~ the completion of a thin pack uses sha1write() for
> > its ability to compute a SHA1 on the written data.  This also provides
> > data buffering which, along with commit 92392b4a45, will confuse pread()
> > whenever an appended object is 1) freed due to memory pressure because
> > of the depth-first delta processing, and 2) needed again because it has
> > many delta children, and 3) its data is still buffered by sha1write().
> 
> BTW, I run into complications trying to test the fix on Shawn's
> master: conflicts,
> and my trivial resolution wasn't good enough.

Huh.

Color me confused.  What the heck was the base version?

Near as I can tell Nico wrote this fix against a8032d12 (sha1write:
don't copy full sized buffers).  This is in Junio's master.

But the changes conflict with what is in Junio's maint.  So the
patch doesn't apply cleanly due to the sha1flush function's
signature changing.

And the changes conflict with 9126f009 (fix openssl headers
conflicting with custom SHA1 implementations), which is in my
master, and was written by Nico.

;-)

Anyway, its merged now.

-- 
Shawn.
