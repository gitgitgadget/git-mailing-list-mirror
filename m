From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] 2GB fixes for Windows
Date: Thu, 5 Mar 2009 17:05:06 +0100 (CET)
Message-ID: <cover.1236268730u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 05 17:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfG61-0001lB-VL
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 17:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbZCEQFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 11:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbZCEQFL
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 11:05:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:48921 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752366AbZCEQFK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 11:05:10 -0500
Received: (qmail invoked by alias); 05 Mar 2009 16:05:07 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 05 Mar 2009 17:05:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bd+p/7hebq/9cAGdT3Fo092/J7BF5piDeoqgb8k
	cQLmgrZCl8dr4K
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112312>

On Windows, we can actually have files larger than 2 gigabyte, just not 
using off_t, but off64_t instead.

This came up as issue 194 on the msysGit tracker, and as I first brushed 
the people off saying that it is not an msysGit issue, by way of an 
apology, I started working on this myself.

The first patch adds a test for cloning repositories larger than 2 
gigabyte, which is disabled by default, since it is quite expensive (both 
in terms of time and in terms of space), and since it must fail when the 
underlying filesystem does not allow files larger than 2 gigabyte.

The second patch convinces msysGit (AKA the MinGW port of Git) to make use 
of the 64-bit file offsets.

Johannes Schindelin (2):
  Add an (optional, since expensive) test for >2g clones
  MinGW: 64-bit file offsets

 compat/mingw.c       |    8 +++++---
 compat/mingw.h       |    5 ++++-
 t/t5705-clone-2gb.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 4 deletions(-)
 create mode 100755 t/t5705-clone-2gb.sh
