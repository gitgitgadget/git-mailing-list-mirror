From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 0/8] gitweb: side-by-side diff
Date: Mon, 31 Oct 2011 00:36:19 +0100
Message-ID: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:37:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKew2-00056e-Pk
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab1J3Xgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 19:36:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33267 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab1J3Xgu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 19:36:50 -0400
Received: by faan17 with SMTP id n17so5066847faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=B7eUwUZ3JsYB4BcV8/lP7gB6APWOI4OemxtB4KUE5+U=;
        b=pqHzas//SFf0DaOVUZAE6AEC1JfqBiWjwF/2iAv9Wd04VpWLt0FONYQKi06EYD8otN
         pnez2QJNvjKwc7t6Lo8pyz8WD47oc26vHEuMSRTTkW63LRSFtnpEm3kPKvVGD2If69NZ
         np4nD/BUNe1iOU6czRWp/Ta2/nfEXqwDE2nBg=
Received: by 10.223.61.211 with SMTP id u19mr24756259fah.29.1320017809157;
        Sun, 30 Oct 2011 16:36:49 -0700 (PDT)
Received: from localhost.localdomain (aeho24.neoplus.adsl.tpnet.pl. [79.186.196.24])
        by mx.google.com with ESMTPS id a26sm19652514fac.2.2011.10.30.16.36.47
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 16:36:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184479>

NOTE: As it is feature-freeze period, this patch series is for review.

This is refinement and extension of Kato Kazuyoshi patch series, sent
originally as

  [PATCH/RFC] gitweb: add the ability to show side-by-side diff on commitdiff.
  http://thread.gmane.org/gmane.comp.version-control.git/183744

and then refined and split into two-patch series

  [PATCH/RFC 1/2] gitweb: change format_diff_line() to remove leading SP from $diff_class
  http://thread.gmane.org/gmane.comp.version-control.git/183770

  [PATCH 2/2] gitweb: add a feature to show side-by-side diff
  http://thread.gmane.org/gmane.comp.version-control.git/183769

This patch series originally started as rebasing second patch in above
two part series on top of diff line classification refactoring
suggested by me and proposed by Junio.  Then I thought about putting
all code printing side-by-side diff in print_sidebyside_diff_chunk()
subroutine, then...


Main changes from v2 version from Kato Kazuyoshi:

* Built on top of refactoring of code related to diff
  output formatting (patches 1 and 2)

* Code reworked so that is in my opinion easier to follow; gitweb now
  handles merges and diffs with incomplete lines correctly (patch 3)
  - well, it handles merges by turning off side-by-side diff for them.

* Adding background color to distinguish empty context lines from
  vertical align, similarly to e.g.
    http://community.activestate.com/files/images/sbsdiffs.png
  but without refinement (word diff of changes).

* Adds some very basic test for side-by-side diff (patch 6 (and 5))

* Split adding navigation into a separate commit, and uses [nav] links
  rather than HTML form for selecting between inline and side-by-side
  diff style (diff 8).  Thanks to more thorough use of href(-replay=>1,..)
  (patch 7) style of diff should be preserved with this series.


Please excuse me for essentially hijacking this patch series.


P.S. I really, really need to finish work on splitting gitweb into
smaller pieces.  With around 8,000 lines it becomes quite unwieldy.
But this would probably need total rework of error handling (the
die_error subroutine), and that would need another changes, etc....


Pull request:
~~~~~~~~~~~~~
These changes are available in the git repository(-y/+ies) at:
  git://repo.or.cz/git/jnareb-git.git gitweb/side-by-side-diff-v4
  git://github.com/jnareb/git         gitweb/side-by-side-diff-v4

Table of contents:
~~~~~~~~~~~~~~~~~~
  [PATCHv3 1/8] gitweb: Refactor diff body line classification
  [PATCHv3 2/8] gitweb: Extract formatting of diff chunk header
  [PATCHv3 3/8] gitweb: Add a feature to show side-by-side diff
  [PATCHv3 4/8] gitweb: Give side-by-side diff extra CSS styling
  [PATCHv3 5/8] t9500: Add test for handling incomplete lines in diff
   by gitweb
  [PATCHv3 6/8] t9500: Add basic sanity tests for side-by-side diff in
   gitweb
  [PATCHv3 7/8] gitweb: Use href(-replay=>1,...) for formats links in
   "commitdiff"
  [PATCHv3 8/8] gitweb: Add navigation to select side-by-side diff

Shortlog:
~~~~~~~~~
Jakub Narebski (6):
  gitweb: Refactor diff body line classification
  gitweb: Extract formatting of diff chunk header
  gitweb: Give side-by-side diff extra CSS styling
  t9500: Add test for handling incomplete lines in diff by gitweb
  t9500: Add basic sanity tests for side-by-side diff in gitweb
  gitweb: Use href(-replay=>1,...) for formats links in "commitdiff"

Kato Kazuyoshi (2):
  gitweb: Add a feature to show side-by-side diff
  gitweb: Add navigation to select side-by-side diff

Diffstat:
~~~~~~~~~
 gitweb/gitweb.perl                     |  339 +++++++++++++++++++++++--------
 gitweb/static/gitweb.css               |   30 +++
 t/t9500-gitweb-standalone-no-errors.sh |   73 +++++++-
 3 files changed, 353 insertions(+), 89 deletions(-)

-- 
1.7.6
