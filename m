From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/9] "git status" that is not "git commit --dry-run"
Date: Sat, 15 Aug 2009 15:39:48 -0700
Message-ID: <1250375997-10657-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 00:40:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McRv3-0003Yf-4E
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 00:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbZHOWkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 18:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbZHOWkB
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 18:40:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZHOWkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 18:40:01 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDBDBC4F5
	for <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56183C4F4 for
 <git@vger.kernel.org>; Sat, 15 Aug 2009 18:39:59 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.227.g1d720
X-Pobox-Relay-ID: 91C951C0-89EC-11DE-93AF-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126035>

Here is an update relative to 7637868 (wt-status: collect untracked files
in a separate "collect" phase, 2009-08-10) that has been queued in 'next'.

[PATCH 1/9] and [PATCH 2/9] are the same from last night's fixes.

[PATCH 3/9] through [PATCH 6/9] introduce a new "git status" with
different semantics for 1.7.0 under a tentative name "git stat".  They
will be squashed into one commit in the final round, as 4, 5, and 6 are
fix-ups, but are keft separate for easier review.

    The new "git status" handles paths differently from the traditional
    one.  It used to be the preview of "git commit paths...", IOW,
    "show what would happen if we try to make a partial commit of only
    these paths".  The new "git status" only limits the paths the output
    talks about and is not a preview of anything at all anymore.

    Another semantic change is that its exit status no longer says if
    there is something to be committed in the index.  We used to exit with
    non-zero status if there is nothing to commit.

[PATCH 7/9] introduces a short format output.

The last two patches make the new "git status" official.  They will be
squashed together into one commit in the final round, but are kept
separate for reviewability.

Junio C Hamano (9):
  Documentation/git-commit.txt: describe --dry-run
  git commit --dry-run -v: show diff in color when asked
  git stat: the beginning
  git stat: honor relative paths setting
  git stat: show traditional status headers and trailers as well
  git stat: pathspec limits, unlike traditional "git status"
  git stat -s: short status output
  git status: not "commit --dry-run" anymore
  git-status: adjust tests

 Documentation/git-commit.txt |   13 ++-
 Documentation/git-status.txt |   79 +++++++++++++++++---
 Makefile                     |    1 +
 builtin-commit.c             |  172 +++++++++++++++++++++++++++++++++++++-----
 t/t6040-tracking-info.sh     |    2 +-
 t/t7060-wtstatus.sh          |    8 +-
 t/t7506-status-submodule.sh  |    6 +-
 t/t7508-status.sh            |   12 ++-
 wt-status.c                  |   10 ++-
 wt-status.h                  |    1 +
 10 files changed, 255 insertions(+), 49 deletions(-)
