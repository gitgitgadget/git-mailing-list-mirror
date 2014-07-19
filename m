From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 0/9] Add --graft option to git replace
Date: Sat, 19 Jul 2014 17:01:06 +0200
Message-ID: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 17:42:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Wly-00087f-Vs
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 17:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbaGSPlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 11:41:46 -0400
Received: from [194.158.98.14] ([194.158.98.14]:33777 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754928AbaGSPlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 11:41:45 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 500586A;
	Sat, 19 Jul 2014 17:41:22 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253885>

Here is a small series to implement:

        git replace [-f] --graft <commit> [<parent>...]

This patch series goes on top of the patch series that
implements --edit.

The changes since v6, thanks to Junio, are:

- the patch that adds for_each_mergetag() is not part of the
  series any more; it is managed by Junio in another dedicated
  series

- replace_parents() iterates over all the argv it is passed,
  not just from argv[1] to argv[argc - 1], in patch 2/9

- in t6050-replace.sh, commit_buffer_contains_parents() has
  been simplified, in patch 3/9

- in t6050-replace.sh, there is now a space between function
  names and (), in patch 3/9

- in t6050-replace.sh, there has been a refactoring regarding
  how commit parenthood is tested, in patchs 3/9 and 7/9; we
  only use commit_has_parents() that now tests everything

- in t6050-replace.sh, commit_buffer_contains_parents()
  compares the 'expected' and 'actual' files in the right
  order, in patch 3/9

We still error if the replacement commit that would be created
would be the same as the existing one, as we already do when
using --edit. If people care, I suggest they send a patch to
change both --graft and --edit at the same time. 

Christian Couder (9):
  replace: cleanup redirection style in tests
  replace: add --graft option
  replace: add test for --graft
  Documentation: replace: add --graft option
  contrib: add convert-grafts-to-replace-refs.sh
  replace: remove signature when using --graft
  replace: add test for --graft with signed commit
  replace: check mergetags when using --graft
  replace: add test for --graft with a mergetag

 Documentation/git-replace.txt             |  10 +++
 builtin/replace.c                         | 126 ++++++++++++++++++++++++++-
 commit.c                                  |  34 ++++++++
 commit.h                                  |   2 +
 contrib/convert-grafts-to-replace-refs.sh |  28 ++++++
 t/t6050-replace.sh                        | 139 ++++++++++++++++++++++++------
 6 files changed, 313 insertions(+), 26 deletions(-)
 create mode 100755 contrib/convert-grafts-to-replace-refs.sh

-- 
2.0.0.421.g786a89d.dirty
