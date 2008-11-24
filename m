From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Not-quite-a-bug in pickaxe
Date: Mon, 24 Nov 2008 12:43:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811241238450.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 24 12:36:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4ZkE-0008Su-1T
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 12:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbYKXLf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 06:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbYKXLf2
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 06:35:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:46845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751751AbYKXLf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 06:35:28 -0500
Received: (qmail invoked by alias); 24 Nov 2008 11:35:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 24 Nov 2008 12:35:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197T45O9Y17r/dmsYa5mUNmIXl++4fkGQJtPQW2AP
	Pq6wOqtARDU2rX
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101602>

Hi people,

I do not know if I hit that behavior before, but now it hit me big time: 
if a commit moves a certain string from one place to another, "git log 
-S<string>" does not pick up that commit.  The code responsible for this 
is in diffcore-pickaxe.c:

                        else if (!diff_unmodified_pair(p) &&
                                 contains(p->one, needle, len, regexp) !=
                                 contains(p->two, needle, len, regexp))
                                has_changes++;

Basically, the "contains()" method says how often the needle was found, 
and pickaxe just assumes that a move of a string is not interesting 
enough.

Now, this behavior is probably intended, as searching files is much 
cheaper than generating the diffs between them, yet it is something you'll 
have to keep in mind when using "-S".

Ciao,
Dscho
