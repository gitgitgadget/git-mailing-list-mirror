From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/4] refactor the --color-words to make it more hackable
Date: Sun, 11 Jan 2009 20:58:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 11 20:59:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6T9-000449-EH
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 20:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbZAKT6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 14:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbZAKT6J
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 14:58:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:44094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751094AbZAKT6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 14:58:07 -0500
Received: (qmail invoked by alias); 11 Jan 2009 19:58:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 11 Jan 2009 20:58:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+K9IM6MY+KWNZXtyURPAUIb84PBQBRO4Hx6QZEYQ
	WFRAlvfT9kvuxW
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105205>


So the total change is pretty large, I have to admit.

But at least _I_ think it is easy to follow, and it actually makes the code
more readable/hackable.  Correct me if I'm wrong.

The basic idea is to decouple the original text from the text that is
passed to libxdiff to find the word differences.

To that end, the words of the pre and post texts are put into two lists that
are fed to libxdiff.  While the words are extracted, an array is created which
contains pointers back to the word boundaries in the original text.

To make the transition as easy to understand as possible, the code is first
refactored without actually changing what makes a word boundary.

Johannes Schindelin (4):
  Add color_fwrite(), a function coloring each line individually
  color-words: refactor word splitting and use ALLOC_GROW()
  color-words: refactor to allow for 0-character word boundaries
  color-words: take an optional regular expression describing words

 color.c |   24 ++++++++
 color.h |    1 +
 diff.c  |  185 +++++++++++++++++++++++++++++++++++++++------------------------
 diff.h  |    1 +
 4 files changed, 141 insertions(+), 70 deletions(-)
