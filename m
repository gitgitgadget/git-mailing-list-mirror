From: Mark Lawrence <nomad@null.net>
Subject: [cogito-0.18.2] Documentation/Code Mismatch: cg-switch -l
Date: Mon, 26 May 2008 13:18:37 +0200
Message-ID: <20080526111837.GA17429@lifebook.rekudos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 14:08:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0bVR-0004Sq-04
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 14:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbYEZMH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 08:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbYEZMH5
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 08:07:57 -0400
Received: from lawrence.nine.ch ([217.150.250.121]:49522 "EHLO
	lawrence.nine.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbYEZMH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 08:07:56 -0400
X-Greylist: delayed 2949 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 May 2008 08:07:55 EDT
Received: from 217-162-110-104.dclient.hispeed.ch ([217.162.110.104] helo=lifebook.rekudos.net)
	by lawrence.nine.ch with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nomad@null.net>)
	id 1K0aiv-0001n7-MZ
	for git@vger.kernel.org; Mon, 26 May 2008 13:18:43 +0200
Received: from mlawren by lifebook.rekudos.net with local (Exim 4.63)
	(envelope-from <nomad@null.net>)
	id 1K0air-0004b4-UM
	for git@vger.kernel.org; Mon, 26 May 2008 13:18:37 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 217.162.110.104
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: nomad@null.net
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lawrence.nine.ch
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=1.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on lawrence.nine.ch)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82925>

Hi,

I don't know if this is a bug or just my understanding, but I'm having
trouble matching the behaviour of "cg-switch -l" with the documentation.

According to the docs, -l means that:
                                                ... local changes will
  be "kept" with your previous branch, you will get a pristine tree of
  the new branch and when you switch back to the original branch you
  will also get back the local changes.

However if I run "cg-switch -l -c testing" on a dirty (ie with local
changes) repository I do not get a pristine tree. In fact, it appears 
the local changes are carried over.

Initial state:

    mlawren@lifebook:/tmp/x$ cg-status
    Heads:
        >master     6a8a774cd1fb84f48f906a9ce3322a5ac94deb00
       R origin     cdc9a7857b93b00f515b010c9aeadda4e649b92a

    ? Changes
    ? META.yml
    ? Makefile
    ? blib/
    ? inc/
    ? pm_to_blib
    ? t/benchmark.pl
    ? t/cache.t
    ? t/hyphens.t
    ? t/synopsis.t
    ? x
    M MANIFEST
    M Makefile.PL
    M debian/changelog
    M debian/control
    M lib/XML/API.pm
    A lib/XML/API/Cache.pm
    M lib/XML/API/RSS.pm
    M lib/XML/API/XHTML.pm
    M t/02-langs.t
    M t/03-XML-API.t
    A t/04-parse.t

Create a new local branch and check status:

    mlawren@lifebook:/tmp/x$ cg-switch -l -c testing
    Creating new branch testing: 6a8a774cd1fb84f48f906a9ce3322a5ac94deb00
    Switching to branch testing...

    mlawren@lifebook:/tmp/x$ cg-status
    Heads:
        master     6a8a774cd1fb84f48f906a9ce3322a5ac94deb00
      R origin     cdc9a7857b93b00f515b010c9aeadda4e649b92a
        >testing    6a8a774cd1fb84f48f906a9ce3322a5ac94deb00

    ? Changes
    ? META.yml
    ? Makefile
    ? blib/
    ? inc/
    ? pm_to_blib
    ? t/benchmark.pl
    ? t/cache.t
    ? t/hyphens.t
    ? t/synopsis.t
    ? x
    M MANIFEST
    M Makefile.PL
    M debian/changelog
    M debian/control
    M lib/XML/API.pm
    A lib/XML/API/Cache.pm
    M lib/XML/API/RSS.pm
    M lib/XML/API/XHTML.pm
    M t/02-langs.t
    M t/03-XML-API.t
    A t/04-parse.t

Why do I still have all these modified and additional files? I fully
expected to still see the '?' file not under git/cogito control. However
the uncommitted changes are still all present.

I am also confused by the existence of the '-p' option, which by my
reading implies pretty much the same condition as if you *don't* specify
-l.

Regards,
Mark.
-- 
Mark Lawrence
