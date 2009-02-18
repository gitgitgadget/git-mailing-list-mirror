From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] RUNTIME_PREFIX enhancements
Date: Wed, 18 Feb 2009 16:10:54 +0100 (CET)
Message-ID: <cover.1234969572u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 18 16:12:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZo66-0004s5-CV
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 16:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbZBRPK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 10:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbZBRPK5
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 10:10:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:40625 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753352AbZBRPK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 10:10:56 -0500
Received: (qmail invoked by alias); 18 Feb 2009 15:10:54 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp028) with SMTP; 18 Feb 2009 16:10:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+akV9TddeabbBUgCUGUlCl7MmjBgvLBwlwnuZctt
	iTv3cYfBXGLg3S
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110549>

When I ran "make" in msysGit's /git/, I was greeted by a pretty unfriendly 
message about a RUNTIME_PREFIX that could not be determined.

Not understanding the code in exec_cmd.c, I went back to a comment I made 
to one of the iterations of the RUNTIME_PREFIX patch series (back when I 
spent a considerable amount of time to understand the code), and turned it 
into a patch myself.

I hope you will agree that the code introduced in 1/2 is more 
understandable than what is removed in 2/2 in favor of the former.

The real meat comes in patch 2/2:

The problem is that Windows will look in the current directory before 
looking in the PATH when it tries to execute a program.  So it will find 
the executable C:\msysgit\git\git.exe and be unable to strip the suffices 
"libexec/git-core" or "bin".

I just added "git" (which should not hurt other users, but instead help 
them if they did not install Git but run it in-place).

Johannes Schindelin (2):
  Introduce the function strip_path_suffix()
  system_path(): simplify using strip_path_suffix(), and add suffix
    "git"

 cache.h    |    2 ++
 exec_cmd.c |   32 +++-----------------------------
 path.c     |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 29 deletions(-)
