From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v4 0/6] submodule: drop the top-level requirement
Date: Sun, 16 Jun 2013 15:18:12 +0100
Message-ID: <cover.1371391740.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 16:18:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoDnE-0000vY-5S
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 16:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab3FPOSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 10:18:43 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:43604 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3FPOSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 10:18:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 14A2CCDA594;
	Sun, 16 Jun 2013 15:18:42 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MCFxQfnCxtZs; Sun, 16 Jun 2013 15:18:39 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 3825CCDA583;
	Sun, 16 Jun 2013 15:18:39 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 26053161E3F1;
	Sun, 16 Jun 2013 15:18:39 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cV0yR1zW5JF6; Sun, 16 Jun 2013 15:18:38 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 82988161E2E9;
	Sun, 16 Jun 2013 15:18:28 +0100 (BST)
X-Mailer: git-send-email 1.8.3.779.g691e267
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228008>

Changes since v3:

* There are four new patches, three of which are style fixes for
  existing tests and one fixes an existing error message to return a
  more accurate path when recursing.

* You now cannot run "git submodule add <relative URL>" from a
  subdirectory.  Because the interpretation of the URL changes depending
  on whether or not remote.origin.url is configured, I have decided to
  just ban this for now.  If someone comes up with a sensible way to
  handle this then we can lift this restriction later.

* The "path" variable exported in "submodule foreach" now uses the
  relative path and matches the "sm_path" variable.

* I audited the code again and fixed a few more cases that weren't
  printing relative paths (notably "submodule init" and "submodule
  foreach").

* More tests.

John Keeping (6):
  t7401: make indentation consistent
  t7403: modernize style
  t7403: add missing && chaining
  submodule: show full path in error message
  rev-parse: add --prefix option
  submodule: drop the top-level requirement

 Documentation/git-rev-parse.txt |  16 ++
 builtin/rev-parse.c             |  24 ++-
 git-submodule.sh                | 135 ++++++++++----
 t/t1513-rev-parse-prefix.sh     |  96 ++++++++++
 t/t7400-submodule-basic.sh      |  80 +++++++++
 t/t7401-submodule-summary.sh    | 116 +++++++-----
 t/t7403-submodule-sync.sh       | 388 ++++++++++++++++++++++++++--------------
 t/t7406-submodule-update.sh     |  15 ++
 t/t7407-submodule-foreach.sh    |  16 ++
 9 files changed, 673 insertions(+), 213 deletions(-)
 create mode 100755 t/t1513-rev-parse-prefix.sh

-- 
1.8.3.779.g691e267
