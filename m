From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-clone: fetch possibly detached HEAD over dumb http
Date: Sun, 1 Jul 2007 18:40:16 +0200
Message-ID: <20070701164016.GA3661@steel.home>
References: <20070628105208.GA11105@liacs.nl> <7vsl8bmxv9.fsf@assigned-by-dhcp.pobox.com> <20070629083108.GA14747@liacs.nl> <20070630133310.GB2866@steel.home> <20070630134542.GF7969MdfPADPa@greensroom.kotnet.org> <20070630222336.GA2703@steel.home> <7vy7i0amnn.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Louis-Noel Pouchet <louis-noel.pouchet@inria.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 18:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I52TL-00084l-1T
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 18:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbXGAQkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 12:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753586AbXGAQkW
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 12:40:22 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:56343 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbXGAQkU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 12:40:20 -0400
Received: from tigra.home (Fa9ee.f.strato-dslnet.de [195.4.169.238])
	by post.webmailer.de (klopstock mo32) (RZmta 7.6)
	with ESMTP id V01a3dj61CwloZ ; Sun, 1 Jul 2007 18:40:17 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3748F277BD;
	Sun,  1 Jul 2007 18:40:17 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A40E8C164; Sun,  1 Jul 2007 18:40:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy7i0amnn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNrERwE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51308>

Junio C Hamano, Sun, Jul 01, 2007 04:22:04 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > The check for .git validity includes checking if HEAD contains
> > something sane, and this check is very simple: the HEAD is read
> > (readlink(2) or plain read(2)) and tested if it contains a
> > reference starting with "refs/", which maybe inconsistent with
> > resolve_gitlink_ref, but probably ok.
> 
> Ah, I was not paying close attention to resolve_gitlink_ref();
> if it does not require HEAD to point at refs/ I would say it is
> a bug.

yes, thats why I think its ok.

> Come to think of it, I would further say that we probably should
> tighten it up a bit: HEAD must be either a valid commit object
> name (i.e. detached)

That (HEAD must point to a _valid_ commit) will make accidentally
corrupted repositories harder to fix. The tool which require a valid
repository (cat-file, update-ref, read-tree) are the same tools which
you need to fix small problems which can happen, like the commit
pointed by HEAD is accidentally pruned from parent repo.
