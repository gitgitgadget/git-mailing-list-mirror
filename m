From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule update - don't run git-fetch if sha1 available
Date: Sat, 11 Aug 2007 12:44:44 -0700
Message-ID: <7vfy2pn9eb.fsf@assigned-by-dhcp.cox.net>
References: <e7bda7770708111048s77fbf416k9d0352486aee6b4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Torgil Svensson" <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 21:44:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJwtF-0002xJ-Nt
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 21:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbXHKToq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 15:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbXHKToq
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 15:44:46 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:44472 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbXHKTop (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 15:44:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811194446.HGBT7956.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 15:44:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ajkk1X00K1kojtg0000000; Sat, 11 Aug 2007 15:44:44 -0400
In-Reply-To: <e7bda7770708111048s77fbf416k9d0352486aee6b4a@mail.gmail.com>
	(Torgil Svensson's message of "Sat, 11 Aug 2007 19:48:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55623>

"Torgil Svensson" <torgil.svensson@gmail.com> writes:

> It's un-necessary (both time-consuming and annoying if you are
> disconnected) for git submodule update to always running git-fetch
> prior to the detached head checkout of the submodule if the commit
> already exists.

This is wrong.  Existence of the commit object alone does not
mean the necessary tree and blob objects to check out that
commit, let alone all the history that leads to the commit,
exist in the repository (think of a commit walker fetch that was
interrupted in the middle).  You need to make sure that the
commit exists *AND* is reachable from one of the refs.
