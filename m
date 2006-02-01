From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 0/9] http-fetch fixes
Date: Wed, 01 Feb 2006 11:28:22 +0000
Message-ID: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Wed Feb 01 12:44:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GPd-00055O-Cs
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWBALo2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWBALo1
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:44:27 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:4848 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932101AbWBALo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:44:26 -0500
Received: (qmail 6476 invoked from network); 1 Feb 2006 11:44:24 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?rwk9TqpcP26BNgKdjd9lphlfCWs3Efsv?@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 11:44:24 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15404>

This patch series fixes the git-http-fetch bug I reported in
`git-http-fetch failure/segfault -- alas no patch'.  The preliminary
patch I was working on /did/ actually fix the bug I found, but uncovered
a bunch more, which I think I've finally got to the bottom of.

The series applies to commit 1506fc34f7585880aeeb12b5fdfe2de4800f9df5.

Particularly: 

  1. watch-slot -- my fix for the actual bug.  Different from Nick
     Hangeval's separate-status structure, it works by locking slots
     that people still want answers from.  I've turned the in_use slot
     field into a bit mask and added a reference counter.  I think you
     can use Nick's patch instead if you prefer it.

  2, 3. list-corruption, abort-object-request -- fix bugs uncovered by
     watch-slot.  See the patch emails for the details.

  4, 5, 6, 7. multi-fdset, fix-rename-message, curl-verbose,
     par-control-flow-tidy -- various other relatively trivial changes I
     noticed while doing the main work above.  fix-rename-message is
     actually a bug, but if you think some other fix is better, that's
     cool; the others are cosmetic things.

  8, 9.  sanity-check-active-slots, sanity-check-object-queue --
     debugging code I threw in while I was trying to track down the main
     bugs.  I'm not going to cry if these aren't accepted (indeed, I
     separated them out and put them at the end specifically!) but they
     might prove useful to someone, so I thought I'd send 'em along
     anyway.

-- [mdw]
