From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/5] git-request-pull.sh: remove -e switch to shell interpreter which breaks ksh
Date: Tue,  1 Jun 2010 19:13:41 -0500
Message-ID: <Wt_M4qptcPdpY0Q3jqUbfP4zZEkPwPt44bpwlkuoHdyyNRTiITmTBE-eGA_-F-7NiaN6W4MRrlA@cipher.nrlssc.navy.mil>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 02:14:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJbbU-0007om-QZ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 02:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793Ab0FBAOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 20:14:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50198 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab0FBAOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 20:14:16 -0400
Received: by mail.nrlssc.navy.mil id o520ECkB007912; Tue, 1 Jun 2010 19:14:12 -0500
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 02 Jun 2010 00:14:12.0333 (UTC) FILETIME=[873FB1D0:01CB01E8]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148177>

From: Brandon Casey <drafnel@gmail.com>

The -e option causes the shell to exit immediately when a command exits
with a non-zero exit status.  This does not seem to cause a problem for
Bash, but it does cause a problem for the Korn shell, like Solaris's
xpg4/sh, whose unset utility returns non-zero if it is passed a variable
name which was not previously set.  When using xpg4/sh, git-request-pull
exits while sourcing git-sh-setup since git-sh-setup tries to unset the
CDPATH environment variable.

When git-request-pull was originally written, it did not do any error
checking and it used this shell feature to exit when an error occurred.
This script now performs proper error checking and provides useful error
messages, so this -e option appears to be merely a historical artifact and
can be removed.

Kudos to Jonathan Nieder for introducing t5150 which exercises the
request-pull code path.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-request-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 74238b0..6dfb885 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -1,4 +1,4 @@
-#!/bin/sh -e
+#!/bin/sh
 # Copyright 2005, Ryan Anderson <ryan@michonline.com>
 #
 # This file is licensed under the GPL v2, or a later version
-- 
1.6.6.2
