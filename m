From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Update "diff -w --exit-code"
Date: Sat, 23 May 2009 12:24:48 -0700
Message-ID: <1243106690-6385-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wqn-0002Cd-C0
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbZEWTY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbZEWTY6
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:24:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032AbZEWTYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BCB05B56BB
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:24:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2C4D8B56BA for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:51 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
X-Pobox-Relay-ID: 63E44BF2-47CF-11DE-840D-F6BA321C86B1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119797>

Here is a re-roll of the earlier patch to change the exit status of "diff"
family of commands on whitespace only changes.

Earlier, "-w" and friends only affected the displayed of textual diff
output and never caused the commands to ignore the presense of
differences.  With this, the commands exit with zero status when the
changes are only about whitespaces that you are ignoring.

E.g. starting from a clean slate:

	$ echo ' a' >a-file ;# one space
	$ git add a-file
	$ echo '  a' >a-file ;# two spaces
	$ git diff --exit-code -w >/dev/null; echo $?

will give 0, instead of 1.

The fact that you have changes (i.e. the contents of a-file as a whole has
changed) is still reported in the textual part of the output by showing
the "diff --git a/a-file b/b-file" header and the "index objname..objname mode"
line.  This is not likely to change.

Junio C Hamano (2):
  diff: change semantics of "ignore whitespace" options
  diff: Rename QUIET internal option to QUICK

 builtin-log.c                |    2 +-
 builtin-rev-list.c           |    2 +-
 diff-lib.c                   |    4 +-
 diff.c                       |   39 ++++++++++++++++++++++---
 diff.h                       |    3 +-
 revision.c                   |    2 +-
 t/t4037-whitespace-status.sh |   63 ++++++++++++++++++++++++++++++++++++++++++
 tree-diff.c                  |    3 +-
 8 files changed, 106 insertions(+), 12 deletions(-)
 create mode 100755 t/t4037-whitespace-status.sh
