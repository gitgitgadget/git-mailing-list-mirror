From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] Revamping "git status"
Date: Wed,  5 Aug 2009 02:15:41 -0700
Message-ID: <1249463746-21538-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:16:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYcbT-00082b-FT
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933915AbZHEJPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933832AbZHEJPu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:15:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933904AbZHEJPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:15:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7D1F1E08B
	for <git@vger.kernel.org>; Wed,  5 Aug 2009 05:15:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2F5981E08A for
 <git@vger.kernel.org>; Wed,  5 Aug 2009 05:15:47 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.18.g07a4a
X-Pobox-Relay-ID: 907D246C-81A0-11DE-A420-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124878>

The first two patches in this series are a small bugfix and an internal
clean-up for the underlying "diff-index" engine used by "git status" when
it inspects how the index differs from the HEAD commit.

The third one separates the logic to inspect the changes in the index and
the work tree from the code to show the result in "git status" command, so
that collected data can be presented in different formats more easily.
It is roughly based on an old patch of mine from October last year, but it
collects a bit more detail on conflicted paths.

The fourth one changes the output from the "git status" command when
unmerged paths are present.  We now have a separate "Unmerged paths"
section at the beginning and describe the nature of the conflict in more
detail.

The last one is a bit iffy, but shows how the new infrastructure can be
used to present the "git status" output in a more succinct and machine
readble format.

Junio C Hamano (5):
  diff-index: report unmerged new entries
  diff-index: keep the original index intact
  wt-status.c: rework the way changes to the index and work tree are
    summarized
  status: show worktree status of conflicted paths separately
  shortstatus: a new command

 Makefile            |    1 +
 builtin-commit.c    |  107 +++++++++++++++++-
 builtin.h           |    1 +
 diff-lib.c          |   22 +----
 git.c               |    1 +
 t/t7060-wtstatus.sh |   31 +++++
 wt-status.c         |  314 +++++++++++++++++++++++++++++++++++++++++++--------
 wt-status.h         |   11 ++
 8 files changed, 418 insertions(+), 70 deletions(-)
 create mode 100755 t/t7060-wtstatus.sh
