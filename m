From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH v3 0/2] New config variable push.default
Date: Mon, 16 Mar 2009 16:42:50 +0100
Message-ID: <1237218172-16565-1-git-send-email-finnag@pvv.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 16:45:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjEzq-0000xT-0U
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 16:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbZCPPn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 11:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbZCPPn2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 11:43:28 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:53570 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbZCPPn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 11:43:28 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1LjEyH-0004WS-Bw; Mon, 16 Mar 2009 16:43:23 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113336>

Add a new configuration variable push.default that decides what action
to take if you do not give "git push" any refspecs, and no refspecs
are implied by options (--all or --mirror), and no refspecs are
configured for the current remote.

Some minor rewording of error messages since last time, and split the
patch into two. Patch 1 introduces the variable with all
functionality, and patch 2 adds a warning if the default behavior is
trigged and push.default has not been configured.

Possible configuration values are:

- nothing: Do not push anything.

- tracking: Push the current branch to the branch it is tracking.  In this
  mode, push will always push to the same branch that pull would pull from.
  This functionality does not exist today.

- current: Push the current branch to a branch of the same name on the
  current remote, create it if it does not exist.  Identical to 
  "git push <remote> HEAD", but you do not have to explicitly give the remote.

- matching: The current behavior, push every branch to the current remote if
  a branch with the same name already exists there.


Finn Arne Gangstad (2):
      New config push.default to decide default behavior for push
      Display warning for default git push with no push.default config

 Documentation/RelNotes-1.6.3.txt |    7 +++
 Documentation/config.txt         |   18 +++++++++
 builtin-push.c                   |   76 +++++++++++++++++++++++++++++++++++--
 cache.h                          |    9 ++++
 config.c                         |   28 ++++++++++++++
 environment.c                    |    1 +
 6 files changed, 134 insertions(+), 5 deletions(-)
