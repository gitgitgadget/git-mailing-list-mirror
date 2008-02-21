From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Wed, 20 Feb 2008 19:00:44 -0500
Message-ID: <20080221000044.GB6429@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 01:01:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRysO-0001br-9a
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 01:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758315AbYBUAAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 19:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758277AbYBUAAr
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 19:00:47 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3737 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758222AbYBUAAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 19:00:47 -0500
Received: (qmail 9402 invoked by uid 111); 21 Feb 2008 00:00:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Feb 2008 19:00:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2008 19:00:44 -0500
Content-Disposition: inline
In-Reply-To: <20080220235944.GA6278@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74576>

The fake-editor shell script invoked /bin/sh; normally this
is fine, unless the /bin/sh doesn't meet our compatibility
requirements, as is the case with Solaris. Specifically, the
$() syntax used by fake-editor is not understood.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3404-rebase-interactive.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e5ed745..62e65d7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -61,8 +61,8 @@ test_expect_success 'setup' '
 	git tag I
 '
 
-cat > fake-editor.sh <<\EOF
-#!/bin/sh
+echo "#!$SHELL" >fake-editor
+cat >> fake-editor.sh <<\EOF
 case "$1" in
 */COMMIT_EDITMSG)
 	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
-- 
1.5.4.2.247.g107bd
