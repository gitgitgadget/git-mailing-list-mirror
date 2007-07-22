From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/4] Modularize http, commit-walker, http-fetch
Date: Sun, 22 Jul 2007 18:09:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707221745440.29679@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:09:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjc9-0000GU-3U
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540AbXGVWJS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756112AbXGVWJS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:09:18 -0400
Received: from iabervon.org ([66.92.72.58]:3830 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753383AbXGVWJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:09:17 -0400
Received: (qmail 29506 invoked by uid 1000); 22 Jul 2007 22:09:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jul 2007 22:09:16 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53337>

This series cleans up a whole lot of flow control and makes it possible to 
extend commit-walkers and http (each individually) in more useful 
directions.

Due to the limitations on what I can test, it could use a bunch more 
testing before it goes in. In particular, http-push is completely 
untested, and I haven't really beaten on USE_CURL_MULTI, although it 
compiles each way.

The first patch just makes the http library code easier to work with.

The second patch turns the caller-provided global function for making 
delayed requests into a callback in a chain.

The third patch (posted previously) removes obsolete commit-walkers.

The fourth patch (posted previously) reworks the commit-walker framework, 
and makes http-fetch into a commit-walker implementation which can be used 
from library code. It also turns http-fetch into a (trivial) builtin which 
calls the walker code with the library walker.

 Makefile                      |   37 ++----
 builtin-http-fetch.c          |   77 +++++++++++++
 builtin.h                     |    1 +
 fetch.h                       |   54 ---------
 git.c                         |    3 +
 http-push.c                   |   25 +---
 http-fetch.c => http-walker.c |  245 +++++++++++++++++----------------------
 http.c                        |   50 ++++++++
 http.h                        |    7 +-
 local-fetch.c                 |  254 -----------------------------------------
 rsh.c                         |   83 -------------
 rsh.h                         |    7 -
 ssh-fetch.c                   |  166 ---------------------------
 ssh-pull.c                    |    4 -
 ssh-push.c                    |    4 -
 ssh-upload.c                  |  143 -----------------------
 fetch.c => walker.c           |   83 +++++++-------
 walker.h                      |   37 ++++++
 18 files changed, 339 insertions(+), 941 deletions(-)

	-Daniel
*This .sig left intentionally blank*
