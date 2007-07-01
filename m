From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone: fetch possibly detached HEAD over dumb http
Date: Sat, 30 Jun 2007 19:22:04 -0700
Message-ID: <7vy7i0amnn.fsf@assigned-by-dhcp.cox.net>
References: <20070628105208.GA11105@liacs.nl>
	<7vsl8bmxv9.fsf@assigned-by-dhcp.pobox.com>
	<20070629083108.GA14747@liacs.nl> <20070630133310.GB2866@steel.home>
	<20070630134542.GF7969MdfPADPa@greensroom.kotnet.org>
	<20070630222336.GA2703@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Louis-Noel Pouchet <louis-noel.pouchet@inria.fr>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 04:22:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4p4o-00040T-2a
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 04:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbXGACWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 22:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754698AbXGACWH
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 22:22:07 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53497 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbXGACWF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 22:22:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701022204.FBGU1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 22:22:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id J2N31X00D1kojtg0000000; Sat, 30 Jun 2007 22:22:04 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51266>

Alex Riesen <raa.lkml@gmail.com> writes:

> The check for .git validity includes checking if HEAD contains
> something sane, and this check is very simple: the HEAD is read
> (readlink(2) or plain read(2)) and tested if it contains a
> reference starting with "refs/", which maybe inconsistent with
> resolve_gitlink_ref, but probably ok.

Ah, I was not paying close attention to resolve_gitlink_ref();
if it does not require HEAD to point at refs/ I would say it is
a bug.

Come to think of it, I would further say that we probably should
tighten it up a bit: HEAD must be either a valid commit object
name (i.e. detached) or a ref that point at somewhere under
refs/heads hierarchy, not just anywhere in refs/.
