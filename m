From: Jan Hudec <bulb@ucw.cz>
Subject: [QGIT RFC] Unit tests for QGit
Date: Fri, 8 Aug 2008 23:13:18 +0200
Message-ID: <20080808211318.GA4396@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 23:14:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRZI6-0004u3-N7
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 23:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbYHHVN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945AbYHHVN0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 17:13:26 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:47710 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754182AbYHHVN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 17:13:26 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 9C7D257253;
	Fri,  8 Aug 2008 23:13:24 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id nzA4fzX4Nkq2; Fri,  8 Aug 2008 23:13:21 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1E66C57361;
	Fri,  8 Aug 2008 23:13:21 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KRZGw-0001P3-Vv; Fri, 08 Aug 2008 23:13:19 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91716>

Hello Marco and others,

I've been thinking about some refactoring of QGit since some time. And to be
sure I don't screw up things too hard in the process, I thought about adding
a test suite infrastructure first (and add some test cases for each think
just before refactoring it).

The problem is, that implementing unittests means I need to compile
2 separate binaries -- qgit itself and the test -- using most (but not all)
of the same sources. I see two ways to do it, so I'd like to ask which you
consider cleaner:

 1. Reorganize stuff so that a (static) library is created from all the
    sources except qgit.cpp and than qgit.cpp is linked to this library to
    create qgit and the tests are linked with it to provide the test runner.

    Pros:
     - The .pro files should remain reasonably simple.
     - The sources are only compiled once.
    Cons:
     - Need to split the src directory to two, so bigger moving stuff around.

 2. Put the list of sources into file included in the src.pro and include it
    in the tests.pro file too.

    Pros:
     - No libraries and stuff
     - Less moving stuff around.
    Cons:
     - The sources actually get compiled twice, once for the tests and once
       for the qgit binary.
     - Paths to the sources need to be manually adjusted after including into
       the .pro files, making the .pro files rather ugly.

There seems to be no solution requiring less changes to the projects, because
qmake can only create one library or executable per directory and including
files from other directory is not supported to well.

I've already done the later (have patch series ready), but I am now thinking
that I should probably redo it the first way. What do you think. Does it make
sense to do that?

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
