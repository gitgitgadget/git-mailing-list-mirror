From: Junio C Hamano <junkio@cox.net>
Subject: Re: First cut at git port to Cygwin
Date: Sat, 08 Oct 2005 11:44:01 -0700
Message-ID: <7vr7avrgr2.fsf@assigned-by-dhcp.cox.net>
References: <20051005155457.GA30303@trixie.casa.cgf.cx>
	<20051005191741.GA25493@steel.home>
	<20051005202947.GA6184@trixie.casa.cgf.cx>
	<81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
	<81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
	<81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
	<Pine.LNX.4.64.0510070828270.31407@g5.osdl.org>
	<20051007205450.GA14827@steel.home> <20051007212250.GA1423@steel.home>
	<4346E8AC.5030503@citi.umich.edu> <20051007213952.GA8821@steel.home>
	<Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
	<Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Oct 08 20:45:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOJg4-0001Jp-RI
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 20:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVJHSoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 14:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVJHSoE
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 14:44:04 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:2443 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750816AbVJHSoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 14:44:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051008184347.WVZG29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Oct 2005 14:43:47 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 8 Oct 2005 20:27:06 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9848>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Am I missing something? I don't see where the changes are written back to 
> the fd. After all, mmap() is called with PROT_WRITE...

PROT_WRITE is true, but we do MAP_PRIVATE, and if I recall
correctly we do not write file via mmap -- at least we do not
intend to.

 - index file is mapped for reading, long ago it was mapped
   read-only but these days we do PROT_WRITE, but updates are
   done via opening a new file and writing afresh.

 - objects are mapped for reading, but, never updated once
   created.  Creation side is regular open - write - close.

 - diff reads original by mapping, but obviously has no business
   writing.

 - local-fetch reads original by mapping for copying.

> *shameless plug* Of course, this problem does not come up with
> my NO_MMAP patch.

Yes.  It might have been overkill that you supported writing
changes back, though.
.  
