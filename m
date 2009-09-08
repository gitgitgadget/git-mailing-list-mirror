From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 00/14] git notes
Date: Tue, 08 Sep 2009 04:26:48 +0200
Message-ID: <1252376822-6138-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 08 04:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkqQb-0005Zj-Rv
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 04:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbZIHC1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 22:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbZIHC1R
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 22:27:17 -0400
Received: from smtp.getmail.no ([84.208.15.66]:34030 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753289AbZIHC1R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 22:27:17 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM00CXIS5HLI90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:17 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM0072GS5GQN30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:17 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.9.8.21525
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127950>

Yet another iteration of the 'git notes' feature. Rebased on top of 'next':
- Patches 1-9 are unchanged from (patches 1-7, 11-12 of) the last iteration.
- Patch 10 teaches the notes code to free its data structures on request.
- Patch 11 introduces the 16-tree notes lookup code that handles SHA1-based
  fanout schemes. This is pretty much unchanged from patch 8 in the previous
  iteration.
- Patch 12 adds selftests that verify correct parsing of notes trees with
  various SHA1-based fanouts.
- Patch 13 introduces a flexible parser for a variety of date-based and
  SHA1-based fanout schemes. This is the interesting part, as far as this
  iteration is concerned.
- Patch 14 adds selftests that verify correct parsing of notes trees with
  various date-based fanouts.

Note that the series does not yet include code for _writing_ notes into a
suitably structured notes tree. That will be done in a later iteration.

I have some performance numbers that I will send in a separate email.


Have fun! :)

...Johan


Johan Herland (9):
  Teach "-m <msg>" and "-F <file>" to "git notes edit"
  fast-import: Add support for importing commit notes
  t3302-notes-index-expensive: Speed up create_repo()
  Add flags to get_commit_notes() to control the format of the note string
  Teach notes code to free its internal data structures on request.
  Teach the notes lookup code to parse notes trees with various fanout schemes
  Selftests verifying semantics when loading notes trees with various fanouts
  Allow flexible organization of notes trees, using both commit date and SHA1
  Add test cases for date-based fanouts

Johannes Schindelin (5):
  Introduce commit notes
  Add a script to edit/inspect notes
  Speed up git notes lookup
  Add an expensive test for git-notes
  Add '%N'-format for pretty-printing commit notes

 .gitignore                        |    1 +
 Documentation/config.txt          |   13 +
 Documentation/git-fast-import.txt |   45 +++-
 Documentation/git-notes.txt       |   60 ++++
 Documentation/pretty-formats.txt  |    1 +
 Makefile                          |    3 +
 cache.h                           |    4 +
 command-list.txt                  |    1 +
 commit.c                          |    1 +
 config.c                          |    5 +
 environment.c                     |    1 +
 fast-import.c                     |   88 +++++-
 git-notes.sh                      |  121 +++++++
 notes.c                           |  673 +++++++++++++++++++++++++++++++++++++
 notes.h                           |   12 +
 pretty.c                          |   10 +
 t/t3301-notes.sh                  |  150 ++++++++
 t/t3302-notes-index-expensive.sh  |  118 +++++++
 t/t3303-notes-subtrees.sh         |  201 +++++++++++
 t/t9300-fast-import.sh            |  166 +++++++++
 20 files changed, 1664 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100644 notes.c
 create mode 100644 notes.h
 create mode 100755 t/t3301-notes.sh
 create mode 100755 t/t3302-notes-index-expensive.sh
 create mode 100755 t/t3303-notes-subtrees.sh
