From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 0/6] receive-pack hooks over sideband
Date: Fri,  5 Feb 2010 12:57:36 -0800
Message-ID: <1265403462-20572-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:04:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVLP-0007MN-IQ
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757437Ab0BEVDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:03:54 -0500
Received: from george.spearce.org ([209.20.77.23]:41732 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424Ab0BEVDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:03:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D71C2381D6
	for <git@vger.kernel.org>; Fri,  5 Feb 2010 20:57:43 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc1.199.g9253ab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139087>

This is a respin of the patch I posted yesterday.  Same idea,
we want to make the messages printed by hooks available over the
sideband protocol so git:// and http:// smart clients are able to
present them, similar to how ssh:// works.

No real major changes from v1, the series is just broken apart to
make it easier to review, and Erik Faye-Lund's patch was integrated
to get a bidirectional async interface, rather than my hacked
.is_reader attempt in v1.

Erik Faye-Lund (1):
  run-command: support custom fd-set in async

Shawn O. Pearce (5):
  run-command: Allow stderr to be a caller supplied pipe
  send-pack: demultiplex a sideband stream with status data
  receive-pack: Refactor how capabilities are shown to the client
  receive-pack: Wrap status reports inside side-band-64k
  receive-pack: Send hook output over side band #2

 Documentation/technical/api-run-command.txt |   52 ++++++++++---
 builtin-fetch-pack.c                        |    7 +-
 builtin-receive-pack.c                      |  111 +++++++++++++++++++++------
 builtin-send-pack.c                         |   66 ++++++++++++----
 convert.c                                   |    5 +-
 remote-curl.c                               |    7 +-
 run-command.c                               |   91 +++++++++++++++++++---
 run-command.h                               |   11 ++-
 t/t5401-update-hooks.sh                     |   22 +++---
 upload-pack.c                               |    7 +-
 10 files changed, 290 insertions(+), 89 deletions(-)
