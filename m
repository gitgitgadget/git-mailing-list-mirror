From: Jeff King <peff@peff.net>
Subject: [PATCHv2 3/4] run-command: help callers distinguish errors
Date: Wed, 28 Jan 2009 02:36:39 -0500
Message-ID: <20090128073639.GC31884@coredump.intra.peff.net>
References: <20090128073059.GD19165@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:38:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS4zv-0007tu-St
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbZA1Hgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbZA1Hgm
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:36:42 -0500
Received: from peff.net ([208.65.91.99]:57651 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbZA1Hgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:36:42 -0500
Received: (qmail 19570 invoked by uid 107); 28 Jan 2009 07:36:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 02:36:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 02:36:39 -0500
Content-Disposition: inline
In-Reply-To: <20090128073059.GD19165@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107493>

run_command returns a single integer specifying either an
error code or the exit status of the spawned program. The
only way to tell the difference is that the error codes are
outside of the allowed range of exit status values.

Rather than make each caller implement the test against a
magic limit, let's provide a macro.

Signed-off-by: Jeff King <peff@peff.net>
---
New since v1 of the series.

 run-command.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/run-command.h b/run-command.h
index 0211e1d..a88b3cd 100644
--- a/run-command.h
+++ b/run-command.h
@@ -10,6 +10,7 @@ enum {
 	ERR_RUN_COMMAND_WAITPID_SIGNAL,
 	ERR_RUN_COMMAND_WAITPID_NOEXIT,
 };
+#define IS_RUN_COMMAND_ERR(x) (x >= ERR_RUN_COMMAND_FORK)
 
 struct child_process {
 	const char **argv;
-- 
1.6.1.1.367.g30b36
