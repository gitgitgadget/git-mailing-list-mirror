From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 0/5] fork/exec removal series
Date: Sun, 30 Sep 2007 22:09:56 +0200
Message-ID: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 30 22:10:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic57H-0002Yg-8g
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 22:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbXI3UKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbXI3UKF
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 16:10:05 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:36895 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbXI3UKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 16:10:04 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 57BBD97204;
	Sun, 30 Sep 2007 22:10:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59554>

Here is a series of patches that removes a number fork/exec pairs.
They are replaced by delegating to start_command/finish_command/run_command.
You can regard this as the beginning of the MinGW port integration.

There still remain a few forks, which fall into these categories:

- They are in tools or code that are not (yet) ported to MinGW.[*]

- The fork()s are not followed by exec(). These need a different
  implementation. I am thinking of a start_coroutine()/finish_coroutine()
  API that is implemented with threads in MinGW. (Suggestions of a better
  as well as implementations are welcome.)

- The upload-pack case calls for an entirely different solution.

[*] Just this weekend Mike Pape ported git-daemon, but I didn't find the
time to have it integrated in this series - if that were possible at all.

Patch 2 depends on Patch 1; otherwise, there are no dependencies.
The series goes on top of next (it touches str_buf stuff in connect.c).

 builtin-archive.c    |    8 +--
 builtin-fetch-pack.c |   63 ++++++++-----------------
 cache.h              |    4 +-
 connect.c            |  126 ++++++++++++++++++++++++--------------------------
 convert.c            |   36 ++++----------
 diff.c               |   38 +--------------
 peek-remote.c        |    8 +--
 send-pack.c          |    8 +--
 transport.c          |    9 +---
 9 files changed, 106 insertions(+), 194 deletions(-)

-- Hannes
