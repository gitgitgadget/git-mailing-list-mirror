From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 0/8] Speed up git-svn
Date: Fri, 23 May 2008 16:19:35 +0200
Message-ID: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Cc: git@vger.kernel.org
To: aroben@apple.com
X-From: git-owner@vger.kernel.org Fri May 23 16:17:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY54-00066y-58
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbYEWOQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbYEWOQQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:16:16 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51014 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751542AbYEWOQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:16:12 -0400
Received: (qmail 31299 invoked by uid 89); 23 May 2008 14:14:48 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.207)
  by smtp1-pc with SMTP; 23 May 2008 14:14:46 -0000
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82705>

This is a respin of the patches by Adam Roben that follow
the ones that are now in "pu".


Adam Roben (6):
  Move git-hash-object tests from t5303 to t1007
  Add more tests for git hash-object
  git-hash-object: Add --stdin-paths option
  Git.pm: Add command_bidi_pipe and command_close_bidi_pipe
  Git.pm: Add hash_and_insert_object and cat_blob
  git-svn: Speed up fetch

These patches have the changes suggested in the old thread to
remove some warnings and fix the tests, plus formatting changes in
the tests. The patches on Git.pm and git-svn.perl are the same as
before, patches 2 and 3 are the ones I have touched.


Michele Ballabio (2):
  builtin-cat-file.c: use parse_options()
  change quoting in test t1006-cat-file.sh

These are independent changes, but are always to be applied on top
of what's in "pu" (on top of ar/batch-cat, actually). The first
tries to simplify the code about the option parsing. The second
one is only for readability.


 Documentation/git-hash-object.txt |    5 +-
 builtin-cat-file.c                |  119 ++++++++-------------
 git-svn.perl                      |   42 ++++----
 hash-object.c                     |   45 ++++++++-
 perl/Git.pm                       |  208 ++++++++++++++++++++++++++++++++++++-
 t/t1006-cat-file.sh               |    6 +-
 t/t1007-hash-object.sh            |  133 +++++++++++++++++++++++
 t/t5303-hash-object.sh            |   35 ------
 8 files changed, 456 insertions(+), 137 deletions(-)
 create mode 100755 t/t1007-hash-object.sh
 delete mode 100755 t/t5303-hash-object.sh
